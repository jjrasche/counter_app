#!/bin/bash
# PreToolUse Hook - Runs BEFORE Claude uses any tool
# Can BLOCK tool execution by exiting with non-zero code
#
# Use cases:
# - Validate tool parameters before execution
# - Check preconditions (e.g., git status clean)
# - Prevent dangerous operations
# - Add safety checks

TOOL_NAME="$1"
TOOL_PARAMS="$2"

# Example: Block destructive operations without confirmation
# if [ "$TOOL_NAME" = "Bash" ] && echo "$TOOL_PARAMS" | grep -q "rm -rf"; then
#     echo "⚠️  Dangerous command detected. Confirm first."
#     exit 1  # Non-zero exit blocks the tool
# fi

# Example: Ensure git is clean before refactoring
# if echo "$TOOL_PARAMS" | grep -qi "refactor"; then
#     if ! git diff-index --quiet HEAD --; then
#         echo "❌ Uncommitted changes detected. Commit first."
#         exit 1
#     fi
# fi

exit 0  # Zero exit allows tool to proceed
