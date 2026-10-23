/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
/-!
# NS Millennium Proof — Frohmanian Symplectic Tether (Main Entry)

**Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.**

Original work by Benjamin Frohman.
-/

import NS_Millennium_Proof.ForMathlib.NS.Tether
import NS_Millennium_Proof.Modules.NS_Equations
import NS_Millennium_Proof.Modules.ArnoldGeometric
import NS_Millennium_Proof.Modules.SymplecticTether
import NS_Millennium_Proof.Modules.TetheredLyapunov
import NS_Millennium_Proof.Modules.GlobalRegularity

-- Re-export for convenience
export SymplecticTether (TetheredBracket TetherKernel)
export GlobalRegularity (frohmanian_symplectic_tether_theorem)
