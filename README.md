# Graphene
Calculating electronic transport properties of bilayer graphene


## Getting started

### Download
Download the code in your working directory.
```
git clone https://github.com/smfarzaneh/Graphene.git
```

### Create directories to store intermediate data
Change your directory to `graphene/`.
```
cd graphene/
```
Make a directory called `data/` and change your directory to it.
```
mkdir data
cd data/
```
Make two other directories called `polarizability/` and `relaxation/`; then return to the main directory.
```
mkdir polarizability
mkdir relaxation
cd ../
```

### Compute Polarizability and Relaxation data
For now, there is no explicit functions to compute the required data. 
Please contact me to provide you with all the data in `data/`. 

### Figures
To plot all the figures related to electronic transport in bilayer graphene run this function in MATLAB:
```
plot_figures_transport()
```
The figures will show up as `.pdf` files in the same directory.  

Note: This function requires Polarizability and Relaxation data stored in `data/`. 
