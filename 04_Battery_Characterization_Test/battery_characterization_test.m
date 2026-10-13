clear; 
clc; 
close all;
%% Battery Test 4 - OCV-SOC Characterization
%% Test Parameters
Capacity_rated = 2.5;      % Rated Capacity (Ah) 
Temperature = 25;         % Test Temperature (degC)
%% SOC Data
SOC = 0:10:100;
%% OCV Data
OCV = [3.00 3.45 3.55 3.62 3.68 3.72 3.78 3.85 3.95 4.08 4.20];
Temperature_data = [25.0 25.1 25.2 25.3 25.4 25.5 25.9 26.1 26.3 26.5 26.7];
T_min = min(Temperature_data);
T_max = max(Temperature_data);
Temperature_Rise = T_max - T_min 

figure;

plot(SOC,Temperature_data,'o-','LineWidth',1.5);

xlabel('SOC (%)');
ylabel('Temperature (degC)');
title('Battery Temperature vs SOC');

grid on;

%% OCV-SOC Curve
figure;
plot(SOC,OCV,'o-','LineWidth',1.5);
xlabel('SOC (%)'); 
ylabel('OCV (V)'); 
title('Battery OCV-SOC Characterization');
grid on;
%% Minimum and Maximum Voltage
V_min = min(OCV); 
V_max = max(OCV);
fprintf('\n'); 
fprintf('========================================\n'); 
fprintf('      BATTERY CHARACTERIZATION TEST\n'); 
fprintf('========================================\n');
fprintf('Test Temperature : %.1f degC\n',Temperature); 
fprintf('Rated Capacity   : %.2f Ah\n',Capacity_rated); 
fprintf('Minimum OCV      : %.2f V\n',V_min); 
fprintf('Maximum OCV      : %.2f V\n',V_max);
fprintf('Minimum Temperature : %.1f degC\n',T_min);
fprintf('Maximum Temperature : %.1f degC\n',T_max);
fprintf('Temperature Rise : %.1f degC\n',Temperature_Rise);
%% Voltage Range
Voltage_Range = V_max - V_min;
fprintf('Voltage Range     : %.2f V\n',Voltage_Range);
fprintf('========================================\n');
%% PASS / FAIL
if V_min >= 3.0 && V_max <= 4.2 && Temperature_Rise <= 5  
fprintf('CHARACTERIZATION TEST RESULT: PASS\n');
else
fprintf('CHARACTERIZATION TEST RESULT: FAIL\n');
end