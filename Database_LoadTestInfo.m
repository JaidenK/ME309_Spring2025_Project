function [TestDescription,RawData,ModelParams] = Database_LoadTestInfo(TestNumber)

% The DataDirectory.mat file contains only the variable DataDirectory,
% which is a string containg the path of the folder containing all the
% Tracker data. The only reason it's not hard-coded right here is to allow
% you to modify it to point to your local copy of the data 
load DataDirectory.mat DataDirectory

% Construct the filename and load the data.
filename = sprintf("Throw_%02d.txt",TestNumber);
full_path = fullfile(DataDirectory,filename);
RawData = readmatrix(full_path);

% Construct the initial guess for the model parameters and provide a
% description of the test.
ModelParams = [0,0,0,0,0];
TestDescription = "[No Description]";
switch(TestNumber)
    case 1
        TestDescription = "Ball; No Chute; Low Arc";
        ModelParams = [1,1,1,1,0.1];
    case 2
        TestDescription = "Ball; No Chute; High Arc";
        ModelParams = [1.283122106137774,1.642406551663037,-0.204654716244155,8.907081047040949,0.044127261050646];
    case 3
        TestDescription = "Ball; Med. Chute; Low Arc; Clean Chute Dynamics";
        ModelParams = [1.193931719840421,1.989163442011656,-3.939831739086767,1.260457045291940,0.335924873674815];
    case 4
        TestDescription = "Ball; Med. Chute; High Arc; Clean Chute Dynamics";
        ModelParams = [-1.871997654204061,2.328357930556231,2.715263611801111,5.872290524153842,0.309757887070275];
    case 5
        TestDescription = "Rubber Duck; No Chute; Low Arc";
        ModelParams = [0.200000000000000,1.995000000000000,-4.544214285714285,1.476190476190472,0.100000000000000];
    case 6
        TestDescription = "Rubber Duck; No Chute; High Arc";
        ModelParams = [1.28683 1.57797 -1.91877 8.64988 0.221963];
    case 7
        TestDescription = "Rubber Duck; No Chute; High Arc";
        ModelParams = [0.680127 1.64703 -1.86011 8.4653 0.155544];        
    case 8
        TestDescription = "Ball; Large Chute; High Arc; Chute Apex Whip Dynamics";
end

end
