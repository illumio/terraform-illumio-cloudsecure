resource "time_static" "timestamp" {}

locals {
  # Clean topic URIs by removing the prefix if present
  # From: //pubsub.googleapis.com/projects/myproject/topics/mytopic
  # To:   projects/myproject/topics/mytopic
  topic_paths = [
    for topic in var.pubsub_topics : replace(topic, "//pubsub.googleapis.com/", "")
  ]
}

# ------------------------------------------------------------------------------
# 1. Project Role (IllumioPubSubAccessRole)
# ------------------------------------------------------------------------------

resource "google_project_iam_custom_role" "pubsub_access_role" {
  role_id     = "IllumioPubSubAccessRole_${time_static.timestamp.unix}"
  title       = "Illumio PubSub Access Role"
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
  role_id     = "IllumioFlowAccessRole_${time_static.timestamp.unix}"
  title       = "Illumio Flow Access Role"
  description = "Role to allow attaching subscriptions to Pub/Sub topics for Illumio CloudSecure"
  permissions = [
    "pubsub.topics.attachSubscription",
  ]
  project = var.project_id
}

# Bind the Topic Role to EACH topic individually
resource "google_pubsub_topic_iam_member" "flow_access_binding" {
  for_each = toset(local.topic_paths)

  topic   = each.value
  role    = google_project_iam_custom_role.flow_access_role.id
  member  = "serviceAccount:${var.service_account_email}"
  project = var.project_id
}

# ------------------------------------------------------------------------------
# 3. CloudSecure Registration
# ------------------------------------------------------------------------------

resource "illumio-cloudsecure_gcp_flow_logs_pubsub_topic" "flow_logs" {
  for_each = var.pubsub_topics

  project_id      = var.project_id
  pubsub_topic_id = each.value

  depends_on = [
    google_project_iam_member.pubsub_access_binding,
    google_pubsub_topic_iam_member.flow_access_binding
  ]
}
