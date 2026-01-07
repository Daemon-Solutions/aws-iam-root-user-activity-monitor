
import json
import logging
import os
import urllib.request

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)



SLACK_WEBHOOK_URL = os.environ["SLACK_WEBHOOK_URL"]

def handler(sns_event, context):
    sns_message = sns_event["Records"][0]["Sns"]["Message"]
    logger.debug("Raw SNS event: %s", json.dumps(sns_event))

    event = json.loads(sns_message)
    detail_type = event.get("detail-type", "unknown")

    if detail_type == "CloudWatch Alarm State Change":
        slack_message = build_alarm_message(event)
    else:
        slack_message = build_activity_message(event)

    post_to_slack(slack_message)


# -------- Message builders --------

def build_alarm_message(event):
    detail = event.get("detail", {})
    state = detail.get("state", {})

    return {
        "text": (
            ":rotating_light: *AWS Root Login Detected*\n"
            f"*Alarm:* `{detail.get('alarmName', 'unknown')}`\n"
            f"*State:* `{state.get('value', 'unknown')}`\n"
            f"*Reason:* {state.get('reason', 'n/a')}\n"
            f"*Account:* `{event.get('account', 'unknown')}`\n"
            f"*Region:* `{event.get('region', 'unknown')}`"
        )
    }


def build_activity_message(event):
    detail = event.get("detail", {})
    user_identity = detail.get("userIdentity", {})

    return {
        "text": (
            ":rotating_light: *AWS Root Activity Detected*\n"
            f"*Event:* `{detail.get('eventName', 'unknown')}`\n"
            f"*Principal Type:* `{user_identity.get('type', 'unknown')}`\n"
            f"*User ARN:* `{user_identity.get('arn', 'unknown')}`\n"
            f"*Account:* `{event.get('account', 'unknown')}`\n"
            f"*Region:* `{event.get('region', 'unknown')}`"
        )
    }


# -------- Slack sender --------

def post_to_slack(slack_message):
    try:
        req = urllib.request.Request(
            SLACK_WEBHOOK_URL,
            data=json.dumps(slack_message).encode("utf-8"),
            headers={"Content-Type": "application/json"},
            method="POST",
        )

        with urllib.request.urlopen(req) as response:
            logger.info("Slack response status: %s", response.status)

    except Exception as e:
        logger.error("Failed to send Slack notification: %s", e)
        raise



