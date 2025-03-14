function [corrected] = AngleRolloverCorrection(theta)
    diff_theta = diff(theta);
    iRollover = find(abs(diff_theta)>pi);
    signs = sign(diff_theta(iRollover));
    for i=1:length(iRollover)
        theta(iRollover(i)+1:end) = theta(iRollover(i)+1:end) - 2*pi*signs(i);
    end
    corrected = theta;
end

% Test:
% theta = deg2rad(mod([0:5:500 500:-5:-360],360)); clf; plot(theta); hold on; plot(AngleRolloverCorrection(theta)); legend("in","out");