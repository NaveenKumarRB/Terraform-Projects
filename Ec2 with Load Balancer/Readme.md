This Folder as the code that how do we create the Ec2 instace with the isolated networ (VPC) and load balancer and you can access the web server from the outside.

In main.tf file as the information of the resource creation
    a. VPC creation
    b. 2 Subnet Creation
    c. Security Group Creation.
    b. Create the Route table and Internet Gateway and attach to VPC

In Loadbalancer.tf file has the information about the "Load Balancer" Resource creation (Load balancer, Target groups and etc )

In Veriable.tf file contains the information about the Veriables required for the main.tf for resource creation

In terraform.tfstate file contaions information of the specs and other details for the resouce creation.

In output.tf file have the information which need to be printed after the execurion (DNS IP's and Instace IP's)