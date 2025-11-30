#!/bin/bash
# PostToolUse Hook - Runs AFTER Claude uses any tool
# Cannot block tool (already executed), but can trigger follow-up actions
#
# Use cases:
# - Auto-format code after editing
# - Run linters after file changes
# - Update documentation
# - Log tool usage for debugging

TOOL_NAME="$1"
TOOL_RESULT="$2"

# Example: Auto-format Dart files after editing
if [ "$TOOL_NAME" = "Edit" ] || [ "$TOOL_NAME" = "Write" ]; then
    if echo "$TOOL_RESULT" | grep -q "\.dart"; then
        echo "📝 Auto-formatting Dart files..."
        dart format lib/ integration_test/ 2>/dev/null || true
    fi
fi

# Example: Run quick syntax check
# if [ "$TOOL_NAME" = "Write" ]; then
#     flutter analyze --no-pub 2>/dev/null || true
# fi

# Example: Log tool usage
# echo "$(date): $TOOL_NAME" >> .claude/tool-usage.log

exit 0
