function [Error] = ComputeError(Data,Model)
Error = struct();

% Error:
% Where is it at some time vs where does the model say it should be at that
% time.

Error.x = Data.x - Model.pos_of_t.x(Data.t);
Error.y = Data.y - Model.pos_of_t.y(Data.t);

Error.magnitudes = vecnorm([Error.x(:)';Error.y(:)'])';

Error.SumSquared = sum(Error.magnitudes.^2);

Error.Mean = sqrt(Error.SumSquared)/length(Error.x);

end

