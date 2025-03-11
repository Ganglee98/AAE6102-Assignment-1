# AAE6102-Assignment-1-LI YUAN

Task 1–Acquisition
Process the IF data using a GNSS SDR and generate initial acquisition outputs. The following is the generated initial acquisition outputs collected in open-sky area.

![image](https://github.com/user-attachments/assets/c15b8fd7-aea4-4ca4-adc3-f647a64ab180)




Task 2 – Tracking
Adapt the tracking loop (DLL) to produce correlation plots and analyze the tracking performance. Discuss the impact of urban interference on the correlation peaks. (Multiple correlators must be implemented for plotting the correlation function)

![image](https://github.com/user-attachments/assets/a0804ba9-e662-4277-9ef8-7f6c49c72b4c)




Task 3 – Navigation data decoding
Decode the navigation message and extract key parameters, such as ephemeris data, for at least one satellite.

![image](https://github.com/user-attachments/assets/4327f74b-7a14-4b3b-863b-678edf51abbb)






Task 4 – Position and velocity estimation
Using the pseudorange measurements obtained from tracking, implement the Weighted Least Squares (WLS) algorithm to compute user’s position and velocity. Plot the user position and velocity, compare it to the provided ground truth values, and comment on the impact of multipath effects on the WLS solution.


![image](https://github.com/user-attachments/assets/113a483f-bacc-41f4-beda-1d6e64157dbe)


Figure 1 Velocity of the receiver in open skys using WLS


![image](https://github.com/user-attachments/assets/02d3a57b-538f-4788-882d-b8661df31591)


Figure 2 WLS positioning results in open-sky areas using WLS






Task 5 – Kalman filter-based positioning
Develop an Extended Kalman Filter (EKF) using pseudorange and Doppler measurements to estimate user position and velocity.

![image](https://github.com/user-attachments/assets/82a37abe-929e-4f10-a7e6-7ee8f025f08c)




Figure 3 Velocity of the receiverusing EKF with pseudorange measurements in open sky areas


![image](https://github.com/user-attachments/assets/78f45a03-a019-4757-a0e3-68bc6c74c35b)


Figure 4 Positioning results in open-sky areas with pseudorange in open sky areas



![image](https://github.com/user-attachments/assets/ded795b4-35cb-4183-9dbd-e06e691daf63)



Figure 5 Velocity of the receiverusing EKF with pseudorange and Doppler measurements in open sky areas

![image](https://github.com/user-attachments/assets/8ee22d15-fdeb-43fa-a9cb-15fae3ff2f2d)


Figure 6 Positioning results in open-sky areas with pseudorange and Doppler measurements in open sky areas

