% Unit Tests


%% Test 1 - DecodeModelParams_FromVecToVar
try
    % Arrange
    clear all; close all; clc;
    params = [1 2 3 4 5];
    
    % Act
    [g,r0,v0,b] = DecodeModelParams_FromVecToVar(params);
    
    % Verify
    assert(g==9.81);
    assert(all(r0 == [1 2]));
    assert(all(v0 == [3 4]));
    assert(b == 5);

    disp("Test 1 PASS");
catch ME
    warning("Test 1 FAIL");
    %rethrow(ME)
end

