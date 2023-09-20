#import Amica
#using Amica
using CairoMakie
#using MAT
#using LinearAlgebra
#using GaussianMixtures
# using Distributions: mean
# using TransferEntropy
#using SpecialFunctions
#using ComponentArrays
#using Diagonalizations

ml_m1_1t = 246.8946/100
ml_m2_1t = 496.0950/100
ml_m4_1t = 988.3812/100
#ml_m10_1t = 0
ml_1t = [ml_m1_1t, ml_m2_1t, ml_m4_1t]

ml_m1_64t = 125.1965/100
ml_m2_64t = 275.0308/100
ml_m4_64t = 561.6809/100
#ml_m10_64t = 1.3560*1000
ml_64t = [ml_m1_64t, ml_m2_64t, ml_m4_64t]

j_m1_1t = 203/100
j_m2_1t = 411/100
j_m4_1t = 813.351843/100
#j_m10_1t = 0
j_1t = [j_m1_1t, j_m2_1t, j_m4_1t]

j_m1_64t = 190.505351/100
j_m2_64t = 406.222596/100
j_m4_64t = 812.646886/100
#j_m10_64t = 0
j_64t = [j_m1_64t, j_m2_64t, j_m4_64t]

f_m1_1t = (26.546+27.321+27.157)/3/100
f_m2_1t = (53.813 +52.714+53.446)/3/100
f_m4_1t = (106.607+ 105.816+ 106.050)/3/100
#f_m10_1t = 0
f_1t = [f_m1_1t, f_m2_1t, f_m4_1t]

f_m1_64t = (31.557 + 31.523 + 31.469)/3/100
f_m2_64t = (62.310 + 62.032 +62.420)/3/100
f_m4_64t = (122.536 + 121.552 + 122.128)/3/100
#f_m10_64t = 0
f_64t = [f_m1_64t, f_m2_64t, f_m4_64t]

#-----
f= Figure()
xs = [1,2,4]
ax = Axis(f[1, 1], xlabel = "Number of models", ylabel = "Time (s/iteration)", title = "Single Thread")
sca = scatter!(xs, ml_1t, color = :red)
sca2 = scatter!(xs, j_1t, color = :blue)
sca3 = scatter!(xs, f_1t, color = :green)

Legend(f[1, 2],
    [sca, sca2, sca3],
    ["MATLAB", "Julia", "Fortran"])
f
#-----
f2= Figure()
xs = [1,2,4]
ax = Axis(f2[1, 1], xlabel = "Number of models", ylabel = "Time (s/iteration)", title = "64 Threads")
sca4 = scatter!(xs, ml_64t, color = :red)
sca5 = scatter!(xs, j_64t, color = :blue)
sca6 = scatter!(xs, f_64t, color = :green)

Legend(f2[1, 2],
    [sca4, sca5, sca6],
    ["MATLAB", "Julia", "Fortran"])
f2
#------
