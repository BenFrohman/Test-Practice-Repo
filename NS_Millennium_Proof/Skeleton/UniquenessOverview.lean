/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
/-
This file is a short orientation note for the uniqueness claims. It is not a proof.
See `README.md`, `NS_Millennium_Proof/Modules/Uniqueness.lean` and
`NS_Millennium_Proof/Modules/GlobalRegularity.lean`.
-/

module

namespace FrohmanianTether.Skeleton

/-!
# Uniqueness overview

This repository records two uniqueness questions. The Lean kernel has settled them as follows.

## The minimal tether is not unique

The source claimed a unique minimal bilinear correction satisfying conditions (C1)–(C3).
`zero_bracket_satisfies_conditions` shows that the zero bracket satisfies those conditions
in every setting, so the uniqueness claim forces the kernel to vanish
(`uniqueness_forces_zero_kernel`). In the explicit setting `S₀`, `B_κ(ω₀; F, F) = -κ`,
which is nonzero when `κ ≠ 0`, so `MinimalTetherUniqueness S₀ κ` is false
(`not_minimalTetherUniqueness`). The tethered bracket is also not antisymmetric in `S₀`
for `κ ≠ 0` (`tetheredBracket_S₀_not_antisymm`).

## Uniqueness of classical solutions is a hypothesis

Global uniqueness of classical solutions on `[0, ∞)` is not proved. It is the named
hypothesis `ClassicalUniqueness` (U). Under (KL), (U), (BKM) and the open majorant
hypothesis (TM), `GlobalRegularity.conditional_global_regularity_for_NS` gives a classical
solution on `[0, ∞)` that is unique on `[0, ∞)`. This is not a solution of the Clay
Millennium problem.
-/

end FrohmanianTether.Skeleton
