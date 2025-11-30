#!/bin/bash
# PreCompact Hook - Runs before Claude compacts conversation context
# Context compaction happens when conversation gets too long
#
# Use cases:
# - Save important context before compaction
# - Log what's being compacted
# - Preserve critical information
# - Generate summaries

CONTEXT_SIZE="$1"

# Example: Warn about large conversations
# if [ "$CONTEXT_SIZE" -gt 100000 ]; then
#     echo "⚠️  Large conversation being compacted. Consider starting fresh."
# fi

# Example: Save conversation before compaction
# echo "$(date): Compacting context (size: $CONTEXT_SIZE)" >> .claude/compaction.log

exit 0
