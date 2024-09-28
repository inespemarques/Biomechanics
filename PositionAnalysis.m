function[q] = PositionAnalysis(q,time)

% Global variables
global tol MaxIter flag

flag.position = 0;
flag.Jacobian = 0;
flag.velocity = 0;
flag.acceleration = 0;

% Define initial error
error = 10*tol;
it = 0;
 
% Start the NR equations
while (error>tol)
    it = it+1;
    
    % To avoid infinite loop (no convergence)
    if (it>MaxIter) 
        disp('There is something running more than what it is supposed - Position Analysis: it > MaxIter')
        break
    end
    
    % Form the constraint equations vector and the Jacobian
    flag.position = 1;
    flag.Jacobian = 1;
    
    [Phi,Jac,~,~] = FunctionEval (q,[],time);
    
    % Calculate correction step
    Deltaq = Jac\Phi;
   
    % Evaluate new positions and error
    q = q - Deltaq;
    error = max(abs(Deltaq));
end


end