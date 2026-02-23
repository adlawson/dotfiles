---
name: open-pr
description: Open a GitHub Pull Request (PR) following a style guide
---

## Overview

Your PR description style should be is characterized by:
- Precise, imperative titles with a simple `description` format
- Opening "This PR..." statements
- Minimal but sufficient context
- Heavy use of cross-references (Slack, Notion, related PRs)
- Technical precision with proper use of backticks
- Honest acknowledgment of limitations and future work
- No explicit test plan sections

**See [`STYLE_GUIDE.md`](STYLE_GUIDE.md) for full details.**

## Workflow

### Step 1: Analyze Current State

Gather information about the branch and changes:

```bash
# Run these in parallel
git status
git branch --show-current
git log master..HEAD --oneline
git diff master...HEAD
```

Check for:
- Uncommitted changes (stage and commit if needed)
- Branch name
- Commit history from divergence point
- Full diff of changes

### Step 2: Generate PR Title

**Format:** `<scope>: <imperative verb> <concise description>`

**Rules:**
- Use imperative verb ("Add", "Fix", "Remove", not "Adds", "Fixed", "Removing")
- Be specific about the scope - usually a package name like `accountslib`
- Keep titles under 100 characters - be concise but complete
- No emojis or prefixes
- Specific and complete

**Examples:**
- "my-service: Add handler for batch-inviting users from the waitlist"
- "accountslib: Add support for new `ProductType` property"

### Step 3: Generate PR Body

#### Opening Statement (Required)
Start with: `This PR <does something specific>.`

Examples:
- "This PR adds a new unified search action that allows staff users to send product feedback directly to Slack."
- "This PR fixes a bug where savings was incorrectly shown to all EU Young Monzo users."
- "This PR refactors the `virtual-card-groceries-card-upsell` activity prompt to support EU markets as well as the UK."

<important>
The PR description should be concise! Most PRs should only have a description of 3-6 sentences.
</important>

#### Context Section (When Needed)
Add `## Context` when the problem isn't immediately obvious:

```markdown
## Context

[Background information, historical context, or problem description]
```

#### Implementation Details (For Complex Changes)
For non-trivial implementations:

```markdown
### 🛠️  Implementation

1. [First step of the flow]
2. [Second step]
3. [Third step]
...
```

#### What's NOT Included (For Incremental Work)
If this is part of larger work:

```markdown
### 🔜  **Not included in this PR**
- [Future item 1]
- [Future item 2]
☝️  These will all come as follow-ups to this PR.
```

#### Cross-References (Almost Always)

Look for and ask about:
- Related PRs (check commit messages)
- Slack discussions
- Notion proposals/documentation
- Linear tickets (check commit messages)
- Incidents

<important>
If you can't find any references, ask the user if there are any you should link.
</important>

Format as:
- 💬 `[Corresponding Slack thread](URL)`
- 📚 `[Proposal: <title>](URL)`

### Step 4: Writing Guidelines

**Tone:**
- Technical but accessible
- Direct and factual
- Honest about limitations

**Formatting:**
- Use backticks for code/packages: `` `libs/requestidentity` ``, `` `GetCountry()` ``
- Use `-` for unordered lists
- Numbered lists for sequential steps
- Limited emojis: 💬 📚 🛠️ 🔜 only

**Avoid:**
- ❌ Explicit "Test plan" or "Test coverage" headers
- ❌ "Summary" sections
- ❌ "Motivation" sections
- ❌ Reviewer instructions
- ❌ Deployment notes (unless critical)

### Step 5: Ask for Context

Before generating the final PR, use `AskUserQuestion` to ask:

1. "Is there a Slack thread or Notion doc related to this work that I should link?"
2. "Is this part of a larger effort? Should I mention what's not included?"
3. "Are there any specific context details I should highlight?"

### Step 7: Create the PR

Once you have all information:

1. Show the proposed title and body to the user
2. Ask for approval
3. If approved, push the branch if needed:
   ```bash
   git push -u origin HEAD
   ```
4. Create the Draft PR:
   ```bash
   gh pr create --draft --title "your title here" --body "$(cat <<'EOF'
   [Your body content here]
   EOF
   )"
   ```
5. Share the PR URL with the user

## Common Patterns

### Bug Fix
```markdown
This PR fixes a bug where [problem description].

[Root cause explanation if helpful]

[How the fix works]

💬 [Corresponding Slack thread](URL)
```

### Feature
```markdown
This PR adds [feature] to [component].

[Why this is needed / problem it solves]

[Implementation details if non-trivial]

📚 [Related documentation](URL)
```

### Refactor
```markdown
This PR refactors [component] to [new approach], [benefit].

The main change here is [specific technical change].
```

## Detail Level

**Most PRs are 3-6 sentences plus links:**
1. Opening statement (what)
2. Context or reason (why)
3. Technical detail (how, if non-obvious)
4. Future work (if applicable)
5. Links to related resources

**Be verbose for:**
- Complex multi-service interactions
- Changes with subtle implications
- Refactors touching many places

**Be concise for:**
- Simple bug fixes
- Straightforward feature additions
- Cleanup/chore PRs

## Examples

### Minimal Bug Fix
```
Title: Stop logging errors for eligible users with low queue numbers

Body:
This PR fixes a bug where we were logging errors for users with low queue numbers who are eligible for signup, even though having a low queue number is expected in this case.

💬 [Corresponding Slack thread](https://foobar.slack.com/archives/...).
```

### Medium Feature
```
Title: Add unified search action for sending product feedback

Body:
This PR adds a new unified search action that allows staff users to send product feedback directly to Slack.

We're currently in the process of building better automated support for collecting feedback from Monzo staff members. We now link to a _Send product feedback_ form when a staff user shakes their device or takes a screenshot, but there is otherwise no in-app entrypoint for this feature.

We don't want to add a prominent entrypoint to this feature to an existing app surface as only staff users are eligible for it. Instead, we'd like a search action to act as a fallback entrypoint if staff users don't discover the rage shake gesture (or have that mechanism disabled for some reason).

💬 [Corresponding discussion in Slack](https://foobar.slack.com/archives/...)
📚 [Documentation for the staff product feedback feature](https://www.notion.so/foobar/...)
```

## Core Principle

Write for the engineer who will review this now AND the engineer who will understand this change in 6 months. Be complete, but concise. Link everything.
