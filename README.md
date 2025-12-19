# Monitor IAM root user activity

Every Amazon Web Services (AWS) account has a root user. As a [security best practice](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html) for AWS Identity and Access Management (IAM), AWS recommends that you use the root user solely to complete the tasks that only the root user is able to perform. For the complete list of tasks that require you to sign in as the root user, see [Tasks that require root user credentials](https://docs.aws.amazon.com/accounts/latest/reference/root-user-tasks.html) in the AWS Account Management Reference Guide. Because the root user account has full access to all of your AWS resources and billing information, we recommend that you don’t use this account and monitor it for any activity, which might indicate that the account credentials have been compromised.

Using this pattern, you set up an [event-driven architecture](https://aws.amazon.com/event-driven-architecture/) that monitors the IAM root user. This pattern sets up a hub-and-spoke solution that monitors multiple AWS accounts, the _spoke_ accounts, and centralizes management and reporting in a single account, the _hub_ account.

When the IAM root user credentials are used, Amazon CloudWatch and AWS CloudTrail record the activity in the log and trail, respectively. In the spoke account, an Amazon EventBridge rule sends the event to the central [event bus](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-bus.html) in the hub account. In the hub account, an EventBridge rule sends the event to an AWS Lambda function. The function uses an Amazon Simple Notification Service (Amazon SNS) topic that notifies you of the root user activity.

This repository implements the solution fully using HashiCorp Terraform for both hub and spoke accounts — CloudFormation is no longer required. The Terraform modules and examples in this repo let you deploy the monitoring, event-routing, and notification services entirely with Terraform.

The code in this repository helps you set up the following target architecture.

![RootActivityMonitor](RootActivityMonitor.png)

For prerequisites and instructions for using this AWS Prescriptive Guidance pattern, see [Monitor IAM root user activity](https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/monitor-iam-root-user-activity.html).

## Alerts and notification options

This implementation emits two distinct alert types, and provides multiple built-in ways to notify operators:

- **Alert types:**
	- **Root login alerts** — triggered when the root user signs in.
	- **Root activity alerts** — triggered for broader root user activity (API calls, changes, etc.).

- **Built-in alerters:** Slack, PagerDuty, and Email. These are provided as in-repo Lambda handlers and Terraform resources you can enable when deploying the hub.

- **Custom integrations:** The hub publishes notifications to Amazon SNS topics. If you want custom behavior (for example, your own Lambda handlers or downstream integrations), subscribe your functions or endpoints to the SNS topics that emit the root-login and root-activity messages.

Using the built-in alerters is fully optional — subscribe your own Lambdas or endpoints to the SNS topics emitted by the hub module to integrate with other tools or workflows.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This implementation is licensed under the MIT-0 License. See the LICENSE file.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hub_account_id"></a> [hub\_account\_id](#input\_hub\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_spoke_account_assume_role_arn"></a> [spoke\_account\_assume\_role\_arn](#input\_spoke\_account\_assume\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_spoke_account_external_id"></a> [spoke\_account\_external\_id](#input\_spoke\_account\_external\_id) | n/a | `string` | n/a | yes |
| <a name="input_spoke_account_id"></a> [spoke\_account\_id](#input\_spoke\_account\_id) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
