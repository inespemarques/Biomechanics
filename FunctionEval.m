function[Phi,Jac,niu,gamma] = FunctionEval(q,qd,time)

% Global variables
global flag Body NConstraints NCoordinates NBody NRevolute NDriver

% Transfer data to working variables
for i = 1:NBody
    
    i1 = 3*i-2;
    i2 = i1+1;
    i3 = i2+1;
    
    Body(i).r = q(i1:i2,1);
    Body(i).theta = q(i3,1);
    
    ctheta = cos(Body(i).theta);
    stheta = sin(Body(i).theta);
    Body(i).A = [ctheta -stheta
                 stheta ctheta];
    Body(i).B = [-stheta -ctheta
                  ctheta -stheta];
end

if (flag.acceleration == 1)
    for i = 1:NBody
    
        i1 = 3*i-2;
        i2 = i1+1;
        i3 = i2+1;

        Body(i).rd = qd(i1:i2,1);
        Body(i).thetad = qd(i3,1);
    end
end

% Initialize vectors and matrices
Phi = zeros(NConstraints,1);
Jac = zeros(NConstraints,NCoordinates);
niu = zeros(NConstraints,1);
gamma = zeros(NConstraints,1); 

line = 1; %Line of position equations

% For each revolute joint
for k = 1:NRevolute
    [Phi, Jac, niu, gamma, line] = JointRevolute(Phi,Jac,niu,gamma,k,line);
end

% For each driver 
for k = 1:NDriver
    [Phi, Jac, niu, gamma, line] = Driver(Phi,Jac,niu,gamma,k,line,time);
end

end