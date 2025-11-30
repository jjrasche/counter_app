#!/bin/bash
# SessionStart Hook - Runs when Claude Code session starts or resumes
# First hook to run in a new conversation
#
# Use cases:
# - Display project status
# - Check for updates (git pull)
# - Remind about pending tasks
# - Load project-specific environment

SESSION_TYPE="$1"  # "new" or "resume"

# Example: Show git status on session start
# if [ "$SESSION_TYPE" = "new" ]; then
#     echo "📊 Git status:"
#     git status -s
# fi

# Example: Check for updates
# git fetch --quiet
# if [ $(git rev-list HEAD...origin/main --count) -gt 0 ]; then
#     echo "⚠️  Your branch is behind origin/main"
# fi

# Example: Display pending tasks
# if [ -f .claude/tasks.txt ]; then
#     echo "📋 Pending tasks:"
#     cat .claude/tasks.txt
# fi

exit 0
