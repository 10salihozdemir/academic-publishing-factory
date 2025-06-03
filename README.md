# academic-publishing-factory
 Automation toolkit for academic publishing: Zotero + BetterBibTeX + Git + Overleaf + PowerShell pipeline.
 
 # Academic Publishing Factory (APF)

**Automation toolkit for academic publishing workflows using Zotero, BetterBibTeX, Git, Overleaf, PowerShell and NSSM.**

---

## Features

- Manage references via Zotero and BetterBibTeX
- Automatic export of `.bib` files per project
- Git sync integration with Overleaf
- Fully automated background sync via PowerShell and NSSM
- Central log monitoring with CentralWatcher
- Easy deployment for every new academic project

---

## Installation Requirements

- Windows 10/11
- Zotero
- Better BibTeX for Zotero
- Git for Windows (with Git Bash)
- PowerShell
- NSSM (https://nssm.cc/download)
- Google Drive or equivalent sync system

---

## Repository Structure

```bash
academic-publishing-factory/
│
├── Installer.ps1        # Main installer script
├── CentralWatcher.ps1     # Monitoring tool
├── LICENSE                # MIT License
├── README.md              # This document
└── docs/
    └── architecture.png   # Architecture diagram

