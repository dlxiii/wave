% This script design the perameters for flume experiments.
clc
clear all

% The plate is fixed which amounted to the wave flume.
% Different water depth means different submergence.

DOCK_LENGTH = 1.00;
DOCK_ANGLES = 0;
DOCK_SUBMER = [-0.10 -0.05 0.00 0.05 0.10];

% PL is for Plate Length.
% PI is for Plate Inclination.
% PS is for Plate Submergence.

WATR_DEPTHS = 0.33;
WAVE_PERIOD = [0.90 1.70];
WAVE_HEIGHT = [0.011 0.087];

% WD is for Water Depth.
% WP is for Wave Period.
% WH is for Wave Height.



alpha = 4 * pi() * pi() / 9.8 ./ WAVE_PERIOD ./ WAVE_PERIOD;
WAVE_NUMBER = zeros(length(WATR_DEPTHS),length(WAVE_PERIOD));
WAVE_LENGTH = zeros(length(WATR_DEPTHS),length(WAVE_PERIOD));
for pt = 1 : length(WAVE_PERIOD);
    for pd = 1 : length(WATR_DEPTHS);
        WAVE_NUMBER(pd,pt) = 1i * dispersion_free_surface(alpha(pt),0,WATR_DEPTHS(pd));
        WAVE_LENGTH(pd,pt) = 2 * pi() / WAVE_NUMBER(pd,pt);
    end
end

WAVE_STEPNS = zeros(length(WATR_DEPTHS),length(WAVE_PERIOD),length(WAVE_HEIGHT));
for pd = 1 : length(WATR_DEPTHS);
    for pt = 1 : length(WAVE_PERIOD);
        for ph = 1 : length(WAVE_HEIGHT);
            WAVE_STEPNS(pd,pt,ph) = WAVE_HEIGHT(ph) / WAVE_LENGTH(pd,pt);
        end
    end
end

RE_WATER_DEPTHS = zeros(size(WAVE_LENGTH));
for pd = 1 : length(WATR_DEPTHS);
    for pt = 1 : length(WAVE_PERIOD);
        RE_WATER_DEPTHS(pd,pt) = WATR_DEPTHS(pd) / WAVE_LENGTH(pd,pt);
    end
end

RE_WAVE_HEIGHT = zeros(length(WATR_DEPTHS),length(WAVE_HEIGHT));
for pd = 1 : length(WATR_DEPTHS);
    for ph = 1 : length(WAVE_HEIGHT);
        RE_WAVE_HEIGHT(pd,ph) = WAVE_HEIGHT(ph) / WATR_DEPTHS(pd);
    end
end

RE_DOCK_SUBMER = DOCK_SUBMER ./ WATR_DEPTHS;

RE_DOCK_LENGTH = DOCK_LENGTH * ones(size(WAVE_LENGTH)) ./ WAVE_LENGTH;

TOP_SUBMER = zeros(length(WATR_DEPTHS),length(DOCK_ANGLES));
for pd = 1 : length(DOCK_SUBMER);
    for pa = 1 : length(DOCK_ANGLES);
        TOP_SUBMER(pd,pa) = DOCK_SUBMER(pd) - 0.5 * DOCK_LENGTH * sin(pi() * DOCK_ANGLES(pa) / 180);
    end
end

MAX_MIN_WAVE_LENGTH = [max(max(WAVE_LENGTH)),min(min(WAVE_LENGTH))];
MAX_MIN_WAVE_STEPNS = [max(max(max(WAVE_STEPNS))),min(min(min(WAVE_STEPNS)))];
MAX_MIN_RE_DOCK_LENGTH = [max(max(RE_DOCK_LENGTH)),min(min(RE_DOCK_LENGTH))];
MAX_MIN_RE_WATR_DEPTH = [max(max(RE_WATER_DEPTHS)),min(min(RE_WATER_DEPTHS))];
MAX_MIN_RE_DOCK_SUBMER = [max(RE_DOCK_SUBMER),min(RE_DOCK_SUBMER)];
MAX_MIN_RE_WAVE_HEIGHT = [max(max(RE_WAVE_HEIGHT)),min(min(RE_WAVE_HEIGHT))];
