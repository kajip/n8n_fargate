// 変数

variable "default_region" {
  description = "AWSのリージョン"
  default     = "ap-northeast-1"
}

variable "vpc_id" {
}

variable "subnets" {
  type = "list"
}

variable "service_name" {
}

variable "n8n_port" {
}

variable "cloudwatch_log_group_name" {
}
