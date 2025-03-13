function velocity = doppler(satPosPrev, satPosCurr, dopplerValues, satRxPos, deltaT)
    % doppler - Calculate receiver velocity from Doppler shift and satellite positions
    %
    % Inputs:
    %   satPosPrev   - Nx3 matrix, satellite positions at the previous time step [x, y, z] (meters)
    %   satPosCurr   - Nx3 matrix, satellite positions at the current time step [x, y, z] (meters)
    %   dopplerValues - Nx1 vector, observed Doppler shifts for each satellite (Hz)
    %   satRxPos     - 1x3 vector, receiver position [x, y, z] (meters)
    %   deltaT       - Scalar, time difference between previous and current satellite positions (seconds)
    %
    % Output:
    %   velocity - 1x3 vector, receiver velocity [vx, vy, vz] (m/s)

    % Constants
    c = 3.0e8; % Speed of light in m/s
    lambda = c / 1.57542e9; % Wavelength in meters (GPS L1 frequency)

    % Number of satellites
    nSatellites = size(satPosCurr, 1);

    % Compute satellite velocities using finite differences
    satVelocities = (satPosCurr - satPosPrev) / deltaT; % Nx3 matrix

    % Initialize matrices for least squares
    A = zeros(nSatellites, 3); % Direction vectors
    b = zeros(nSatellites, 1); % Adjusted Doppler values


    xyz=satRxPos(:,1:3);
    % Loop through each satellite
    for i = 1:nSatellites
        % Compute direction vector from receiver to satellite (normalized)
        satToRxVector = satPosCurr(i, :) - xyz; % Vector from receiver to satellite
        unitVector = satToRxVector / norm(satToRxVector); % Normalize direction vector

        % Fill matrix A with direction vectors
        A(i, :) = -unitVector; % Negative direction vector

        % Compute adjusted Doppler value
        b(i) = lambda * dopplerValues(i) - dot(satVelocities(i, :), unitVector);
    end

    % Solve for receiver velocity using least squares
    velocity = (A' * A) \ (A' * b); % 3x1 vector
end