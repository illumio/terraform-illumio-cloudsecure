locals {
  # A stable, unique key per registered source. project_id is constant for the
  # module call, so (bucket_name, path_prefix) is the source identity.
  buckets_by_key = {
    for b in var.buckets :
    "${b.bucket_name}${b.path_prefix == null ? "" : "::${b.path_prefix}"}" => b
  }

  grant_read_access = var.service_account_email != null

  # Read access is granted per bucket, so dedupe entries that only differ by
  # path_prefix.
  grant_buckets = local.grant_read_access ? toset([for b in var.buckets : b.bucket_name]) : toset([])
}

# Optionally create each bucket. Disabled by default: customers usually already
# have flow logs writing to the bucket.
resource "google_storage_bucket" "this" {
  for_each                    = var.create_bucket ? local.buckets_by_key : {}
  name                        = each.value.bucket_name
  project                     = var.project_id
  location                    = var.bucket_location
  uniform_bucket_level_access = true
  labels                      = var.labels
}

# Optionally grant the CloudSecure service account read access to the buckets.
resource "google_storage_bucket_iam_member" "object_viewer" {
  for_each = local.grant_buckets
  bucket   = each.value
  role     = "roles/storage.objectViewer"
  member   = "serviceAccount:${var.service_account_email}"

  depends_on = [google_storage_bucket.this]
}

# Register each existing bucket with CloudSecure by name and (optional) prefix.
resource "illumio-cloudsecure_gcp_flow_logs_storage_bucket_source" "this" {
  for_each    = local.buckets_by_key
  project_id  = var.project_id
  bucket_name = each.value.bucket_name
  path_prefix = each.value.path_prefix

  depends_on = [
    google_storage_bucket.this,
    google_storage_bucket_iam_member.object_viewer,
  ]
}
