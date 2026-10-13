clear;
clc;
close all;

%% Battery Test 1 - CSV Data Analysis

% Read CSV file
batteryData = readtable('Data/Battery_Test1_Capacity_Data.csv');

% Extract measured data
time_data = batteryData.Time;
voltage_data = batteryData.Voltage;
current_data = batteryData.Current;
temperature_data = batteryData.Temperature;

%% Calculate Power

power_data = voltage_data .* current_data;

%% Display Data

disp('Time Data:');
disp(time_data);

disp('Voltage Data:');
disp(voltage_data);

disp('Current Data:');
disp(current_data);

disp('Temperature Data:');
disp(temperature_data);

%% Power Curve

figure;

plot(time_data,power_data,'o-','LineWidth',1.5);

xlabel('Time (s)');
ylabel('Power (W)');
title('Battery Power vs Time');

grid on;
%% Energy 
energy_Wh = trapz(time_data,power_data) / 3600;


%% Maximum and Minimum Values

max_voltage = max(voltage_data);
min_voltage = min(voltage_data);

max_current = max(current_data);
min_current = min(current_data);

max_power = max(power_data);
min_power = min(power_data);
%% Calculate Measured Capacity

capacity_Ah = trapz(time_data,current_data) / 3600;

fprintf('Measured Capacity = %.4f Ah\n',capacity_Ah);
%% Battery Test Curves

figure;

plot(time_data,voltage_data,'LineWidth',1.5);

xlabel('Time (s)');
ylabel('Voltage (V)');
title('Battery Voltage vs Time');

grid on;


figure;

plot(time_data,current_data,'LineWidth',1.5);

xlabel('Time (s)');
ylabel('Current (A)');
title('Battery Current vs Time');

grid on;


figure;

plot(time_data,power_data,'LineWidth',1.5);

xlabel('Time (s)');
ylabel('Power (W)');
title('Battery Power vs Time');

grid on;

%% Final Battery Test 1 Report

fprintf('\n');
fprintf('========================================\n');
fprintf('       BATTERY CAPACITY & ENERGY TEST\n');
fprintf('========================================\n');

fprintf('Test Duration       : %.0f s\n',time_data(end));
fprintf('Initial Voltage     : %.2f V\n',voltage_data(1));
fprintf('Final Voltage       : %.2f V\n',voltage_data(end));

fprintf('Maximum Voltage     : %.2f V\n',max(voltage_data));
fprintf('Minimum Voltage     : %.2f V\n',min(voltage_data));

fprintf('Measured Capacity   : %.4f Ah\n',capacity_Ah);
fprintf('Measured Energy     : %.4f Wh\n',energy_Wh);

fprintf('Maximum Current     : %.2f A\n',max(current_data));
fprintf('Maximum Power       : %.2f W\n',max(power_data));

fprintf('========================================\n');
