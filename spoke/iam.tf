
resource "aws_iam_role" "event_delivery_role" {
  name = "RootActivityEventDeliveryRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "events.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "event_delivery_role_policy" {
  name = "RootActivityEventBusDeliveryRolePolicy"
  role = aws_iam_role.event_delivery_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["events:PutEvents"]
        Resource = "arn:aws:events:${data.aws_region.current.name}:${var.hub_account}:event-bus/${var.hub_event_bus_name}"
      }
    ]
  })
}