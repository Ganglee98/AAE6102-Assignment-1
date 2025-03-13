function [pos,el, az, dop] = leastSquarePos(satpos,obs,settings)

%=== Initialization =======================================================
nmbOfIterations = 100;

dtr     = pi/180;
pos     = zeros(4, 1);   % center of earth
pos1     = zeros(4, 1);   % center of earth
X       = satpos;
nmbOfSatellites = size(satpos, 2);

A       = zeros(nmbOfSatellites, 4);
omc     = zeros(nmbOfSatellites, 1);
weight = ones(nmbOfSatellites, 1);
az      = zeros(1, nmbOfSatellites);
el      = az;
%=== Iteratively find receiver position ===================================
for iter = 1:nmbOfIterations

if(iter>1)
    
distance = sqrt((pos(1) - pos1(1))^2 + (pos(2) - pos1(2))^2 + (pos(3) - pos1(3))^2);
if distance < 0.01
    break;
end
end

    for i = 1:nmbOfSatellites
        if iter == 1
            %--- Initialize variables at the first iteration --------------
            Rot_X = X(:, i);
            trop = 2; 
        else
            %--- Update equations -----------------------------------------
            rho2 = (X(1, i) - pos(1))^2 + (X(2, i) - pos(2))^2 + ...
                   (X(3, i) - pos(3))^2;
            traveltime = sqrt(rho2) / settings.c ;

            Rot_X = e_r_corr(traveltime, X(:, i));
            
            %--- Find the elevation angel of the satellite ----------------
            [az(i), el(i), ~] = topocent(pos(1:3, :), Rot_X - pos(1:3, :));

            if (settings.useTropCorr == 1)
                %--- Calculate tropospheric correction --------------------
                trop = tropo(sin(el(i) * dtr), ...
                             0.0, 1013.0, 293.0, 50.0, 0.0, 0.0, 0.0);
            else
                % Do not calculate or apply the tropospheric corrections
                trop = 0;
            end
            weight(i)=sin(el(i))^2;
        end % if iter == 1 ... ... else 

        %--- Apply the corrections ----------------------------------------
        omc(i) = ( obs(i) - norm(Rot_X - pos(1:3), 'fro') - pos(4) - trop ); 

        %--- Construct the A matrix ---------------------------------------
        A(i, :) =  [ (-(Rot_X(1) - pos(1))) / norm(Rot_X - pos(1:3), 'fro') ...
                     (-(Rot_X(2) - pos(2))) / norm(Rot_X - pos(1:3), 'fro') ...
                     (-(Rot_X(3) - pos(3))) / norm(Rot_X - pos(1:3), 'fro') ...
                     1 ];
        
        % weight by hd
        
    end 

    % These lines allow the code to exit gracefully in case of any errors
    if rank(A) ~= 4
        pos     = zeros(1, 4);
        dop     = inf(1, 5);
        fprintf('Cannot get a converged solotion! \n');
        return
    end

    %--- Find position update (in the least squares sense)-----------------
    %x   = A \ omc;

    %--- Find position update (for the weighted least square)
    W=diag(weight);
    C=W'*W;
    x=(A'*C*A)\(A'*C*omc);
    pos1=pos;
    %--- Apply position update --------------------------------------------
    pos = pos + x;

end

pos = pos';

if nargout  == 4
    dop     = zeros(1, 5);
    Q       = inv(A'*A);
    dop(1)  = sqrt(trace(Q));                       % GDOP    
    dop(2)  = sqrt(Q(1,1) + Q(2,2) + Q(3,3));       % PDOP
    dop(3)  = sqrt(Q(1,1) + Q(2,2));                % HDOP
    dop(4)  = sqrt(Q(3,3));                         % VDOP
    dop(5)  = sqrt(Q(4,4));                         % TDOP
end 
