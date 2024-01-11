#!/bin/bash

csvPath="path_to_cell_classification/Classification/csv/"
gleasonPath="path_to_gleason_segmentation/Classification/AnnotatedTiles/"
outPath="path_to_cell_classification/Classification/gleasonCellsCSVs/"

colours="[255, 255, 255; 0, 158, 115; 240, 228, 66; 213, 94, 0; 93, 58, 155]"
labels="{'benign', 'g3', 'g4', 'g5', 'unknown'}"

mkdir -p "${outPath}"

codePath="./matlab/"

if [ $# -gt 0 ]; then
    all_files=("$csvPath"/*/)
    files=()
    for var in "$@"; do
        files+=("${all_files[$((var-1))]}")
    done
else
    files=("$csvPath"/*/)
fi

for file in "${files[@]}"; do
    imageName="$(basename "$file")"

    matlab -nodesktop -nosplash -r "addpath(genpath('${codePath}')); MakeGleasonCellCSVs('${file}', '${gleasonPath}/${imageName}', '${outPath}/${imageName}', ${colours}, ${labels}); exit;"
done
