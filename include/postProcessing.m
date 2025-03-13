%% Initialization =========================================================
disp ('Starting processing...');

[fid, message] = fopen(settings.fileName, 'rb');

%Initialize the multiplier to adjust for the data type
if (settings.fileType==1) 
dataAdaptCoeff=1;
else
dataAdaptCoeff=2;
end

%If success, then process the data
%  if (fid > 0)
% 
% Move the starting point of processing. Can be used to start the
% signal processing at any point in the data record (e.g. good for long
% records or for signal processing in blocks).
fseek(fid, dataAdaptCoeff*settings.skipNumberOfBytes, 'bof'); 

%% Acquisition ============================================================

% Do acquisition if it is not disabled in settings or if the variable
% acqResults does not exist.
if ((settings.skipAcquisition == 0) || ~exist('acqResults', 'var'))
    
    % Find number of samples per spreading code
    samplesPerCode = round(settings.samplingFreq / ...
                       (settings.codeFreqBasis / settings.codeLength));
    
    
    % At least 42ms of signal are needed for fine frequency estimation
    codeLen = max(42,settings.acqNonCohTime+2);
    % Read data for acquisition.
    data  = fread(fid, dataAdaptCoeff*codeLen*samplesPerCode, settings.dataType)';

    if (dataAdaptCoeff==2)    
        data1=data(1:2:end);    
        data2=data(2:2:end);    
        data=data1 + 1i .* data2;    
    end

    %--- Do the acquisition -------------------------------------------
    disp ('   Acquiring satellites...');
    acqResults = acquisition(data, settings);
    save("acqResults")
end

% Initialize channels and prepare for the run ============================

% Start further processing only if a GNSS signal was acquired (the
% field FREQUENCY will be set to 0 for all not acquired signals)
if (any(acqResults.carrFreq))
    channel = preRun(acqResults, settings);
    showChannelStatus(channel, settings);
else
    % No satellites to track, exit
    disp('No GNSS signals detected, signal processing finished.');
    trkResults = [];
    navResults = [];
    return;
end

% Track the signal =======================================================
if ~exist("trkResults.mat")
startTime = now;
disp (['   Tracking started at ', datestr(startTime)]);

% Process all channels for given data block
[trkResults, ~] = tracking(fid, channel, settings);
save("trkResults")
else
    load("trkResults.mat");
end
Close the data file
fclose(fid);
disp(['   Tracking is over (elapsed time ', ...
                                    datestr(now - startTime, 13), ')'])                      

% Calculate navigation solutions =========================================
disp('   Calculating navigation solutions...');

[navResults, ~] = postNavigation(trkResults, settings);
save("navResults")

disp('   Processing is complete for this data block');
disp('Post processing of the signal is over.');
%% Plot all results ===================================================
disp ('   Ploting results...');

if 1
    plotAcquisition(acqResults);
end

if 1
    plotTracking(1:settings.numberOfChannels, trkResults, settings);
end

if settings.plotNavigation
    plotNavigation(navResults, settings);
end
disp('Post processing of the signal is over.');

