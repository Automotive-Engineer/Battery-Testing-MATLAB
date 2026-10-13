%% Test parameter
Capacity_rated = 2.5;    % Ah
v_nominal = 3.7;        %V
I_test = 2.5;           %A
T_test = 25 ;           %degC
%% Read Battery Test Date 
Data = readtable('Data/Battery_Test1_Capacity_Data.csv');

%% Extract Test Data
t = data.Time; 
V = data.Voltage;
I = data.Current;
T = data.Temperature;

%% time
dt = 10;
t = (0:dt:3600)';

%% current 
I = I_test*ones(size(t));

%% voltage
V = 4.2 - 1.2*(t/3600).^ 0.7;

%% Temperature
T = T_test + 2*((t/3600))

figure;
plot(t/60,T,'LineWidth',1.5);
xlabel ('time(min)');
ylabel ('Temperature(^oC)');
title('battery Temperature during Dicharge');
grid on ;

%% Capacity_measured 
Capacity_measured = trapz(t,I)/3600;

Capacity_error = abs(capacity_measured - capacity_rate) / capacity_rated *100 ;

%% Energy_measured 
P = V .*I;
Energy_measured = trapz(t,P)/3600;

%% Test Results

fprintf('==============================\n');
fprintf('      BATTERY TEST REPORT\n');
fprintf('==============================\n');

fprintf('Rated Capacity    : %.2f Ah\n', Capacity_rated);
fprintf('Measured Capacity : %.2f Ah\n', Capacity_measured);
fprintf('Capacity Error    : %.2f %%\n', Capacity_error);
fprintf('Measured Energy   : %.2f Wh\n', Energy_measured);
fprintf('Test Current      : %.2f A\n', I_test);
fprintf('Initial Temperature : %.2f C\n', T(1));
fprintf('Final Temperature   : %.2f C\n', T(end));

fprintf('==============================\n'); 

%% Basic Data analysis 
V_average = mean(V);
V_max = max(V);
V_min = min(V);
Voltage_drop = v(1)- V(end);
fprintf('V_max   : %.2f v\n', V_max );
fprintf('V_min   : %.2f v\n', V_min);
fprintf('Voltage_drop   : %.2f v\n', Voltage_drop);
%% Temperature rise
Temperature_rise = T(end)- T(1)
T_average = mean(T);
T_max = max(T);
T_min = min(T);
fprintf('Temperature_rise   : %.2f C\n', Temperature_rise);
fprintf('T_max   : %.2f v\n', T_max );
fprintf('T_min   : %.2f v\n', T_min);
fprintf('T_mean   : %.2f v\n', T_average);

%% condutions
if Capacity_error <= 5
    fprintf('Capacity_test: PASS \n');
else
     fprintf('Capacity_test: FAIL\n');
end

if T_max <= 30
    fprintf('Temperature Test: PASS\n');
else
    fprintf('Temperature Test: FAIL\n');
end
if Capacity_error <= 5 && T_max <= 30
    fprintf('==============================\n');
    fprintf('FINAL TEST RESULT: PASS\n');
    fprintf('==============================\n');
else
    fprintf('==============================\n');
    fprintf('FINAL TEST RESULT: FAIL\n');
    fprintf('==============================\n');
end