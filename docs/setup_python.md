# 🚀 Installing Python and Jupyter Notebook from Scratch (Miniconda)

This short tutorial explains how to:

- 🐍 Install Python using **Miniconda**
- 🧱 Create a new Python environment
- 📦 Install basic scientific packages (**NumPy**, **SciPy**)
- 📓 Start **Jupyter Notebook**

---

## 🏁 1. Start from Scratch: Install Python (Miniconda)

We recommend using **Miniconda**, a minimal Python distribution that includes:

- 🐍 **Python**
- 🧰 **Conda**, a package and environment manager

ℹ️ **Important:**  
Miniconda does **NOT** include Jupyter Notebook or scientific packages by default.  
This makes it lightweight and ideal for creating **clean, controlled environments**.

---

## ⬇️ Download Miniconda

Download the latest **Miniconda3** installer for your operating system:

🔗 https://www.anaconda.com/download/success

Choose:
- The installer for your system (**Windows**, **macOS**, or **Linux**)
- Run the installer and follow the default instructions

---

## 🧭 2. Open Your Terminal

After installation, open:

- 🪟 **Anaconda Prompt** (Windows)
- 🖥️ **Terminal** (macOS / Linux)

Check that Python is installed:
```console
python --version
```

## 🧱 3. Create a New Python Environment

Create a clean environment called "myenv_tutorial":

```console
conda create -n myenv_tutorial python=3.10
```

Activate it:
```console
conda activate myenv_tutorial
```
✅ You should now see (myenv_tutorial) in your terminal.

## 📦 4. Install Scientific Packages
With the environment activated, **please install the required packages**:

- ✅ **Required dependencies**: numpy, scipy, matplotlib, and bctpy.
- 
```console
conda install numpy scipy matplotlib bctpy jupyter
```
- ✅ [**HOI package**]: (https://github.com/brainets/hoi)
  
---
## 📁 5. Go to the Tutorial Folder

Before starting Jupyter Notebook, make sure you are located in the 
folder that contains the tutorial materials.

1. Download the tutorials / data to your computer.
2. Locate the main tutorial directory.
3. Move into the tutorials folder.

Use the terminal to navigate to the folder, for example:

```console
cd path/to/MathModel_Neuro/tutorials
```

## 📓 6. Start Jupyter Notebook
Launch Jupyter Notebook with:
```console
jupyter notebook
```
