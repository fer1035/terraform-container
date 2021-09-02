variable "family_name" {
    type = string
}

variable "image_name" {
    type = string
}

variable "instance_count" {
    type = number
    default = 1
}

variable "force_new" {
    type = bool
    default = false
}

resource "aws_ecs_task_definition" "task" {
  family = var.family_name
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = 256
  memory = 512
  execution_role_arn = "arn:aws:iam::${local.account_id}:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
      name = var.family_name
      image = var.image_name
      essential = true
      workingDirectory = "/app"
    }
  ])
}

resource "aws_ecs_cluster" "cluster" {
  name = var.family_name
}

resource "aws_ecs_service" "service" {
  name = var.family_name
  cluster = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count = var.instance_count
  launch_type = "FARGATE"
  platform_version = "LATEST"
  force_new_deployment = var.force_new
  network_configuration {
      subnets = ["<public_subnet_id_1>", "<public_subnet_id_2>"]
      security_groups = ["<security_group_id_port_80>"]
      assign_public_ip = true
  }
}
