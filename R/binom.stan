data{
int N; // number of observations
int H; // number of observed head
}
parameters{
real<lower=0, upper=1> p; // parameter for binomial distribution
}
model{
p ~ uniform(0, 1);
H ~ binomial(N, p); // likelihood func
}
