variable "user_uuid" {
  description = "UUID for the user"
  type        = string

  validation {
    # This regex pattern matches a standard UUID format with dashes, consisting of 8-4-4-4-12 characters
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "Invalid UUID format. Please provide a valid UUID."
  }
}

variable "bucket_name" {
  description = "Bucket Name"
  type        = string
}

variable "index_html_filepath" {
  type        = string
  description = "File path for the index.html file"

  #   validation {
  #   condition     = fileexists(var.index_html_filepath)
  #   error_message = "The provided path for index.html does not exist."
  # }
}

variable "error_html_filepath" {
  type        = string
  description = "File path for the error.html file"

  #   validation {
  #   condition     = fileexists(var.error_html_filepath)
  #   error_message = "The provided path for error.html does not exist."
  # }
}

variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1."
  type        = number

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1."
  }
}

variable "assets_path" {
  description = "Path to assets folder"
  type = string
}