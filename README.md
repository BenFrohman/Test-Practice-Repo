<!-- Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under Apache-2.0. -->
# NS_Millennium_Proof — Frohmanian Symplectic Tether Regularity Theorem

**Author:** Benjamin Stanley Frohman  
**Date:** 2026

Formalization in Lean 4 of the global regularity for the 3D incompressible Navier–Stokes equations using the Frohmanian Symplectic Tether framework.

**Status:** Not certified. The lake roots are `NS_Millennium_Proof` and `ForMathlib`. The kernel-certificate workflow builds those roots and fails while `sorry`, `admit`, `native_decide`, or an `axiom` declaration remains in them. `historical/`, `docs/`, and the top-level `Modules/` mirror are not part of that scan. A green run would not be a Clay solution.

## Structure
- `ForMathlib/NS/Tether.lean`: Upstream-candidate geometric kernel.
- `Modules/`: Core modules (SymplecticTether, GlobalRegularity, etc.).
- `Definitions/FrohmanianTether.lean`: Canonical naming (`𝔉𝕋`).

See `HISTORY.md`, `Blueprint.md`, and `LaTeX_Lean_Relationship.md` for full details.
