locals {
  gcp_project_id     = "{{ .GCPProjectID }}"
  gcp_project_number = "{{ .GCPProjectNumber }}"
  gcp_region         = "{{ .GCPRegion }}"
  state_bucket_name  = "{{ .StateBucketName }}"
}
