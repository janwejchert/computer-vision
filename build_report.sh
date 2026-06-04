#!/usr/bin/env bash
# Build REPORT.pdf from REPORT.tex via tectonic.
# REPORT.tex is the source of truth; REPORT.md is kept only for reference.
set -euo pipefail
cd "$(dirname "$0")"

tectonic --keep-logs --outdir . REPORT.tex
echo "wrote REPORT.pdf"
