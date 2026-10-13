clear;
clc;
close all;

%% Battery Test 2 - Pulse Test Analysis

% Read CSV file
batteryData = readtable('Data/Battery_Test2_Pulse_Data');

% Extract measured data
time_data = batteryData.Time;
voltage_data = batteryData.Voltage;
current_data = batteryData.Current;
temperature_data = batteryData.Temperature;

%% Calculate Power
power_data = voltage_data .* current_data;

%% Display Data
disp('Time (s):');
disp(time_data);

disp('Voltage (V):');
disp(voltage_data);

disp('Current (A):');
disp(current_data);

disp('Temperature (deg C):');
disp(temperature_data);

%% Plot Voltage
figure;
plot(time_data, voltage_data, 'o-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Pulse Test - Voltage vs Time');
grid on;

%% Plot Current
figure;
plot(time_data, current_data, 'o-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Current (A)');
title('Pulse Test - Current vs Time');
grid on;

%% Plot Power
figure;
plot(time_data, power_data, 'o-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Power (W)');
title('Pulse Test - Power vs Time');
grid on;

%% Pulse Test - Calculate Key Parameters

% Find pulse samples
pulse_idx = find(current_data > 0);

% Identify pulse start and end
first_pulse_idx = pulse_idx(1);
last_pulse_idx = pulse_idx(end);

% Identify the sample before the pulse
pre_pulse_idx = first_pulse_idx - 1;

% Identify the first sample after the pulse
recovery_idx = last_pulse_idx + 1;

%% Voltage Drop at Pulse Start
V_before = voltage_data(pre_pulse_idx);
V_pulse_start = voltage_data(first_pulse_idx);

voltage_drop = V_before - V_pulse_start;

%% Estimate Internal Resistance
I_before = current_data(pre_pulse_idx);
I_pulse = current_data(first_pulse_idx);

current_change = abs(I_pulse - I_before);

R_est = abs(voltage_drop) / current_change;
R_est_mOhm = R_est * 1000;

%% Voltage Drop During the Pulse
V_pulse_end = voltage_data(last_pulse_idx);

total_pulse_drop = V_before - V_pulse_end;

%% Voltage Recovery
V_recovery_start = voltage_data(recovery_idx);
V_recovery_final = voltage_data(end);

recovery_amount = V_recovery_final - V_pulse_end;

recovery_percentage = (recovery_amount / total_pulse_drop) * 100;

%% Display Results
fprintf('\n');
fprintf('========================================\n');
fprintf('       PULSE TEST RESULTS\n');
fprintf('========================================\n');
fprintf('Voltage Before Pulse : %.3f V\n', V_before);
fprintf('Voltage at Pulse Start: %.3f V\n', V_pulse_start);
fprintf('Initial Voltage Drop : %.3f V\n', voltage_drop);
fprintf('Estimated Resistance : %.3f Ohm\n', R_est);
fprintf('Estimated Resistance : %.2f mOhm\n', R_est_mOhm);
fprintf('Total Pulse Voltage Drop: %.3f V\n', total_pulse_drop);
fprintf('Voltage After Pulse  : %.3f V\n', V_recovery_start);
fprintf('Final Recovery Voltage: %.3f V\n', V_recovery_final);
fprintf('Voltage Recovery     : %.3f V\n', recovery_amount);
fprintf('Recovery Percentage  : %.2f %%\n', recovery_percentage);
fprintf('========================================\n');
