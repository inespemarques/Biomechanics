function [] = ReportResults(q,qd,qdd,time)

global Body NBody file Nsteps

% Remove the first 10 steps and last 10 steps of gait cycle
if strcmp(file,'gait')
    q = q(:,12:end-10); % 12 because the first one in q is the q_initial (still before entering in the cycle)
    qd = qd(:,12:end-10); % 12 because the first one in q is 0 (still before entering in the cycle)
    qdd = qdd(:,12:end-10);% 12 because the first one in q is 0 (still before entering in the cycle)
    time = time(11:end-10);
    Nsteps = Nsteps - 20;
else
    q = q(:,2:end);
    qd = qd(:,2:end);
    qdd = qdd(:,2:end);
    % time remains the same
    % Nsteps remain the same
end

for i = 1:NBody
    x = 3*i-2;
    y = 3*i-1;
    theta = 3*i;
    for k = 1:Nsteps
       
        A = [cos(q(theta,k)) -sin(q(theta,k)); sin(q(theta,k)) cos(q(theta,k))];
        csi_global = A*[1;0];
        pProx(:,k) = q(x:y,k)+csi_global*(1-Body(i).PCoM)*Body(i).Length; % distal point
        pDist(:,k) = q(x:y,k)-csi_global*(Body(i).PCoM)*Body(i).Length; %proximal point

    end
    Body(i).pProx = pProx;
    Body(i).pDist = pDist;

end

 figure
 r = 1:Nsteps;
 Animate(r);

 % Plots of the angle of the joints 
 JointAngles(time,q); 

 % Plot of the position, velocity and acceleration of the bodies
 KinematicResults(q,qd,qdd,time);


end


