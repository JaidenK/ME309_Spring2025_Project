%% Input/Configuration
user_options;

%% Load the data
[TestDescription,RawData,ModelParams] = Database_LoadTestInfo(TestNumber);
Data = FormatData(RawData,DownsamplingValue);

% Lump some info into the struct to make it easier to pass around to
% functions (rather than relying on workspace variables directly)
Data.Info = struct();
Data.Info.TestNumber = TestNumber;
Data.Info.Description = TestDescription;
Data.Info.DownsamplingValue = DownsamplingValue;

% Clear the old vars from workspace to enforce consistency with struct usage
clear TestNumber TestDescription DownsamplingValue
clear RawData % This is inserted into the Data struct in the FormatData function

% Generate model parameters based on the data. 
% Initial guess can come from the first 2 sample points.
if(forceInitialParameterEstimation || (ModelParams(1) == 0))
    disp("Estimating initial parameters.");
    ModelParams = EstimateInitialModelParams(Data);
else
    disp("Using initial parameters from database.");
end

%% 

% Select n evenly spaced samples from the raw data. I don't think this is a
% valid analogy to a realtime system with a low sampling rate but it's 
% late and idgaf. 

nSamples = 10; % minimum of 5 samples because 5 unknowns in the model.

FrameInfo = [struct()];
ImpactLocations = [];

for frameNo = nSamples:Data.Raw.iImpact
    %iSample = round(linspace(1,frameNo,nSamples));
    iSample = round((frameNo-1)*log10(linspace(1,10,nSamples)))+1;
    Data.t = Data.Raw.t(iSample);
    Data.x = Data.Raw.x(iSample);
    Data.y = Data.Raw.y(iSample);
    
    [Model] = GenerateModel(whichModelType,ModelParams);
    [Error] = ComputeError(Data,Model);
    
    [Model,Error,GradientDescentResults] = GradientDescent_v2(whichModelType,Data,ModelParams,nGradientDescentIterations);
    
    ModelParams = Model.Params;

    %FrameInfo(frameNo) = struct();
    FrameInfo(frameNo).Data = Data;
    FrameInfo(frameNo).Model = Model;   
    ImpactLocations(frameNo) = Model.xImpact;
    fprintf("Frame %d of %d\n",frameNo,Data.Raw.iImpact);
end

if(generatePlots)
    %QuickPlot_Combined_Position(FrameInfo(end/2).Model,FrameInfo(end/2).Data,Error);
    AnimatedPlot_Combined_ImpactPrediction(FrameInfo,ImpactLocations);
    QuickPlot_ImpactHistogram(ImpactLocations,FrameInfo(end).Data);
    QuickPlot_ImpactError(ImpactLocations,FrameInfo(end).Data);
end
