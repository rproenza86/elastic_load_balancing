# Elastic Load Balancing

> Terraform scripts to build the AWS environment where to use Elastic Load Balancing to load balance traffic across multiple Amazon Elastic Compute Cloud (EC2) instances in a multiple Availability Zones. You will deploy a simple application on multiple Amazon EC2 instances and observe load balancing by viewing the application in your browser.

```
Tested using:

Terraform v0.11.10
+ provider.aws v1.42.0
```

## Use case description

Launch a pair of instances, bootstrap them to install web servers and content, and then access the instances independently using Amazon EC2 DNS records.

Next, terraform will set up Elastic Load Balancing, add the EC2 instances to the load balancer, and then access the DNS record again to watch your requests load balance between servers.

Finally, you will be able of view Elastic Load Balancing metrics in Amazon CloudWatch.

### Infrastructure objectives

* Create Virtual Private Cloud(VPC)
* Create a public and private subnets
* Create an Internet Gateway
* Create a Route Table and add a route to the Internet
* Create a security group for the web server to only allow HTTP inbound traffic from Internet
<ul>
<li>Launching a multiple server web farm on Amazon EC2.</li>
<li>Using bootstrapping techniques to configure Linux instances with Apache, PHP, and a simple PHP application downloaded from Amazon Simple Storage Service (S3).</li>
<li>Creating and configuring an application load balancer that will sit in front of your Amazon EC2 web server instances.</li>
<li>Viewing Amazon CloudWatch metrics for the load balancer.</li>
</ul>

## How to use

### Pre-requirement: Set AWS environment variables

```
$ export TF_VAR_access_key=<your_key>

$ export TF_VAR_secret_key=<your-secret>

$ export TF_VAR_region=<your_region>
```

### Initialize a working directory

`$ cd intrastructure/`

`$ terraform init`

### Create an execution plan

`$ terraform plan`

### Apply the changes required to reach the desired state of the configuration

`$ terraform apply`

### Delete infrastructure

`$ terraform destroy`

## How to test?

When applied the configuration `terraform` will show us the next output:

```
Outputs:

loadbalancer_public_dns_records = web-servers-lb-1880196268.us-east-1.elb.amazonaws.com
web_servers_public_dns_records = [
    ec2-35-173-28-26.compute-1.amazonaws.com,
    ec2-35-175-69-159.compute-1.amazonaws.com
]
```

Use the `loadbalancer_public_dns_records` to test multiple times the endpoint hitting both web servers.