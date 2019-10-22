# Code Ready Containers
These instructions draw from these urls:
- https://github.com/code-ready/crc
- https://code-ready.github.io/crc/

## Introduction
CodeReady Containters will start a single node Openshift 4 virtual machine on your workstation. In its current state, the certificates are set to expire 30 days from the date the VM was packaged by the CRC team prior to download. There currently isn't a process for regenerating the certificates, meaning that the old version will need to be deleted and new version of the CRC downloaded and started.  All previously deployed applications on the node will be lost and need to be redeployed.

## Installation for MAC
1. Go to this URL and follow the instructions
   ```
   https://cloud.redhat.com/openshift/install/crc/installer-provisioned
   ```

2. Untar the file from the download link for your operating system and copy the crc binary to the following path:
    ```
    /usr/local/bin
    ```
3. At the URL, click the link to Download your pull secret.  You will be prompted for this later during the CRC Start process.

## Startup
1. Run the following command from a termanl session:
    ```
    crc setup
    ```
2. By default it is set to only use 8GB ram. The more ram you can give it, the better. Here we are setting it to 10Gb:
    ```
    crc config set memory 10240
    ```
3. Run the crc start command in a terminal window
    ```
    crc start
    ```
4. During the installation process you will be prompted for your pull secret.  Copy and Paste it into the terminal window.

6.  Wait about 5 minutes for the VM initialization to complete.  When complete, the kubeadmin password will be displayed.  Make note of this password becasue you will need it to log into the console.

5. Open a web browser and go to the openshift console
     ```
     http://console-openshift-console.apps-crc.testing
     ```

6. Click the Log in with kube.admin link.  
    - for the username, enter: kubeadmin  
    - for the password, enter the password guid displayed in the terminal window when the CRC start command completed. 

## Reset
```
crc delete
```
