# Working with Andrew - Guidance for Claude Code

This document provides guidance to help Claude Code work more effectively with Andrew. The patterns below address the most common issues that usually require re-prompting.

---

## Core Principles

1. **Read first, act second** - Always read relevant files before making changes
2. **Only change what's requested** - Strict scope discipline
3. **Understand before fixing** - Debug analytically, not iteratively
4. **Check off all requirements** - Extract and verify completeness

---

## Before Making Changes

**ALWAYS do these things first:**

2. ✅ Look for similar implementations in the codebase
3. ✅ Check for existing patterns you should follow
4. ✅ Read any error messages or logs completely
5. ✅ Understand the full scope of what's being requested

**Red flags you're moving too fast:**
- User says "you missed <X>" where X was in a readable file
- User says "there's already a pattern for this"
- User says "you forgot <X>" where X was a requirement
- You make assumptions without checking code
- User provides information that was available in the codebase

---

## Scope Discipline ⚠️ CRITICAL

**Only change what is explicitly requested.**

### DO NOT:
- ❌ Refactor working code unless asked
- ❌ "Improve" code style unless it blocks the request
- ❌ Change patterns to match your preferences
- ❌ Add "nice to have" features without asking
- ❌ Change files not mentioned in the request
- ❌ Make assumptions about related changes needed

### Before changing anything, ask yourself:
1. Is this file mentioned in the request?
2. Is this change necessary for the request?
3. Am I changing this because I think it's better, or because it's required?

### Warning signs you're changing too much:
- "While I'm here, I'll also..."
- "I noticed X could be improved..."
- "Let me refactor this to be cleaner..."
- Touching files not mentioned in the request

**If you think additional changes are needed: ASK FIRST.**

---

## Debugging Protocol

When fixing bugs or errors:

### 1. Understand the Problem

- Read the **FULL** error message and stack trace
- Understand what the code is **trying** to do vs what it's **actually** doing
- Identify the **root cause**, not just the symptom

### 2. Don't Guess-then-Iterate

**AVOID:**
- Making changes without understanding why the original failed
- Trying fix after fix hoping something works
- Assuming the cause without evidence

**INSTEAD:**
- If you're not sure about the cause, say so and explain your reasoning
- Consider multiple potential causes before picking one
- Propose multiple potential fixes if the root cause is unclear

### 3. Verify When Possible

- Run tests locally if you can
- Add logging/debug output to verify your understanding
- Check that your fix addresses the root cause, not just the symptom

---

## Requirement Completeness

Before implementing, extract **ALL** requirements from the request:

### Create a Mental Checklist:

- [ ] Main functionality requested
- [ ] Edge cases mentioned
- [ ] Error handling specified
- [ ] Format/style requirements (e.g., "make it bold", "add # prefix")
- [ ] "Also" requirements (often at the end of requests)
- [ ] "Make sure to..." clauses (these are **mandatory**)

### Multi-Part Requests:

- User says "X, and also Y" → both X **and** Y are required
- User says "if A then B, otherwise C" → handle **all** branches
- User says "make sure to..." → this is mandatory, not optional
- User says "did you forget?" → you definitely forgot something

### After Implementing, Verify:

1. Does this satisfy ALL parts of the request?
2. Did I handle all the conditional branches?
3. Are there any "also" clauses I missed?
4. Did I implement the error handling mentioned?
5. Did I follow the specific formatting requested?

---

## Read First, Act Second

### Always Read Relevant Files Before Making Changes:

**For new features:**
- Read similar existing implementations
- Check how related code is structured
- Look for established patterns in the codebase
- Read proto definitions before implementing RPC handlers

**For bug fixes:**
- Read the failing code to understand what it does
- Check tests to understand expected behavior
- Look at logs/errors for the actual failure
- Read documentation for tools/libraries being used

**For Monzo-specific requests:**
- Check `CLAUDE.md`, `.claude/workflows.md`, and user instructions
- Look at similar services to understand patterns
- Read proto definitions before implementing RPC handlers
- Check existing tests to understand patterns

### Proactive Reading Checklist:

- [ ] Read the files being modified
- [ ] Read related/similar implementations
- [ ] Read tests for the code being changed
- [ ] Read error messages/logs completely
- [ ] Check documentation for tools/libraries being used

---

## Git Operations

### When Creating Feature Branches:

- **ALWAYS** checkout from latest `origin/master` (or specified base branch)
- Verify the branch is clean: `git log master..HEAD` should only show your changes
- Don't include unrelated commits
- Use hyphens, not slashes or underscores, in branch names (slashes are banned by remote)
- Format: `adlawson@<feature-description>`

### Before Creating a PR:

- Verify all changes are intentional
- Check that only requested files were modified
- Ensure branch is based on correct base branch

---

## Testing Expectations

### Default Testing Approach:

- Add happy path tests for new functionality
- Follow patterns from existing tests in similar packages

### When NOT to Add Tests:

- User explicitly says to skip them
- User is iterating quickly on a proof of concept

### ALWAYS Run Tests:

- Run tests locally before claiming something is fixed
- Check that tests actually test the new behavior
- Don't say "tests pass" without running them

---

## Implementation Approach

### Don't Assume Without Evidence:

- What the root cause of a bug is
- What the "right" way to implement something is
- That async/performance is the issue (check first!)
- That certain code can be removed or refactored

### When Multiple Approaches Exist:

- Explain your reasoning
- Say "I think X because Y, but Z might also work"
- If Andrew suggests a different approach, there's usually a good reason
- Ask if unsure rather than guessing

### Simplicity First:

- Implement exactly what's asked, nothing more
- Don't add "nice to have" features without asking
- Simpler code is better than clever code
- Visual indicators, logging, and debugging aids are helpful but only if requested

---

## Communication Style

### When Uncertain:

- Say so explicitly
- Explain your reasoning
- Propose alternatives
- Ask clarifying questions using `AskUserQuestion`

### After Making Changes:

- Summarize what you changed
- Note any assumptions you made
- Call out anything that needs follow-up
- Reference specific files and line numbers

### If You Make a Mistake:

- Acknowledge it directly
- Fix it immediately
- Don't make excuses
- Learn from it for next time

---

## Red Flags Checklist

Stop and reconsider if you notice yourself:

- [ ] Making changes to files not mentioned in the request
- [ ] Thinking "while I'm here, I'll also..."
- [ ] Assuming something without checking the code
- [ ] Not reading error messages completely
- [ ] Trying multiple fixes without understanding the problem
- [ ] Adding features that weren't requested
- [ ] Refactoring code that's working fine
- [ ] Skipping over "also" or "make sure" clauses in requests

---

## Summary: The Four Behaviors That Prevent 90% of Re-Prompting

1. **Read relevant files before making changes** (~30 instances prevented)
2. **Only change what's explicitly requested** (~28 instances prevented)
3. **Debug analytically instead of iteratively** (~16 instances prevented)
4. **Extract and check off all requirements** (~17 instances prevented)

Follow these principles, and you'll work much more effectively with Andrew.
