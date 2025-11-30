#!/bin/bash
# SubagentStop Hook - Runs when a subagent task completes
# Subagents are launched with the Task tool for complex operations
#
# Use cases:
# - Log subagent results
# - Trigger follow-up actions
# - Aggregate subagent outputs
# - Clean up subagent artifacts

SUBAGENT_TYPE="$1"
SUBAGENT_RESULT="$2"

# Example: Log subagent completion
echo "$(date): Subagent $SUBAGENT_TYPE completed" >> .claude/subagent.log

# Example: Process exploration results
# if [ "$SUBAGENT_TYPE" = "Explore" ]; then
#     echo "📊 Exploration complete, summarizing findings..."
# fi

exit 0
