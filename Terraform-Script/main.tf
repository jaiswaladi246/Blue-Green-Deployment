resource "aws_instance" "jenkins_instance" {
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = "t2.medium"
  key_name               = "publickeypair"
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  user_data              = templatefile("./sonarqube.sh", {})

  tags = {
    Name = "Jenkins-Docker"
  }
}

resource "aws_instance" "sonarqube_instance" {
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = "t2.medium"
  key_name               = "publickeypair"
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  user_data              = templatefile("./nexus.sh", {})

  tags = {
    Name = "sonarqube_instance"
  }
}

resource "aws_security_group" "instance_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress = [
    for port in [22, 80, 8080, 9000, 443, 8081] : {
      description      = "inbound rules"
      from_port        = port # Corrected attribute name
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
