<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.root_activity_monitor_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.root_alarm_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.root_activity_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.root_alarm_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_metric_filter.root_account_logins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_metric_alarm.root_account_logins_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_query_definition.root_account_logins_query](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_query_definition) | resource |
| [aws_iam_role.event_delivery_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.event_delivery_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_evaluation_periods"></a> [alarm\_evaluation\_periods](#input\_alarm\_evaluation\_periods) | The period over which the root account activity metric is evaluated, in seconds | `number` | `300` | no |
| <a name="input_cloudtrail_log_group_name"></a> [cloudtrail\_log\_group\_name](#input\_cloudtrail\_log\_group\_name) | Cloudtrail cloudwatch log group name | `string` | n/a | yes |
| <a name="input_hub_account"></a> [hub\_account](#input\_hub\_account) | Account Id for the hub account, e.g., 123456789012 | `string` | n/a | yes |
| <a name="input_hub_event_bus_name"></a> [hub\_event\_bus\_name](#input\_hub\_event\_bus\_name) | Name of the EventBridge event bus in the hub account | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->