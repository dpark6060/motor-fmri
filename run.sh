#!/bin/bash
#
#
#

FLYWHEEL_BASE=/flywheel/v0
MANIFEST_FILE=${FLYWHEEL_BASE}/manifest.json
INPUT_DIR=${FLYWHEEL_BASE}/input
mkdir -p ${INPUT_DIR}
OUTPUT_DIR=${FLYWHEEL_BASE}/output
mkdir -p ${OUTPUT_DIR}
RESULTS_DIR=${FLYWHEEL_BASE}/report_results
mkdir -p ${RESULTS_DIR}
BIDS_DIR=${INPUT_DIR}/bidsdir
FPREP_DIR=${INPUT_DIR}/fprep
CONTAINER='[flywheel/presurgicalreport]'
#cp ${FLYWHEEL_BASE}/fmriprep_dir ${INPUT_DIR}/bids_dataset/derivatives/fmriprep/fmriprep_dir

# CREATE A BIDS FORMATTED DIRECTORY
#   Use fw-heudiconv to accomplish this task
# /opt/miniconda-latest/bin/python3 ${FLYWHEEL_BASE}/create_archive_fw_heudiconv.py
# if [[ $? != 0 ]]; then
#   echo "$CONTAINER  Problem creating archive! Exiting (1)"
#   exit 1
# fi

# VALIDATE INPUT DATA
# Check if the input directory is not empty
if [[ "$(ls -A $INPUT_DIR)" ]] ; then
    echo "$CONTAINER  Starting..."
else
    echo "Input directory is empty: $INPUT_DIR"
    exit 1
fi

# Show the contents of the BIDS directory
ls -R ${BIDS_DIR}

/usr/local/miniconda/bin/python3 report.py ${BIDS_DIR}/bids_dataset ${FPREP_DIR}/fmriprep ${RESULTS_DIR}

zip -r report_results.zip report_results

cp report_results.zip ${OUTPUT_DIR}/
