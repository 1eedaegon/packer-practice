packer {
  required_plugins {
    amazon = {
      version = ">=0.02"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "how-to-use-ami-with-packer"
  instance_type = "t2.micro"
  region        = "ap-northeast-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "how-to-use-packer-with-aws"
  sources = [
    "source.amazon-ebs.ubuntu",
    #"source.amazon-ebs.ubuntu-focal",
  ]

  provisioner "shell" {
    environment_vars = [
      "FOO=Hello world",
    ]
    inline = [
      "echo Welcome to ubuntu focal",
      "sleep 30",
      "sudo apt update",
      "sudo apt install -y net-tools",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }

  provisioner "shell" {
    inline = ["echo This provisioner runs finish"]
  }

  post-processor "vagrant" {}
}
