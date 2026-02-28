# TCGA Analysis Reports

Password-protected multi-report site deployed on GitHub Pages via [StatiCrypt](https://github.com/robinmoisson/staticrypt).

**Live page:** https://ckntav.github.io/20260227_test_encrypt_dataviz/

---

## Deploy / add a report

```bash
chmod +x deploy.sh    # first time only

./deploy.sh <report-slug> /path/to/report.html
```

**Example — DDR vs MSI:**
```bash
./deploy.sh ddr-vs-msi \
  /Users/chris/Desktop/20260118_SYM_project/scripts/explore_TCGA_cancer_vs_MSI/20260227_DDR_vs_MSI_status_TCGA.html
```

The script will:
1. Prompt for a password (not stored anywhere)
2. Encrypt the landing page → `index.html`
3. Encrypt the report → `reports/<slug>/index.html`
4. Commit and push both

---

## Add a new report to the landing page

1. Edit `_src/index.html` — copy one of the `<a class="card">` blocks and update the text and `href`
2. Run `./deploy.sh <new-slug> /path/to/new_report.html`

---

## Password & remember-me

All pages are encrypted with the same password and shared salt (`.staticrypt-salt`).
Entering the password once on any page remembers it for **7 days** across the whole site.

---

## First-time GitHub Pages setup (one-off)

1. Go to **Settings → Pages** in this repository
2. Set **Source** → Branch: `main`, folder: `/ (root)` → Save
