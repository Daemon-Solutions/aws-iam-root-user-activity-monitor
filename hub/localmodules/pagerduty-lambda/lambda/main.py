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

    eventname = event["detail"]["eventName"]
    user = event["detail"]["userIdentity"]["type"]
    target_account = event["account"]

    logger.debug(f"Event: {json.dumps(event)}")

    pagerduty_event = {
        "routing_key": PAGERDUTY_ROUTING_KEY,
        "event_action": "trigger",
        "payload": {
            "summary": f"AWS IAM Root activity detected: {eventname}",
            "severity": "critical",
            "source": f"aws-account-{target_account}",
            "custom_details": {
                "eventName": eventname,
                "principal": user,
                "account": target_account,
            }
        }
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
