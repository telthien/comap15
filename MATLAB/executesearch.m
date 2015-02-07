%  Plane Search V0.1
%  executesearch.m
%  Populates an initial probability matrix P0 based on:
%  flightpath

cells=11;
%Set cells to the amount of cells per side of probability distribution

P0=zeros(cells,cells);
%P0 is initial probability distribution

%iterate is the amount of cells above and below the middle row of the
%probability distribution
min0=0.9;
max0=1.0;
P0(round(cells/2),:)=randomizerow(cells,min0,max0);
iterate = (cells-1)/2;
decreaseFactor=1.1;
for n1 = 1:iterate
    P0(round(cells/2)-n1,:)= ...
        randomizerow(cells,min0/(decreaseFactor^n1),max0/(decreaseFactor^n1));
    P0(round(cells/2)+n1,:)= ...
        randomizerow(cells,min0/(decreaseFactor^n1),max0/(decreaseFactor^n1));
end

planeAlpha = 0.3;
trialsMat = zeros(cells);
trialsMat(6,6) = 1;

epsilonMat = P0 .* ((1 - planeAlpha).^trialsMat) * planeAlpha;
epsilonMat;
%P0
    