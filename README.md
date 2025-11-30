# Compound-Poisson-R-Shiny
Project Description

This project analyzes a Compound Poisson Process 
𝑆
(
𝑡
)
S(t) where:

The arrival process follows a Poisson(λ) model with exponential interarrival times.

Jump/claim sizes 
𝑋
𝑖
X
i
	​

 are i.i.d. Exponential(μ) random variables.

The aggregate process is defined as

𝑆
(
𝑡
)
=
∑
𝑖
=
1
𝑁
(
𝑡
)
𝑋
𝑖
,
S(t)=
i=1
∑
N(t)
	​

X
i
	​

,

representing the total accumulated claims or jumps by time 
𝑡
t.

Mathematical Framework
Compound Poisson Process Properties

𝑁
(
𝑡
)
∼
Poisson
(
𝜆
𝑡
)
N(t)∼Poisson(λt) — number of arrivals by time 
𝑡
t.

𝑋
𝑖
∼
Exponential
(
𝜇
)
X
i
	​

∼Exponential(μ) — individual claim/jump sizes.

𝑆
(
𝑡
)
S(t) follows a Compound Poisson distribution with:

A point mass at zero: 
𝑃
(
𝑆
(
𝑡
)
=
0
)
=
𝑒
−
𝜆
𝑡
P(S(t)=0)=e
−λt

A continuous density for 
𝑠
>
0
s>0 given by the modified Bessel-function form.

Features

R Shiny Application – Interactive dashboard to visualize the distribution of 
𝑆
(
𝑡
)
S(t).

Time Evolution Analysis – Histograms of 
𝑆
(
𝑡
)
S(t) at

𝑡
=
10
,
 
100
,
 
1000
,
 
10000
t=10, 100, 1000, 10000.

Parameter Sensitivity – Real-time comparison of how different
values of λ and μ affect the shape, mean, and variance of the process.

Theoretical Validation – Overlay of the theoretical PDF vs. Monte Carlo simulation results.

Fully Deployable – Can be hosted on shinyapps.io or any R Shiny server.
