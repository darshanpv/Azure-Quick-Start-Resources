#!/bin/bash

JOB_ID=$1
NOTEBOOK_PARAMS=$2

if [[ -z $JOB_ID || -z $NOTEBOOK_PARAMS ]]
then
    echo "An arguments must be passed as parameter"
    exit 1
fi

echo "Running the job with id: $JOB_ID..."
echo "Got the notebook parameters: " $NOTEBOOK_PARAMS    
RUN_ID=$(databricks jobs run-now --version=2.1 --job-id $JOB_ID --notebook-params "$NOTEBOOK_PARAMS" | jq '.run_id')

#set task variable run_id to be passed for next step
echo "Job run created with id: " $RUN_ID
echo "##vso[task.setvariable variable=run_id;]$RUN_ID"