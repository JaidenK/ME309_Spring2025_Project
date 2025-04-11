function [ModelParams] = EstimateInitialModelParams(Data)

r0 = [Data.x(1) Data.y(1)];
v0 = [Data.x(2)-Data.x(1) Data.y(2)-Data.y(1)]/(Data.t(2)-Data.t(1));
b = 0.1;

ModelParams = EncodeModelParams_VarToVec(r0,v0,b);

end

