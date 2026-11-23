/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
module

/-!
# NS Millennium Proof — Frohmanian Symplectic Tether (Main Entry)

**Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.**

Original work by Benjamin Frohman.
-/

public import ForMathlib.NS.Tether
public import NS_Millennium_Proof.Modules.NS_Equations
public import NS_Millennium_Proof.Modules.ArnoldGeometric
public import NS_Millennium_Proof.Modules.SymplecticTether
public import NS_Millennium_Proof.Modules.TetheredLyapunov
public import NS_Millennium_Proof.Modules.GlobalRegularity

-- The bracket lives in `FrohmanianTether`. The theorem in this library is
-- `frohmanian_tether_theorem`, not `frohmanian_symplectic_tether_theorem`.
export FrohmanianTether (TetheredBracket TetherKernel)
export GlobalRegularity (frohmanian_tether_theorem)
