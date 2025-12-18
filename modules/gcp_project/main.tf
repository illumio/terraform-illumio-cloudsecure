# Enable required APIs
resource "google_project_service" "required_apis" {
  for_each = toset([
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ])

  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}

# Service Account
resource "google_service_account" "illumio_sa" {
  account_id   = lower(replace("${var.iam_name_prefix}-sa", "_", "-"))
  display_name = "Illumio CloudSecure Service Account"
  project      = var.project_id
}

# Custom Role: API Enable
resource "google_project_iam_custom_role" "api_enable_role" {
  role_id     = lower("${var.iam_name_prefix}_api_enable_role")
  title       = "Illumio API Enable Role"
  description = "Role to allow enabling specific services"
  permissions = [
    "serviceusage.services.enable",
    "serviceusage.services.list",
    "serviceusage.services.get",
  ]
  project = var.project_id
}

# Bind API Enable Role
resource "google_project_iam_binding" "api_enable_role_binding" {
  project = var.project_id
  role    = google_project_iam_custom_role.api_enable_role.id
  members = ["serviceAccount:${google_service_account.illumio_sa.email}"]
}

# Bind Predefined Roles
resource "google_project_iam_member" "predefined_role_binding" {
  for_each = toset([
    "roles/iam.securityReviewer",
    "roles/compute.viewer",
    "roles/cloudasset.viewer"
  ])

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.illumio_sa.email}"
}

# Bind Impersonation Role
resource "google_service_account_iam_binding" "impersonation_role_binding" {
  service_account_id = google_service_account.illumio_sa.name
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = ["serviceAccount:${var.illumio_service_account_email}"]
}

# Conditional Write Role
resource "google_project_iam_custom_role" "write_role" {
  count = var.mode == "ReadWrite" ? 1 : 0

  role_id     = lower("${var.iam_name_prefix}_write_role")
  title       = "Illumio Write Role"
  description = "Role to allow write operations for Illumio CloudSecure"
  permissions = [
    "compute.firewalls.create",
    "compute.firewalls.delete",
    "compute.firewalls.get",
    "compute.firewalls.update",
    "compute.networks.updatePolicy",
  ]
  project = var.project_id
}

# Bind Write Role
resource "google_project_iam_binding" "write_role_binding" {
  count = var.mode == "ReadWrite" ? 1 : 0

  project = var.project_id
  role    = google_project_iam_custom_role.write_role[0].id
  members = ["serviceAccount:${google_service_account.illumio_sa.email}"]
}

# CloudSecure Registration
resource "illumio-cloudsecure_gcp_project" "project" {
  project_id            = var.project_id
  name                  = var.name
  mode                  = var.mode
  organization_id       = var.organization_id
  service_account_email = google_service_account.illumio_sa.email

  depends_on = [
    google_project_iam_binding.api_enable_role_binding,
    google_project_iam_member.predefined_role_binding,
    google_service_account_iam_binding.impersonation_role_binding,
    google_project_iam_binding.write_role_binding
  ]
}
