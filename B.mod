


var Y{I, T} >= 0; 
var X{I, T} binary;  
var Z{I, T} binary;  
param CA{I};  
param CP{I};  
param CF{I};  
param CV{I}; 
param Pmin{I};  
param Pmax{I};  
param U{I};  
param V{I};  
param PI{I}; 
param D{T};  
param r{T}; 


set I;  
set T := 1..l;  
param l;

maximize TotalBenefit:
	sum {i in I, t in T} (PI[i] * Y[i, t]) 
     - sum {i in I, t in T} (CA[i] * Z[i, t] + CP[i] * (1-Z[i, t]) + CF[i] * X[i, t] + CV[i] * Y[i, t]);


subject to ProductionLimits {i in I, t in T}:
    Pmin[i] <= Y[i, t] <= Pmax[i];

subject to ProductionChanges {i in I, t in T: t > 1}:
    -V[i] <= Y[i, t] - Y[i, t-1] <= U[i];

subject to DemandSatisfaction {t in T}:
    sum {i in I} Y[i, t] >= D[t];

subject to CorrectedReserveConstraint {t in T}:
    sum {i in I} Y[i, t] >= r[t];
    subject to StopConstraints {i in I, t in T: t > 1}:
    (1-Z[i, t]) >= X[i, t-1] - X[i, t];

subject to StartStopRelation {i in I, t in T}:
    Z[i, t] + (1-Z[i, t]) <= 1;
subject to RelationBinaryVa {i in I, t in T}:
	Y[i, t] <= Pmax[i] * X[i, t];
    
subject to RelationBinaryVa2 {i in I, t in T}:
	Y[i, t] >= Pmax[i] * X[i, t];
	
subject to StartConstraints {i in I, t in T: t > 1}:
    Z[i, t] >= X[i, t] - X[i, t-1];

ç