variable "cidr_block" {
  type        = string
  description = "CIDR block for vpc"
}
variable "az_count" {
  description = "Number of AZs in give region"
  type        = number
}
variable "project" {
  description = "Variable for set tags and naming resource by project name"
  type        = string
}
variable "environment" {
  description = "Variable for set tags and naming resource by environment"
  type        = string
}
variable "region" {
  description = "AWS region"
  type        = string
}
variable "image" {
  description = "Docker image to run in the ECS cluster"
  type        = string
}
variable "application_port" {
  description = "Port exposed by docker image"
  type        = number
}
variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  type        = string
}
variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  type        = string
}
variable "desired_count" {
  description = "Count of docker container to run"
  type        = number
}
variable "subscription_email_address" {
  type        = string
  description = "Subscription email address for get CW alarms"
}
