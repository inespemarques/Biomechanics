function[qd] = VelocityAnalysis(q,time)

% Global variables
global flag

% Form Jacobian matrix
flag.position = 0;
flag.Jacobian = 1;
flag.velocity = 1;
[~,Jac,niu,~] = FunctionEval (q,[],time);

% Solve system and equations
qd = Jac\niu;

end