# DDR gene expression vs MSI status — TCGA Explorer

Password-protected interactive HTML explorer deployed on GitHub Pages via [StatiCrypt](https://github.com/robinmoisson/staticrypt).

**Live page:** https://ckntav.github.io/20260227_test_encrypt_dataviz/

---

## Deploy / update

```bash
chmod +x deploy.sh          # first time only
./deploy.sh /Users/chris/Desktop/20260118_SYM_project/scripts/explore_TCGA_cancer_vs_MSI/20260227_DDR_vs_MSI_status_TCGA.html
```

The script will:
1. Prompt for a password (not stored anywhere)
2. Encrypt the HTML with AES-256 via staticrypt
3. Write `index.html` and push to `main`

---

## First-time GitHub Pages setup (one-off)

1. Go to **Settings → Pages** in this repository
2. Set **Source** → Branch: `main`, folder: `/ (root)`
3. Save — the page will be live within ~1 minute

---

## How the encryption works

[StatiCrypt](https://github.com/robinmoisson/staticrypt) wraps the entire HTML payload in AES-256-CBC encryption.
The browser decrypts it client-side after the correct password is entered.
The password is never sent to any server.
