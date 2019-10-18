# Installing Catalyst on CRC

Step 1 - setup and run the CRC by following these instructions: 
https://github.com/michaelsteven/data-pipeline-notes/tree/master/code-ready-containers


Step 2 - clone down my fork.
```
https://github.ibm.com/Michael-Hepfer/iteration-zero-ibmcloud
```

Step 3 - Switch to the "mike-working" branch

Step 4 - Rename these files to .BAK so they don’t execute
- stage3-appid.tf
- stage3-cloud_object_storage.tf
- stage3-cloudant.tf
- stage3-logdna.tf
- stage3-sysdig.bak

Step 5 - run the launch.sh and runTerraform.sh scripts as normal

Step 6 - when prompted for variable input, put in dummy data
