# DevOps Coding Test

## Create the environment

The first step is to create the hole environment:
* VPC
* Public Subnets
* IGW
* LoadBalancer
* Target Group
* Docker Cluster

The `CloudFormation/main_infra.json` file is a CloudFormation Template that will create all for you.

You have to login to the AWS console with the user y and pass that Veronica sended to you.

Then you have deploy that template in CloudFormation.

### * Make it Parameters
* Stack Name: whathever you want
* Key: devop-challenge
* For the rest, just leave default


**Note**: before pushing the `Create` button, you have to check:
* `I acknowledge that AWS CloudFormation might create IAM resources` 


## Output values

When the CloudFormation task ends, you have to take the two values that will show up on the `Output` tab.

You have to use those values with the script `ECS/hello-service.json`, to replace some strings. It is clear when you see the file.


## Create Task and Service

We have already the environment, it is time to run some services.

### Task

You have to run:

```bash
aws --region us-east-1  ecs register-task-definition --cli-input-json file://ECS/hello-task.json

```

That will create the task definition for you, it is just a docker with nginx inside.

### Service

Once you have modified the file `hello-service.json` with the output from `CloudFormation`, you have to run:

```bash
aws --region us-east-1  ecs create-service  --cli-input-json file://ECS/hello-service.json
```

# Done!

You have to look for the ApplicationLoadBalancer in the AWS console, take the url and put it on the browser.

You will see the hello from Nginx :-)


## HealthCheck

I made a healthcheck that shows `OK` and `FAIL` on a webpage. It's a simple ruby - rack app.
I've put it in a Docker, and you can configure it throught the `docker-compose.yml` file.

Edit the `docker-compose.yml` file, for the parameters:
* REFRESH_TIME: time in seconds for reload the browser
* WEBSITE: url to check.

Then you have to run:
```bash
docker-compose up
```

and connect to: `http://localhost:8080`


## Notes
* I know that my solution it is not so cloud agnostic, but AWS is the Cloud I know the most.
* This solution use diferent AZ to provide high availability. By default each server is created in a different AZ, and the creation of containers acurs in the same way.
* This solution lacks of secutiry for the clusters servers, because they are on a public subnet. In a more sofisticated solution, I would create private subnets with NAT, and no public IP for the cluster.
* I don't know terraform, but I'm a fast learner.


------------------------------------------------------------------------------------------------------------------------------



DevOps Coding Test
==================

# Goal

Script the creation of a service, and a health check script to verify it is up and responding correctly.

# Prerequisites

You will need an AWS account. Create one if you don't own one already. You can use free-tier resources for this test.

# The Task

You are required to provision and deploy a new service in AWS. It must:

* Be publicly accessible.
* Run a web server, it can be an out of the box webserver (ie: Nginx, Apache) or any application acting as one.
* Deploy the content. This can be as simple as some static text representing a version number, for example:
3.0.1
or as complex as a full website. You choose. We will not provide the content.

# Mandatory Work

Fork this repository.

* Script your service using your configuration management and/or infrastructure-as-code tool of choice.
* Provision the service in your AWS account.
* Write a health check script that can be run externally to periodically check that the service is up 
* Alter the README to contain instructions required to:
  * Provision the service.
  * Run the health check script.
* Provide us IAM credentials to log in to the AWS account. If you have other resources in it make sure we can only access what is related to this test.
  * Document each step.
  * Make it easy to install
  * Make it as Cloud provider agnostic as you can - i.e. can we repeat this in Azure or Google Cloud Platform
Once done, give us access to your fork. Feel free to ask questions as you go if anything is unclear, confusing, or just plain missing.

# Extra Credit

We know time is precious, we won't mark you down for not doing the extra credits, but if you want to give them a go...

* Run the service inside a Docker container.
* Make it highly available.
* We value Terraform and rely on it heavily. If you already know TF, we’d love to see you use it.

# Questions

#### What scripting languages can I use?

Anyone you like. You’ll have to justify your decision. We use CloudFormation, Puppet and Python internally. Please pick something you're familiar with, as you'll need to be able to discuss it.

#### Will I have to pay for the AWS charges?

No. You are expected to use free-tier resources only and not generate any charges. Please remember to delete your resources once the review process is over so you are not charged by AWS.

#### What will you be grading me on?

Scripting skills, security, elegance, understanding of the technologies you use, documentation.

#### What will you not take into account?

Brevity. We know there are very simple ways of solving this exercise, but we need to see your skills. We will not be able to evaluate you if you provide five lines of code.

#### Will I have a chance to explain my choices?

If we proceed to a technical interview, we’ll be asking questions about why you made the choices you made. Comments in the code are also very helpful.

#### Why doesn't the test include X?

Good question. Feel free to tell us how to make the test better. Or, you know, fork it and improve it!

#### How long should this take?
There are many ways to solve this problem so it may vary for each candidate and depends how far you want to take it but we are confident the basic requirements can be met with 2-3 hours work.
