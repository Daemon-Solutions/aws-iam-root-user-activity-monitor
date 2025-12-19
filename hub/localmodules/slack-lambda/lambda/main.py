import json
import logging
import os
import urllib.request

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

SLACK_WEBHOOK_URL = os.environ["SLACK_WEBHOOK_URL"]

def handler(sns_event, context):
    # SNS → Lambda event
    sns_message = sns_event["Records"][0]["Sns"]["Message"]
    logger.debug(f"SNS message: {json.dumps(event)}")

    event = json.loads(sns_message)

    eventname = event["detail"]["eventName"]
    user = event["detail"]["userIdentity"]["type"]
    target_account = event["account"]

    logger.debug(f"Event: {json.dumps(event)}")

    slack_message = {
        "text": (
            f":rotating_light: *AWS IAM Root Activity Detected*\n"
            f"*Event:* `{eventname}`\n"
            f"*Principal:* `{user}`\n"
            f"*Account:* `{target_account}`"
        )
    }

    try:
        req = urllib.request.Request(
            SLACK_WEBHOOK_URL,
            data=json.dumps(slack_message).encode("utf-8"),
            headers={"Content-Type": "application/json"},
            method="POST",
        )

        with urllib.request.urlopen(req) as response:
            logger.debug(f"Slack response status: {response.status}")

    except Exception as e:
        logger.error(f"Failed to send Slack notification: {e}")
        raise

