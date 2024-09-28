clear all; close all; clc;

% Global memory data
global Data file 

% Read input data for the biomechanical model
ReadDraftInput('model.txt'); 

% Read the static data
StaticData = ReadProcessData('static');

% Compute averages length
ComputeAverageLengths(StaticData);

% Choose motion
[file,~] = uigetfile('*.xlsx','Choose gait or jump');
file = file(1:end-5);

% Read data
Data = ReadProcessData(file);
% Compute positions and angles of bodies
EvaluatePositions(Data);
% Evaluate drivers
EvaluateDrivers(Data);

% Updates the date in files to be read by the kinematic analysis
WritesModelInput(strcat('BiomechanicalModel_',file,'.txt'));

