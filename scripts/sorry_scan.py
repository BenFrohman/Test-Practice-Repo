#!/usr/bin/env python3
"""Scan the lake library for sorry, admit, native_decide, and axiom declarations.

Comments and strings are ignored. A hit exits 1. This script does not skip a
file because it is unfinished. Pass the lake roots on the command line.

  python3 scripts/sorry_scan.py NS_Millennium_Proof.lean NS_Millennium_Proof ForMathlib
"""
import re
import sys
from pathlib import Path

ROOTS = [Path(p) for p in sys.argv[1:]]
if not ROOTS:
    sys.exit("usage: sorry_scan.py PATH [PATH ...]")


def strip(src: str) -> str:
    out = []
    i = 0
    depth = 0
    n = len(src)
    while i < n:
        if src.startswith("/-", i):
            depth += 1
            i += 2
            continue
        if depth and src.startswith("-/", i):
            depth -= 1
            i += 2
            continue
        if depth:
            i += 1
            continue
        if src.startswith("--", i):
            j = src.find("\n", i)
            i = n if j < 0 else j
            continue
        if src[i] == '"':
            j = i + 1
            while j < n and src[j] != '"':
                j += 2 if src[j] == "\\" else 1
            out.append('""')
            i = j + 1
            continue
        out.append(src[i])
        i += 1
    return "".join(out)


def files(path: Path):
    if path.is_file() and path.suffix == ".lean":
        yield path
        return
    if not path.is_dir():
        sys.exit(f"path not found: {path}")
    for f in sorted(path.rglob("*.lean")):
        if ".lake" not in f.parts and ".git" not in f.parts:
            yield f


bad = []
seen = []
for root in ROOTS:
    for f in files(root):
        seen.append(f)
        code = strip(f.read_text(encoding="utf-8"))
        for n, line in enumerate(code.splitlines(), 1):
            if re.search(r"\b(sorry|admit|native_decide)\b", line) or re.match(
                r"\s*(@\[[^\]]*\]\s*)?((private|protected|noncomputable|public|unsafe)\s+)*axiom\s",
                line,
            ):
                bad.append(f"{f}:{n}: {line.strip()}")

print(f"Scanned {len(seen)} Lean files under: {' '.join(str(p) for p in ROOTS)}")
if not seen:
    sys.exit("FAIL: no Lean files scanned")
if bad:
    print("\n".join(bad))
    print(f"RESULT: {len(bad)} hits")
    sys.exit(1)
print("RESULT: 0 hits")
