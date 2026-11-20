# Autonomous cloud worker (Otzaria) — up to 3 units of work per run

You are one of several identical workers started on a schedule. The coordinator's computer may be OFF; everything is coordinated through the fork `dudua99/otzaria` (your checkout, remote `origin`). Do units of work back to back: after finishing one unit, go back to step 2 and take the next one. (This replaces the "one unit of work" wording in your launch prompt — WORKER.md wins.) Stop after 3 units, or when about 3 hours have passed since you started, or when there is nothing left (step 2c). Throughput matters: the owner wants many finished items soon — but never skip a step of FIX.md/QA.md.

Rules: follow `FIX.md` / `QA.md` from this branch (they include GIT IDENTITY: dudua99 / 99@9900.co.il, NO Co-Authored-By / AI attribution anywhere, no force push, no PRs, no GitHub comments). AGENTS.md from upstream/dev overrides everything.

## 0. Setup
`git fetch origin cloud-notes && git show FETCH_HEAD:FIX.md > /tmp/FIX.md && git show FETCH_HEAD:QA.md > /tmp/QA.md && git show FETCH_HEAD:QUEUE.md > /tmp/QUEUE.md`; set the git identity now.
List remote branches once: `git ls-remote origin 'refs/heads/prbody/*' 'refs/heads/claim/*'`.

## 1. Claim (atomic lock)
To claim key K: create an orphan commit containing CLAIM.md (UTC time, what you will do) and push it as a NEW branch: `git push origin <sha>:refs/heads/claim/K`. If the push is rejected because the branch exists, someone else owns it — pick the next candidate. A claim older than 5 hours whose result branch does not exist is STALE: you may take it over by fetching `claim/K`, committing a new CLAIM.md ON TOP of it and pushing normally (fast-forward); if that push is rejected, skip.

## 2. Pick the unit (first match wins)
a. **QA backlog** — for every `prbody/<N>-fix` whose VERDICT.md first line is `READY` and that has no `prbody/<N>-qa`: claim `qa-<N>`, then do the QA exactly per QA.md for that fix branch (the branch name is in its VERDICT.md; if an issue-specific note exists in notes/<N>.md read it too). Output `prbody/<N>-qa`. (Skip N=5599: it is stacked on another PR and handled by the coordinator.)
b. **Next queue item** — the first line of QUEUE.md whose `<N>` has no `prbody/<N>-fix` and no live `claim/fix-<N>`: claim `fix-<N>` and implement it per FIX.md + `notes/<N>.md` (for `feature`/`feature-default`: the missing behavior is the "defect"; test that fails on upstream/dev, then the implementation; branch `feat/<slug>-<N>`; for feature-default state in BODY.md that maintainers had not decided and which default you implemented and why). Before starting, RECHECK the issue (search API as in FIX.md): if it was closed, or an open PR by someone else now covers it, or a maintainer decided otherwise — write `prbody/<N>-fix` with VERDICT `NOT READY` and the reason, and stop.
c. Nothing to do → stop without pushing anything.

Within one run you may do a QA only for a fix that ANOTHER worker/run produced (QA must be independent of the author). Never QA your own fix from the same run.

## 3. Finish
Your result branch (`prbody/<N>-fix` or `prbody/<N>-qa`, orphan, BODY.md + VERDICT.md) IS the completion marker. Also commit a final CLAIM.md "done: <result branch> <head sha>" on top of your claim branch and push it (fast-forward). Visual changes: before/after captures with real Hebrew fonts to `qa-shots/<N>` (or `-v2` if it exists).
If you hit a usage limit or an unrecoverable environment problem, push whatever is committed on your work branch, update CLAIM.md with "interrupted: <reason>" and stop — another run will take over after 5 hours.
