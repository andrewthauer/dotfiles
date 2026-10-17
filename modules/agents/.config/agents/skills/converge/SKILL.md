---
name: converge
description: Structured decision between known options. Stress-tests each option in an isolated subagent (best case plus pre-mortem), scores all options against weighted criteria, and commits to one pick with a runner-up, a switch condition, and a first step. Use on /converge, "help me decide", "which should I pick", "compare these options", or after a /diverge run. Skip when there is only one option, or when the user asks for a quick opinion.
---

# Converge

Pick one option from a known set, and show why. The skill judges each
option on its own first, so the first option does not color how the others
get judged. Then it compares all options side by side.

## Pre-flight

1. **Find the options.** Take them from the user message, a file, a thread,
   or an earlier `/diverge` run in this conversation.
2. **Check the count.**
   - If there are fewer than 2 options, stop. Ask for more options, or
     suggest `/diverge <problem>`.
   - If there are more than 5 options, cut the list to 5. Give a one-line
     reason for each cut.
3. **Add a baseline.** If "do nothing" or "keep the current design" is a
   real choice, add it as an option.

## Phase 0: Frame the decision

1. Write the decision D in one sentence.
2. Collect the context the subagents need. For a code decision, read the
   relevant files first. Write a short brief: constraints, the current
   design, and what "done" means.
3. Set the criteria.
   - If the user gave criteria, use them.
   - If not, pick 3 to 5 criteria that fit D. Examples: cost to build,
     risk, time to ship, operations load, reversibility, fit with the
     current code.
   - Give each criterion a weight. The weights add up to 1.0.
   - Show the criteria and weights in the output. Do not stop to ask for
     approval.

## Phase 1: Stress-test (isolated)

Spawn one subagent per option with the Agent tool. Put all the calls in
**one message** so that they run in parallel.

**CAUTION:** Give each subagent one option only. Do not show it the other
options. Do not tell it which option the user prefers.

Give each subagent this instruction:

> You test one option for a decision. Be fair, then be hard on it.
> Decision: <D>
> Brief: <brief>
> Criteria: <criteria with weights>
> Option: <option>
> You can read files to check claims against the real code. Do not edit
> files.
> 1. Make the best honest case for this option.
> 2. Run a pre-mortem. Assume that six months later this option failed.
>    Give the 3 most likely reasons.
> 3. Name any fatal flaw: a problem that rules the option out. If there is
>    none, return null.
> 4. Name the hidden costs.
> 5. Say how hard the option is to undo, and why.
> 6. For each criterion, give one or two lines of evidence. Do not score.
> Return JSON only:
> `{"best_case": "...", "premortem": ["...", "...", "..."],
> "fatal_flaw": null, "hidden_costs": ["..."],
> "reversibility": {"level": "easy|medium|hard", "why": "..."},
> "evidence": {"<criterion>": "..."}}`

## Phase 2: Score and decide

Do this phase yourself after all subagents return.

1. **Score.** Rate every option from 0 to 10 on each criterion. Score all
   options for one criterion before you go to the next criterion. This
   keeps the scores consistent across options.
2. **Remove.** Remove any option with a fatal flaw that you agree with.
   If you do not agree with a flaw, say why.
3. **Total.** Compute the weighted total for each remaining option.
4. **Decide.** Pick one option. Name a runner-up.
   - If the top two totals are within 0.5, call it a tie. Name the one
     criterion that breaks the tie, and pick on that criterion.
   - A hybrid of two options is allowed if it is obvious from the
     evidence. Label it as a hybrid. Do not invent new options.
   - If every option has a fatal flaw, say so. Suggest `/diverge` for new
     options.

## Output

Render the result in this order.

1. **Decision.** One line that states D.
2. **Criteria.** A list of the criteria with their weights.
3. **Table.** One row per option. Columns: one score per criterion, the
   weighted total, and the fatal flaw (or "none").
4. **Pick.** The chosen option, and why, in two or three sentences.
5. **Runner-up.** The second option, and the one fact that would make it
   the better choice.
6. **Risks.** The top pre-mortem reasons for the pick, and how to watch
   for each one.
7. **Reversibility.** How hard the pick is to undo.
8. **First step.** One concrete first action.
9. **Open questions.** Facts that would change the result if you knew
   them. Leave this out if there are none.

## Failure modes

- **False precision.** The scores are judgments, not measurements. Do not
  present a difference of 0.2 as a clear win.
- **Anchoring to the user.** If the user leans toward one option, test that
  option as hard as the others. The isolation in Phase 1 exists for this.
- **No commitment.** "It depends" is not a pick. State what it depends on,
  then pick for the most likely case.
- **New options.** This skill judges options. It does not make them. Use
  `/diverge` for that.
