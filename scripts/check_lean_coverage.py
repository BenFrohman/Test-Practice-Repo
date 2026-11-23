#!/usr/bin/env python3
# Copyright (c) 2026 Benjamin Stanley Frohman. Licensed under Apache-2.0.
"""Build every tracked .lean file. Run after `lake build` in CI.

The file list is `git ls-files '*.lean'`. There is no exclusion list. Every file must be:
  BUILT     its module .olean was produced by the lake build;
  LAKEFILE  ./lakefile.lean, which Lake elaborates on every `lake` invocation;
  COMPILED  `lake env lean <file>` exits 0 with no `error:` and no `declaration uses 'sorry'`.
Anything else FAILS, by name, with its first compiler messages. The full compiler output of each
COMPILED file is written to cert-out/lean-files/<path>.log."""
import os, re, subprocess, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(ROOT)
LOGDIR = "cert-out/lean-files"

files = [f for f in subprocess.check_output(["git", "ls-files", "*.lean"]).decode().splitlines() if f]
counts = {"BUILT": 0, "LAKEFILE": 0, "COMPILED": 0}
fails = []
for f in files:
    if os.path.isfile(os.path.join(".lake/build/lib/lean", f[:-5] + ".olean")):
        counts["BUILT"] += 1; print(f"BUILT     {f}", flush=True); continue
    if f == "lakefile.lean":
        counts["LAKEFILE"] += 1; print(f"LAKEFILE  {f}", flush=True); continue
    p = subprocess.run(["lake", "env", "lean", f], capture_output=True, text=True)
    out = p.stdout + p.stderr
    log = os.path.join(LOGDIR, f + ".log")
    os.makedirs(os.path.dirname(log), exist_ok=True)
    open(log, "w", encoding="utf-8").write(out + f"\n[exit {p.returncode}]\n")
    if p.returncode == 0 and not re.search(r"(^|\s)error:", out) and "sorry" not in out:
        counts["COMPILED"] += 1; print(f"COMPILED  {f}", flush=True); continue
    fails.append(f)
    print(f"FAIL      {f}\n  " + "\n  ".join(out.strip().splitlines()[:8]), flush=True)
print(f"BUILD-EVERY-FILE: {len(files)} tracked .lean files: "
      + ", ".join(f"{v} {k}" for k, v in counts.items()) + f", {len(fails)} FAILED")
if not files:
    sys.exit("BUILD-EVERY-FILE FAIL: no tracked .lean file (vacuous check)")
if fails:
    print("BUILD-EVERY-FILE FAIL:\n" + "\n".join(fails)); sys.exit(1)
print("BUILD-EVERY-FILE PASS: every tracked .lean file was built by lake or compiled by lean")
