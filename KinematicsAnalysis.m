clear all; close all; clc;


% Define global variables
global tstart tstep tend Nsteps NCoordinates

% Input data: read, pre-process
ReadInput();


% Allocate memory for q, qd, qdd
q = zeros(NCoordinates, Nsteps+1);
qd = zeros(NCoordinates, Nsteps+1);
qdd = zeros(NCoordinates, Nsteps+1);

% Initialize q
q(:,1) = Body2q();

% Add iteration counters
i = 1;
time = tstart:tstep:tend;

% For each time step, do kinematic analysis

for instant = time
    
    % Updating time step
    i = i+1; 
    
    % Take it the previous q as a good estimation for next this q
    q(:,i) = q(:,i-1); 
    
    % Position Analysis
    q(:,i) = PositionAnalysis(q(:,i),instant);
    
    % Velocity Analysis
    qd(:,i) = VelocityAnalysis(q(:,i),instant);
    
    % Acceleration Analysis
    qdd(:,i) = AccelerationAnalysis(q(:,i),qd(:,i),instant);
    
% End analysis
end

% Report of the results
ReportResults(q,qd,qdd,time);

