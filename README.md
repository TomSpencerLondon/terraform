[### Terraform

In this course we will learn about:

- Infrastructure as Code
- Types of IaC tools
- Why terraform is useful?
- Hashicorp Configuration Language (HCL)
- How to provision update and destroy infrastructure using terraform
- Providers
- Input Variables
- Output variables
- Resource Attributes
- Resource Dependencies

We will then learn about state in terraform. What it is? Why it is useful and considerations to follow when working with
state.
The following are some of the topics we will learn about:

- Terraform state
- Commands
- Mutable versus immutable infrastructure
- LifeCycle rules
- Datasources
- Meta-Arguments
- count and for_each
- version constraints
- AWS Basics

### AWS Basics

We will also learn about AWS basics including:

- Programmatic access
- IAM basics
- IAM with Terraform
- S3
- S3 with Terraform
- DynamoDB with Terraform

### Other concepts

We will also learn about:

- remote state
- state locking
- remote backend with S3
- State commands
- Introduction to EC2
- AWS EC2 with Terraform
- Provisioners

### Bonus topics

We will also learn about:

- terraform taints
- debugging
- terraform import
- modules
- functions
- conditional expressions
- workspaces
- terraform cloud

### Traditional IT & Challenges

Traditional IT development processes can be quite time consuming and bureaucratic. This is partly due to the challenge
of
upfront infrastructure costs:

![image](https://user-images.githubusercontent.com/27693622/236455547-61ce0224-c7aa-414c-abe8-abf0637fcce2.png)

Several parts of the application development process are also manual and error prone.
Other challenges include:

- Slow deployment
- High cost of deployment
- Limited Automation
- Human Error
- Inconsistency
- Wasted Resources

Moving to cloud can significantly reduce the time to market and hardware costs. The datacenter and hardware assets are
the responsibility of the cloud provider. This means that the cloud provider is responsible for the maintenance and
provision.

Using the management console can be error prone and time consuming. It is also not scalable. This is where
Infrastructure as Code
comes in. There are now a range of infrastucture as code tools available. These include:
![image](https://user-images.githubusercontent.com/27693622/236456537-2b3b4c6d-b338-4fc6-8190-9f70c74a64fc.png)

### Infrastructure as Code

Infrastructure as Code is the process of managing and provisioning infrastructure through machine readable definition
files.
A better way to manage infrastructure is to use code. This is where Infrastructure as Code comes in. This is an example
of a bash script
for creating infrastructure:

```bash
#!/bin/bash

IP_ADDRESS="10.2.2.1"

EC2_INSTANCE=$(ec2-run-instances --instance-typ t2.micro ami-0edab43b6fa892279)

INSTANCE=$(echo ${EC2_INSTANCE} | sed 's/*INSTANCE //' | sed 's/ .*//')

while ! ec2-describe-instance $INSTANCE | grep -q "running"
do
  echo Waiting for $INSTANCE to be ready...
done

if [ ! $(ec2-describe-instances $INSTANCE | grep -q "running") ]; then
  echo "Instance $INSTANCE is stopped"
  exit 1
fi

ec2-associate-address $IP_ADDRESS -i $INSTANCE

echo Instance $INSTANCE was created successfully
```

The above is an example of infrastructure as code. It is a bash script that creates an EC2 instance. It is not very
readable and difficult to manage. We can replace this code with
terraform:

```terraform

resource "aws_instance" "webserver" {
  ami           = "ami-0edab43b6fa892279"
  instance_type = "t2.micro"
}
```

and as ansible:

```yaml
- amazon.aws.ec2:
  key_name: mykey
  instance_type: t2.micro
  image: ami-123456
  wait: yes
  group: webserver
  count: 3
  vpc_subnet_id: subnet-29e63245
  assign_public_ip: yes
```

Ansible and terraform are used to provision infrastructure. Ansible is a configuration management tool.

Types of IAC tools:

| Configuration Management   | Server Templating                 | Provisioning              |
|----------------------------|-----------------------------------|---------------------------|
| Ansible, Puppet, Saltstack | Docker, Packer, HashiCorp Vagrant | Terraform, CloudFormation |

Configuration management tools are used to install and manage software. These follow a standard structure and idempotent
and
can be checked into version control. Idempotency is important because it means that the same result is achieved no
matter how
many times we run the code.

Server templating tools are used to create machine images. These are used to create immutable infrastructure. These
include software and dependencies
and represent immutable infrastructure that can be deployed to any environment.

Provisioning tools are used to provision infrastructure. These include terraform and cloudformation. These are used to
deploy immutable infrastructure
resources. These can include servers, databases, network components. Terraform can be used with multiple providers.
Cloudformation is used with AWS.

### Terraform

Terraform is a free and open source infrastructure tool. It allows us to quickly deploy and destroy infrastructure on a
wide range of cloud providers.
Providers help terraform to provision resources through their APIs. Terraform uses hcl (Hashicorp Configuration
Language) to define infrastructure.
All infrastructure can be defined in .tf files. The following code is used to deploy resources on AWS:

```terraform

resource "aws_instance" "webserver" {
  ami           = "ami-0edab43b6fa892279"
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "finance" {
  bucket = "finance-21092020"
  tags   = {
    Description = "Finance and Payroll"
  }
}

resource "aws_iam_user" "admin-user" {
  name = "lucy"
  tags = {
    Description = "Team Leader"
  }
}
```

The code is declarative. It tells the provider what to do. It does not tell the provider how to do it. Terraform will
create a plan and then apply the plan.

Terraform works in three phases:

- init
- plan
- apply

Every object managed by terraform is called a resource. Terraform records the state of the infrastructure and can then
respond to put the file

### Getting started with Terraform

This link is useful for downloading terraform:
https://developer.hashicorp.com/terraform/downloads

This is an example of a terraform file:

```terraform
resource "aws_instance" "webserver" {
  ami           = "ami-0edab43b6fa892279"
  instance_type = "t2.micro"
}
```

A resource is an object that terraform manages. It can include a range of objects. The above code will create an EC2
instance. The resource type is aws_instance. The name of the resource is webserver. The resource type and name are used
to reference the resource. The resource type is used to identify the resource. The name is used to reference the
resource. The resource type and name are separated by an underscore. The resource type is followed by the name of the
resource. The resource type and name are separated by a dot. The resource type is followed by the name of the resource.
The resource type and name are separated by a dot. The resource type is followed by the name of the resource. The
resource type and name are separated by a dot. The resource type is followed by the name of the resource. The resource
type and name are separated by a dot. The resource type is followed by the name of the resource. The resource type and
name are separated by a dot. The resource type is followed by the name of the resource. The resource type and name are
separated by a dot. The resource type is followed by the name of the resource. The resource type and name are separated
by a dot. The resource type is followed by the name of the resource. The resource type and name are separated by a dot.
The resource type is followed by the name of the resource. The resource type and name are separated by a dot. The
resource type is followed by the name of the resource. The resource type and name are separated by a dot.
We will start by looking at the simple resource type for understanding the lifecycle.

The HCL file consists of blocks and arguments:

```yaml
<block> <parameters> {
  key1 = value1
  key2 = value2
}
```

Let's start by creating a local file:

```yaml
resource "local file" "pet" {
  filename = "${path.module}/pets.txt"
  content = "We love pets!"
}
```

Here we have filename which we will create in our folder. We perform:

```bash
terraform init
terraform apply
```

We then have a new file in our folder called pets.txt.

Here is another terraform file. Here we create a webserver on AWS:

```yaml
resource "aws_instance" "webserver" {
  ami = "ami-0edab43b6fa892279"
  instance_type = "t2.micro"
}
```

In this example we create an AWS S3 bucket:

```yaml
resource "aws_s3_bucket" "data" {
  bucket = "webserver-bucket-org-2207"
  acl = "private"
}
```

The terraform workflow consists of four steps:

1. Write the file
2. Initialise the file with init
3. Create a plan with plan
4. Apply the plan with apply

We can also show information about the state of the infrastructure with show:

```bash
tom@tom-ubuntu:~/Projects/terraform/root/terraform-local-file$ terraform show
# local_file.pet:
resource "local_file" "pet" {
    content              = "We love pets!"
    content_base64sha256 = "zUA5Ip/IeKlmTQIptlp90JdMGAd8YLStDXhpGq0Bp0c="
    content_base64sha512 = "tduqTz5S8Wa3O9Ab5+g0GcGL6kMjMh61vjFcMm5KkOO5TgViAC/kBOdvYHl9qky2K99+u80z0CfCs2ExsHbjGg=="
    content_md5          = "f510a471c5dc0bcd4759ad9dc81a516f"
    content_sha1         = "cba595b7d9f94ba1107a46f3f731912d95fb3d2c"
    content_sha256       = "cd4039229fc878a9664d0229b65a7dd0974c18077c60b4ad0d78691aad01a747"
    content_sha512       = "b5dbaa4f3e52f166b73bd01be7e83419c18bea4323321eb5be315c326e4a90e3b94e0562002fe404e76f60797daa4cb62bdf7ebbcd33d027c2b36131b076e31a"
    directory_permission = "0777"
    file_permission      = "0777"
    filename             = "./pets.txt"
    id                   = "cba595b7d9f94ba1107a46f3f731912d95fb3d2c"
}
```

We can then destroy the file with terraform destroy.

It is common to put resources that we want to define in main.tf:

```yaml
resource "local_file" "pet" {
  filename = "${path.module}/pets.txt"
  content = "We love pets!"
}

  resource "local_file" "cat" {
  filename = "${path.module}/cat.txt"
  content = "My favorite pet is Mr Whiskers"
}
```

| File name    | Purpose                                                       |
|--------------|---------------------------------------------------------------|
| main.tf      | The main configuration file containing resource configuration |
| variables.tf | The file containing the variables used in the configuration   |
| outputs.tf   | The file containing the outputs of the configuration          |
| provider.tf  | The file containing the provider configuration                |


### Multiple Providers
Here we will look at using multiple providers with Terraform. We can also use multiple providers in the terraform system.

```yaml

resource "local_file" "pet" {
  filename = "/root/pets.txt"
  content = "We love pets!"
}
```
We can add a random provider:

```yaml
resource "random_pet" "my-pet" {
  prefix = "Mrs"
  separator = "."
  length = "1"
}
```

We have to run terraform init to add the random provider. We then run terraform plan to view the plan. A new resource will be 
created based on the new resource block we added. We then can add the new configuration with terraform apply. 

