https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/ECS_AWSCLI_Fargate.html


```
aws ecs create-cluster --cluster-name fargate-cluster2
{
    "cluster": {
        "clusterArn": "arn:aws:ecs:ap-northeast-1:245214441821:cluster/fargate-cluster2",
        "clusterName": "fargate-cluster2",
        "status": "ACTIVE",
        "registeredContainerInstancesCount": 0,
        "runningTasksCount": 0,
        "pendingTasksCount": 0,
        "activeServicesCount": 0,
        "statistics": [],
        "tags": [],
        "settings": [
            {
                "name": "containerInsights",
                "value": "disabled"
            }
        ],
        "capacityProviders": [],
        "defaultCapacityProviderStrategy": []
    }
}
```



## タスクの定義
コンテナのリスト


```
aws ecs register-task-definition --cli-input-json file:///Users/koji/src/sandbox/ecs/with-aws-cli/task.json
{   
    "taskDefinition": {
        "taskDefinitionArn": "arn:aws:ecs:ap-northeast-1:245214441821:task-definition/sample-fargate:1",
        "containerDefinitions": [
            {   
                "name": "fargate-app",
                "image": "httpd:2.4",
                "cpu": 0,
                "portMappings": [
                    {   
                        "containerPort": 80,
                        "hostPort": 80,
                        "protocol": "tcp"
                    }
                ],
                "essential": true,
                "entryPoint": [
                    "sh",
                    "-c"
                ],
                "command": [
                    "/bin/sh -c \"echo '<html> <head> <title>Amazon ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Amazon ECS Sample App</h1> <h2>Congratulations!</h2> <p>Your application is now running on a container in Amazon ECS.</p> </div></body></html>' >  /usr/local/apache2/htdocs/index.html && httpd-foreground\""
                ],
                "environment": [],
                "mountPoints": [],
                "volumesFrom": []
            }
        ],
        "family": "sample-fargate",
        "networkMode": "awsvpc",
        "revision": 1,
        "volumes": [],
        "status": "ACTIVE",
        "requiresAttributes": [
            {   
                "name": "com.amazonaws.ecs.capability.docker-remote-api.1.18"
            },
            {   
                "name": "ecs.capability.task-eni"
            }
        ],
        "placementConstraints": [],
        "compatibilities": [
            "EC2",
            "FARGATE"
        ],
        "requiresCompatibilities": [
            "FARGATE"
        ],
        "cpu": "256",
        "memory": "512"
    }
}

## サービスの作成
```
aws ecs create-service --cluster fargate-cluster2 --service-name fargate-service --task-definition sample-fargate:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[subnet-05717e9cdd0728147],securityGroups=[sg-036feda348151b9a8],assignPublicIp=ENABLED}"

{
    "service": {
        "serviceArn": "arn:aws:ecs:ap-northeast-1:245214441821:service/fargate-cluster2/fargate-service",
        "serviceName": "fargate-service",
        "clusterArn": "arn:aws:ecs:ap-northeast-1:245214441821:cluster/fargate-cluster2",
        "loadBalancers": [],
        "serviceRegistries": [],
        "status": "ACTIVE",
        "desiredCount": 1,
        "runningCount": 0,
        "pendingCount": 0,
        "launchType": "FARGATE",
        "platformVersion": "LATEST",
        "taskDefinition": "arn:aws:ecs:ap-northeast-1:245214441821:task-definition/sample-fargate:1",
        "deploymentConfiguration": {
            "maximumPercent": 200,
            "minimumHealthyPercent": 100
        },
        "deployments": [
            {
                "id": "ecs-svc/6124588809356055568",
                "status": "PRIMARY",
                "taskDefinition": "arn:aws:ecs:ap-northeast-1:245214441821:task-definition/sample-fargate:1",
                "desiredCount": 1,
                "pendingCount": 0,
                "runningCount": 0,
                "createdAt": 1602747481.485,
                "updatedAt": 1602747481.485,
                "launchType": "FARGATE",
                "platformVersion": "1.3.0",
                "networkConfiguration": {
                    "awsvpcConfiguration": {
                        "subnets": [
                            "subnet-05717e9cdd0728147"
                        ],
                        "securityGroups": [
                            "sg-036feda348151b9a8"
                        ],
                        "assignPublicIp": "ENABLED"
                    }
                }
            }
        ],
        "roleArn": "arn:aws:iam::245214441821:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS",
        "events": [],
        "createdAt": 1602747481.485,
        "placementConstraints": [],
        "placementStrategy": [],
        "networkConfiguration": {
            "awsvpcConfiguration": {
                "subnets": [
                    "subnet-05717e9cdd0728147"
                ],
                "securityGroups": [
                    "sg-036feda348151b9a8"
                ],
                "assignPublicIp": "ENABLED"
            }
        },
        "schedulingStrategy": "REPLICA",
        "createdBy": "arn:aws:iam::245214441821:user/terraform",
        "enableECSManagedTags": false,
        "propagateTags": "NONE"
    }
}
```
