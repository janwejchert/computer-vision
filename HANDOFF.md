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

The PDF is built from REPORT.md through LaTeX (pandoc -> tectonic). To regenerate after edits, run from the project root:

```bash
./build_report.sh
```

This writes two artefacts: `REPORT.pdf` (the deliverable) and `REPORT.tex` (the LaTeX intermediate, useful for inspecting how pandoc translates the markdown). Toolchain: `pandoc 3.9` + `tectonic` (both `brew install`-able). Old weasyprint-based recipe is retired.

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
