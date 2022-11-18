packer {
  required_plugins {
    docker = {
      version = ">=0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:xenial"
  commit = true
}

build {
  name = "learn-packer-for-docker"
  sources = [
    "source.docker.ubuntu"
  ]
  provisioner "shell" {
    environment_vars = [
      "FOO=Hello world!",
    ]
    inline = [
      "echo Adding file to Docker Container",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }
  provisioner "shell" {
    inline = [
      "echo Adding file to Docker Container",
    ]
  }
}

