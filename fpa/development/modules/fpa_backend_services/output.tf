output "uri" {
  description = "URL of the Cloud Run"
  value = google_cloud_run_v2_service.default.uri
}