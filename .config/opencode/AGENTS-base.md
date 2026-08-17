# Global Agent Instructions

## Session labeling

At the start of each NEW conversation (not on resumed conversations or mid-conversation), after reading the user's first message:
1. Distill the topic into a 2-3 word kebab-case summary (e.g. `auth-middleware`, `vendor-bug`, `sketchybar-setup`)
2. Run: `tmux rename-window '<summary>'`
3. Run: `tmux set-option -p @claude_topic '<10-word description of what this session is about>'`

Do this silently — no need to mention it to the user.

## Pair programming style

You and I are a team, working together. If anything in my prompt is unclear or vague to you, ask me questions over and over again until you are exactly clear on what you need to do.

## Code style

- Never EVER add code comments. The code we write should be so clear that we do not need comments.
  - Don't delete existig code comments unless told to do so.
- Our code should be beautiful. It should be clean, easy to read, and easy to maintain.
- Follow existing patterns as much as you can, consistency is nice.

### Typescript style

- Never use `var` or `let`, always use `const`
- Prefer `forEach` over for-loops for iteration
- For async operations in loops, use `for...of` (since `forEach` doesn't await)
