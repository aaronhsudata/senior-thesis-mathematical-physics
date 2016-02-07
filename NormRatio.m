%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File:       NormRatio.m
%%% Function:   NormRatio(vector)
%%% Purpose:    Computes, for a given vector, the norm ratio of
%%% (infinity-norm)/(2-norm).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function result = NormRatio(vector)

% Calculate infinity-norm divided by two-norm of the desired eigenvector
result = max(abs(vector)) / norm(vector,2);