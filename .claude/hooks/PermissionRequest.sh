#!/bin/bash
# PermissionRequest Hook - Runs when permission dialog appears
# Can auto-approve/deny based on context
#
# Use cases:
# - Auto-approve safe operations (flutter pub get)
# - Auto-deny dangerous operations (rm -rf)
# - Add context to permission prompts
# - Log permission requests

PERMISSION_TYPE="$1"
RESOURCE="$2"

# Example: Auto-approve safe Flutter commands
# if [ "$PERMISSION_TYPE" = "Bash" ]; then
#     if echo "$RESOURCE" | grep -q "flutter pub get"; then
#         echo "✅ Auto-approving safe command"
#         exit 0  # Auto-approve
#     fi
# fi

# Example: Add warning to dangerous operations
# if echo "$RESOURCE" | grep -q "rm"; then
#     echo "⚠️  WARNING: This will delete files permanently!"
# fi

exit 0
