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



![image](https://github.com/user-attachments/assets/1c017744-117a-4058-90f7-6eb117de5312)


Figure 5 Velocity of the receiverusing EKF with pseudorange and Doppler measurements in open sky areas






Figure 6 Positioning results in open-sky areas with pseudorange and Doppler measurements in open sky areas

