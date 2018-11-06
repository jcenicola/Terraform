# create a vpc with networking and name

resource "aws_vpc" "jc_vpc" {
	cidr_block = "10.0.0.0/16"
    	instance_tenancy = "default"
    	enable_dns_support = "true"
    	enable_dns_hostnames = "true"
    	tags {
            Name = "jc_vpc"
    }
}

# create public subnets for vpc

resource "aws_subnet" "jc_vpc_public-1" {
	vpc_id = "${aws_vpc.jc_vpc.id}"
	cidr_block = "10.0.1.0/24"
    	map_public_ip_on_launch = "true"
    	availability_zone = "us-west-1a"

    	tags {
            Name = "jc_vpc-public-1"
    }
}

resource "aws_subnet" "jc_vpc_public-2" {
        vpc_id = "${aws_vpc.jc_vpc.id}"
        cidr_block = "10.0.2.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "us-west-1b"

        tags {
            Name = "jc_vpc-public-2"
    }    
}

# create private subnets for vpc

resource "aws_subnet" "jc_vpc_private-1" {
        vpc_id = "${aws_vpc.jc_vpc.id}"
        cidr_block = "10.0.3.0/24"
        map_public_ip_on_launch = "false"
        availability_zone = "us-west-1a"

        tags {
            Name = "jc_vpc-private-1"
    }
}

resource "aws_subnet" "jc_vpc_private-2" {
        vpc_id = "${aws_vpc.jc_vpc.id}"
        cidr_block = "10.0.4.0/24"
        map_public_ip_on_launch = "false"
        availability_zone = "us-west-1b"

        tags {
            Name = "jc_vpc-private-2"
    }
}

# create Internet Gateway for vpc

resource "aws_internet_gateway" "jc_vpc_igw" {
	vpc_id = "${aws_vpc.jc_vpc.id}"

    	tags {
            Name = "jc_vpc"
    }
}

# create route tables for vpc

resource "aws_route_table" "jc_vpc_route_table" {
    	vpc_id = "${aws_vpc.jc_vpc.id}"
    	route {
            cidr_block = "0.0.0.0/0"
            gateway_id = "${aws_internet_gateway.jc_vpc_igw.id}"
    	}	
	
	tags {
            Name = "jc_vpc"
    }
}

