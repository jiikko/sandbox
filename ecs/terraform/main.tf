resource "aws_ecs_cluster" "antena" {
  name = "antena_with_terraform"
}

resource "aws_ecs_task_definition" "antena" {
  family                   = aws_ecs_cluster.antena.name
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./container_definitions.json")
}

module "nginx_sg" {
  source      = "./security_group"
  name        = "antena-nginx-sg"
  vpc_id      = aws_vps.example.id
  port        = 80
  cidr_blocks = [aws_vpc.example.cidr_block]
}

resource "aws_ecs_service" "antena" {
  family                            = aws_ecs_cluster.antena.name
  cluster                           = aws_ecs_cluster.antena.arn
  task_desinition                   = aws_ecs_task_definition.antena.arn
  desired_count                     = 1
  launch_type                       = "FARGATE"
  platform_version                  = "1.3.0"
  health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = false
    security_groups  = [module.nginx_sg.security_group_id]

    subnets = [aws_subnet.private_0.id, aws_subnet.private_1.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.antena.arn
    container_name   = "aaaaaaaaaaaaaaaa"
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
