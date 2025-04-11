function [Error] = ComputeError(Data,Model)
Error = struct();

Error.x = Model.pos_of_t.x(Data.t) - Data.x;
Error.y = Model.pos_of_t.y(Data.t) - Data.y;

Error.magnitudes = vecnorm([Error.x(:)';Error.y(:)'])';

Error.SumSquared = sum(Error.magnitudes.^2);

end

