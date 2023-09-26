import Amica
using Amica
using CairoMakie
using MAT
using LinearAlgebra
using Distributions: mean

#Plots comparison of Julia and MATLAB implementations on sinus data with 2 ICA models.

#Sinus data from mat file
file = matopen("test/TestData/sinus_multimodel_data.mat")
x = read(file, "x")
s = read(file, "s")
#A = read(file, "A")

beta_init = read(file, "beta_init")
mu_init = read(file, "mu_init")
A_init = read(file, "A_init")

close(file)
am = fit(MultiModelAmica,x;maxiter=2000,M=2, m=3, remove_mean = false,do_sphering = false, scale=beta_init, location=mu_init, A=copy(A_init))

file = matopen("test/Results/results_sinus_matlab_MultiModel.mat")
matlab_A = read(file,"A")
matlab_A1 = matlab_A[:,:,1]
matlab_A2 = matlab_A[:,:,2]
matlab_LL = read(file, "LL")

close(file)

#Plots first and last 100 samples of original sources and mixed data
f = Figure(resolution = (1300, 500))
series(f[1,1],s[:,1:100])
series(f[1,2],s[:,900:1000])

series(f[2,1],x[:,1:100])
series(f[2,2],x[:,900:1000])
f
#Plots first and last 100 samples of data unmixed by Julia and MATLAB implementations
f2 = Figure(resolution = (1300, 500))
series(f2[1,1],pinv(am.models[1].A)*x[:,1:100])
series(f2[1,2],pinv(am.models[2].A)*x[:,900:1000])

series(f2[2,1],pinv(matlab_A1)*x[:,1:100])
series(f2[2,2],pinv(matlab_A2)*x[:,900:1000])
f2
#Plots likelihood functions of Julia and MATLAB implementations
f3 = Figure(resolution = (1300, 500))
lines(f3[1,1],am.LL)
lines(f3[1,2],vec(matlab_LL))
f3
#Plots first and last 100 samples with unmixing matrices applied in wrong order
f4 = Figure(resolution = (1300, 250))
series(f4[1,1],pinv(am.models[2].A)*x[:,1:100])
series(f4[1,2],pinv(am.models[1].A)*x[:,900:1000])
f4
#-----------