---
name: diverge
description: Parallel divergent ideation. Spawns isolated subagents under different cognitive frames (inversion, speedrunner, 3am on-call, biology, $0 budget), then scores, clusters, flags traps, and deepens the top ideas. Use on /diverge, "brainstorm", "ideate", "give me options", or open-ended architecture, API surface, schema, naming, and fuzzy-debug decisions. Skip for syntax, lookups, bugs with a known root cause, or closed phrasing ("quick", "standard", "canonical", "just"). The full pre-flight gate is in the skill body.
---

# Diverge

The first three answers to a design question are usually the answers a
senior engineer gives in thirty seconds. They are correct but not
interesting. This skill forces the search past them. Then it converges on a
real recommendation.

## Pre-flight

This skill is expensive: about 8 subagent calls and 5 to 10 times the cost
of a direct answer. Run this gate before Phase 0.

1. **Explicit request.** If the user typed `/diverge` or asked for this
   skill by name, go to Phase 0. Do not question the request.
2. **Self-check.** In all other cases, answer these questions. If any
   answer is "no", stop and answer directly.
   - Is the problem open? Would two senior engineers give different
     viable answers?
   - Is the cost of a wrong default answer high? Architecture, public
     APIs, schemas, product names, and bugs with no known cause are high.
     A throwaway script is not.
   - Is the phrasing open? Words like "quick", "standard", "canonical",
     "textbook", "just", or "one-liner" mean the user wants a direct
     answer.

If the gate fails, give the direct answer. You can add one sentence:
"Run `/diverge <problem>` for a wider search across parallel frames."

## Phase 0: Frame the problem

1. Write the problem P in one or two sentences.
2. Collect the context the branches need. For a code problem, read the
   relevant files first. Write a short brief: constraints, current design,
   and what "done" means.
3. Pick 5 frames from the table below.
   - For a code or design problem, pick 4 frames tagged `code` or `design`.
     Add 1 frame tagged `wild`.
   - For a product or strategy problem, mix frames from all tags.
   - Do not always pick the same frames. Vary the set between runs.

## Phase 1: Diverge (no critic)

Spawn 5 subagents with the Agent tool. Put all 5 calls in **one message**
so that they run in parallel.

**CAUTION:** Do not pass the output of one branch to another branch. Do not
write the branches yourself in sequence. Branches that see each other copy
each other, and the search collapses to one wide thought.

Give each subagent only P, the brief, the frame's vantage prompt, and this
instruction:

> You are in DIVERGENT mode. You generate ideas. You do not judge them.
> Do not use tools. Everything you need is in this prompt.
> Frame: <vantage prompt>
> Generate 6 short, distinct ideas under this frame. Each idea is one
> phrase or one sentence. Do not evaluate, rank, or hedge. The three
> obvious answers that everyone gives are banned. Go past them.
> Output a JSON array only, with no text before or after:
> `[{"text": "...", "rationale": "..."}]`

## Phase 2: Focus (critic on)

Do steps 1 and 2 yourself after all branches return.

1. **Score.** Rate each idea from 0 to 10 on three axes:
   - Novelty (N): distance from the obvious default.
   - Viability (V): can a team ship it?
   - Fit (F): does it solve the stated problem?

   Flag an idea as a **trap** if it looks good but has a hidden cost. Give
   a one-line reason. Examples: false economy, poor scale, premature
   abstraction, high operations load.
2. **Cluster.** Group the ideas into 3 to 6 clusters by the underlying
   approach, not by shared keywords. Label each cluster by its approach,
   for example "remove the server", "cache-shaped", "batch-window".
3. **Deepen.** Compute a weighted score: 0.35 × N + 0.40 × V + 0.25 × F.
   Remove the traps. Take the top 3 ideas. Spawn 3 parallel subagents, one
   for each idea, with this instruction:

   > You are in FOCUS mode. Develop one promising idea.
   > Problem: <P>
   > Brief: <brief>
   > Idea: <idea>
   > You can read files to ground the idea in the real code. Do not edit
   > files.
   > Return JSON only:
   > `{"sketch": "4 to 8 sentences on how it works", "key_risk": "...",
   > "first_step": "one concrete first action", "children": ["3 to 5
   > variations, hybrids, or things this idea makes possible"]}`

## Frames

| Frame | Vantage prompt | Tags |
|---|---|---|
| **hardware engineer** | You think in latency, memory layout, and physical limits. Treat this as a hardware or firmware problem. What do the bus, the cache, and the timing budget tell you? | code, wild |
| **regulator** | You audit systems for compliance and failure. What must be provable, traceable, or refusable here? | design, general |
| **10-year-old** | You are a curious 10-year-old who has never seen software. Suggest naive approaches that ignore convention. | general, wild |
| **attacker** | You are a hostile competitor or attacker. Find ways to exploit, break, or abuse the obvious solution. Then turn each attack into a design idea. | code, design |
| **biology** | Take a mechanism from biology (immune system, neural plasticity, cell signals, evolution). Apply it to this problem. | code, wild |
| **logistics** | Take mechanisms from logistics: queues, batches, just-in-time, hub-and-spoke, returns, last mile. Apply them literally. | code, design |
| **game designer** | Treat the user as a player. What are the loops, rewards, friction points, save states, and shortcuts? | design, general |
| **markets** | Treat the problem as a market with buyers, sellers, and market makers. What does an auction or a clearing house look like here? | design, wild |
| **inversion** | Ask the opposite question. If the goal is X, list ways to guarantee "not X". Then negate each answer. | code, design, general |
| **$0 budget, 1 hour** | You have no money, no team, and one hour. What is the crudest version that still does the core job? | code, general |
| **infinite budget, 10 years** | You have unlimited compute, unlimited engineers, and ten years. What is the maximal version? | design, wild |
| **remove the fixed assumption** | Name the one thing everyone treats as fixed: the framework, the database, request-response, the network. Remove it. What becomes possible? | code, design, wild |
| **speedrunner** | You are a speedrunner. Find the skips, glitches, and shortcuts. What is the abusive but legal path? | code, wild |
| **ant colony** | There is no central planner. Many simple agents follow local rules. How does the problem solve itself? | code, wild |
| **3am on-call** | You are the on-call engineer. This system pages you at 3am. What design means you never get that page? | code, design |
| **deletion** | The best code is no code. What can you delete, merge, or refuse so that the problem goes away? | code, design |

## Output

Render the result in this order. Keep the structure. Do not merge it into
long prose.

1. **Brief.** One or two lines that restate P and any reframe.
2. **Wide set.** All ideas, grouped by cluster. Each idea is one short
   phrase with a score chip, for example `[N7 V8 F9]`.
3. **Converge.** A shortlist of 2 to 4 ideas, each with one line on why it
   is on the list. Mark the best non-obvious but viable pick with ★. List
   the traps separately, each with its one-line reason.
4. **Focus.** The 3 deepened ideas. For each, show the sketch, the key
   risk, the first step, and the child ideas.
5. **Recommendation.** State which idea you would choose and why, in two
   or three sentences.
6. **Provocation.** One wild question or idea that opens a new direction
   if nothing above fits.
7. **Next step.** End with one line: "Run `/converge` on the shortlist for
   a full decision."

## Failure modes

- **False divergence.** Ten small variations of one idea is not breadth.
  If all ideas share one assumption, run a new branch under a frame that
  removes that assumption.
- **No convergence.** A list of 30 unsorted strange ideas is as useless
  as one safe answer. Always converge.
- **No opinion.** "Here are 20 ideas, you decide" is not an answer. Give a
  recommendation.
- **Simulated branches.** If you write the branches yourself in one
  context, the method fails. Use separate subagents.

## Calibration

- **Size.** Scale the run to the stakes. A function name needs 3 frames ×
  4 ideas. A product position needs 5 frames × 8 ideas. The default is
  5 × 6 = 30.
- **Tone.** For serious strategy work, label wild ideas clearly. For open
  brainstorms, let the wild ideas run. A strange idea is useful when it
  leads to a viable one.
- **Stop point.** Stop when new ideas repeat the shape of existing ones.
  Do not add ideas to reach a number.

Adapted from https://github.com/UditAkhourii/adhd (MIT).
