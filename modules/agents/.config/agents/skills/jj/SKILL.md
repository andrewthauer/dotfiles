---
name: jj
description: Move, reorder, split, squash, or restack jj (Jujutsu) revisions and bookmarks with jj's own history commands, then fix conflicts in place. Use before any jj rebase, restack, reorder, split, squash, move of changes between revisions, bookmark move, or sync with trunk. Do not re-apply edits by hand to change history.
---

# jj history edits

In jj, a revision is a unit you can move. Move it with a command. Do not
make it again.

## Hard rules

- Do not re-create work to change history. Do not copy diffs, re-type
  edits, or `jj abandon` a revision to build it again elsewhere.
- Do not resolve a conflict by a rewrite of the file from memory. Edit
  the conflict markers only.
- Do not use interactive commands. They open an editor or a TUI and
  hang. This includes `jj split` without paths, `jj squash -i`,
  `jj arrange`, `jj resolve`, and `jj describe` without `-m`.
- Before a history edit, run `jj log` to see the graph. After the edit,
  run `jj log` again to check the result.
- If an edit goes wrong, run `jj undo`. Do not repair it by hand.

## Pick the command

| Goal | Command |
| --- | --- |
| Move a stack onto a new base | `jj rebase -b <rev> -o <base>` |
| Move a revision and its descendants | `jj rebase -s <rev> -o <base>` |
| Move one revision only (descendants stay) | `jj rebase -r <rev> -o <base>` |
| Put a revision between two others | `jj rebase -r <rev> -A <after>` or `-B <before>` |
| Reorder two revisions | `jj rebase -r <rev> -B <other>` |
| Sync all local work with trunk | `jj git fetch` then `jj rebase -b @ -o 'trunk()'` |
| Move all changes into another revision | `jj squash --from <src> --into <dst>` |
| Move some files into another revision | `jj squash --from <src> --into <dst> <paths>` |
| Send each hunk in `@` to the revision that last touched those lines | `jj absorb` |
| Split files out of a revision | `jj split -r <rev> -m "<msg>" <paths>` |
| Undo a file's changes in a revision | `jj restore -r <rev> <paths>` (restores from its parent) |
| Copy a file's state from another revision | `jj restore --from <src> --into <dst> <paths>` |
| Make revisions siblings, not a chain | `jj parallelize <revs>` |
| Copy a revision to a second place | `jj duplicate <rev> -o <base>` |
| Point a bookmark at a revision | `jj bookmark set <name> -r <rev>` (add `--allow-backwards` to move back) |
| Fold a revision into its parent | `jj squash -r <rev>` |
| Drop a revision | `jj abandon <rev>` (descendants move to its parent) |

Notes:

- Descendants rebase automatically after `squash`, `split`, `absorb`,
  `restore`, and `abandon`. Do not rebase them yourself.
- Bookmarks follow their revisions on rebase. Move a bookmark only if it
  must point at a different change.
- Use change IDs (the letters in `jj log`), not commit hashes. Change IDs
  do not change when a revision moves.
- When both revisions have a description, `jj squash` opens an editor.
  Pass `-m "<msg>"` or `-u` (keep the destination message) to stop this.

## Fix conflicts in place

A rebase in jj does not stop on a conflict. It records the conflict in the
revision and continues. Fix the conflict after the rebase.

1. Run `jj log -r 'conflicts()'` to list conflicted revisions.
2. Start with the oldest conflicted revision. A fix there often clears the
   revisions above it.
3. Run `jj new <rev>` to make a fix revision on top of it.
4. Run `jj resolve --list` to see the conflicted files.
5. Edit each file. Remove the markers. Keep the correct content from each
   side.
6. Run `jj squash` to move the fix into `<rev>`. Descendants rebase onto
   the fix.
7. Run `jj log -r 'conflicts()'` again. Repeat until it is empty.
8. Run `jj new <top-of-stack>` to put `@` back on top of the stack.

How to read jj conflict markers (default "diff" style):

```text
<<<<<<< conflict 1 of 1
%%%%%%% diff from base to side #1
-old line
+line from side 1
+++++++ side #2
line from side 2
>>>>>>> conflict 1 of 1 ends
```

- The `%%%%%%%` part is a diff. Apply that diff to the `+++++++` part to
  get the merged result.
- Some sections use `-------` (base) and `+++++++` (side) snapshots
  instead of a diff. Merge the sides against the base.

## Check the result

- `jj log` shows the expected shape.
- `jj log -r 'conflicts()'` is empty.
- `jj diff -r <rev> --stat` for each moved revision shows only its own
  changes.
- `jj interdiff --from <old> --to <new>` shows that a moved revision has
  the same changes as before. Get `<old>` from `jj evolog -r <rev>`.
