module amica
	using Distributions
	using StatsPlots
	using Pkg
	using Plots
	using CairoMakie
	using GaussianMixtures
	using LinearAlgebra

    #Arguments which are passed when amica is used, currently hardcoded
	M = 1 #number of mixture models
	m = 3 #number of source density mixtures
	maxiter = 10 #max iterations
	do_sphere = 2 #what kind of sphering should be performed
	#do_newton
	#As
	#cs
	#Ainit
	#cinit
	#kinit

    #Hardcoded variables
    fix_init = 1
	block_size = 3000

    #initialize parameters
	(n, N) = size(x)
	num_comps = n*M
	eye = Matrix{Float64}(I, n, n) #identity matrix
	A = zeros(n,n*M)
	c = zeros(n,M)
	khinds = fill(0,n,M)
    for h in 1:M
        khinds[:,h] = ((h-1)*n+1):(h*n);
        #A[:,khinds[:,h]] = eye .+ 0.05*(0.5 .- rand(n,n)); #random A
		A = [1 2; 3 4] #fake A zum testen
        #c[:,h] = randn(n,1); #random c
		c[:,h] = [5;6] #fake c zum testen
    end
    for k in 1:num_comps
       #A[:,k] = A[:,k] / norm(A[:,k]); #put back in after removing the fake A
    end
	gm = (1/M)*ones(m,n*M)

    #perform sphering depending on do_sphere input
    if do_sphere == 1
		#remove mean and sphere data
		xmn = mean(x,dims=2)
		for i in 1:n
			x[i,:] = x[i,:] .- xmn[i]
		end
		decomp = svd(x*x'/N) #Ursprünglich Us Ss Vs
        S = decomp.U * diagm(1 ./sqrt.(decomp.S)) * decomp.U' #Diagonal() is more efficient than diagm -> change!
        x_sphered = S*x #just x in original
	elseif do_sphere == 2
		#only remove mean and normalize channels
		xmn = mean(x,dims=2)
		for i in 1:n
			x[i,:] = x[i,:] .- xmn[i]
		end
		S = Diagonal(vec(( 1 ./ sqrt.(var(x',dims=1)))))
		x_sphered = S*x
	elseif do_sphere == 0
		#do not remove mean or sphere
		xmn = mean(x,dims=2)
		for i in 1:n
			x[i,:] = x[i,:] .- xmn[i] #wieso wird der mean hier abgezogen? da steht doch do NOT remove mean...
		end
		S = Matrix{Int}(I, n, n)
	end
	ldetS = log(abs(det(S)))

    alpha = (1/m) * ones(m,n*M)
	
	if fix_init == 1 #fix_init is currently set to 1
	    mu =repeat( ( (1:m)' .-1 .-(m-1)/2 ),n*M)'
	    beta = ones(m,n*M)
	else #todo
	    #if m > 1
	     #   mu = 0.1 * randn(m,n*M);
	    #else
	   #     mu = zeros(m,n*M);
	   # end
	  #  beta = ones(m,n*M) + 0.1 * rand(m,n*M);
	end
	#rho = rho0 * ones(m,n*M);

    #allocate variables
    b = zeros(n,block_size,M)
	g = zeros(n,block_size)

	y = zeros(n,block_size,M)
	fp = zeros(n,block_size)
	Q = zeros(m,block_size)

	#hier fehlt noch das if nargin > 7

	Lt = zeros(M,block_size)
	v = zeros(M,block_size)
	z = zeros(n,block_size,m,M)

	num_blocks = max(1,floor(N / block_size)) #floor rundet zu integer ab

    #Lines 251 - ?

	W = zeros(n,n)#W*S = Unmixing Matrix, S = sphering matrix
	ldet = zeros(1,M)
	LL = zeros(maxiter) #Learning rate
	#iteratively optimize parameters using EM
	for iter in 1:maxiter
		for h in 1:M
			W[:,:,h] = pinv(A[:,khinds[:]]) #pinv = Moore-Penrose Pseudoinverse 
			ldet[h] = log(abs(det(W[:,:,h])))
		end
		
		#Loop over data blocks and accumulate updates
		LL[iter] = 0
		dalpha_numer = zeros(m,num_comps)
    	dalpha_numer = zeros(m,num_comps)
	    dalpha_denom = zeros(m,num_comps)
	    dmu_numer = zeros(m,num_comps)
	    dmu_denom = zeros(m,num_comps)
	    dbeta_numer = zeros(m,num_comps)
	    dbeta_denom = zeros(m,num_comps)
	    drho_numer = zeros(m,num_comps)
	    drho_denom = zeros(m,num_comps)
	
	    vsumsum = zeros(1,M)
	
	    dbaralpha_numer = zeros(m,n,M)
	    dbaralpha_denom = zeros(m,n,M)
	    dlambda_numer = zeros(m,n,M)
	    dlambda_denom = zeros(m,n,M)
	    dsigma2_numer = zeros(n,M)
	    dsigma2_denom = zeros(n,M)
	    dkappa_numer = zeros(m,n,M)
	    dkappa_denom = zeros(m,n,M)
	    Phi = zeros(n,n,M)
	    cnew = zeros(n,M)

		blksize = block_size
		for blk in 1:num_blocks
			xstrt = (blk-1) * block_size + 1
			if blk == num_blocks
				blksize = size(x,2) - xstrt + 1
				println(blk)
			end
			xstp = xstrt + blksize - 1

			#get y,z,Q,Lt
			for h in 1:M
				#Lt[h,1:blksize] .= log(gm[h]) .+ ldet[h] .+ ldetS
				for i in 1:n
					#todo
				end
			end
					



		end

		
	end
end
