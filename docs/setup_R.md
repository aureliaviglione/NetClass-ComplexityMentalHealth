# 🚀 Installing R and RStudio from Scratch

This short tutorial explains how to install:

✔ R

✔ RStudio

✔ Required R packages

### 🧩 1. Install R

Visit the official R website:
👉 https://cran.r-project.org

Choose your operating system:

macOS → Download R for macOS → download .pkg

Windows → Download R for Windows → base → download .exe

Open the installer and follow the instructions
(default options recommended)

### 🚀 2. Install RStudio

Go to the RStudio download page:
👉 https://posit.co/download/rstudio-desktop/

Select:

macOS: download .dmg → drag to Applications

Windows: download .exe → run the installer

### 📂 3. Open RStudio

macOS → Applications

Windows → Start Menu or Desktop icon

RStudio will automatically detect your R installation.

### 📦 4. Install Required R Packages

👉 Install all packages at once (recommended)
install.packages(c(
  "dplyr", "writexl", "tidyr", "tidyverse",
  "qgraph", "bootnet", "NetworkComparisonTest",
  "ggplot2"
))

👉 GUI method (RStudio)

Go to the Packages tab

Click Install

Paste the package list

Click Install

<img src="https://github.com/user-attachments/assets/5229a28d-8c04-4607-afb0-ea69195d0511" width="300">

### 📁 5. Go to the Tutorial Folder

Before starting the tutorial, make sure the tutorial materials are available on your computer.

1. Download the R scripts and Datasets to your computer.
2. Locate the main project directory (e.g., `CrashCourse_NetworkMentalHealth`).
3. Create the folder that will contain the tutorial materials (e.g., `Tutorial_2`).

### 📊 6. Open the Tutorial in RStudio

Start **RStudio** and open the tutorial script.

Option 1 — Open the file manually:

1. Open RStudio  
2. Click **File → Open File**  
3. Navigate to the `tutorials` folder (e.g., `CrashCourse_NetworkMentalHealth/Tutorial_2`) 
4. Select the tutorial script (e.g., `Tutorial 2 - Cross-sectional graph.R`)

Option 2 — Set the working directory:

```r
setwd("path/to/CrashCourse_NetworkMentalHealth/Tutorial_2")
