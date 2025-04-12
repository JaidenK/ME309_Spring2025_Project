% This is supposed to be a replica of the downsampling function of the
% signial processing toolbox
function y = downsample(x,downsampling_period)
y=[x(1)];
for i = 1:length(x)
    if mod(i,downsampling_period)== 0
        y(end+1)= x(i);
    end
end


end