# **BSc-Thesis:** Implementation of AMICA in Julia
**Author:** *Alexander Lulkin*

**Supervisor(s):** *Benedikt Ehinger*

**Year:** *2023*

## Project Description
>Independent Component Analysis is commonly used on electroencephalography data for blind source separation. Various ICA
algorithms exist, among them Adaptive Mixture Independent Component Analysis. AMICA is widely used in EEG due to being one of the best
performing ICA algorithms. However, the current implementations are not transparent and not perfectly suited for further development. This
thesis aims to produce an implementation in the scientific programming language Julia. The implementation will feature a modular structure,
which will make it easy to replace certain components of the algorithm to find better performing variations.

## Bibliography
>See `Bib`-File in `report` folder.

## Instruction for a new student
To run Amica.jl, you will need Julia: https://julialang.org/

Please follow the following steps to test the Amica algorithm:
1. Open a terminal

2. Download Amica.jl from https://github.com/s-ccs/Amica.jl

         > git clone https://github.com/s-ccs/Amica.jl
3. Start Julia

         > julia
4. Switch to the package manager Pkg by typing `]`
5. Activate the project environment by providing the path to Amica.jl

         pkg> activate ~/Path/to/Amica.jl
6. Download the required packages

         pkg> instantiate
7. Check if all packages have been succesfully installed

         pkg> status
8. Run the run_amica.jl script

         julia> include("/path/to/Amica.jl/test/run_amica.jl")
9. The project will now precompile. This might take a while.
10. You can now inspect the results of the algorithm by calling the the fields of the Amica object `am`. E.g. to get the unmixing matrix A, type

         julia> am.A
The fields of the Amica object are defined in `src/types.jl`.
You can experiment with Amica.jl by trying to run it as SingleModel/MultiModel algorithm or by switching up different parameters. The easiest way to do this is by editing the `run_amica.jl` script.

Generally, performing the algorithm on given data `x` can be done by using the `fit` function to create an Amica object. You will need to specify whether the algorithm should be performed as SingleModel or MultiModel, e.g.

         obj = fit(SingleModelAmica, x)
Additional parameters can be given, like for example the maximum amount of iterations or the number of generalized Gaussians for the Gaussian mixture models.

        obj = fit(SingleModelAmica, x; maxiter = 100, m = 3)
For all possible parameters and their default values, please check the `fit` and `amica!` functions in `/src/main.jl`.

A neat feature is the ability to pass initial values for parameters which would otherwise be initialized randomly. This is very useful for running performance evaluations.

## Overview of Folder Structure 

```
│projectdir          <- Project's main folder. It is initialized as a Git
│                       repository with a reasonable .gitignore file.
│
├── report           <- **Immutable and add-only!**
│   ├── proposal     <- Proposal PDF
│   ├── thesis       <- Final Thesis PDF
│   ├── talks        <- PDFs (and optionally pptx etc) of the Intro,
|   |                   Midterm & Final-Talk
|
├── _research        <- WIP scripts, code, notes, comments,
│   |                   to-dos and anything in an alpha state.
│
├── plots            <- All exported plots go here, best in date folders.
|   |                   Note that to ensure reproducibility it is required that all plots can be
|   |                   recreated using the plotting scripts in the scripts folder.
|
├── notebooks        <- Pluto, Jupyter, Weave or any other mixed media notebooks.*
│
├── scripts          <- Various scripts, e.g. simulations, plotting, analysis,
│   │                   The scripts use the `src` folder for their base code.
│
├── src              <- Source code for use in this project. Contains functions,
│                       structures and modules that are used throughout
│                       the project and in multiple scripts.
│
├── test             <- Folder containing tests for `src`.
│   └── runtests.jl  <- Main test file
│   └── setup.jl     <- Setup test environment
│
├── README.md        <- Top-level README. A fellow student needs to be able to
|   |                   continue your project. Think about her!!
|
├── .gitignore       <- focused on Julia, but some Matlab things as well
│
├── (Manifest.toml)  <- Contains full list of exact package versions used currently.
|── (Project.toml)   <- Main project file, allows activation and installation.
└── (Requirements.txt)<- in case of python project - can also be an anaconda file, MakeFile etc.
                        
```

\*Instead of having a separate *notebooks* folder, you can also delete it and integrate your notebooks in the scripts folder. However, notebooks should always be marked by adding `nb_` in front of the file name.
