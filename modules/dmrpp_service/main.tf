

locals {
  default_tags = {
    Deployment = var.prefix
  }
}

module "dmrpp_ecs_task_module" {
  source = "../dmrpp_task"
  name   = "${var.prefix}-dmrpp-generator"
}

module "dmrpp_service" {
<<<<<<< HEAD
  source = "https://github.com/nasa/cumulus/releases/download/v4.0.0/terraform-aws-cumulus-ecs-service.zip"
||||||| 55f25d3
  source = "https://github.com/nasa/cumulus/releases/download/v3.0.0/terraform-aws-cumulus-ecs-service.zip"
=======
  source = "https://github.com/nasa/cumulus/releases/download/v5.0.1/terraform-aws-cumulus-ecs-service.zip"
>>>>>>> upstream/master


  prefix                                = var.prefix
  name                                  = "${var.prefix}_dmrpp_generator"
  tags                                  = local.default_tags
  cluster_arn                           = var.cluster_arn
  desired_count                         = var.desired_count
  image                                 = var.docker_image
  log2elasticsearch_lambda_function_arn = var.log2elasticsearch_lambda_function_arn
  cpu                                   = var.cpu
  memory_reservation                    = var.memory_reservation
  volumes                               = var.volumes

  environment = {
    AWS_DEFAULT_REGION = var.region
  }
  command = [
    "dmrpp-generator",
    "activity",
    "--arn",
    module.dmrpp_ecs_task_module.task_id
  ]
  alarms = {
    TaskCountHight = {
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 1
      metric_name         = "MemoryUtilization"
      statistic           = "SampleCount"
      threshold           = 1
    }
  }
}
