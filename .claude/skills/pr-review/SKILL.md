---
name: pr-review
description: Review a GitHub pull request and present findings in a consistent, structured format. Use when the user provides a GitHub PR URL for review.
user-invocable: true
disable-model-invocation: true
argument-hint: <github-pr-url>
---

# PR Review

You are reviewing a GitHub pull request. The PR URL is: $ARGUMENTS

## Step 1 — Fetch PR data

Use `gh` to fetch, in parallel:

- The PR diff: `gh pr diff <url>`
- The PR metadata: `gh pr view <url> --json title,body,author,baseRefName,headRefName,state,additions,deletions,changedFiles,files`
- Individual file contents from the PR as needed (`gh api`)

**Do NOT run bare `gh pr view <url>`** — it pulls deprecated Projects (classic) fields and fails with a GraphQL error, which cancels any parallel `gh` calls. Always pass `--json` with the explicit field list above.

### Local repo context (use this!)

Repos are checked out locally under `~/Documents/projects/<repo-name>`, where `<repo-name>` matches the GitHub repo name from the PR URL. When you need more context to support the review — understanding callers of a changed function, related modules, project conventions, the surrounding code that the diff doesn't show — read directly from the local checkout using `Read`, `Grep`, and `Glob`. This is faster and gives you repo-wide search.

You are encouraged to do this liberally. A review grounded in how the rest of the codebase actually uses the changed code is far more valuable than one that only sees the diff.

Caveats:

- The local checkout may be on a different branch than the PR. For _unchanged_ files (the surrounding codebase), this is fine. For files the PR modifies, trust `gh pr diff` over the local copy — the local file may be older or newer than what's in the PR.
- If the repo isn't checked out at `~/Documents/projects/<repo-name>`, fall back to `gh api`. Don't clone it yourself.

Do NOT summarize the PR. Go straight to the review.

## Step 2 — Present findings

### Output format

Start with a **Highlights** section — a brief paragraph (2-4 sentences max) calling out anything genuinely well done. Keep it short and conversational. No file/line references, no headers per item. If nothing stands out, skip this section entirely.

Then present findings grouped by file. Within each file, order findings by severity (Critical first, Nitpick last).

Each finding uses this exact format:

```
### [SEVERITY] Short description of the finding

File: `path/to/file.ext:LINE_NUMBER`

Explanation with enough context to act on it.

---
```

Where SEVERITY is one of: `Critical`, `Warning`, `Suggestion`, `Nitpick`

Always end each finding with a horizontal rule (`---`) to visually separate it from the next one. The last finding in a file group also gets a rule.

Group all findings under a file-level heading. Add a blank line after the file heading for breathing room:

```
## path/to/file.ext

(findings for this file here, each separated by ---)
```

Order files by highest severity found in each file (files with Critical findings first).

Separate file groups with two blank lines so they're clearly distinct sections.

If there are zero findings, just say so — don't pad the output.

### Severity guide

- **Critical**: Bugs, security issues, data loss risks, broken logic. Must fix.
- **Warning**: Likely problems — poor error handling, race conditions, missing edge cases. Should fix.
- **Suggestion**: Design improvements, readability, better patterns. Nice to fix.
- **Nitpick**: Style, naming, minor preferences. Take it or leave it.

## Write-to-file behavior

When the user says "md":

1. Take the latest review you produced this session (the full output from Step 2, or the three-section output from a refresh)
2. Write it to `pr-<number>-review.md` in the root of the local checkout (`~/Documents/projects/<repo-name>/pr-<number>-review.md`), where `<number>` is the PR number from the URL
3. Overwrite the file if it already exists — no timestamps, no history
4. Confirm the path you wrote to in one line, nothing else

If no review has been produced yet this session, do the review first, then write it.

## Refresh behavior

When the user says "refresh":

1. Re-fetch the PR diff from the same URL using `gh pr diff`
2. Compare against your previous findings
3. Present the output in three sections:

**Resolved** — Previous findings that are no longer present. One line each:

```
- ~[SEVERITY] Short description (file.ext:LINE)~ — resolved
```

**Still Open** — Previous findings still present. Full format again (file + line may have shifted — use the current line number).

**New Findings** — Anything new from changed/added code. Full format.

If all previous findings are resolved and there are no new ones, just say so.
