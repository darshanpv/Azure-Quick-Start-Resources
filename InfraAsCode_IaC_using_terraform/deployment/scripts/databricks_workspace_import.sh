#!/bin/bash

SRC_DIR=$1
DEST_DIR=$2

if [[ -z $SRC_DIR || -z $DEST_DIR ]]
then
    echo 'A subdirectory name must be passed as parameter'
    exit 1
fi

echo "Uploading notebooks from source: $SRC_DIR to workspace destination: $DEST_DIR ..."
databricks workspace import_dir --overwrite $SRC_DIR $DEST_DIR