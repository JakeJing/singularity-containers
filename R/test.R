library(rstan)

databinom = list(N = 50, H = 10)

fit1 = stan(
  file = "binom.stan",  # Stan program
  data = databinom,    # named list of data
  chains = 1,             # number of Markov chains
  warmup = 1000,          # number of warmup iterations per chain
  iter = 2000,            # total number of iterations per chain
  cores = 1,              # number of cores (could use one per chain)
  refresh = 0             # no progress shown
  )
print(fit1)
