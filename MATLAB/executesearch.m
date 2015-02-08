%  Plane Search V0.2
%  executesearch.m
%  
%  flightpath

cells=101;
cells2=cells*cells;
%Set cells to the amount of cells per side of probability distribution

P0=(abs(peaks(cells)/(sum(sum(abs(peaks(cells)))))));
%P0 is initial probability distribution, representing the probability
%that the plane is in each cell.
%This command populates it with the peaks data set of size
%cells x cells and converts it to a probability distribution
%(sum of all elements = 1)

ships=3;
shipPos=zeros(cells);
%ships = # of ships searching
%Initiliazes matrix shipPos;
%shipPos tracks the position of each ship

searchCount=zeros(cells);
%Initializes matrix searchCount;
%searchCount tracks the number of times each cell has been searched

alpha = 0.45;

%Alpha is the probability of finding the plane while searching for it
%in a particular cell with a given technology.


shipPlacer = P0;
maxP0valuesIni=zeros(1,ships);
maxP0locIni=zeros(1,ships);
for n=1:ships
    maxP0ini=find(shipPlacer == max(shipPlacer(:)));
    shipPos(maxP0ini)=1;
    searchCount(maxP0ini)=1;
    shipPlacer(maxP0ini)=0;
    maxP0valuesIni(n) = P0(maxP0ini);
    maxP0locIni(n)= maxP0ini;
end

%This loop places the ships in the cells with the highest probability
%of conducting a successful search.
%It stores the maximum initial P0 values in the vector maxP0valuesIni
%and the original location of those values in the vector maxP0locIni

epsilonMat=zeros(cells,cells);
for n=1:cells2
    epsilonMat(n)=(P0(n).*betaRef(n,alpha,searchCount));
end

%Initiates and populates the epsilon matrix epsilonMat without
%the cost function.

for n=1:cells2
    P0(n)=P0(n).*((1/(1-(P0(n).*betaRef(n,alpha,searchCount)))));
end

%Applies Bayesian Search Theory for all cells using the unsearched
%state. The loop below applies the Bayesian Search Theory for all cells
%using the searched state for the searched cells.

for n=1:ships
    P0(maxP0locIni(n))=maxP0valuesIni(n)*((1-betaRef(maxP0locIni(n),alpha,searchCount))/...
        (1-P0(n).*betaRef(n,alpha,searchCount)));
end
