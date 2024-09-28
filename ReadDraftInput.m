function ReadDraftInput(model)

global NBody NRevolute NGround NDriver  Body JntRevolute JntDriver

% Read the input file

H = dlmread(model);

% Store the general dimensions of the system
NBody=H(1,1);
NRevolute=H(1,2);
NGround=H(1,3);
NDriver=H(1,4);
line = 1;

% Store the data for the rigid body information
for i = 1:NBody
    line=line+1;
    Body(i).pi=H(line,2);
    Body(i).pj=H(line,3);
    Body(i).PCoM=H(line,4);
end

% Stores the data for the revolute joints
for k = 1:NRevolute 
    line = line + 1;
    JntRevolute(k).i = H(line,2);
    JntRevolute(k).j = H(line,3);
    JntRevolute(k).spi = H(line,4:5)';
    JntRevolute(k).spj = H(line,6:7)';
end 

% Stores the data for the driver joints
for k=1:NDriver
    line=line+1;
    JntDriver(k).type=H(line,2);
    JntDriver(k).i=H(line,3);
    JntDriver(k).coordi=H(line,4);
    JntDriver(k).j=H(line,5);
    JntDriver(k).coordj=H(line,6);
    JntDriver(k).filename=H(line,7);
end

end