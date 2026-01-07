## Requirements

| Name                                                   | Version |
| ------------------------------------------------------ | ------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~> 3.0  |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_archive"></a> [archive](#provider_archive) | n/a     |
| <a name="provider_aws"></a> [aws](#provider_aws)             | ~> 3.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                            | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_cloudwatch_event_bus.hub-root-activity-eventbus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_bus)                         | resource    |
| [aws_cloudwatch_event_permission.hub-root-activity-eventbus-OrgAccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_permission) | resource    |
| [aws_cloudwatch_event_rule.hub-root-activity-rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule)                           | resource    |
| [aws_cloudwatch_event_target.root-activity-event-target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target)                   | resource    |
| [aws_iam_role.LambdaRootAPIMonitorRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                   | resource    |
| [aws_iam_role_policy.LambdaRootAPIMonitorPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)                                   | resource    |
| [aws_lambda_function.RootActivityLambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)                                           | resource    |
| [aws_lambda_permission.allow_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission)                                             | resource    |
| [aws_sns_topic.root-activity-sns-topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic)                                                  | resource    |
| [aws_sns_topic_subscription.root-activity-sns-topic-sub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription)                    | resource    |
| [archive_file.RootActivityLambda](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file)                                                      | data source |

## Inputs

| Name                                                                              | Description                                             | Type          | Default                    | Required |
| --------------------------------------------------------------------------------- | ------------------------------------------------------- | ------------- | -------------------------- | :------: |
| <a name="input_email_address"></a> [email_address](#input_email_address) | Add your email here to be able to receive notifications | `string`      | `"email@example.com"`      |   yes    |
| <a name="input_sns_topic_name"></a> [sns_topic_name](#input_sns_topic_name)             | Add SNS topic name.                                     | `string`      | `"monitor-root-API-calls"` |   yes    |
| <a name="input_region"></a> [region](#input_region)                               | Add the region code where resources will be deployed.   | `string`      | `"eu-west-1"`              |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                     | Add tags to set on module resources.                    | `map(string)` | `{}`                       |   yes    |

## Outputs

No outputs.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_root_activity_email_alarm_alert"></a> [root\_activity\_email\_alarm\_alert](#module\_root\_activity\_email\_alarm\_alert) | ./localmodules/email-lambda | n/a |
| <a name="module_root_activity_slack_alert"></a> [root\_activity\_slack\_alert](#module\_root\_activity\_slack\_alert) | ./localmodules/slack-lambda | n/a |
| <a name="module_root_login_email_alarm_alert"></a> [root\_login\_email\_alarm\_alert](#module\_root\_login\_email\_alarm\_alert) | ./localmodules/email-lambda | n/a |
| <a name="module_root_login_pagerduty_alarm_alert"></a> [root\_login\_pagerduty\_alarm\_alert](#module\_root\_login\_pagerduty\_alarm\_alert) | ./localmodules/pagerduty-lambda | n/a |
| <a name="module_root_login_slack_alert"></a> [root\_login\_slack\_alert](#module\_root\_login\_slack\_alert) | ./localmodules/slack-lambda | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_bus.hub_root_activity_eventbus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_bus) | resource |
| [aws_cloudwatch_event_permission.hub_root_activity_eventbus_OrgAccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_permission) | resource |
| [aws_cloudwatch_event_rule.root_activity_monitor_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.root_alarm_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.root_activity_event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.root_alarm_event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_metric_filter.root_account_logins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_metric_alarm.root_account_logins_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_query_definition.root_account_logins_query](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_query_definition) | resource |
| [aws_sns_topic.root_activity_email_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic.root_activity_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic.root_login_alarm_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.root_activity_email_sns_topic_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.root_activity_email_sns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.root_activity_sns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.root_login_alarm_sns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.myorg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_evaluation_periods"></a> [alarm\_evaluation\_periods](#input\_alarm\_evaluation\_periods) | The period over which the root account activity metric is evaluated, in seconds | `number` | `300` | no |
| <a name="input_cloudtrail_log_group_name"></a> [cloudtrail\_log\_group\_name](#input\_cloudtrail\_log\_group\_name) | Cloudtrail cloudwatch log group name | `string` | n/a | yes |
| <a name="input_enable_root_activity_email_alert"></a> [enable\_root\_activity\_email\_alert](#input\_enable\_root\_activity\_email\_alert) | Enable email alerts for root activity events. | `bool` | `false` | no |
| <a name="input_enable_root_activity_slack_alert"></a> [enable\_root\_activity\_slack\_alert](#input\_enable\_root\_activity\_slack\_alert) | Enable Slack alerts for root activity events. | `bool` | `false` | no |
| <a name="input_enable_root_login_email_alert"></a> [enable\_root\_login\_email\_alert](#input\_enable\_root\_login\_email\_alert) | Enable email alerts for root login events. | `bool` | `false` | no |
| <a name="input_enable_root_login_pagerduty_alert"></a> [enable\_root\_login\_pagerduty\_alert](#input\_enable\_root\_login\_pagerduty\_alert) | Enable PagerDuty alerts for root login events. | `bool` | `false` | no |
| <a name="input_enable_root_login_slack_alert"></a> [enable\_root\_login\_slack\_alert](#input\_enable\_root\_login\_slack\_alert) | Enable Slack alerts for root login events. | `bool` | `false` | no |
| <a name="input_hub_event_bus_name"></a> [hub\_event\_bus\_name](#input\_hub\_event\_bus\_name) | Name of the EventBridge event bus in the account | `string` | `"hub-root-activity"` | no |
| <a name="input_pagerduty_routing_key"></a> [pagerduty\_routing\_key](#input\_pagerduty\_routing\_key) | PagerDuty routing key used by PagerDuty alert lambdas. Required if PagerDuty alerts are enabled. | `string` | `null` | no |
| <a name="input_root_activity_email_config"></a> [root\_activity\_email\_config](#input\_root\_activity\_email\_config) | Email configuration for root activity notifications | <pre>object({<br>    sns_topic_name         = optional(string, "aws-iam-root-user-activity-email-monitor")<br>    sns_topic_display_name = optional(string, "AWS IAM Root User Activity Monitor")<br>    email_address          = string<br>  })</pre> | `null` | no |
| <a name="input_root_activity_email_lambda_name"></a> [root\_activity\_email\_lambda\_name](#input\_root\_activity\_email\_lambda\_name) | Lambda function name for root activity email alert. | `string` | `"root-activity-email-alarm-handler"` | no |
| <a name="input_root_activity_slack_lambda_name"></a> [root\_activity\_slack\_lambda\_name](#input\_root\_activity\_slack\_lambda\_name) | Lambda function name for root activity Slack alert. | `string` | `"root-activity-slack-alarm-handler"` | no |
| <a name="input_root_login_email_lambda_name"></a> [root\_login\_email\_lambda\_name](#input\_root\_login\_email\_lambda\_name) | Lambda function name for root login email alert. | `string` | `"root-login-email-alarm-handler"` | no |
| <a name="input_root_login_pagerduty_lambda_name"></a> [root\_login\_pagerduty\_lambda\_name](#input\_root\_login\_pagerduty\_lambda\_name) | Lambda function name for root login PagerDuty alert. | `string` | `"root-login-pagerduty-alarm-handler"` | no |
| <a name="input_root_login_slack_lambda_name"></a> [root\_login\_slack\_lambda\_name](#input\_root\_login\_slack\_lambda\_name) | Lambda function name for root login Slack alert. | `string` | `"root-login-slack-alarm-handler"` | no |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | Slack webhook URL used by Slack alert lambdas. Required if Slack alerts are enabled. | `string` | `null` | no |
| <a name="input_sns_root_activity_topic_display_name"></a> [sns\_root\_activity\_topic\_display\_name](#input\_sns\_root\_activity\_topic\_display\_name) | Display name for the SNS root activity topic | `string` | `"AWS IAM Root User Activity Monitor"` | no |
| <a name="input_sns_root_activity_topic_name"></a> [sns\_root\_activity\_topic\_name](#input\_sns\_root\_activity\_topic\_name) | SNS topic name for root activity notifications | `string` | `"aws-iam-root-user-activity-monitor"` | no |
| <a name="input_sns_root_login_alarm_topic_display_name"></a> [sns\_root\_login\_alarm\_topic\_display\_name](#input\_sns\_root\_login\_alarm\_topic\_display\_name) | Display name for the SNS root login alarm topic | `string` | `"AWS IAM Root User Login Alarm Monitor"` | no |
| <a name="input_sns_root_login_alarm_topic_name"></a> [sns\_root\_login\_alarm\_topic\_name](#input\_sns\_root\_login\_alarm\_topic\_name) | SNS topic name for root login alarm notifications | `string` | `"aws-iam-root-user-login-alarm-monitor"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hub_event_bus_name"></a> [hub\_event\_bus\_name](#output\_hub\_event\_bus\_name) | n/a |
| <a name="output_orgid"></a> [orgid](#output\_orgid) | n/a |
| <a name="output_root_activity_sns_topic_arn"></a> [root\_activity\_sns\_topic\_arn](#output\_root\_activity\_sns\_topic\_arn) | n/a |
| <a name="output_root_alarm_sns_topic_arn"></a> [root\_alarm\_sns\_topic\_arn](#output\_root\_alarm\_sns\_topic\_arn) | n/a |
<!-- END_TF_DOCS -->