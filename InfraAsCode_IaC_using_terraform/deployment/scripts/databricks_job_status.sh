#!/bin/bash

RUN_ID=$1

if [[ -z $RUN_ID ]]
then
    echo "A job run id must be passed as parameter"
    exit 1
fi

echo "Waiting for job with run ID: $RUN_ID to complete..."

job_status="PENDING"
while [ $job_status = "RUNNING" ] || [ $job_status = "PENDING" ]
do
    sleep 5
    job_status=$(databricks runs get --version=2.1 --run-id $RUN_ID | jq -r '.state.life_cycle_state')
    echo "Please wait the job is still running. Current Status..." $job_status
done

RESULT=$(databricks runs get-output --version=2.1 --run-id $RUN_ID)
RESULT_STATE=$(echo $RESULT | jq -r '.metadata.state.result_state')
RESULT_MESSAGE=$(echo $RESULT | jq -r '.metadata.state.state_message')
NOTEBOOK_RESULT=$(echo $RESULT | jq -r '.notebook_output.result')
   
if [ $RESULT_STATE = "FAILED" ]
then
    echo "##vso[task.logissue type=error;]$RESULT_MESSAGE"
    echo "##vso[task.complete result=Failed;done=true;]$RESULT_MESSAGE"
fi

if [ $RESULT_STATE = "SUCCESS" ]
then
    echo "Job executed successfully..."
    echo "Result: " $NOTEBOOK_RESULT
    echo "##vso[task.setvariable variable=notebook_result;]$NOTEBOOK_RESULT"

fi

echo $RESULT | jq .