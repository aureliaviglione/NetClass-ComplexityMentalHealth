<img width="600" height="300" alt="Logo_CMH" src="https://github.com/user-attachments/assets/02031362-88ab-4fee-9596-b1ccdb1c1b92" />

🔍 Description

This course is part of the Ettore Majorana Workshop “Complexity in Mental Health: The Interplay Between Brain, Behavior, and Context.” It is designed to introduce participants to key concepts in network theory and its applications in mental-health research, with a focus on practical implementation in R.

🛠 Dependencies

To run the tutorials, please install R, RStudio, and the required R packages.

1. Install R

Visit the official R website:
▶ https://cran.r-project.org

Choose your operating system:

macOS
Click “Download R for macOS” and download the latest .pkg file (e.g., R-4.x.x.pkg).

Windows
Click “Download R for Windows”, then “base”, and download the latest .exe installer (e.g., R-4.x.x-win.exe).

Open the installer and follow the instructions.
Default settings are recommended.

2. Install RStudio

Visit the RStudio (Posit) download page:
▶ https://posit.co/download/rstudio-desktop/

Under RStudio Desktop (Open Source Edition), select your operating system:

macOS: Download the .dmg file → open → drag RStudio into Applications.

Windows: Download the .exe file and run the installer.

3. Open RStudio

macOS → open RStudio from Applications.

Windows → open it from the Start Menu or desktop shortcut.

RStudio will automatically detect your R installation.

4. Install Required R Packages

You can install everything at once by running this command in the RStudio Console:

install.packages(c(
  "dplyr", "writexl", "tidyr", "tidyverse",
  "qgraph", "bootnet", "NetworkComparisonTest",
  "ggplot2"
))


Alternative (GUI method):

Go to the Packages tab (bottom-right panel).

Click Install.

Enter the package names, separated by commas.

Click Install.
 

