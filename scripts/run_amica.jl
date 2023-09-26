import Amica
using Amica
using CairoMakie
using MAT
using LinearAlgebra

#Sinus data from mat file
file = matopen("test/TestData/pink_sinus_data.mat")
x = read(file, "x")
s = read(file, "s")
#A = read(file, "A")

beta_init = read(file, "beta_init")
mu_init = read(file, "mu_init")
A_init = read(file, "A_init")

close(file)

#Remove init args for randomly initialized parameters
@time am = fit(SingleModelAmica,x;maxiter=500, m=3, remove_mean = false,do_sphering = false, scale=beta_init[:,:,1], location=mu_init[:,:,1], A=copy(A_init[:,:,1]))
#@time am = fit(MultiModelAmica,x;maxiter=100, M = 2, m=3, remove_mean = true,do_sphering = true, scale=beta_init, location=mu_init, A=copy(A_init))


#---
f = Figure()
series(f[1,1],s[:,1:100]) #Original sources (not mixed)
series(f[1,2],x[:,1:100]) #Mixed data
series(f[2,1],pinv(am.A[:,:,1])*x[:,1:100]) #Unmixed sources
lines(f[3,1],am.LL) #Log-Likelihood over iterations
f
#----