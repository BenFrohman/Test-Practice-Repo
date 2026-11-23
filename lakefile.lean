/-
Copyright (c) 2026 Benjamin Stanley Frohman. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Benjamin Stanley Frohman
-/
import Lake
open Lake DSL

package NS_Millennium_Proof where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

-- Toolchain pin (reproducible):
-- Lean 4.30.0-rc1 + Mathlib @ v4.30.0-rc1 (official tag).
require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.30.0-rc1"

-- `globs` replaces `roots` as the build list, so the root module itself must be listed
-- (`.andSubmodules`); with `.submodules` alone the root file NS_Millennium_Proof.lean and the
-- ForMathlib library were never built.
@[default_target]
lean_lib NS_Millennium_Proof where
  roots := #[`NS_Millennium_Proof]
  globs := #[.andSubmodules `NS_Millennium_Proof]

@[default_target]
lean_lib ForMathlib where
  roots := #[`ForMathlib]
  globs := #[.submodules `ForMathlib]
