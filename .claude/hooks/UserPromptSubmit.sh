#!/bin/bash
# UserPromptSubmit Hook - Runs when user submits a prompt
# Can add context, reminders, or validation
#
# Use cases:
# - Remind about project workflow
# - Suggest slash commands
# - Check prerequisites
# - Add contextual tips

USER_PROMPT="$1"

# Example: Remind about BDD workflow for features
if echo "$USER_PROMPT" | grep -qi "add\|implement\|create.*feature"; then
    echo "💡 Reminder: Follow BDD workflow (scenario → test → code)"
fi

# Example: Suggest slash command
if echo "$USER_PROMPT" | grep -qi "run.*test"; then
    echo "💡 Tip: Use /run-tests for consistent test execution"
fi

# Example: Check git status before refactoring
if echo "$USER_PROMPT" | grep -qi "refactor\|rewrite"; then
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        echo "⚠️  You have uncommitted changes"
    fi
fi

exit 0
