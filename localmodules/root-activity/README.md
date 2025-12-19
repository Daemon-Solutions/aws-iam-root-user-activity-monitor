<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.root_activity_monitor_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.root_alarm_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_log_metric_filter.root_account_logins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_metric_alarm.root_account_logins_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_query_definition.root_account_logins_query](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_query_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_evaluation_periods"></a> [alarm\_evaluation\_periods](#input\_alarm\_evaluation\_periods) | The period over which the root account activity metric is evaluated, in seconds | `number` | `300` | no |
| <a name="input_cloudtrail_log_group_name"></a> [cloudtrail\_log\_group\_name](#input\_cloudtrail\_log\_group\_name) | Cloudtrail cloudwatch log group name | `string` | `"aws-controltower/CloudTrailLogs"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_root_activity_monitor_rule"></a> [root\_activity\_monitor\_rule](#output\_root\_activity\_monitor\_rule) | n/a |
| <a name="output_root_alarm_rule"></a> [root\_alarm\_rule](#output\_root\_alarm\_rule) | n/a |
<!-- END_TF_DOCS -->