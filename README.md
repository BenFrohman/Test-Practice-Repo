<!-- Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under Apache-2.0. -->
# NS_Millennium_Proof — conditional global regularity via the Frohmanian tether

**Author:** Benjamin Stanley Frohman · **License:** Apache-2.0 (see `LICENSE`, `NOTICE`)

**This repository does not prove global regularity of the 3D Navier–Stokes equations and does
not solve the Clay Millennium problem.** It proves, in Lean 4 with Mathlib, that global
regularity on the torus `𝕋³` *follows from* four named hypotheses, and it records exactly which
claims of the source papers are proved, which are assumed, and which are false.

Every tracked `.lean` file is compiled in CI (`git ls-files '*.lean'`, no exclusions) with
0 `sorry`, 0 `admit`, 0 `native_decide` and 0 custom axioms. `#print axioms` for every theorem
lists only `propext`, `Classical.choice` and `Quot.sound`.

## Main theorem (kernel-checked)

`GlobalRegularity.conditional_global_regularity_for_NS`: let `ν`, `C > 0`, `κ'' > 0`. Assume

| name | hypothesis (a `Prop` passed as an argument) | status |
|---|---|---|
| (KL)  | `KatoLocalExistence ν`: every smooth, divergence-free, periodic `u₀` has a classical solution on some `[0, T)`, `T > 0` | classical (Kato 1972), not formalized |
| (U)   | `ClassicalUniqueness ν`: classical solutions with the same `u(0)` agree where both exist | classical, not formalized |
| (BKM) | `BealeKatoMajdaContinuation ν`: a classical solution on `[0, T)` with `sup_{t<T} ‖ω(t)‖_{L^∞} < ∞` extends past `T` | classical (Beale–Kato–Majda 1984), not formalized |
| (TM)  | `TetherMajorantInequality ν C κ''`: along every classical solution there is a differentiable `M(t) ≥ ‖ω(t)‖_{L^∞}` with `M' ≤ C M² − κ'' M³` | **open**; this is the analytic claim of the source and is at least as strong as an a-priori bound on `‖ω‖_{L^∞}` |

Then every smooth, divergence-free, periodic `u₀` generates a classical solution `(u, p)` of
`∂ₜu + (u·∇)u + ∇p = νΔu`, `div u = 0` on `[0, ∞)`, and any two such solutions agree on `[0, ∞)`.

The operators `div`, `curl`, `Δ`, `∇`, `(u·∇)` and the notion of classical solution are genuine
definitions built from Mathlib's `fderiv`, `HasDerivAt` and `ContDiff` (`NS_Equations.lean`);
`𝕋³` is represented by `ℤ³`-periodic fields on `ℝ³`.

## Other kernel-checked results

* `IndependentMajorant`: every subsolution of `y' = C y² − κ'' y³` on `[0, T)` satisfies
  `y(t) ≤ max (y(0), C/κ'')`; solutions with `y(0) ≥ 0` stay in `[0, max (y(0), C/κ'')]`.
* `TetheredLyapunov.apriori_vorticity_bound`: (TM) ⇒ `‖ω(t, x)‖ ≤ max (M(0), C/κ'')`.
* `Continuation.global_of_continuation`: the abstract continuation argument;
  `NonVacuity.lean` shows each of its five hypotheses is needed (models where the other four
  hold and the conclusion fails), and that they are jointly satisfiable.
* `NavierStokes3D.zero_isClassicalSolutionOn`: `u = 0, p = 0` is a classical solution.
* Tether kernel `B_κ(ω; F, G) = −κ ∫_{𝕋³} ‖ω‖² ⟨Π_u δF/δω, Π_u δG/δω⟩ dx` (`SymplecticTether.lean`):
  it is **symmetric** in `(F, G)`; for `κ ≥ 0`, `B_κ(ω; F, F) ≤ 0`; under the named hypothesis
  (EG) `δH/δω = u` and `‖u‖²_{L²} ≠ 0`, `B_κ(ω; F, H) = 0` and `{F, H}_κ = {F, H}`.
  Caution: for the classical `L²` derivative, `δH/δω = (−Δ)⁻¹ω` (the stream function), not `u`.
* `Π_u` (`ForMathlib/NS/Tether.lean`, `Projection.lean`): `Π_u u = 0` when `‖u‖²_{L²} ≠ 0`, and
  `∫ ⟨Π_u v, u⟩ = 0`. `Ω_κ(a, b) + Ω_κ(b, a) = −2κ ∫ ‖ω‖² ⟨a, b⟩`, so the "tether two-form" is not
  skew for `κ ≠ 0`.

## Claims of the source shown false in Lean

* **Uniqueness of the minimal tether (5-step canonicity, Theorem 2.3).** The zero bracket is
  antisymmetric and satisfies (C1)–(C3) in every setting, so the claim forces `B_κ ≡ 0`
  (`uniqueness_forces_zero_kernel`); in the explicit setting `S₀`, `B_κ(ω₀; F, F) = −κ ≠ 0`, so
  `MinimalTetherUniqueness S₀ κ` is false for `κ ≠ 0` (`not_minimalTetherUniqueness`).
* **The tethered bracket is not antisymmetric** in `S₀` for `κ ≠ 0`
  (`tetheredBracket_S₀_not_antisymm`), so it is not a Poisson bracket there.
* Two earlier statements were false as written and were corrected: pointwise orthogonality of
  `Π_u` (it is `L²` orthogonality), and `Π_u u = 0` without `‖u‖²_{L²} ≠ 0`. The earlier
  `∃! u : ℝ → VelocityField` is false as written (values at negative times are free); uniqueness
  is now stated on `[0, ∞)`.

## Not proved, and not assumed by any theorem

Invariance (C1) of `B_κ` under the coadjoint action; the Jacobi identity for `{·,·}_κ`
(`TetheredJacobiIdentity`, a statement only); Arnold's theorem that the classical bracket
generates Euler; the tethered differential inequality itself (it enters only as (TM)).

## Layout

* Lake libraries (both default targets): `NS_Millennium_Proof` (root `NS_Millennium_Proof.lean`
  and every module under `NS_Millennium_Proof/`) and `ForMathlib`.
* `Modules/`, `docs/` and `historical/` hold archived snapshots. They were never compiled; each
  one that could not compile or contained `sorry`/`axiom` is now a short note, and its original
  text is in git at commit `b4001a7` (see `historical/ARCHIVED_LEAN_SNAPSHOTS.md`). The lake
  target `NS_Millennium_Proof/Skeleton/PaperOverview.lean` is archived the same way: it contained
  six `sorry` hidden by an unclosed comment, which is not a proof. `Skeleton/UniquenessOverview.lean`
  is a short orientation note matching the kernel (the minimal-tether uniqueness claim is false;
  solution uniqueness is hypothesis (U)).
* CI: `.github/workflows/kernel-certificate.yml` (no-skip guard, full build-log scan,
  build-every-file, `sorry`/axiom scan of every tracked `.lean` file, `#print axioms` audit).
  The same checks run locally with `scripts/verify_millennium_complex_calcs.sh`.

`Blueprint.md`, `LaTeX_Lean_Relationship.md` and `HISTORY.md` are development notes from before
this restatement; where they claim more than the list above, this README is authoritative.
