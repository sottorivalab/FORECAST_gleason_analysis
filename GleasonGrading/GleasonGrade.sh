#!/bin/bash

tilePath="./path_to_gleason_analysis/Classification/AnnotatedTiles/"
outFile="./path_to_gleason_analysis/Classification/GleasonGrades.csv"

colours="[240 228 66; 213 94 0; 93 58 155]"
minCountableArea=15000
minGradeableArea=200000

matlabPath='./matlab/'

matlab -nodesktop -nosplash -r "addpath(genpath('${matlabPath}')); GleasonGradeBatch('${tilePath}', '${outFile}', ${colours}, ${minCountableArea}, ${minGradeableArea}); exit;"
