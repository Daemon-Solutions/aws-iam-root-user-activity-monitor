import json
import logging
import os
import urllib.request

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)


PAGERDUTY_ROUTING_KEY = os.environ["PAGERDUTY_ROUTING_KEY"]
PAGERDUTY_URL = "https://events.pagerduty.com/v2/enqueue"

def handler(sns_event, context):
    # SNS → Lambda event
    sns_message = sns_event["Records"][0]["Sns"]["Message"]


    event = json.loads(sns_message)

    logger.debug(f"Raw event: {json.dumps(event)}")

    detail = event.get("detail", {})
    state = detail.get("state", {})
    previous_state = detail.get("previousState", {})

    alarm_name = detail.get("alarmName", "Unknown alarm")
    new_state = state.get("value", "UNKNOWN")
    reason = state.get("reason", "No reason provided")

    account_id = event.get("account", "unknown")
    region = event.get("region", "unknown")
    timestamp = event.get("time", "unknown")
    alarm_arn = event.get("resources", ["unknown"])[0]

    pagerduty_event = {
        "routing_key": PAGERDUTY_ROUTING_KEY,
        "event_action": "trigger",
        "payload": {
            "summary": f"AWS Root User Activity Detected ({alarm_name})",
            "severity": "critical",
            "source": f"aws-account-{account_id}",
            "timestamp": timestamp,
            "custom_details": {
                "alarm_name": alarm_name,
                "new_state": new_state,
                "previous_state": previous_state.get("value"),
                "reason": reason,
                "account_id": account_id,
                "region": region,
                "alarm_arn": alarm_arn,
                "recommended_action": (
                    "Immediately verify whether root user access was expected. "
                    "Rotate root credentials, review CloudTrail logs, and enable MFA if not already enabled."
                ),
            },
        },
    }


    try:
        req = urllib.request.Request(
            PAGERDUTY_URL,
            data=json.dumps(pagerduty_event).encode("utf-8"),
            headers={"Content-Type": "application/json"},
            method="POST",
        )

        with urllib.request.urlopen(req) as response:
            logger.debug(f"PagerDuty response status: {response.status}")

    except Exception as e:
        logger.error(f"Failed to send PagerDuty event: {e}")
        raise
