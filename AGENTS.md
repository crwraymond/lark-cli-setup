# AI Agent Instructions — Lark CLI Self-Setup

You are an AI agent. This file contains everything you need to install, configure, and authenticate Lark CLI **fully autonomously** — no human input required except where explicitly stated.

Follow the steps **in order**. Do not skip any step.

---

## Overview

Lark CLI (`lark-cli`) is a command-line tool for interacting with the Lark Open Platform. It supports two identities:
- **Bot** (`--as bot`) — app-level identity, uses `App ID` + `App Secret`
- **User** (`--as user`) — user-level identity, requires browser-based OAuth login

> **Default rule**: Always use `--as bot` for ALL `lark-cli` commands unless the operation explicitly requires user identity (e.g. searching contacts by name, reading personal calendar, searching group chats you're a member of).
>
> **This is a hard rule — never omit `--as bot` on any `lark-cli` command.**

---

## Step 1 — Check Node.js

Lark CLI requires Node.js >= 16.

```bash
node --version
```

If not installed or version is too old:
```bash
# macOS
brew install node

# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

---

## Step 2 — Install Lark CLI

```bash
npm install -g lark-cli
```

Verify installation:
```bash
lark-cli --version
```

---

## Step 3 — Get App Credentials

You need a Lark Developer App with an **App ID** and **App Secret**.

**Ask the user to provide:**
1. `App ID` (starts with `cli_`)
2. `App Secret`

If the user doesn't have one yet, instruct them to:
1. Go to https://open.larksuite.com/app (or https://open.feishu.cn/app for China)
2. Click **Create App → Custom App**
3. Fill in app name and description
4. Go to **Credentials & Basic Info** and copy the **App ID** and **App Secret**

---

## Step 4 — Initialize Config

Run the interactive config setup:

```bash
lark-cli config init
```

When prompted:
- Enter the **App ID** from Step 3
- Enter the **App Secret** from Step 3
- Select the correct domain (`larksuite.com` for international, `feishu.cn` for China)

Verify bot identity works:
```bash
lark-cli im +chat-list --as bot
```

If successful, you will see a list of chats (or an empty list). This confirms bot identity is working.

---

## Step 5 — Request Required Scopes (Permissions)

Lark CLI needs specific scopes (permissions) to be enabled in the Developer Console before it can perform operations.

**Instruct the user to:**
1. Go to their app in the [Lark Developer Console](https://open.larksuite.com/app)
2. Navigate to **Permissions & Scopes**
3. Enable the scopes they need based on the features they want to use:

| Feature | Scopes |
|---------|--------|
| Send/read messages | `im:message`, `im:chat:read` |
| Documents | `docx:document`, `docx:document:readonly` |
| Calendar | `calendar:calendar`, `calendar:calendar.free_busy:read` |
| Drive/Files | `drive:drive`, `drive:file` |
| Base/Spreadsheets | `base:app`, `sheets:spreadsheet` |
| Contacts | `contact:user.base:readonly` |
| Wiki | `wiki:wiki`, `wiki:node:readonly` |

4. Click **Apply for Release** and wait for admin approval

To check which scopes are already approved:
```bash
lark-cli auth status
```

---

## Step 6 — (Optional) Authenticate User Identity

Some operations require user identity (e.g. searching contacts by name, reading personal calendar). To set up user auth:

```bash
lark-cli auth login --no-wait --json
```

This will output a `verification_url`. **Show this URL to the user exactly as returned — do not modify it.** Ask the user to open it in their browser and complete the login.

After the user confirms they have authorized, complete the flow:
```bash
lark-cli auth login --device-code <device_code_from_previous_output>
```

---

## Step 7 — Install Skills (AI Agent Integration)

Skills teach the AI agent Lark API patterns, command syntax, and best practices for each Lark module. **This step is required for the AI agent to operate Lark CLI correctly.**

Install all available skills:

```bash
npx skills install lark-cli -g
```

This installs skills for all Lark modules: `lark-im`, `lark-doc`, `lark-base`, `lark-calendar`, `lark-drive`, `lark-sheets`, `lark-wiki`, `lark-task`, `lark-mail`, `lark-vc`, `lark-okr`, `lark-approval`, `lark-contact`, `lark-whiteboard`, `lark-slides`, `lark-minutes`, `lark-attendance`, `lark-event`, and more.

Verify skills are installed:
```bash
npx skills list
```

You should see a list of `lark-*` skills. If any are missing, re-run the install command.

---

## Step 8 — Write Global Agent Rules

Create a global `AGENTS.md` so these rules apply to every session automatically:

```bash
mkdir -p ~/.opencode
cat >> ~/.opencode/AGENTS.md << 'EOF'

## Lark CLI

- Always use `--as bot` for every `lark-cli` command by default.
- Only switch to `--as user` when the operation explicitly requires user identity (e.g. `+search-user`, personal calendar, group chat search).
- Never omit the `--as` flag on any `lark-cli` command.
EOF
```

Verify it was written:
```bash
cat ~/.opencode/AGENTS.md
```

---

## Step 9 — Verify Full Setup

Run these checks to confirm everything is working:

```bash
# Bot identity — list chats
lark-cli im +chat-list --as bot

# Check auth status and granted scopes
lark-cli auth status

# List installed skills
npx skills list

# Confirm global agent rules
cat ~/.opencode/AGENTS.md
```

If all commands succeed, setup is complete. ✅

---

## Troubleshooting

| Error | Fix |
|-------|-----|
| `missing required scope` | Go to Developer Console → enable the missing scope → apply for release |
| `Permission denied` | Check bot identity vs user identity — some APIs require `--as user` |
| `App not found` | Double-check App ID and App Secret in `lark-cli config init` |
| `node: command not found` | Install Node.js (Step 1) |
| `lark-cli: command not found` | Run `npm install -g lark-cli` again; check `npm bin -g` is in your PATH |

---

## Quick Reference

```bash
# ALWAYS use --as bot by default (hard rule)
lark-cli <command> --as bot

# Only use --as user when explicitly required
lark-cli <command> --as user

# Check current auth status
lark-cli auth status

# Update lark-cli to latest
lark-cli update

# Update all skills
npx skills install lark-cli -g
```
