function [data]=regular(Hmean,Tmean,dt,Tleng)
% [data]=regular(Hmean,Tmean,dt,TL)
% This code generate regular wave elevation with sine function.
% Data: April 2017, by WANG YULONG.

%%%%%%%%%%%%%%%%%%%% SYMBOL DEFINITION %%%%%%%%%%%%%%%%%%%%
% Hmean: Mean wave height.
% Tmean: Mean wave period.
% dt:    Time step for wave.
% Tleng: length of wave propgating time. 

%%%%%%%%%%%%%%%%%%%% WAVE GENERATION %%%%%%%%%%%%%%%%%%%%

num_sample = Tleng/dt;
count = [0:1:num_sample]';
data = Hmean * sind((360 / Tmean) * count * dt);
filename = ['reg_H' num2str(Hmean) '_T' num2str(Tmean) '.wang'];
dlmwrite(filename,data);