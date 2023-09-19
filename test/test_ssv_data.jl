import Amica
using Amica
using CairoMakie
using MAT
using LinearAlgebra
#using GaussianMixtures
using Distributions: mean
#using SpecialFunctions
#using ComponentArrays
#using Diagonalizations

function mean_squared_error(A,B)
    squared_error = (A .- B) .^ 2
    mse = mean(squared_error)
    return mse
end
#Note: time and iterations(julia): Minimizing 1429  Time: 0 Time: 0:45:15 ( 1.90  s/it)
#load data set
file = matopen("test/eeg_data.mat")
x = read(file, "x")
close(file)
#load julia results
file = matopen("test/results_ssv_julia_singlemodel.mat")
julia_A = read(file,"A")
julia_LL = read(file,"LL")
close(file)
#load matlab results

#---
f = Figure(resolution = (1300, 500))
series(f[1,1],s[:,1:100])
series(f[1,2],s[:,900:1000])

series(f[2,1],x[:,1:100])
series(f[2,2],x[:,900:1000])
f
#--------
f2 = Figure(resolution = (1300, 500))
series(f2[1,1],pinv(am.models[1].A)*x[:,1:100])
series(f2[1,2],pinv(am.models[2].A)*x[:,900:1000])

series(f2[2,1],pinv(matlab_A1)*x[:,1:100])
series(f2[2,2],pinv(matlab_A2)*x[:,900:1000])
f2
#-----------
f3 = Figure(resolution = (1300, 500))
lines(f3[1,1],am.LL)
lines(f3[1,2],vec(matlab_LL))
f3
#-----------
f4 = Figure(resolution = (1300, 250))
series(f4[1,1],pinv(am.models[2].A)*x[:,1:100])
series(f4[1,2],pinv(am.models[1].A)*x[:,900:1000])
f4
#colsize!(f3.layout, 1, Aspect(1, 1.0))
#supertitle = Label(f[6,2], "HIII", fontsize = 20)
#----
#___________________________________________________________
# file = matopen("test/sinus_multimodel_data.mat")
# A_original = read(file, "A")
# close(file)
# series(f[5,1],pinv(A_original)*x[:,1:100])
# series(f[6,1],pinv(am.models[2].A)*x[:,1:100])
# series(f[6,2],pinv(am.models[1].A)*x[:,900:1000])