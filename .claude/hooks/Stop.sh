#!/bin/bash
# Stop Hook - Runs when Claude finishes responding
# Can perform cleanup, analysis, or follow-up actions
#
# Use cases:
# - Analyze conversation for next steps
# - Generate summary of changes
# - Update documentation
# - Clean up temporary files

RESPONSE_TEXT="$1"

# Example: Generate TODO list from conversation
# if echo "$RESPONSE_TEXT" | grep -qi "next steps"; then
#     echo "📋 Generating TODO list..."
# fi

# Example: Update project docs after significant changes
# if echo "$RESPONSE_TEXT" | grep -qi "added feature"; then
#     echo "📝 Consider updating documentation"
# fi

exit 0
