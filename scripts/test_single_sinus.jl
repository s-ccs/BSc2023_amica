import Amica
using Amica
using CairoMakie
using MAT
using LinearAlgebra
using Distributions: mean

#Runs SingleModelAmica on sinus data, loads MATLAB results from .mat and plots both

function mean_squared_error(A,B)
    squared_error = (A .- B) .^ 2
    mse = mean(squared_error)
    return mse
end

#Sinus data from mat file
file = matopen("test/TestData/pink_sinus_data.mat")
x = read(file, "x")
s = read(file, "s")
#A = read(file, "A")

beta_init = read(file, "beta_init")
mu_init = read(file, "mu_init")
A_init = read(file, "A_init")

close(file)
am = fit(SingleModelAmica,x;maxiter=1000, m=3, remove_mean = false,do_sphering = false, scale=beta_init[:,:,1], location=mu_init[:,:,1], A=copy(A_init[:,:,1]))

file = matopen("test/Results/results_sinus_matlab_singleModel.mat")
matlab_A = read(file,"A")
matlab_LL = read(file, "LL")
close(file)

#---
f = Figure()
series(f[1,1],s[:,1:100])
series(f[1,2],x[:,1:100])
series(f[2,1],pinv(am.A)*x[:,1:100])
series(f[2,2],pinv(matlab_A)*x[:,1:100])
lines(f[3,1],am.LL)
lines(f[3,2],vec(matlab_LL))
f
#----