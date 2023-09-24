variable "user_uuid" {
  description = "UUID for the user"
  type        = string

  validation {
    # This regex pattern matches a standard UUID format with dashes, consisting of 8-4-4-4-12 characters
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "Invalid UUID format. Please provide a valid UUID."
  }
}