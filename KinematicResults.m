function [] = KinematicResults(q, qd, qdd, t)

global NBody
code = ["trunk", "head", "left arm", "left forearm",...
        "Right arm", "Right Forearm","Left Thigh ","Left Leg","Left Foot", ...
        "Left Toes","Right Thigh","Right Leg","Right Foot","Right Toes" ];
% Calculate the total time of the stride

total_time = max(t);

% Create a vector of stride percentage
stride_percentage = (t / total_time) * 100;
j=1;
% Plot for each body
for i = 1:2:2*NBody
    
    figure
    subplot(231)
    plot(stride_percentage, q(i,:)); xlabel('Stride Percentage (%)');
    title(['Position x [m] - ' code(j)]);
    subplot(232)
    plot(stride_percentage, qd(i,:)); xlabel('Stride Percentage (%)');
    title(['Velocity x [m/s] - ' code(j)]);
    subplot(233)
    plot(stride_percentage, qdd(i,:)); xlabel('Stride Percentage (%)');
    title(['Acceleration x [m/s^2] - ' code(j)]);
    subplot(234)
    plot(stride_percentage, q(i+1,:)); xlabel('Stride Percentage (%)');
    title(['Position z [m] - ' code(j)]);
    subplot(235)
    plot(stride_percentage, qd(i+1,:)); xlabel('Stride Percentage (%)');
    title(['Velocity z [m/s] - ' code(j)]);
    subplot(236)
    plot(stride_percentage, qdd(i+1,:)); xlabel('Stride Percentage (%)');
    title(['Acceleration z [m/s^2] - ' code(j)]);
    j=j+1;
end