# Handoff, end of day 2026-06-01

## TL;DR

All training is done, the report is written, the PDF is generated. Open `REPORT.pdf` tomorrow, read it end to end, make any edits in `REPORT.md`, then regenerate the PDF with the one-liner in section 4 below.

## 1. Where the project stands

- Branch: `clean-notebook-rewrite` (pushed to GitHub).
- 10 models trained: 4 YOLO26 HBB + 2 RF-DETR + 4 YOLO OBB.
- Best model: `yolo11s-obb` (val mAP@50-95 = 0.737, test mAP@50-95 = 0.787).
- Full failure analysis verified per-image against ground-truth polygon geometry.
- Final deliverable: `REPORT.pdf`, 13 pages, 2.9 MB.

## 2. Files to look at first tomorrow

| File | Purpose |
|---|---|
| `REPORT.pdf` | The submission artefact. Read this first. |
| `REPORT.md` | Source of the report. Edit here, not in the PDF. |
| `report_outline.md` | The original outline used to write the report. |
| `results/yolo26_hbb/comparison.csv` | YOLO26 numbers, source of truth for the tables. |
| `results/rfdetr/comparison.csv` | RF-DETR numbers. |
| `results/obb/comparison.csv` | OBB numbers. |
| `AssignmentNotebooks/02_train_yolo26 (1).ipynb` | Executed nb 2 with all outputs. |
| `AssignmentNotebooks/03_train_rfdetr (1).ipynb` | Executed nb 3. |
| `AssignmentNotebooks/04_train_obb (1).ipynb` | Executed nb 4. |
| `report_figures/` | All 6 headline figures plus extracted gallery panels. |

## 3. Style rules baked into the report

- Author byline: "Jan Wejchert" (full name, as you asked for this deliverable).
- Zero em dashes (verified by grep).
- AI acknowledgement section is section 10, clarifying that you orchestrated everything and Claude was used for efficiency, error checking, and debugging.

## 4. Regenerating the PDF after editing REPORT.md

The PDF is built from REPORT.md by weasyprint with a small inline stylesheet. To regenerate after edits, run from the project root:

```bash
python3 - <<'EOF'
import markdown, pathlib
from weasyprint import HTML, CSS
src = pathlib.Path('REPORT.md').read_text()
html = markdown.markdown(src, extensions=['tables','fenced_code','attr_list','toc'])
CSS_TEXT = """@page {size:A4; margin:2.2cm 2cm; @bottom-center {content: counter(page) " / " counter(pages); font-size:9pt; color:#777;}}
body {font-family:-apple-system,"Helvetica Neue",Arial,sans-serif; color:#1a1a1a; font-size:10.5pt; line-height:1.45;}
h1 {font-size:22pt; margin:0 0 0.4em; border-bottom:2px solid #555; padding-bottom:6px;}
h2 {font-size:15pt; margin-top:1.6em; border-bottom:1px solid #ccc; padding-bottom:4px; page-break-after:avoid;}
h3 {font-size:12pt; margin-top:1.1em; page-break-after:avoid;}
p {margin:0.55em 0; text-align:justify;}
table {border-collapse:collapse; margin:0.9em 0; width:100%; font-size:9.5pt; page-break-inside:avoid;}
th,td {border:1px solid #ccc; padding:5px 8px; text-align:left; vertical-align:top;}
th {background:#f3f3f3; font-weight:600;} tr:nth-child(even) td {background:#fafafa;}
img {max-width:100%; height:auto; margin:0.6em auto; display:block; page-break-inside:avoid;}
code {background:#f0f0f0; padding:1px 4px; border-radius:3px; font-size:9.5pt; font-family:"Menlo",monospace;}
ul,ol {margin:0.4em 0; padding-left:1.5em;} li {margin:0.15em 0;}
hr {border:none; border-top:1px solid #ccc; margin:1.4em 0;}
a {color:#1a5fb4; text-decoration:none;}"""
HTML(string=f'<!doctype html><html><body>{html}</body></html>', base_url='.').write_pdf('REPORT.pdf', stylesheets=[CSS(string=CSS_TEXT)])
print('Wrote REPORT.pdf')
EOF
```

## 5. Things that might need a look tomorrow

These are not bugs, they are decisions worth a second pass.

- **Numbers in tables.** Spot-check a few cells in section 5 of REPORT.md against `results/*/comparison.csv` to make sure the rounded values match.
- **Failure analysis cases.** The polygon ratios, rotation angles, and areas in section 7 were computed from the actual label files; re-check the analysis prose matches the visual you remember from the gallery if anything reads off.
- **Length.** 13 pages. Trim section 4 (hyperparameter tables) if you want the report under 10 pages; the tables can move to an appendix.
- **Repo link in section 1.** Says `branch clean-notebook-rewrite`. Update to `main` once you merge.
- **RF-DETR weights.** `results/rfdetr/*.pth` files are too big for GitHub (>100 MB each) so they were excluded from the commit. They live on Drive at `MyDrive/IE/CV/results/rfdetr/`. If the grader needs to reproduce, the link to Drive should go in the appendix.

## 6. Open items I did not do

- No PR opened against `main`. Branch is just pushed.
- No grader checklist cross-check (the brief lists "Required Experimental Analysis" and "Failure Analysis Section" requirements; the report covers them but you may want to map each brief sentence to a section number for safety).
- No formal augmentation ablation. Section 8.6 is qualitative. If the grader expects per-augmentation deltas, that would need 4 more training runs.

## 7. Submission checklist (best guess from brief)

- [ ] PDF report (have: REPORT.pdf)
- [ ] Notebooks (have: AssignmentNotebooks/01..04, executed copies for 02..04)
- [ ] Trained model artefacts (have: results/ folder; RF-DETR weights on Drive)
- [ ] Roboflow dataset link in report (have: workspace `jans-workspace-l9aj6`, project `pools-tduhd`)
- [ ] Hardware section (have: appendix A)
- [ ] AI acknowledgement (have: section 10)

## 8. Git state

```
On branch clean-notebook-rewrite
Commits ahead of main: 4
  ad869e7 Clean minimalist rewrite of notebooks 02-04
  e455fde nb 2: fix failure-analysis GT parser for polygon labels
  d5a871b nb 2: enrich failure gallery so loc errors are distinguishable
  477590e Add final report, executed notebooks, training results, and figures
  + the commit pushing REPORT.pdf and HANDOFF.md
Push status: in sync with origin/clean-notebook-rewrite
```
