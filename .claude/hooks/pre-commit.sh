#!/bin/bash
# Pre-commit hook - runs before git commits
# This ensures code quality before committing

echo "🔍 Running pre-commit checks..."

# Format Dart code
echo "📝 Formatting Dart code..."
dart format lib/ integration_test/

# Run tests (optional - can be slow)
# echo "🧪 Running tests..."
# flutter test integration_test/

# Check for TODOs (per CLAUDE.md, we don't allow TODOs)
echo "🚫 Checking for TODOs..."
if git diff --cached | grep -i "TODO\|FIXME"; then
    echo "❌ Found TODO/FIXME comments. Remove them before committing."
    exit 1
fi

echo "✅ Pre-commit checks passed!"
exit 0
