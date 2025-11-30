#!/bin/bash
# Notification Hook - Runs when Claude sends notifications
# Can intercept, modify, or log notifications
#
# Use cases:
# - Log important notifications
# - Send alerts to Slack/email
# - Filter notification types
# - Add custom notification handlers

NOTIFICATION_TYPE="$1"
NOTIFICATION_MESSAGE="$2"

# Example: Log errors
# if [ "$NOTIFICATION_TYPE" = "error" ]; then
#     echo "$(date): ERROR - $NOTIFICATION_MESSAGE" >> .claude/errors.log
# fi

# Example: Send critical notifications to Slack
# if [ "$NOTIFICATION_TYPE" = "critical" ]; then
#     curl -X POST slack-webhook-url -d "{\"text\":\"$NOTIFICATION_MESSAGE\"}"
# fi

exit 0
