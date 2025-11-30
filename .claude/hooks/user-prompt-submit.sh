#!/bin/bash
# User-prompt-submit hook - runs when user submits a prompt
# Useful for reminders, context checks, or prompt enhancement

USER_PROMPT="$1"

# Example: Remind about BDD workflow for feature requests
if echo "$USER_PROMPT" | grep -qi "add\|implement\|create.*feature"; then
    echo "💡 Reminder: Follow BDD workflow (write scenario first, then tests, then code)"
fi

# Example: Suggest using slash command
if echo "$USER_PROMPT" | grep -qi "run.*test"; then
    echo "💡 Tip: You can use /run-tests for consistent test execution"
fi

# Example: Check if git is clean before major changes
if echo "$USER_PROMPT" | grep -qi "refactor\|rewrite\|migrate"; then
    if ! git diff-index --quiet HEAD --; then
        echo "⚠️  Warning: You have uncommitted changes. Consider committing before refactoring."
    fi
fi

exit 0
