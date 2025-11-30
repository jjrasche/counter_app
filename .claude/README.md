# .claude/ Directory

This directory configures Claude Code for this Flutter BDD project.

## 📁 File Structure

```
.claude/
├── CLAUDE.md                      # Project instructions (auto-loaded)
├── settings.json                  # Shared project settings
├── settings.local.json            # Your personal settings (gitignored)
├── README.md                      # This file
├── commands/                      # Slash commands
│   ├── new-feature.md            # /new-feature
│   ├── run-tests.md              # /run-tests
│   └── check-deploy.md           # /check-deploy
├── hooks/                         # Event hooks
│   ├── pre-commit.sh             # Before git commit
│   ├── post-tool-use.sh          # After Claude uses tools
│   └── user-prompt-submit.sh     # When you send a message
└── context/                       # Always-loaded context
    └── flutter-patterns.md        # Flutter/BDD best practices
```

## 🎯 What Each File Does

### CLAUDE.md (Required)
- **Auto-loaded** in every conversation
- Defines BDD workflow for this project
- Tells Claude how to behave
- **Edit this** to customize project workflow

### settings.json (Optional)
- **Shared** with the team (committed to git)
- Default permissions for common operations
- Project-wide preferences
- **Edit this** to change team defaults

### settings.local.json (Optional)
- **Your personal** preferences (gitignored)
- Overrides settings.json for you
- Not shared with team
- **Edit this** for your own preferences

### commands/*.md (Custom Slash Commands)
- Each `.md` file becomes a `/command`
- Type `/` to see all commands
- **Add more** for your workflows

### hooks/*.sh (Event Automation)
- Run scripts on specific events
- Must be executable: `chmod +x .claude/hooks/*.sh`
- **Add more** for custom automation

### context/*.md (Always-Loaded)
- Loaded in every conversation
- Project patterns, conventions, references
- **Add files** for important context

## 🚀 Using Slash Commands

**List available commands:**
```
/
```

**Run a command:**
```
/new-feature
/run-tests
/check-deploy
```

**Create new command:**
1. Create `.claude/commands/my-command.md`
2. Add description in frontmatter:
   ```markdown
   ---
   description: What this command does
   ---

   Prompt text here...
   ```
3. Use with `/my-command`

## ⚡ Using Hooks

**Available hooks:**
- `pre-commit.sh` - Before git commits
- `post-commit.sh` - After git commits
- `pre-push.sh` - Before git push
- `post-tool-use.sh` - After Claude uses a tool
- `user-prompt-submit.sh` - When you send a message

**Enable hooks:**
```bash
# Make executable
chmod +x .claude/hooks/*.sh

# They run automatically!
```

**Example - Auto-format on commit:**
```bash
# .claude/hooks/pre-commit.sh
#!/bin/bash
dart format lib/ integration_test/
```

## 📋 Settings Reference

### settings.json Structure

```json
{
  "defaultModel": "sonnet",        // or "opus", "haiku"
  "permissions": {
    "Bash": {
      "command": "allow" | "ask"  // Per-command permissions
    },
    "Read": {
      "**/*.dart": "allow"         // Glob patterns
    }
  },
  "features": {
    "autoFormat": true,
    "customFeature": false
  },
  "customRules": [
    "Project-specific rules..."
  ]
}
```

### settings.local.json (Personal)

```json
{
  "defaultModel": "opus",          // You prefer opus
  "permissions": {
    "Bash": {
      "rm": "ask"                  // You want extra caution
    }
  }
}
```

## 🎨 Customizing for Your Project

### Add Custom Command

**Create `.claude/commands/deploy-staging.md`:**

```markdown
---
description: Deploy to staging environment
---

Deploy this app to the staging environment:

1. Run tests first
2. Build for web
3. Deploy to Firebase staging channel
4. Post URL in Slack #staging channel
```

Use with: `/deploy-staging`

### Add Custom Hook

**Create `.claude/hooks/pre-push.sh`:**

```bash
#!/bin/bash
# Run full test suite before pushing

echo "Running full test suite..."
flutter test integration_test/

if [ $? -ne 0 ]; then
    echo "❌ Tests failed. Fix before pushing."
    exit 1
fi
```

Make executable: `chmod +x .claude/hooks/pre-push.sh`

### Add Custom Context

**Create `.claude/context/api-patterns.md`:**

```markdown
# API Patterns

Our API uses:
- Base URL: https://api.example.com
- Auth: Bearer tokens
- Response format: JSON

Example request:
...
```

This context loads automatically in every conversation.

## 🔧 Troubleshooting

**Commands not showing up:**
- Check filename: `.claude/commands/name.md`
- Check frontmatter has `description: ...`
- Restart Claude Code

**Hooks not running:**
- Check they're executable: `ls -la .claude/hooks/`
- Run `chmod +x .claude/hooks/*.sh`
- Check for syntax errors: `bash -n hook.sh`

**Settings not applying:**
- settings.json = team defaults
- settings.local.json = your overrides
- settings.local.json is gitignored

**CLAUDE.md not loaded:**
- Must be named exactly `CLAUDE.md`
- Must be in `.claude/` directory
- Auto-loaded, no action needed

## 💡 Best Practices

**CLAUDE.md:**
- Keep focused on project workflow
- Include "DO NOT" lists (prevents bad behavior)
- Update as project evolves

**Commands:**
- One command = one workflow
- Use descriptive names
- Include clear instructions

**Hooks:**
- Keep fast (< 1 second)
- Don't block on failures (unless critical)
- Log to `.claude/*.log` for debugging

**Context:**
- Only include frequently needed info
- Keep files small (< 1000 lines)
- Use for patterns, not documentation

**Settings:**
- settings.json = team agrees on
- settings.local.json = personal preference
- Commit settings.json, ignore settings.local.json

## 📚 Example Workflows

**New Feature:**
```
You: /new-feature
Claude: "What feature do you want to build?"
You: "User profile page"
Claude: *creates BDD scenario, tests, implementation*
```

**Check Deployment:**
```
You: /check-deploy
Claude: *runs gh pr checks, shows URLs*
```

**Custom Workflow:**
```
You: /deploy-staging
Claude: *runs tests, builds, deploys, posts Slack message*
```

## 🎯 Template Usage

When using this project as a template:

**Keep these files:**
- ✅ CLAUDE.md (customize for your project)
- ✅ settings.json (adjust defaults)
- ✅ commands/ (add your own)
- ✅ hooks/ (enable as needed)
- ✅ context/ (add project patterns)

**Don't commit:**
- ❌ settings.local.json (personal settings)
- ❌ *.log files (hook logs)

**Add to .gitignore:**
```
.claude/settings.local.json
.claude/*.log
```

---

**This setup makes Claude Code:**
- 🎯 More accurate (CLAUDE.md guidelines)
- ⚡ Faster (only reads relevant files)
- 🔄 Consistent (slash commands)
- 🤖 Automated (hooks)
