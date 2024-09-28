function [] = JointAngles(t, q)

global NDriver JntDriver

code = ["neck joint", "left shoulder", "left elbow", "right shoulder",...
        "right elbow", "left leg","left knee","left ankle","left toes", ...
        "right leg","right knee","right ankle","right toes"];

% Calculate the total time of the stride
total_time = max(t);

% Create a vector of stride percentage
stride_percentage = (t / total_time) * 100;

% Plot the angle for each joint
for i = 1:(NDriver-3)  
    figure(i+1)
    legend = code(1,i);
    hold on
    plot(stride_percentage, (q(3*JntDriver(i).bodyj,:) - q(3*JntDriver(i).bodyi,:)) * 180 / pi); 
    xlabel('Stride Percentage (%)');
    ylabel('Theta (deg)');
    title(sprintf('Angle of %s joint', legend));
    axis tight
    hold off
end
