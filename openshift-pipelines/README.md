# Pipeline Creation Steps

## Prerequisite: Installing and Using the OC CLI

### Installing the CLI
1. Download the OC CLI
2. Install it onto your path
    On windows: Extract the contents to your standalone programs, location it to your path, and reboot so it takes effect
    On Mac: Copy into your /usr/local/bin directory

### Logging in to the OC Server
1. Enter the OC Login command, specifying the server to connect to:
    ```
    oc login https://foo.bar.net
    ```
2. Select Y when asked about allowing insecrue connections
3. You will be prompted for the username and password

### Verify your server connection
```
oc cluster-info
```
---

## Step 1:  Creating Configmaps

### Create the Config Map
Every application should have a version of it's application.yml exported to a ConfigMap, and this should be repeated for each of the namespaces/stages to be used (i.e. dev, fit, prod).

NOTE: The name used when running the create will be used later when creating the deployment pipelines.

```
oc create configmap <application-name>-map --from-file=<directory containing the file to add> -n <<application-name>-dev
```

## Step 2: Project Deployment Configuration

### Overview
RedHat OpenShift templates are used to make artifact creation easier and repeatable.  The template definition provided here defines a Kubernetes service, route and DeploymentConfig for a given application.

The <<projectname>>-deploy template defines the following:
- service listening on ports 9080, 9443, 9082
- route to expose the 9443 port externally
- DeploymentConfig to host the Open Liberty container.
    - The image for the container is taken from the ImageStream that will be populated by the Jenkins pipeline
    - Environment variables are defined for resources such as databases used by the application allowing for environment specific information to be injected from secrets
    - Probes for liveness and readiness are defined to check port 9443 is active
    - The SecurityContext is set to allow read/write access to the filesystem and to run the container as user 1001
    - The deployment will be updated if a new image is loaded to the ImageStream or if a change to the configurtion is detected

### Deploying a new Deployment Template
Issue the commands below to load the template named `foo-springboot-deploy` in the `dev`, `stage` and `prod` projects:
1. Change into the project's "Deployment\Openshift\" folder
2. Install the deployment template to each namespace by running the following command:

        ```bash
        oc create -f <<projectname>>-deploy.yaml -n <<workspace>>-dev
        ```

    NOTE: Should you need to redeploy, use this commands to remove it:
        
        ```
        oc delete template <<projectname>>-deploy --namespace=<<workspace>>-dev
        ```

3. Deploy the deployment template to each namespace buy ruinning the4 following command:

        ```bash
        oc new-app <<projectname>>-deploy -p APPLICATION_NAME<<projecname>> -n <<workspace>>-dev
        ```

## Step 3: Jenkins Pipeline Configuration

### First Time Jenkins Setup for the Project
Create a secret to hold the gitlab service account credentials to be used by Jenkins
    ```
    oc create secret generic gitlab --from-literal=username=<<the_username>> --from-literal=password=<<the_password>> --type=kubernetes.io/basic-auth -n jenkins
    ```

### Deploying the Pipeline
1. Change into the project's "Deployment\Openshift" folder
2. Run the following command:

    ```
    oc create -f <<projectname>>-build.yaml -n jenkins
    ```

    NOTE: if you mess up, you can delete your template using this command:
    
    ```
    oc delete template <<projectname>>-build --namnespace=jenkins
    ```

### Create a Jenkins Deployment Application
1. Run the following command:
    ```
    oc new-app <<proijectname>>-build -p APPLICATION_NAME=<<projectname>> -p SOURCE_URL="https://github.com/<<your_organization>>/<<your_projectname>>.git" -n jenkins
    ```
    NOTE: You may get the following message "error: imagestrams.image.openshift.io "websphere-liberty" already exists."

### To Manually Trigger a Build via the CLI
```
oc start-build <<projectname>>-pipeline -n jenkins
```




