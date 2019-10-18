# Code Ready Containers
These instructions draw from these urls:
- https://github.com/code-ready/crc
- https://code-ready.github.io/crc/

## Installation for MAC
1. Download the file "crc-macos-amd64.tar.xz" from:
   ```
   https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/
   ```

2. Untar the file and copy the crc binary to the following path:
    ```
    /usr/local/bin
    ```
3. Run the following command from a termanl session:
    ```
    crc setup
    ```
4. During the installation process you will be prompted for your redhat secret.  Go to the link presented, copy and paste in your secret to the terminal window.


## Startup
1. Run the crc start command in a terminal window
    ```
    crc start
    ```
2. Open a browser and go the the following url
    ```
    https://console-openshift-console.apps-crc.testing/
    ```
3. To use the command line, run these commands: 
    ```
    crc oc-env
    ```
    ```
    eval $(crc oc-env)
    ```
    ```
    oc login -u kubeadmin -p <<password>> https://api.crc.testing:6443
4. Verify your connected to the right server
    ```
    oc cluster-info
    ```
## Reset
```
crc delete
```
