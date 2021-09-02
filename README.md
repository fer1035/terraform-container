# API Container with Terraform

---

## Overview

This collection of Docker and Terraform files let you create a simple API using the Fargate Elastic Container Service (ECS) in AWS. You can also opt to use other platforms to manage your containers, but it will require a rewrite of the [main.tf](terraform/main.tf) file included here.

> ***CAUTION!***: The infrastructure and API provisioned by the following steps are **for educational and testing purposes only**, and are NOT secure for real, production usage. Make sure to clean your account up once you're done with these.

## Files

### terraform

1. [backend.tf](terraform/backend.tf)
    - Create an AWS backend in Terraform.

2. [provider.tf](terraform/provider.tf)
    - Connect to AWS using Access Key ID and Secret Access Key.
    - Stored as sensitive variables in Terraform.

3. [locals.tf](terraform/locals.tf)
    - Create some local variables using account-related data from AWS.

4. [main.tf](terraform/main.tf)
    - Create infrastructure.
    - Components:
        - ECS task definition
        - ECS cluster
        - ECS service

        > Elastic Container Registry (ECR) repository creation isn't included in the template as it's a very simple process to provision the repository and push your container images to it.

### docker

1. [app.py](docker/app.py)
    - API code in Python3 using the Flask and gunicorn modules.
    - Update this to change your API functionalities and update the Docker image.

2. [Dockerfile](docker/Dockerfile)
    - Docker image building and running instructions.

3. [requirements.txt](docker/requirements.txt)
    - Python3 modules to be installed automatically during Docker image creation.

## Deployment

### Prerequisites

1. An [AWS account](https://aws.amazon.com/console/) (or other Cloud provider, which may require different steps than the ones outlined here).

2. Setup [AWS CLI](https://aws.amazon.com/cli/) for your account.

3. [Terraform Cloud guide](https://learn.hashicorp.com/tutorials/terraform/cloud-login?in=terraform/cloud).

4. Setup secret variables in your Terraform Cloud environment.

5. [Docker](https://www.docker.com/products/docker-desktop) to create and test container images.

### Steps

1. Login to your AWS account.

2. Navigate to the [ECR console](https://console.aws.amazon.com/ecr).

3. Create a new private repository.

4. Select the newly-created repository and click on **View push commands**. This will provide you with the commands to build and push your container image to the repository.

5. One your image is pushed, navigate into the repository and copy the URI of the image. This will be used as a parameter in Terraform.

6. Execute the Terraform templates to create the rest of the infrastructure.

### Test

1. Navigate to the [ECS console](https://console.aws.amazon.com/ecs).

2. Click on the corresponding cluster name.

3. Click on the **Tasks** tab.

4. Click on the corresponding task.

5. Under **Network**, look for **Public IP**.

6. Use the IP address to make your test API call.

7. The default [app.py](docker/app.py) Python3 code requires a name (any name, no spaces) in the path part and returns a howdy as follows:
    
    ```txt
    HTTP GET 'http://3.87.24.111/JacknJill'
    ```
    
    Giving the following response:

    ```json
    {"message": "Howdy, JacknJill!"}
    ```
