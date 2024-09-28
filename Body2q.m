function [q] = Body2q ()

global Body NBody 

% Setup the initial conditions for kinematic analysis

q = zeros(3*NBody,1);
for i=1:NBody
    n=3*i-2;
    q(n:n+1,1)=Body(i).r;
    q(n+2,1)=Body(i).theta;
end
