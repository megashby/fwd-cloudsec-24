## Introduction

This repo contains the reference architecture for my 2024 fwd:cloudsec session, "Balancing Security and Costs in AWS VPC Interface Endpoints"

## Architecture

The VPC `vpc-new-york` contains the centralized VPC Endpoints. `vpc-new-jersey` is connected to `vpc-new-york` through VPC Peering, and `vpc-connecticut` is connected to `vpc-new-york` through Transit Gateway.

## Fair Warnings
###### Deploying through terraform

All projects cannot be applied in parallel. As best practice please follow the below ordering:
1. deploy the `vpc-new-york` project first with the `data.tf` file & blocks commented out.
2. do likewise with the projects `vpc-new-jersey` and `vpc-connecticut`.
3. Once the VPC components are deployed, please deploy the `connectivity` project.
4. Uncomment data blocks and resources in `vpc-new-york` and deploy.
5. Uncomment data blocks and resources in `vpc-new-jersey` and `vpc-connecticut` and deploy.
6. The `sqs` project can be deployed at any point.



>
>       "Deploying this infrastructure isn't an art, and it isn't a science. It's mostly just a mess." - Meg



###### VPC Endpoint over-simplicity
The VPC Endpoint policies do not contain the block:
```
{
    "Sid": "AllowRequestsByAWSServicePrincipals",
    "Effect": "Allow",
    "Principal": {
        "AWS": "*"
    },
    "Action": "*",
    "Resource": "*",
    "Condition": {
        "Bool": {
            "aws:PrincipalIsAWSService": "true"
        }
    }
}
```
(in the allow-listing examples)

or the condition
```
"Condition": {
    "BoolIfExists": {
        "aws:PrincipalIsAWSService": "false"
    }
}
```
(in the deny-listing examples)

In an effort to keep the focus on the present condition keys. However, in true production environments, these are required to allow AWS services to use other AWS services protected by VPC Endpoints. Please see [AWS Blog Series on Data Perimeters](https://aws.amazon.com/blogs/security/establishing-a-data-perimeter-on-aws-allow-only-trusted-identities-to-access-company-data/) for more details on why this is necessary (or find me in real life and I will do my best to regurgitate the blog to you)
