% Noah Sutton-Smolin
% Monte Carlo multithreaded search of the model space

threaded = 1;
numTrials = 25;

%Input ranges
searchItersMin = 10;
searchItersMax = 1000;
alphaMin = 0.25;
alphaMax = 0.5;
shipCountMin = 5;
shipCountMax = 50;

%Computed ranges
searchItersRng = searchItersMax - searchItersMin;
alphaRng = alphaMax - alphaMin;
shipCountRng = shipCountMax - shipCountMin;

%Input collection
m_searchIters = zeros(1,numTrials);
m_alpha = zeros(1,numTrials);
m_shipCount = zeros(1,numTrials);

%Output collection
m_percentSuccess = zeros(1,numTrials);
m_distanceTraveled = zeros(1,numTrials);
m_numSearchedSquares = zeros(1,numTrials);
m_computationTime = zeros(1,numTrials);

%Generate data

if threaded == 1
    matlabpool open
end

disp('Generating data...')
t0 = clock;
parfor i=1:numTrials
    randSearchIters = round(rand*searchItersRng) + searchItersMin;
    randAlpha = (round(rand*alphaRng*1000)/1000)+alphaMin;
    randShipCount = round(rand*shipCountRng)+shipCountMin;

    m_searchIters(i) = randSearchIters;
    m_alpha(i) = randAlpha;
    m_shipCount(i) = randShipCount;
end
disp(num2str(round(etime(clock,t0)*1000)));

disp('Running simulation...')
t0 = clock;
parfor i=1:numTrials
    randSearchIters = m_searchIters(i);
    randAlpha = m_alpha(i);
    randShipCount = m_shipCount(i);
    %disp(strcat(num2str(i),'|',num2str(randSearchIters),'|',num2str(randAlpha),'|',num2str(randShipCount)));

    t1 = clock;
    [pr1, pr2, pr3] = executesearchfn(randSearchIters, randShipCount, randAlpha);
    
    m_percentSuccess(i) = pr1;
    m_distanceTraveled(i) = pr2;
    m_numSearchedSquares(i) = pr3;
    m_timeSearched(i) = round(etime(clock,t0)*1000);
end
disp(num2str(round(etime(clock,t0)*1000)));

if threaded == 1
    matlabpool close
end