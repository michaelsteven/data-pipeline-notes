# data-pipeline-notes
Notes and thoughts on data pipelines

## Overview
This is just a place for me to check in files related to patterns for moving data between databases or systems.  Prime examples are from the cloud to onprem, or visa-versa.

## My initial thoughts
1. Use built-in mechanisms whenever possible:
    - example:  If there is a cassandra ring in the cloud, put a readonly read-only nodes onprem
2. When there isn't anything built-in, use a purpose built pipeline system
    - this is where I'm at right now; trying and documenting existing practices.

## ETL and CDC 
Extrat Transform Load and Change Data Capture patterns and tools

### CDC
- https://debezium.io/
