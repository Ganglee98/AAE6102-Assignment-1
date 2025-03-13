function plotNavigation(navSolutions, settings)
%Functions plots variations of coordinates over time and a 3D position
%plot. It plots receiver coordinates in UTM system or coordinate offsets if
%the true UTM receiver coordinates are provided.  
%
%plotNavigation(navSolutions, settings)
%
%   Inputs:
%       navSolutions    - Results from navigation solution function. It
%                       contains measured pseudoranges and receiver
%                       coordinates.
%       settings        - Receiver settings. The true receiver coordinates
%                       are contained in this structure.

%--------------------------------------------------------------------------
%                           SoftGNSS v3.0
% 
% Copyright (C) Darius Plausinaitis
% Written by Darius Plausinaitis
%--------------------------------------------------------------------------
%This program is free software; you can redistribute it and/or
%modify it under the terms of the GNU General Public License
%as published by the Free Software Foundation; either version 2
%of the License, or (at your option) any later version.
%
%This program is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with this program; if not, write to the Free Software
%Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
%USA.
%--------------------------------------------------------------------------

% CVS record:
% $Id: plotNavigation.m,v 1.1.2.25 2006/08/09 17:20:11 dpl Exp $

%% Plot results in the necessary data exists ==============================
if (~isempty(navSolutions))

    %% If reference position is not provided, then set reference position
    %% to the average postion
    if isnan(settings.truePosition.E) || isnan(settings.truePosition.N) ...
                                      || isnan(settings.truePosition.U)

        %=== Compute mean values ========================================== 
        % Remove NaN-s or the output of the function MEAN will be NaN.
        refCoord.E = mean(navSolutions.E(~isnan(navSolutions.E)));
        refCoord.N = mean(navSolutions.N(~isnan(navSolutions.N)));
        refCoord.U = mean(navSolutions.U(~isnan(navSolutions.U)));

        %Also convert geodetic coordinates to deg:min:sec vector format
        meanLongitude = dms2mat(deg2dms(...
            mean(navSolutions.longitude(~isnan(navSolutions.longitude)))), -5);
        meanLatitude  = dms2mat(deg2dms(...
            mean(navSolutions.latitude(~isnan(navSolutions.latitude)))), -5);

        refPointLgText = ['Mean Position\newline  Lat: ', ...
                            num2str(meanLatitude(1)), '{\circ}', ...
                            num2str(meanLatitude(2)), '{\prime}', ...
                            num2str(meanLatitude(3)), '{\prime}{\prime}', ...
                         '\newline Lng: ', ...
                            num2str(meanLongitude(1)), '{\circ}', ...
                            num2str(meanLongitude(2)), '{\prime}', ...
                            num2str(meanLongitude(3)), '{\prime}{\prime}', ...
                         '\newline Hgt: ', ...
                            num2str(mean(navSolutions.height(~isnan(navSolutions.height))), '%+6.1f')];
    else
        refPointLgText = 'Reference Position';
        refCoord.E = settings.truePosition.E;
        refCoord.N = settings.truePosition.N;
        refCoord.U = settings.truePosition.U;        
    end    
     
    figureNumber = 300;
    % The 300 is chosen for more convenient handling of the open
    % figure windows, when many figures are closed and reopened. Figures
    % drawn or opened by the user, will not be "overwritten" by this
    % function if the auto numbering is not used.
 
    %=== Select (or create) and clear the figure ==========================
    figure(figureNumber);
    clf   (figureNumber);
    set   (figureNumber, 'Name', 'Navigation solutions');
 
    %--- Draw axes --------------------------------------------------------
    handles(1, 1) = subplot(1, 1 ,1);
%     handles(3, 1) = subplot(4, 2, [5, 7]);
%     handles(3, 2) = subplot(4, 2, [6, 8]);    
 
%% Plot all figures =======================================================
% 提取经纬度
llongitude = navSolutions.longitude;
llatitude = navSolutions.latitude;
po = [llatitude', llongitude'];

% 参考点
truePosition = [22.328444770087565, 114.1713630049711];

% 计算纬度和经度差异
deltaLat = llatitude - truePosition(1);
deltaLon = llongitude - truePosition(2);

% 将差异转换为米
latMeters = deltaLat * 111320;
lonMeters = deltaLon * 111320 .* cosd(truePosition(1));

% 计算平面误差
planeError = sqrt(lonMeters.^2 + latMeters.^2);

% 创建一个新的图形窗口
figure;

% 绘制散点图，颜色表示平面误差
scatter(llatitude, llongitude, 50, planeError, 'filled');
hold on;
plot(truePosition(1), truePosition(2), 'ro', 'MarkerSize', 10, 'DisplayName', 'True Position');
% 添加颜色条
colorbar;
colormap('jet'); % 使用 'jet' 颜色映射

% 添加图例和标签
xlabel('East Error (meters)');
ylabel('North Error (meters)');
title('Scatter Plot of ENU Errors with Plane Error Color');
legend('Location', 'best');
grid on;
hold off;


% 提取东、北、天坐标
EE = navSolutions.E;
NN = navSolutions.N;
UU = navSolutions.U;

% 计算速度
% 速度 = 位置差 / 时间差
% 由于时间间隔为 1 秒，速度就是相邻位置的差异
vE = diff(EE); % 东向速度
vN = diff(NN); % 北向速度
vU = diff(UU); % 天向速度

% 创建时间向量，注意速度向量比位置向量少一个元素
time = 1:length(vE);

% 创建一个新的图形窗口
figure;

% 绘制东向速度
subplot(3, 1, 1); % 3行1列的第1个子图
plot(time, vE, 'b');
xlabel('Time (s)');
ylabel('East Velocity (m/s)');
title('East Velocity Over Time');
grid on;

% 绘制北向速度
subplot(3, 1, 2); % 3行1列的第2个子图
plot(time, vN, 'g');
xlabel('Time (s)');
ylabel('North Velocity (m/s)');
title('North Velocity Over Time');
grid on;

% 绘制天向速度
subplot(3, 1, 3); % 3行1列的第3个子图
plot(time, vU, 'r');
xlabel('Time (s)');
ylabel('Up Velocity (m/s)');
title('Up Velocity Over Time');
grid on;



end