# Jenkins CI/CD + Terraform Mini Project

Name: Kenisha Koul | PRN: 202301100004 | Batch: A1

A small FastAPI app with a Jenkins pipeline (checkout, build, test, docker build, deploy, verify)
and Terraform code that provisions AWS infrastructure.

## Folders
- app/ and tests/ : the application and its tests
- Dockerfile : builds the app image
- Jenkinsfile : the CI/CD pipeline
- jenkins/Dockerfile : Jenkins image with Python and Docker CLI
- terraform/ : AWS infrastructure (security group, EC2, S3)
- terraform-local/ : same idea without cloud, using Docker
- screenshots/ : execution evidence

## Run Jenkins
    docker build -t my-jenkins ./jenkins
    docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock my-jenkins

Open http://localhost:8080, create a Pipeline job, choose "Pipeline script from SCM", and use this repository.
The deployed app is available at http://localhost:8001

## Run Terraform
    cd terraform
    terraform init
    terraform plan
    terraform apply
    terraform destroy
