# AAE6102-Assignment-1-LI YUAN

# Task 1–Acquisition
Process the IF data using a GNSS SDR and generate initial acquisition outputs. The following is the generated initial acquisition outputs collected in open-sky area. （run init.m）

![image](https://github.com/user-attachments/assets/c15b8fd7-aea4-4ca4-adc3-f647a64ab180)





# Task 2 – Tracking
Adapt the tracking loop (DLL) to produce correlation plots and analyze the tracking performance. Discuss the impact of urban interference on the correlation peaks. (Multiple correlators must be implemented for plotting the correlation function)

Urban interference significantly impacts GNSS signal tracking by distorting correlation peaks. Multipath effects, caused by signal reflections off buildings, create secondary peaks, while signal attenuation reduces peak amplitude. These distortions degrade tracking accuracy, leading to position errors. Implementing multiple correlators helps visualize these effects, enabling better analysis and mitigation of urban interference on tracking performance.
![image](https://github.com/user-attachments/assets/baa124b2-1d29-473b-aa97-99d1c65c7c17)

![image](https://github.com/user-attachments/assets/1eff82c9-84ce-4892-94b4-38f87c208cec)




# Task 3 – Navigation data decoding
Decode the navigation message and extract key parameters, such as ephemeris data, for at least one satellite.

![image](https://github.com/user-attachments/assets/b4f42847-2416-425a-b18a-cb158370d6d9)







# Task 4 – Position and velocity estimation
Using the pseudorange measurements obtained from tracking, implement the Weighted Least Squares (WLS) algorithm to compute user’s position and velocity. Plot the user position and velocity, compare it to the provided ground truth values, and comment on the impact of multipath effects on the WLS solution.

WLS algorithm estimates user position and velocity using pseudorange measurements. Multipath effects introduce errors in pseudoranges, degrading WLS accuracy. Comparing WLS results to ground truth reveals position and velocity deviations, especially in urban environments. Multipath distorts signals, causing outliers and increased uncertainty in the WLS solution.

I add the         [xyzdt,navSolutions.el(activeChnList, currMeasNr), ... navSolutions.az(activeChnList, currMeasNr), ...  navSolutions.DOP(:, currMeasNr)] =...   leastSquarePos(satPositions, clkCorrRawP, settings);

![image](https://github.com/user-attachments/assets/113a483f-bacc-41f4-beda-1d6e64157dbe)   


Figure 4.1 Velocity of the receiver using WLS in open-sky area


![image](https://github.com/user-attachments/assets/02d3a57b-538f-4788-882d-b8661df31591)  ![image](https://github.com/user-attachments/assets/856a655e-7283-4085-84a6-507af6482e82)



Figure 4.2 WLS positioning results in open-sky areas (left) and urban canyons (right) using WLS

# Task 5 – Kalman filter-based positioning
Develop an Extended Kalman Filter (EKF) using pseudorange and Doppler measurements to estimate user position and velocity.


I add the function [pos,el, az, P] = ekfpos(satpos, obs, settings, pos_init, P_prev,Q) to complement the EKF-based positioning :

if(currMeasNr<3)
% 首历元初始化
pos_init = [0;0;0;0]; % 初始位置+钟差

P = diag([5^2 5^2 5^2 1]); % 初始不确定度

Q = diag([1 1 1 0.1]).^2; % 过程噪声

%
% Calculate receiver position

[xyzdt,navSolutions.el(activeChnList, currMeasNr), ...navSolutions.az(activeChnList, currMeasNr), ...navSolutions.DOP(:, currMeasNr)] =...leastSquarePos(satPositions, clkCorrRawP, settings);
pos_init=xyzdt;

else

pos_init=pos';

P=PP;

pos_init=xyzdt;

end

% 逐历元调用

[pos, navSolutions.el(activeChnList, currMeasNr), navSolutions.az(activeChnList, currMeasNr), PP] = ekfpos(satPositions, clkCorrRawP, settings, pos_init', P, Q);
 


![image](https://github.com/user-attachments/assets/ded795b4-35cb-4183-9dbd-e06e691daf63)



Figure 5.1 Velocity of the receiverusing EKF with pseudorange and Doppler measurements in open-sky areas

![image](https://github.com/user-attachments/assets/8ee22d15-fdeb-43fa-a9cb-15fae3ff2f2d)

![image](https://github.com/user-attachments/assets/7830a3a6-43d3-468e-972d-8a1b99e1f394)


Figure 5.2 Positioning results in open-sky areas (left) and urban canyons (right) with pseudorange and Doppler measurements

