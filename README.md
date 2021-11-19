#Rlambda Docker Container

Produces a docker container running R that can be loaded to ECR and serve requests from lambda functions. Lambda functions are loaded into the `functions.R` file.

##Current Process

1. Build the docker container with `docker build -t faustian/rlambda .`
2. You can run locally as `docker run -p 9000:8080 faustian/rlambda`
2. Create the ecr repo `aws ecr create-repository --repository-name rlambda --image-scanning-configuration scanOnPush=true`
2. Tag the docker container `docker tag faustian/rlambda:latest 332963913137.dkr.ecr.us-east-1.amazonaws.com/rlambda:latest`
3. Push container to ECR: `aws ecr get-login-password | docker login --username AWS --password-stdin 332963913137.dkr.ecr.us-east-1.amazonaws.com/rlambda && docker push 332963913137.dkr.ecr.us-east-1.amazonaws.com/rlambda:latest`