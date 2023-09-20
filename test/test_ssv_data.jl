# import Amica
# using Amica
using CairoMakie
using MAT
using LinearAlgebra
#using GaussianMixtures
using Distributions: mean
#using SpecialFunctions
#using ComponentArrays
#using Diagonalizations


file = matopen("test/Experiments/Results/results_ssv_matlab_singlemodel.mat")
matlab_A = read(file,"A")
time = read(file, "total_time")
# matlab_A2 = read(file,"A_2")
# matlab_A3 = read(file,"A_3")
matlab_LL = read(file, "LL")
# matlab_LL2 = read(file, "LL_2")
# matlab_LL3 = read(file, "LL_3")
close(file)
#Note: time and iterations(julia): Minimizing 1429  Time: 0 Time: 0:45:15 ( 1.90  s/it)
file = matopen("test/Experiments/Results/results_ssv_julia_singlemodel.mat")
julia_A = read(file,"A")
# matlab_A2 = read(file,"A_2")
# matlab_A3 = read(file,"A_3")
julia_LL = read(file, "LL")
# matlab_LL2 = read(file, "LL_2")
# matlab_LL3 = read(file, "LL_3")
close(file)

dLL = zeros(Float64,10)
for iter in 1:10
    dLL[iter] = matlab_LL[iter+1725] - matlab_LL[iter+1724]
end
sdll = sum(dLL[10-10+1:10])/10
term = 1e-8
# f = Figure(resolution = (1300, 500))
# #series(f[1,1],s[:,1:100])
# #ax,h = heatmap(f[1,2],A)
# #Colorbar(f[1,3],h)
# lines(f[1,1],julia_LL)
# lines(f[1,2],vec(matlab_LL))


# f