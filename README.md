# Rlambda Docker Container

Produces a docker container running R (>=4) that can be loaded to ECR and serve requests from lambda functions. Lambda functions are loaded into the `functions.R` file. 

## Prerequisites

You should run the most recent version of `Docker` and have access to `aws cli` as well. You should also have a docker hub account that you can push images to. Run `aws configure` to set your region, secret keys and other details. Drop your R functions in the `functions.R` script.

## Current Process

1. Build the docker container with `docker build -t <docker username>/rlambda .`.
2. You can run locally as `docker run -p 9000:8080 <docker username>/rlambda`.
3. Create the ecr repo `aws ecr create-repository --repository-name rlambda --image-scanning-configuration scanOnPush=true`.
4. Tag the docker container with the resulting `repositoryUri` with the following command: `docker tag <docker username>/rlambda:latest <repositoryUri>/rlambda:latest`.
5. Push container to ECR: `aws ecr get-login-password | docker login --username AWS --password-stdin <repositoryUri>/rlambda && docker push <respositoryUri>/rlambda:latest`.
6. Once the container is uploaded create a lambda function and choose container image as the source. Choose the container image URI of the docker container you just pushed. 
7. Create the function and then configure the timeout settings to 30 seconds or more and edit the image configuration for CMD to point to the function you want to call such as `functions.filterPosts`.
8. Function `filterPosts` shows how to incorporate library call for a function within the docker container. 

# Credits

Credit for this goes to `mdneuzerling` with his post [here](https://mdneuzerling.com/post/r-on-aws-lambda-with-containers/).