---
name: action-review
description: Read a PR review markdown file from the repo root and triage which findings are worth actioning. Use after `/pr-review` (run in another session) has produced a `pr-<number>-review.md` file in the current repo.
user-invocable: true
disable-model-invocation: true
---

# Action Review

You are triaging a PR review markdown file (produced by the `/pr-review` skill in another Claude Code session) and helping the user decide what is worth actioning.

## Step 1 — Find the review file

The review file is always named `pr-<number>-review.md`, where `<number>` is the GitHub PR number for the currently checked-out branch.

1. Get the current branch's PR number: `gh pr view --json number -q .number` (no URL — uses the current branch)
2. Look for `pr-<number>-review.md` in the current working directory (repo root)
3. If the file exists, use it. If not, tell the user no review file was found for PR #<number> and suggest they run `/pr-review` in another session first.

If `gh pr view` fails (e.g. the current branch has no associated PR), tell the user and stop.

## Step 2 — Read and assess

Read the file. For every finding — regardless of severity (Critical, Warning, Suggestion, Nitpick) — form an independent opinion on whether it is worth actioning.

Assessment criteria:

- Does the finding correctly identify a real issue? (Reviews are not infallible.)
- Is the suggested fix actually an improvement, or would it hurt readability, add unnecessary complexity, or conflict with existing patterns?
- For Nitpicks especially: is this a genuine quality win, or bikeshedding? Nitpicks are included in the triage — the goal is the best code possible — but not every nitpick is worth acting on. Some make things harder to read.

Read the surrounding code as needed to make an informed call. The review file has file paths and line numbers — use them via `Read` and `Grep`.

## Step 3 — Present opinions

For each finding in the review, output a verdict:

- **Action** — worth doing. One sentence on why.
- **Skip** — not worth it. One sentence on why (e.g. "hurts readability", "not actually a bug — the existing code handles this via X", "conflicts with the pattern established in file Y").
- **Discuss** — genuine tradeoff, need the user's call. State the tradeoff.

Group verdicts by severity, Critical first, Nitpick last. Keep each entry tight. Use the same file:line references as the review so the user can cross-check.

At the end, present a short summary line (e.g. "3 to action, 4 to skip, 1 to discuss") and stop. Wait for the user to confirm or override before making any changes.

The user may:

- Confirm the assessment as-is
- Override individual calls ("also action the nitpick on X", "skip the warning on Y")
- Ask questions before deciding

## Step 4 — Apply changes

Once the user confirms, apply the code changes for everything marked **Action** plus any overrides they added.

After you're done, list what you changed — one line per change, referencing the file and a short description.

Do NOT delete or modify the `pr-*-review.md` file. Leave it for the user to clean up or refresh against later.
