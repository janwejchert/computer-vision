# Report outline

Reference for writing the PDF report. Each section lists what to write and which notebook output to drop in.

## 1. Introduction (~0.5 page)
- Task: swimming-pool detection from aerial imagery
- Why this matters (brief uses: commercial targeting, insurance, urban monitoring)
- What this report does: annotate via GroundingDINO + manual review, then benchmark YOLO26 (4 scales), RF-DETR (2 scales) and OBB (4 variants)

## 2. Dataset (~1 page)
- Source: aerial imagery dataset provided in brief
- 288 images total
- Roboflow project `pools-tduhd` v1 (link to public version if shareable)
- Split: 202 train / 57 valid / 29 test (≈ 70/20/10), split done in Roboflow
- Preprocessing applied in Roboflow: resize Stretch to 640x640, Auto-Orient. No Roboflow-side augmentations (kept in training code for reproducibility).
- 1 class: swimming pool

## 3. Annotation pipeline (~1 page) — Step 1 evidence
- GroundingDINO prompts used: cite from `01_annotate_pools_groundingdino.ipynb` (CLASSES + box/text thresholds)
- Manual-review process: cite `pool_annotations/low_confidence.csv` (number of rows flagged at threshold). Show 2-3 GD-vs-reviewed before/after thumbnails (you can pick from `pool_annotations/previews/`).
- Tool used for review: Roboflow web UI (annotation-only use, per brief)
- Stats to include:
  - Raw GD detections vs final reviewed pool count
  - Number of false positives removed, missed pools added (rough estimate is fine if exact diff isn't tracked)

## 4. YOLO26 training (~2 pages) — Step 2
- Hyperparameter table: copy verbatim from nb 2 "Training configuration" markdown
- Justify the split (Roboflow's 70/20/10 stratified)
- Results table for n / s / m / l (paste `comparison.csv` from `MyDrive/IE/CV/results/yolo26_hbb/`)
- Two plots from nb 2 cell 13:
  - Bar chart of mAP@50-95 per variant
  - Scatter of mAP@50-95 vs params (speed/accuracy tradeoff)
- Diagnostic plots for the best variant (nb 2 cell 15): results.png, PR_curve.png, confusion_matrix.png
- Test-set metrics (standard + TTA) from nb 2 cell 17
- Discussion:
  - Which size wins on validation and on test
  - Speed/accuracy tradeoff: how mAP changes vs params
  - Effect of TTA (delta between standard and TTA columns)

## 5. RF-DETR vs YOLO26 (~1.5 pages) — Step 3
- Hyperparameter table from nb 3
- Note the resolution mismatch (RF-DETR at 672 because of the DINOv2 14x14 patch divisibility constraint; YOLO26 at 640). One sentence as a fairness caveat.
- Side-by-side comparison table from nb 3 cell 14 (combined CSV: YOLO26 rows + RF-DETR rows)
- Discussion:
  - Transformer vs CNN: does RF-DETR beat YOLO26 at matched param count? At max accuracy?
  - Small-pool detection: compare recall on small boxes (you can split test by pool area if you want depth)
  - Generalization: do the train-val gaps differ?

## 6. OBB vs HBB (~1.5 pages) — Step 4
- Hyperparameter table from nb 4 (identical hparams to nb 2 to make the HBB-vs-OBB comparison fair)
- OBB results table (4 variants: yolo26n-obb, yolo26s-obb, yolo11n-obb, yolo11s-obb) from `MyDrive/IE/CV/results/obb/comparison.csv`
- HBB vs OBB side-by-side table (combined CSV from nb 4 cell 19)
- Discussion:
  - YOLO26-OBB vs YOLO11-OBB head-to-head at matched scale
  - When OBB beats HBB: rotated, elongated pools where HBB wastes area on non-pool pixels
  - When OBB hurts: small pools where rotation regression adds noise
  - Localization precision: mAP50-95 delta (50-95 is more sensitive to box tightness than 50)

## 7. Failure analysis (~1.5 pages) — covers brief's mandatory ≥5 cases
For each model family pick the most informative cases from the inline notebook galleries:
- **YOLO26 HBB**: 2-3 failures from nb 2 cell 20 (top FPs and FNs)
- **RF-DETR**: 1-2 failures from nb 3 cell 16
- **OBB**: 1-2 failures from nb 4 cell 22 (focus on rotated pools)

For each case show:
- Image with predicted box (red) / GT box (green)
- One-line cause hypothesis (e.g., "shaded pool confused with rooftop", "elongated pool axis under-estimated", "patio mistaken for water")
- One-line proposed fix (e.g., "more shaded-pool training examples", "OBB head", "explicit water-color cue or expanded HSV aug")

## 8. Required experimental discussion (~1 page)
Direct answers to the brief's prompts:
- Which architecture performed best? (YOLO26 vs RF-DETR vs OBB)
- Which size offered the best speed/accuracy tradeoff?
- Did RF-DETR outperform YOLO-based detectors?
- When are OBB annotations beneficial?
- Which failure cases occurred most often?
- Which augmentations improved performance the most? (Document the augs used; note the chosen aug profile is a single configuration, not an ablation. Reference Ultralytics' built-in mosaic/mixup/HSV/flip/rotate set as the bundle that produced these numbers.)

## 9. Conclusion (~0.5 page)
- Best model overall
- What you would do next: ablate augmentations, label more training images, try larger backbones, tile inference for very large aerial mosaics

## Appendix
- Hardware: NVIDIA A100 40 GB on Google Colab
- Reproducibility: seeds set; full hparam tables in each notebook; CSVs saved to `MyDrive/IE/CV/results/`
- Brief link & dataset link
