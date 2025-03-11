# AAE6102-Assignment-1-LI YUAN

Task 1–Acquisition
Process the IF data using a GNSS SDR and generate initial acquisition outputs. The following is the generated initial acquisition outputs collected in open-sky area.

![image](https://github.com/user-attachments/assets/c15b8fd7-aea4-4ca4-adc3-f647a64ab180)




Task 2 – Tracking
Adapt the tracking loop (DLL) to produce correlation plots and analyze the tracking performance. Discuss the impact of urban interference on the correlation peaks. (Multiple correlators must be implemented for plotting the correlation function)

Urban interference significantly impacts GNSS signal tracking by distorting correlation peaks. Multipath effects, caused by signal reflections off buildings, create secondary peaks, while signal attenuation reduces peak amplitude. These distortions degrade tracking accuracy, leading to position errors. Implementing multiple correlators helps visualize these effects, enabling better analysis and mitigation of urban interference on tracking performance.

![image](https://github.com/user-attachments/assets/1eff82c9-84ce-4892-94b4-38f87c208cec)




Task 3 – Navigation data decoding
Decode the navigation message and extract key parameters, such as ephemeris data, for at least one satellite.

![image](https://github.com/user-attachments/assets/4327f74b-7a14-4b3b-863b-678edf51abbb)






Task 4 – Position and velocity estimation
Using the pseudorange measurements obtained from tracking, implement the Weighted Least Squares (WLS) algorithm to compute user’s position and velocity. Plot the user position and velocity, compare it to the provided ground truth values, and comment on the impact of multipath effects on the WLS solution.

WLS algorithm estimates user position and velocity using pseudorange measurements. Multipath effects introduce errors in pseudoranges, degrading WLS accuracy. Comparing WLS results to ground truth reveals position and velocity deviations, especially in urban environments. Multipath distorts signals, causing outliers and increased uncertainty in the WLS solution.


![image](https://github.com/user-attachments/assets/113a483f-bacc-41f4-beda-1d6e64157dbe)


Figure 1 Velocity of the receiver in open skys using WLS


![image](https://github.com/user-attachments/assets/02d3a57b-538f-4788-882d-b8661df31591)


Figure 2 WLS positioning results in open-sky areas using WLS



![image](https://github.com/user-attachments/assets/ded795b4-35cb-4183-9dbd-e06e691daf63)



Figure 5 Velocity of the receiverusing EKF with pseudorange and Doppler measurements in open sky areas

![image](https://github.com/user-attachments/assets/8ee22d15-fdeb-43fa-a9cb-15fae3ff2f2d)


Figure 6 Positioning results in open-sky areas with pseudorange and Doppler measurements in open sky areas

