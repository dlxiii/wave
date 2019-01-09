clear all
close all
clc

% This code is for experiments of WANG with a uniform water depth of 0.6m.
% Data April 2017

%%%%%%%%%%%%%%%%%%% WAVE GENERATION & MEASUREMENT SETTING %%%%%%%%%%%%%%%%%%
%-------------------------------------General-------------------------------
sw=0;                   %sw=0 if only wave generation, sw=1 if daq is done.
%---------------------------------Wave Setting------------------------------
TL=120;                 %Duration of the waves(sec)
dt=0.05;                %Controlling Time Step(sec)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Wave_Height = [0.02 0.08 0.16];
Wave_Period = [1.00 1.50 2.00];
Wave_Sign_Height = [0.02 0.08 0.16];
Wave_Sign_Period = [1.00 1.50 2.00];

% icase = 1; % Regular wave H = 0.02m T = 1.0s
% icase = 2; % Regular wave H = 0.02m T = 1.5s
% icase = 3; % Regular wave H = 0.02m T = 2.0s
% icase = 4; % Regular wave H = 0.08m T = 1.0s
% icase = 5; % Regular wave H = 0.08m T = 1.5s
% icase = 6; % Regular wave H = 0.08m T = 2.0s
% icase = 7; % Regular wave H = 0.16m T = 1.0s
% icase = 8; % Regular wave H = 0.16m T = 1.5s
 icase = 9; % Regular wave H = 0.16m T = 2.0s

% icase = 10; % Irregular wave Hsign = 0.02m Tsign = 1.0s
% icase = 11; % Irregular wave Hsign = 0.02m Tsign = 1.5s
% icase = 12; % Irregular wave Hsign = 0.02m Tsign = 2.0s
% icase = 13; % Irregular wave Hsign = 0.08m Tsign = 1.0s
% icase = 14; % Irregular wave Hsign = 0.08m Tsign = 1.5s
% icase = 15; % Irregular wave Hsign = 0.08m Tsign = 2.0s
% icase = 16; % Irregular wave Hsign = 0.16m Tsign = 1.0s
% icase = 17; % Irregular wave Hsign = 0.16m Tsign = 1.5s
% icase = 18; % Irregular wave Hsign = 0.16m Tsign = 2.0s

for i = 1 : length(Wave_Height)
    for j = 1 : length(Wave_Period)
        regular(Wave_Height(i),Wave_Period(j),dt,TL);
    end
end

for i = 1 : length(Wave_Sign_Height)
    for j = 1 : length(Wave_Sign_Period)
        irregular(Wave_Sign_Height(i),Wave_Sign_Period(j),dt,TL);
    end
end

if     icase==1
  outdata=load('reg_H0.02_T1.wang');
elseif icase==2
  outdata=load('reg_H0.02_T1.5.wang');
elseif icase==3
  outdata=load('reg_H0.02_T2.wang');
  
elseif icase==4
  outdata=load('reg_H0.08_T1.wang');
elseif icase==5
  outdata=load('reg_H0.08_T1.5.wang');
elseif icase==6
  outdata=load('reg_H0.08_T2.wang');
  
elseif icase==7
  outdata=load('reg_H0.16_T1.wang');
elseif icase==8
  outdata=load('reg_H0.16_T1.5.wang');
elseif icase==9
  outdata=load('reg_H0.16_T2.wang');
  
elseif icase==10
  outdata=load('irreg_H0.02_T1.wang');
elseif icase==11
  outdata=load('irreg_H0.02_T1.5.wang');
elseif icase==12
  outdata=load('irreg_H0.02_T2.wang');
  
elseif icase==13
  outdata=load('irreg_H0.08_T1.wang');
elseif icase==14
  outdata=load('irreg_H0.08_T1.5.wang');
elseif icase==15
  outdata=load('irreg_H0.08_T2.wang');
  
elseif icase==16
  outdata=load('irreg_H0.16_T1.wang');
elseif icase==17
  outdata=load('irreg_H0.16_T1.5.wang');
else
  outdata=load('irreg_H0.16_T2.wang');
end

%%%%%%%%%%%%%%%%%%%%% WAVE GENERATION & MEASUREMENT SETTING %%%%%%%%%%%%%%%%%%
ao=analogoutput('contec','AIO000');
chansout=addchannel(ao,0);
set(ao,'SampleRate',1/dt)
ActualRate_out=get(ao,'SampleRate');
set(ao,'TriggerType','Manual')

plot(outdata)

putdata(ao,10 * outdata);
start(ao)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TRRIGER%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R=input('Are you ready starting Wave Generation?[y/n]','s');
if R=='y'
    trigger(ao);
else
    stop(ao)
    error('Canceled')
end
input('Press Enter to stop wave generation');
stop(ao);
delete(ao)


