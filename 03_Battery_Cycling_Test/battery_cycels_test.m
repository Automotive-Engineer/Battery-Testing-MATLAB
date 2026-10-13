clear;
clc;
close all;

%% Battery Test 3 - Cycle Life Test

%% Test Parameters

Capacity_rated = 2.5 ;        % Rated battery capacity (Ah)
Number_of_Cycles = 10;      % Number of cycles

%% Cycle Number

Cycles = 1:Number_of_Cycles;

%% Capacity Degradation Model

Degradation_rate = 0.002;    % Capacity loss per cycle (training assumption)

Capacity = Capacity_rated .* (1 - Degradation_rate .* (Cycles - 1));

%% State of Health (SOH)

SOH = (Capacity ./ Capacity_rated) .* 100;

%% Capacity Retention

Capacity_retention = Capacity ./ Capacity_rated .* 100;

%% Plot Capacity vs Cycle

figure;

plot(Cycles,Capacity,'LineWidth',1.5);

xlabel('Cycle Number');
ylabel('Capacity (Ah)');
title('Battery Capacity Degradation');

grid on;

%% Plot SOH vs Cycle

figure;

plot(Cycles,SOH,'LineWidth',1.5);

xlabel('Cycle Number');
ylabel('SOH (%)');
title('Battery SOH vs Cycle');

grid on;

%% Capacity Fade
Capacity_Fade = 100-SOH (end)
fprintf('Capacity Fade =%.2f %%\n',Capacity_Fade);

%% Degradation Rate

Degradation_Rate = (SOH(1) - SOH(end)) / (Cycles(end) - Cycles(1));
fprintf('SOH Degradation Rate = %.4f %% per cycle\n',Degradation_Rate);
%% Important Results

Initial_Capacity = Capacity(1);
Final_Capacity = Capacity(end);

Initial_SOH = SOH(1);
Final_SOH = SOH(end);

Capacity_Loss = Initial_Capacity - Final_Capacity;

fprintf('\n');
fprintf('====================================\n');
fprintf('       BATTERY CYCLE LIFE TEST\n');
fprintf('====================================\n');

fprintf('Number of Cycles  : %d\n',Number_of_Cycles);
fprintf('Initial Capacity  : %.4f Ah\n',Initial_Capacity);
fprintf('Final Capacity    : %.4f Ah\n',Final_Capacity);
fprintf('Capacity Loss     : %.4f Ah\n',Capacity_Loss);
fprintf('Capacity Fade     : %.4f Ah\n',Capacity_Fade);
fprintf('Initial SOH       : %.2f %%\n',Initial_SOH);
fprintf('Final SOH         : %.2f %%\n',Final_SOH);
fprintf('Final SOH Degradation Rate  : %.4f %%\n',Degradation_Rate);

fprintf('====================================\n');

%% Final PASS / FAIL

SOH_limit = 80;

if Final_SOH >= SOH_limit
    
    fprintf('CYCLE LIFE TEST RESULT: PASS\n');
    
else
    
    fprintf('CYCLE LIFE TEST RESULT: FAIL\n');
    
end