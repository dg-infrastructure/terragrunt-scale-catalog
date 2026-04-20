variable "project_id" {
  description = "The GCP project ID where the bucket will be created."
  type        = string
}

variable "name" {
  description = "The name of the bucket. Must be globally unique across all GCP projects."
  type        = string
}

variable "location" {
  description = "The GCS location where the bucket will be created (e.g. US, EU, ASIA, us-central1)."
  type        = string
}

// Optional Variables

variable "storage_class" {
  description = "The storage class of the bucket. Valid values are STANDARD, NEARLINE, COLDLINE, and ARCHIVE."
  type        = string
  default     = "STANDARD"
}

variable "versioning_enabled" {
  description = "Whether to enable versioning on the bucket."
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Whether to delete all objects in the bucket when the bucket is destroyed."
  type        = bool
  default     = false
}

variable "uniform_bucket_level_access" {
  description = "Whether to enable uniform bucket-level access, which disables object-level ACLs."
  type        = bool
  default     = true
}
