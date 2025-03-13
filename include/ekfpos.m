function [pos,el, az, P] = ekfpos(satpos, obs, settings, pos_init, P_prev,Q)
% EKF定位算法（需在外部维护状态传递）
% 新增输入参数：
%   pos_init  - 初始状态估计 [X; Y; Z; dt] 
%   P_prev    - 上一历元协方差矩阵 (4x4)
%   Q         - 过程噪声协方差 (4x4)
%   R         - 观测噪声协方差标量或对角阵

dtr = pi/180;
nmbOfSatellites = size(satpos, 2);
H = zeros(nmbOfSatellites, 4);  % 雅可比矩阵
h = zeros(nmbOfSatellites, 1);  % 预测观测值
y = zeros(nmbOfSatellites, 1);  % 观测残差
az = zeros(1, nmbOfSatellites);
el = az;

%% EKF预测阶段
F = eye(4);  % 状态转移矩阵（静态模型假设）
x_pred = F * pos_init;          % 状态预测
P_pred = F * P_prev * F' + Q;   % 协方差预测

%% 观测模型线性化
for i = 1:nmbOfSatellites
    % 地球自转校正（同原算法）
    traveltime = norm(satpos(:,i)-x_pred(1:3)) / settings.c;
    Rot_X = e_r_corr(traveltime, satpos(:,i));
    
    % 计算仰角（用于加权）
    [az(i), el(i), ~] = topocent(x_pred(1:3), Rot_X - x_pred(1:3));
    
    % 对流层延迟校正
    if settings.useTropCorr
        trop = tropo(sin(el(i)*dtr), 0, 1013, 293, 50, 0, 0, 0);
    else
        trop = 0;
    end
    
    % 预测伪距（包含钟差）
    h(i) = norm(Rot_X - x_pred(1:3)) + x_pred(4) + trop;
    
    % 构建雅可比矩阵（同原A矩阵）
    H(i,:) = [-(Rot_X(1)-x_pred(1))/h(i), 
             -(Rot_X(2)-x_pred(2))/h(i),
             -(Rot_X(3)-x_pred(3))/h(i),
             1];
    
    % 观测残差
    y(i) = obs(i) - h(i);

    weight(i)=sin(el*dtr)/sin(el*dtr);
end


R=diag(weight);
%% EKF更新阶段
% 观测噪声加权（根据仰角调整R）
   R_matrix = R;  % 仰角越低权重越小


% 卡尔曼增益计算
S = H * P_pred * H' + R_matrix;
K = P_pred * H' / S;

% 状态更新
x = x_pred + K * y;
P = (eye(4) - K * H) * P_pred;

%% 输出结果
pos = x;  % 返回更新后的状态估计
end

