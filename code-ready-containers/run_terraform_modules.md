# Catalyst on CRC

## Installation
Step 1 - setup and run the CRC by following these instructions: 
https://github.com/michaelsteven/data-pipeline-notes/tree/master/code-ready-containers

Step 2 - clone down my fork.
```
https://github.com/michaelsteven/ibm-garage-iteration-zero.git
```

Step 3 - Switch to the "mike-working" branch

Step 4 - Open a new terminal window (different than the one used to start CRC) and navigate into the iteration-zero-ibmcloud directory

Step 5 - Run the launch.sh script that will create start a docker container and exec in as a bash session in the terminal window
```
./launch.sh
```

Step 6 - From inside the terminal/container, log into the openshift cluster via the cli.
```
oc login --insecure-skip-tls-verify=true -u kubeadmin -p <your-password> https://api.crc.testing:6443
```
NOTE: replace "<your-password>" with the password displayed when the "crc start" command command completed.

Step 7 - make a dummy credentials.properties file
```
cp credentials.template credentials.properties
```

Step 8 - Run the runTerraform.sh scripts as normal
```
./runTerraform.sh
```

Step 9 - When prompted for the cluster type, enter "o" for openshift

Step 10 - when prompted for variable input, put in dummy data

## Cleaning Up
Step 1. - In the terminal where the CRC was started, delete the CRC VM instance and start it up again
```
crc delete
```

Step 2. - In the tools container terminal, delete the terraform workspace folder
```
rm -rf workspace/
```
    
