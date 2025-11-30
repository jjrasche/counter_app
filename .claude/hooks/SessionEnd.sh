#!/bin/bash
# SessionEnd Hook - Runs when Claude Code session ends
# Last hook to run before closing
#
# Use cases:
# - Save conversation summary
# - Cleanup temporary files
# - Generate session report
# - Update project status

# Example: Save session summary
# echo "$(date): Session ended" >> .claude/session-history.log

# Example: Cleanup temp files
# rm -f .claude/*.tmp 2>/dev/null

# Example: Remind about uncommitted changes
# if ! git diff-index --quiet HEAD -- 2>/dev/null; then
#     echo "⚠️  Don't forget to commit your changes!"
# fi

# Example: Generate session report
# if [ -f .claude/tool-usage.log ]; then
#     echo "📊 Session report:"
#     echo "Tools used: $(wc -l < .claude/tool-usage.log)"
# fi

exit 0
