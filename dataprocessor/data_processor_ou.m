clc
clear all
%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%  Caliberation Processor  %%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%

N = 3;              % Number of channels
E = [-8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8];  % Elevation of wave gauge
S_cal = 10000;      % Number of samplings
%%%%%%%%%%%%%%%%%%%% EXTRACT DATA %%%%%%%%%%%%%%%%%%%%
icount = length(E);
for i = 1 : icount
    filename = ['/Users/WANGYULONG/Dropbox/Matlab/2016/Experiment/data/caliberation/1704051529/NewFile' num2str(i) '.csv'];
    sheetname = ['NewFile' num2str(i)];
    datarange = [char(65) num2str(N+6) ':' char(64+N) num2str(N+5+S_cal)];
    voltage(:,N*i-(N-1):N*i) = xlsread(filename,sheetname,datarange);
end
mean_voltage = mean(voltage,1);
%%%%%%%%%%%%%%%%%%%% ARRANGE DATA %%%%%%%%%%%%%%%%%%%%
matr_voltage = zeros(length(E),N);
icount = length(E);
jcount = N;
for i = 1 : icount
    for j = 1 : jcount
        matr_voltage(i,j) = mean_voltage((i-1)*N+j);
    end
end
%%%%%%%%%%%%%%%%%%%% LIGATURE DATA %%%%%%%%%%%%%%%%%%%%
icount = N;
poly_coef = zeros(N,2);
R_square = zeros(N,1);
for j = 1 : icount
    poly_coef(j,:) = polyfit(E',matr_voltage(:,j),1);  
    R2 = corrcoef(E',matr_voltage(:,j));
    R_square(j,:) = R2(1,2) * R2(2,1);
    plot(E,matr_voltage(:,j),'+',E,polyval(poly_coef(j,:),E));    
    hold on
end

%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%  Wave Data Preprocessor  %%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%

F = 18;              % Number of logger files
S_log = 125000;      % Number of samplings
%%%%%%%%%%%%%%%%%%%% EXTRACT DATA %%%%%%%%%%%%%%%%%%%%
icount = F;
for i = 1 : icount
    filename = ['H:\test\experiment\wavelogger\1704041954/NewFile' num2str(i) '.csv'];
    sheetname = ['NewFile' num2str(i)];
    datarange = [char(65) num2str(N+6) ':' char(64+N) num2str(N+5+S_log)];
    wave_voltage(:,N*i-(N-1):N*i) = xlsread(filename,sheetname,datarange);
end
%%%%%%%%%%%%%%%%%%%% CONVERT DATA %%%%%%%%%%%%%%%%%%%%
icount = F;
jcount = N;
wave_elevation = zeros(size(wave_voltage));
for i = 1 : icount
    for j = 1 : jcount
        wave_elevation(:,(i-1)*N+j) = (wave_voltage(:,(i-1)*N+j) - poly_coef(j,2))/poly_coef(j,1);
    end
end

%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%  Wave Reflection calculate  %%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%

eta1 = wave_elevation(:,4);
eta2 = wave_elevation(:,6);
dL = 0.50;
h = 0.60;
dt = 0.0001;
g_min = 0.05;
g_max = 0.45;
p_flag = 1;


[KR, A_in,A_ref, SP1,SP2, n_min,n_max] = func_refwave(eta1,eta2,dL,h,dt,g_min,g_max,p_flag);


