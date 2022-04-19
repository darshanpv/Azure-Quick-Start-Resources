#!/bin/bash

CLUSTER_ID=$1
NOTEBOOK_NAME=$2
JOB_NAME=$3

if [[ -z $CLUSTER_ID || -z $NOTEBOOK_NAME || -z $JOB_NAME ]]
then
    echo "A required arguments must be passed as parameter"
    exit 1
fi

echo "Creating the job using cluster id: $CLUSTER_ID..."
echo "Got the notebook name: " $NOTEBOOK_NAME
echo "Got the job name: " $JOB_NAME

JOB_ID=$(databricks jobs create  --version=2.1 --json "{\"name\":\"$JOB_NAME\",
\"existing_cluster_id\":\"$CLUSTER_ID\",
\"timeout_seconds\":3600,\"max_retries\":1,
\"notebook_task\":{\"notebook_path\":\"$NOTEBOOK_NAME\",\"base_parameters\":{}}}" | jq '.job_id')

#set task variable job_id to be passed for next step
echo "Job created with id: " $JOB_ID
echo "##vso[task.setvariable variable=job_id;]$JOB_ID"