%  Plane Search V0.2
%  executesearch.m
%  
%  flightpath

cells=7;
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


%%%epsilonMat=(P0.*alpha.*((1-alpha).^(k-1)))/(1+d);
%Initializes the matrix epsilonMat, which stores the value for epsilon
%in each cell.

shipPlacer = P0;
for n=1:ships
    maxP0ini=find(P0 == max(shipPlacer(:)))
    shipPos(maxP0ini)=1;
    shipPlacer(maxP0ini)=0;
    maxP0valuesIni(n) = P0(maxP0ini);
    maxP0locIni(n)= maxP0ini;
end

%Finds the index of the current maximum value of P0.

%P0(maxP0)
%%%shipPos(maxP0)=1;
%P0(maxP0)=(P0(maxP0)*betaRef(maxP0,alpha,searchCount));