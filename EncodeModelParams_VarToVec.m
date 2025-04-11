function [ModelParams] = EncodeModelParams_VarToVec(r0,v0,b)

ModelParams = [r0(1) r0(2) v0(1) v0(2) b];

end

