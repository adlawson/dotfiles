---
name: checkout
description: Fetch origin/<default branch> and checkout a new branch
user_input: optional
---

## Workflow

1. If the User provided a branch name (e.g. `/checkout my-feature-branch`) use it as is. Otherwise determine the branch name from conversation context or ask the user what the branch is for.
2. Convert the branch name to lowercase hyphen-separated words if not already (e.g. "My new feature" becomes `my-new-feature`).
3. Fetch the latest changes from `origin`:
   ```bash
   git fetch origin master
   ```
   If the `master` branch doesn't exist, try `main`. Whichever of the two works, store it to local project memory and use this in future.
4. Create and checkout the new branch based on `origin/master`:
   ```bash
   git checkout -b <branch name> origin/master
   ```
   Again, reuse the memory to check we're basing off the correct default branch


### Rules

- Branch names MUST always be prefixed with `adlawson@` (e.g. `/checkout "My feature branch"` becomes `adlawson@my-feature-branch`).
- The rest of the branch name MUST be lowercase hyphen-separated words.
- The branch MUST always be based on a freshly fetched `origin/master` (or `origin/main` if that's the default).
- Branch names MUST be concise but descriptive, and SHOULD NOT exceed four hyphen-separated words.
- If the User already provided a branch name, do not modify or second-guess it.

### Exceptions

1. The User might suggest follow up actions (e.g. `/checkout and then /commit`) which shouldn't be confused with a branch name.
