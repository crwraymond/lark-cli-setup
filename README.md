# lark-cli-setup

> Give this repo to any AI agent and it will install, configure, and authenticate Lark CLI **end-to-end — fully autonomously**.

## What is Lark CLI?

[Lark CLI](https://www.npmjs.com/package/lark-cli) (`lark-cli`) is a command-line tool for interacting with the Lark Open Platform. It lets you automate Lark operations — sending messages, managing documents, querying calendars, handling approvals — directly from your terminal or AI agent.

---

## For AI Agents

If you are an AI agent (OpenCode, Claude, Cursor, etc.), read [`AGENTS.md`](./AGENTS.md) — it contains step-by-step instructions to self-install and configure Lark CLI with no human intervention (except providing credentials).

**Just point your agent at this repo:**
```
https://github.com/crwraymond/lark-cli-setup
```

The agent will:
1. Install Node.js (if needed)
2. Install `lark-cli` globally
3. Walk through `lark-cli config init` with your App ID + App Secret
4. Guide you through enabling the right scopes
5. Optionally set up user identity via OAuth
6. Install all Lark CLI AI skills
7. Verify the full setup

---

## For Humans — Quick Setup

### Prerequisites
- Node.js >= 16
- A Lark Developer App ([create one here](https://open.larksuite.com/app))

### Install

```bash
npm install -g lark-cli
```

### Configure

```bash
lark-cli config init
```

Enter your **App ID** and **App Secret** when prompted.

### Verify

```bash
lark-cli im +chat-list --as bot
```

---

## Getting App Credentials

1. Go to [Lark Developer Console](https://open.larksuite.com/app)
2. Click **Create App → Custom App**
3. Go to **Credentials & Basic Info**
4. Copy your **App ID** (`cli_xxx`) and **App Secret**

---

## Install AI Skills

Skills teach your AI agent how to use Lark CLI APIs effectively:

```bash
npx skills install lark-cli -g
```

---

## Key Commands

```bash
# Use bot identity (default for most operations)
lark-cli <command> --as bot

# Use user identity (for personal resources)
lark-cli <command> --as user

# Check auth status
lark-cli auth status

# Update to latest version
lark-cli update
```

---

## Required Scopes

Enable these in your app's **Permissions & Scopes** in the Developer Console:

| Feature | Scopes |
|---------|--------|
| Messaging | `im:message`, `im:chat:read` |
| Documents | `docx:document`, `docx:document:readonly` |
| Calendar | `calendar:calendar`, `calendar:calendar.free_busy:read` |
| Drive | `drive:drive`, `drive:file` |
| Base | `base:app` |
| Contacts | `contact:user.base:readonly` |
| Wiki | `wiki:wiki` |

---

## Troubleshooting

| Error | Fix |
|-------|-----|
| `missing required scope` | Enable the scope in Developer Console and apply for release |
| `Permission denied` | Try switching identity: `--as user` vs `--as bot` |
| `lark-cli: command not found` | Run `npm install -g lark-cli`; ensure npm global bin is in your PATH |

---

## Resources

- [Lark CLI npm page](https://www.npmjs.com/package/lark-cli)
- [Lark Developer Console](https://open.larksuite.com/app)
- [Lark Open Platform Docs](https://open.larksuite.com/document)
