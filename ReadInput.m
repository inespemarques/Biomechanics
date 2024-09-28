function ReadInput

% Function to read an input file (written as txt) for the biomechanical
% system to be studied

global NBody NRevolute NGround NDriver NConstraints Body JntRevolute JntDriver tstart tstep tend Nsteps tol MaxIter NCoordinates file
 
% Load the input file name
[file,~] = uigetfile('*.txt','Select the kinematic model file (gait or jump)');
H = dlmread(file);
file = file(20:end-4);

NBody = H(1,1);
NRevolute = H(1,2);
NGround = H(1,3);
NDriver = H(1,4);


line = 1;

% Store data for rigid body transformation

for i = 1:NBody
    line = line+1;
    Body(i).r = H(line,2:3)';
    Body(i).theta = H(line,4);
    Body(i).PCoM = H(line,5);
    Body(i).Length = H(line,6);
end

% Store data for revolute joint

for k = 1:NRevolute
    line = line+1;
    JntRevolute(k).i = H(line,2);
    JntRevolute(k).j = H(line,3);
    JntRevolute(k).spi = H(line,4:5)';
    JntRevolute(k).spj = H(line,6:7)';
end

% Store data for driver
for k = 1:NDriver
    line = line+1;
    JntDriver(k).type = H(line,2);
    JntDriver(k).bodyi = H(line,3);
    JntDriver(k).coordi = H(line,4);
    JntDriver(k).bodyj = H(line,5);
    JntDriver(k).coordj = H(line,6);
end


for i = 1:NDriver 
    name  =  sprintf('%d.txt',i);
    D  =  dlmread(strcat(file,name));
    t = D(:,1);
    z = unwrap(D(:,2));
   
    % Spline interpolation
    JntDriver(i).p = spline(t,z);

    % Initialize arrays
    Nsplines = JntDriver(i).p.pieces;
    coefs_d = zeros(Nsplines,3);
    coefs_dd = zeros(Nsplines,2);

    % Calculate spline 1st derivative and build v for each driver
    for k = 1:Nsplines
        coefs_d(k,:) = polyder(JntDriver(i).p.coefs(k,:));
    end
    JntDriver(i).v = mkpp(t,coefs_d);

    % Calculate spline 2nd derivative and build a for each driver
    for k = 1:Nsplines
        coefs_dd(k,:) = polyder(JntDriver(i).v.coefs(k,:));
    end
    JntDriver(i).a = mkpp(t,coefs_dd);
end

% Store data for analysis period and time step
line = line+1; 
tstart = H(line,1);
tstep = H(line,2);
tend = H(line,3);
Nsteps = round((tend-tstart)/tstep) + 1;

NCoordinates = 3*NBody;
NConstraints = 2*NRevolute+NDriver;
tol = 10^-6;
MaxIter = 12;

end