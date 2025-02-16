# resource "aws_security_group" "eventbridge_sg" {
#   vpc_id = aws_vpc.main.id
#   ingress {
#   from_port        = 0
#   to_port          = 0
#   protocol         = "-1"
#   # TO DO: change to eventbridge cidr
#   cidr_blocks      = ["0.0.0.0/0"]
# }
#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = [var.private_subnet_cidr]
#   }
# }

# resource "aws_security_group" "ssm_sg" {
#   vpc_id = aws_vpc.main.id
#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     # TO DO: add ssm cidr
#     cidr_blocks      = [var.private_subnet_cidr]
#   }
# }



# Security Group for Lambda Functions
resource "aws_security_group" "lambda_sg" {
  vpc_id = aws_vpc.main.id

  # Allow Lambda to communicate with VPC Endpoints (Secrets Manager, SSM, EventBridge)
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.vpc_endpoint_sg.id]  # Allow only VPC Endpoints
  }

  # Allow all outbound traffic (to access NAT Gateway, VPC Endpoints)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "LambdaSG"
  }
}

# Security Group for VPC Endpoints (Secrets Manager, SSM, EventBridge)
resource "aws_security_group" "vpc_endpoint_sg" {
  vpc_id = aws_vpc.main.id

  # Allow incoming requests only from Lambda SG
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.lambda_sg.id]  # Only accept traffic from Lambda
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPCEndpointSG"
  }
}