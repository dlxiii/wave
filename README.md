# To wave maker user in Okayasu Lab

## Introduction

These codes are developped for:
* Generating target wave profiles, converting to digital signal and driving the wave maker to work.
* Reading measured wave profile using zero crossing method.

## DATADESIGN

In this folder, the configuration of waves are described.
* 'parameters.m' design the important wave parameters for the wave flume experiment, this is only useful for my case which deal with a fixed submerged plate in the flume.

## WAVEMAKING

In this folder, the 'm' files control everythings.
* 'wave_making_ou.m' is running for (1) generating the target wave profiles, (2) call the wave maker API, 'analogoutput, etc.' to convert target wave profiles to digiral signal which can be sent to the motor, (3) trriger the wave maker to work.
* 'regular.m' is called by 'wave_making_ou.m' to generate **'regular'** target wave profiles.
* 'irregular.m' is called by 'wave_making_ou.m' to generate **'irregular'** target wave profiles (Bredschneider-Mitsuyasu Spectrum).
* 'type_height_period.wang' are the generated wave profiles, **'type'** has 'irreg' and 'reg' options, **'height'** and **'period'** are user decided.

## DATA

In this folder, both pre and post work are recorded.
* 'wavelogger.clc' and 'trigger.clc' are configuration files of the wave elevation logger softwares, user can import them for caliberation and wave recording, details are not well remembered, the experiment had finished two years ago.
* 'caliberation' folder save the caliberation results from logger software, these data are useful for 'DATAPROCESSOR' part.
* 'wavelogger' folder save the real experiment results from logger software, these data are useful for 'DATAPROCESSOR' part.

## DATAPROCESSOR

In this folder, codes are prepared to read wave data and calculate reflection coefficient of the fixed submerged plate in the flume.
* 'data_processor.m' is where the main work happen.
* 'func_refwave' is called by 'data_processor.m' to calculate the reflection coefficient.

Modified date: 2019/01/09

Modified Author: Yulong WANG
