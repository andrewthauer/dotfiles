# User Preferences

## Local Preferences

- If `~/.config/agents/AGENTS.local.md` exists and is not already in your
  context, read it before you start work.
- Its rules add to the rules in this file. If two rules conflict, the rule in
  `AGENTS.local.md` wins.

@~/.config/agents/AGENTS.local.md

## Writing Style

- Follow the rules in "Communication Language" below for all output (responses,
  commit messages, PR descriptions, code comments, memory entries, etc.).
- Do not use the following terms or phrases in any output:
  - "load bearing"

## Communication Language

**IMPORTANT: every rule in this section is a hard rule. Follow all of them,
every response.**

Write to the rules of ASD-STE100 Simplified Technical English (STE):

- Use short sentences. Keep procedural sentences to 20 words or fewer. Keep
  descriptive sentences to 25 words or fewer.
- Write one instruction per sentence. Do not join two steps with "and".
- Use the active voice. Say "run the tests", not "the tests should be run".
- Use the simple tenses (present, past, future). Do not use the perfect or
  progressive tenses when a simple tense works.
- Use articles ("a", "an", "the") in full. Do not drop them for brevity.
- Use one word for one meaning. Pick a term and reuse it. Do not switch to a
  synonym for variety.
- Use each word as one part of speech only. Do not use nouns as verbs ("action
  the task", "gift the file") or verbs as nouns ("do a build").
- Do not stack more than three nouns in a row. Break up noun clusters with
  prepositions or a rewrite.
- Do not use "-ing" forms when a base verb works. Prefer "to run" or "runs" over
  "running".
- Put warnings and cautions before the instruction they apply to.
- Do not use jargon, slang, idioms, or metaphors. Say the plain thing.
- Do not use filler words or hedges. Cut "just", "simply", "basically",
  "actually", "essentially".

Also follow these house rules on top of STE:

- Do not use "clanker speak" — dense, jargon-heavy AI phrasing. Only go into
  deep technical detail when I ask for it.
- Do not use mannered prose: no "It's worth noting that…", "Interestingly,",
  "Ultimately,", "At its core,", no rhetorical triads ("clear, concise, and
  correct"), no "not just X, but Y".
- Do not use these words or phrases: "certainly", "I'd be happy to", "let me",
  "diving in", "leveraging", "utilize", "robust", "seamless", "comprehensive".
- Do not write preambles that restate the request. Do not write trailing
  summaries of what I can already see in the diff. Do not write filler
  affirmations.
- State what you did, what you found, or what you need. Nothing more.
- If something is uncertain, say so in one short sentence. Do not pad with
  qualifiers.

Shape every chat response so that I can read it fast:

- Put the answer or main point in the first line.
- Use one idea per bullet or short paragraph.
- If a technical term is necessary, explain it in a few words the first time.
- Show at most two or three options. Say which one you recommend.
- When there is something for me to do or decide, end with clear next steps.
- For a stricter version of these rules, use the `plain` skill.

## Code Comments

- Avoid excessive or unnecessary comments. Do not narrate what the code
  obviously does — well-named identifiers already convey that.
- Only add a comment when it provides real value to the reader: a non-obvious
  "why", a hidden constraint or invariant, a workaround for a specific bug, or
  behavior that would surprise someone reading the code.
- Keep comments succinct but clear about intention and purpose. Prefer one short
  line over a paragraph.
- Do not reference the current task, fix, ticket, or caller (e.g. "added for X
  flow", "fixes #123") — that belongs in the commit message or PR description,
  not in the code.

## Collaboration

- When I'm asking questions about decisions or direction, treat it as
  exploratory — I may not be sure about the approach yet. Do not commit or push
  code that is in flight. Wait for explicit confirmation before finalizing or
  publishing changes.

## Version Control

- Use `jj` (Jujutsu) instead of `git` for all version control operations.
- To change history (rebase, restack, reorder, split, squash, bookmark moves),
  use the `jj` skill. Move the existing revisions with jj commands. Fix
  conflicts in place. Do not re-create the work by hand.
- Always prefix bookmark names with `andrewthauer/` (e.g.,
  `andrewthauer/my-feature`).
- Use [Conventional Commits](https://www.conventionalcommits.org/) for all
  commit messages. Only use these three types:
  - `feat:` — new features or capabilities
  - `fix:` — bug fixes
  - `chore:` — everything else (refactors, docs, tests, CI, deps, etc.)
- Use scopes to indicate the area of the codebase affected (e.g., `feat(auth):`,
  `fix(api):`, `chore(deps):`). Scopes must be short, descriptive area names —
  never ticket IDs.
- Take the PR title and body from the bookmark's own commit message
  (`jj log -r <bookmark> -T description`). Use the subject as the title. Use the
  rest of the message as the body. If the bookmark has more than one commit, use
  the top commit's subject as the title. Put each commit message in the body,
  separated by `---`.
- To create a PR, use `gh pr create`. jj is not on a git branch, so always pass
  `--head <bookmark-name>`. Pass `--base main` or the parent bookmark. Also pass
  `--fill`, or `--fill-verbose` if the bookmark has more than one commit.
  Without `--fill`, the title is the branch name and the body is empty.
- To finish a revision, use `jj commit -m "<msg>"`. It sets the description and
  moves `@` to a new empty child in one command.
- In jj, the working copy is a commit. If `@` stays on a finished or pushed
  revision, the next file edit changes that revision with no warning.
  - After `jj describe`, `jj bookmark create -r @`, or `jj git push` on `@`, run
    `jj new` in the same Bash call.
  - Do not skip `jj new` because the PR is open or no more work is planned.
  - Skip it only when the next step changes the same revision again.
- To move the nearest bookmark to the new commit after `jj commit`, run `jj tug`
  (`jj bookmark advance`). It moves the bookmark to `@-`.
- jj does not push a commit whose description starts with `wip:` or `private:`
  (`git.private-commits`). Rename the commit before you push it.
- Do not run jj commands that open an editor or a TUI. In an agent, jj config
  makes them fail. Examples: `jj describe` without `-m`, `jj split` without
  paths, `jj squash -i`, `jj resolve`. See the `jj` skill for the full list.
- Keep jj output short:
  - Run `jj diff --stat` or `jj diff --summary` before a full `jj diff`.
  - Use `jj log -r 'trunk()..@'` to see only your own work.
  - Use `jj file show -r <rev> <path>` to read a file at a revision.
- Do NOT hard-wrap PR body text. GitHub renders Markdown with soft wrapping, so
  pre-wrapped lines look awkwardly broken in the PR UI. Write each paragraph as
  a single long line and let GitHub handle wrapping. This applies even when the
  same text appears in a commit message. Unwrap the commit message body before
  you pass it as the PR body. Do not reuse a hard-wrapped commit message body
  verbatim.
- When submitting PRs to upstream/forked repositories, always include an AI
  disclaimer in the PR description using the actual tool name and model you are
  running as, e.g.:

  > 🤖 This PR was created with the assistance of
  > [Claude Code](https://claude.ai/code) (claude-sonnet-4-6).

  Replace `Claude Code` and `claude-sonnet-4-6` with the actual tool and model
  name at the time of the PR submission.

## Stacked Pull Requests

- GitHub has a native stacked pull requests feature (public preview) with a
  `gh stack` CLI extension (`gh extension install github/gh-stack`). It links a
  chain of branches where each PR targets the branch below it.
- jj bookmarks aren't managed by `gh-stack`, so use `gh stack link` to attach an
  existing bottom-to-top chain of bookmarks as a GitHub stack:
  `gh stack link <bottom-bookmark> <next-bookmark> ... <top-bookmark>`.
  - This only calls the GitHub API (sets each PR's base, reuses or creates draft
    PRs) — it adds no local tracking, so `gh stack view` and `gh stack rebase`
    won't see it.
  - Use `--base <branch>` to override the trunk the bottom PR targets, and
    `--open` to skip draft mode.
  - To grow the stack later, rerun `gh stack link` with the full bottom-to-top
    list — existing PRs by number, new branches by name.
  - For full local tracking plus `gh stack rebase`/`gh stack sync`, adopt the
    bookmarks with `gh stack init <bookmarks...>` then `gh stack submit` instead
    of `link`.
- Unlike `gh pr create`, neither `gh stack link` nor `gh stack submit --auto`
  has a `--fill` equivalent — new PRs they create always get a generic title
  derived from the branch name and an empty body. Immediately after linking, set
  the title and body of each new PR with
  `gh pr edit <number> --title <title> --body <body>`. Take them from the
  bookmark's commit message, as for a normal PR (see "Version Control" above).
- Only link bookmarks that form an actual linear chain (each built on top of the
  previous one). Sibling bookmarks branching off the same parent are just normal
  PRs with `--base <parent-bookmark>` — they don't need `gh-stack`.
- Gotcha: reordering commits within a jj bookmark chain and pushing can make
  GitHub think a PR's branch is already merged (it checks `git merge-base`
  reachability), which permanently closes that PR along with its reviews and
  comments. If reordering is needed, unstack via the GitHub UI first, push each
  bookmark bottom-to-top, then set each PR's base with
  `gh pr edit <number> --base <branch>`.

## Workspaces

- Use `jj workspace add` to create additional working copies instead of
  `git worktree`. jj workspaces share the repo's operation log and commits, so
  changes are visible across workspaces without pushing.
- Place workspaces under `.claude/workspaces/<name>` within the repo (e.g.,
  `jj workspace add .claude/workspaces/<name>`).
- When creating the first workspace, also create `.claude/workspaces/.gitignore`
  with `/*` as its only content. This prevents the workspace directories from
  appearing as untracked in `jj status` / `git status`. Adding
  `.claude/workspaces/` to the root `.gitignore` does not work because git
  treats directories containing a `.git` file as nested repositories and ignores
  `.gitignore` rules for them.
- Use `jj workspace list` to see active workspaces and
  `jj workspace forget <name>` to remove one when finished.
