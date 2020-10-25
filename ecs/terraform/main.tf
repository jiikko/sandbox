resource "aws_ecs_cluster" "antena" {
  name = "antena"
}

resource "aws_ecs_task_definition" "td" {
  family                   = aws_ecs_cluster.antena.name
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./container_definitions.json")
}
