variable "resource_group_name" {
    type        = string
    description = "resource group name"
}

variable "location" {
    type        = string
    description = "resources location"
}

variable "default_tags" {
    type        = map
    description = "Map of Default Tags"
}
