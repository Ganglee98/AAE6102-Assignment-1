# AAE6102-Assignment-1-LI YUAN

Task 1–Acquisition
Process the IF data using a GNSS SDR and generate initial acquisition outputs. The following is the generated initial acquisition outputs collected in open-sky area.

![image](https://github.com/user-attachments/assets/d8779731-d0a3-4867-9ba7-41627b28fdc5)



Task 2 – Tracking
Adapt the tracking loop (DLL) to produce correlation plots and analyze the tracking performance. Discuss the impact of urban interference on the correlation peaks. (Multiple correlators must be implemented for plotting the correlation function)





Task 3 – Navigation data decoding
Decode the navigation message and extract key parameters, such as ephemeris data, for at least one satellite.





Task 4 – Position and velocity estimation
Using the pseudorange measurements obtained from tracking, implement the Weighted Least Squares (WLS) algorithm to compute user’s position and velocity. Plot the user position and velocity, compare it to the provided ground truth values, and comment on the impact of multipath effects on the WLS solution.


 ![image](https://github.com/user-attachments/assets/f0c6c962-5bd5-4f21-af0b-630c2304c16a)

Figure 1 Velocity of the receiver in open skys using WLS


![image](https://github.com/user-attachments/assets/8e3228f1-4bd5-473b-b798-438738c91cf3)


Figure 2 WLS positioning results in open-sky areas using WLS






Task 5 – Kalman filter-based positioning
Develop an Extended Kalman Filter (EKF) using pseudorange and Doppler measurements to estimate user position and velocity.

![image](https://github.com/user-attachments/assets/8ca830d2-7550-4937-85df-a92ed7b4eeef)



Figure 3 Velocity of the receiverusing EKF with pseudorange measurements in open sky areas


![image](https://github.com/user-attachments/assets/7a041f05-7bd3-43b1-8e8e-b7190b432352)

Figure 4 Positioning results in open-sky areas with pseudorange in open sky areas



![image](https://github.com/user-attachments/assets/9ecd88c5-83c6-4c87-bf17-c59e44b8415f)

Figure 5 Velocity of the receiverusing EKF with pseudorange and Doppler measurements in open sky areas



![image](https://github.com/user-attachments/assets/ff9a1bc5-66b7-4472-a87e-026a62f388ae)


Figure 6 Positioning results in open-sky areas with pseudorange and Doppler measurements in open sky areas

