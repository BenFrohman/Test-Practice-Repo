/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
/-!
# Archived snapshot: `NS_Millennium_Proof/Skeleton/PaperOverview.lean`

The original text of this file is preserved verbatim in the git history:

    git show b4001a7:NS_Millennium_Proof/Skeleton/PaperOverview.lean

(sha256 `7ab1a115d6665cbe5ab31c136e99a75e79935002ab483cf9dea2269496719720`, listed in `historical/ARCHIVED_LEAN_SNAPSHOTS.md`).

That text was a narrative skeleton of the source paper. It did not typecheck: it used
undefined identifiers and contained six `sorry`. A pre-existing typo (writing `-!/` where
a Lean block comment has to be closed) left the body inside an unclosed `/ -!` block,
which was then balanced by an `auto-closed` closer at the end of the file, so the kernel
and the comment-stripping sorry scan never saw those `sorry`. That is not a proof, and
it is not part of any claim.

This file now contains only this note, so that every tracked `.lean` file is compiled with
no `sorry` and no custom axiom. The kernel-checked development is the
`NS_Millennium_Proof` library; see `README.md`. In particular this repository does not
prove global regularity and does not solve the Clay Millennium problem.
-/
