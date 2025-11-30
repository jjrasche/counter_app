#!/bin/bash
# Post-tool-use hook - runs after Claude uses a tool
# Useful for logging, notifications, or automatic actions

TOOL_NAME="$1"
TOOL_RESULT="$2"

# Log tool usage (useful for debugging)
# echo "$(date): Used tool: $TOOL_NAME" >> .claude/tool-usage.log

# Example: Auto-format after editing Dart files
if [ "$TOOL_NAME" = "Edit" ] || [ "$TOOL_NAME" = "Write" ]; then
    # Check if a Dart file was modified
    if echo "$TOOL_RESULT" | grep -q "\.dart"; then
        echo "📝 Auto-formatting Dart files..."
        dart format lib/ integration_test/ 2>/dev/null || true
    fi
fi

# Example: Run quick syntax check after writing code
# if [ "$TOOL_NAME" = "Write" ]; then
#     flutter analyze --no-pub
# fi

exit 0
