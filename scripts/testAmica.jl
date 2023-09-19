using Amica

x = [1 4; 4 1]*Float64.([1 2 3 4 5 6; 7 8 9 10 11 12])
M = 1 #number of mixture models
m = 3 #number of source density mixtures
maxiter = 55 #max iterations
update_rho = 1
mindll = 1e-8
iterwin = 1 #default should be 50?
do_newton = 1
remove_mean = 1
#---
z, counter, A, Lt, LL = amica(x, M, m, maxiter, update_rho, mindll, iterwin, do_newton, remove_mean)

#---