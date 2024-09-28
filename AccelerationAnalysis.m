function[qdd] = AccelerationAnalysis(q,qd,time)

% Global variables
global  flag


flag.position = 0;
flag.Jacobian = 1;
flag.velocity = 0;
flag.acceleration = 1;
[~,Jac,~,gamma] = FunctionEval (q,qd,time);

% Solve system and equations
qdd = Jac\gamma;

end