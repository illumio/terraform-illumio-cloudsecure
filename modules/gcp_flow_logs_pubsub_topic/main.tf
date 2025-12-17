# ------------------------------------------------------------------------------
# 1. Project Role (IllumioPubSubAccessRole)
# ------------------------------------------------------------------------------

resource "google_project_iam_custom_role" "pubsub_access_role" {
  role_id     = "${var.iam_name_prefix}PubSubAccessRole"
  title       = "Illumio Pub/Sub Access Role"
  description = "Role to allow Pub/Sub subscription management for Illumio CloudSecure"
  permissions = [
    "pubsub.subscriptions.create",
    "pubsub.subscriptions.consume",
    "pubsub.subscriptions.delete",
  ]
  project = var.project_id
}

resource "google_project_iam_member" "pubsub_access_binding" {
  project = var.project_id
  role    = google_project_iam_custom_role.pubsub_access_role.id
  member  = "serviceAccount:${var.service_account_email}"
}

# ------------------------------------------------------------------------------
# 2. Topic Role (IllumioFlowAccessRole)
# ------------------------------------------------------------------------------

resource "google_project_iam_custom_role" "flow_access_role" {
  role_id     = "${var.iam_name_prefix}FlowAccessRole"
  title       = "Illumio Flow Access Role"
  description = "Role to allow attaching subscriptions to Pub/Sub topics for Illumio CloudSecure"
  permissions = [
    "pubsub.topics.attachSubscription",
  ]
  project = var.project_id
}

# Bind the Topic Role to EACH topic individually
resource "google_pubsub_topic_iam_binding" "flow_access_binding" {
  for_each = var.pubsub_topic_ids

  project = var.project_id
  topic   = each.value
  role    = google_project_iam_custom_role.flow_access_role.id
  members = ["serviceAccount:${var.service_account_email}"]
}

# ------------------------------------------------------------------------------
# 3. CloudSecure Registration
# ------------------------------------------------------------------------------

resource "illumio-cloudsecure_gcp_flow_logs_pubsub_topic" "flow_logs" {
  for_each = var.pubsub_topic_ids

  project_id      = var.project_id
  pubsub_topic_id = each.value

  depends_on = [
    google_project_iam_member.pubsub_access_binding,
    google_pubsub_topic_iam_binding.flow_access_binding
  ]
}
