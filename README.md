# 📘 Compound Poisson R Shiny

## Project Description
This project analyzes a Compound Poisson Process S(t) where the arrival process follows a Poisson(λ) model with exponential interarrival times, and jump/claim sizes Xᵢ are i.i.d. Exponential(μ) random variables. The aggregate process is:
S(t) = X1 + X2 + ... + X_{N(t)}
representing the total accumulated claims or jumps by time t.

## Mathematical Framework
### Compound Poisson Process Properties
- N(t) ~ Poisson(λt)  — number of arrivals by time t
- Xᵢ ~ Exponential(μ) — individual claim sizes
- S(t) — compound Poisson distribution
## Key Formulas
P(S(t)=0) = exp(-λt)  
E[S(t)] = (λt) / μ  
Var[S(t)] = (2λt) / μ²  

## Density for s > 0
f_S(s) = exp(-λt - μs) * sqrt(λμt / s) * I₁( 2 * sqrt(λμts) )  
(I₁ = Modified Bessel function of the first kind)

## Features
- Interactive R Shiny App to explore S(t)
- Histograms at t = 10, 100, 1000, 10000
- Real-time parameter sensitivity for λ and μ
- Theoretical PDF vs simulated results
- Summary statistics: mean & variance (sample + theoretical)

## How to Run
Open R and run:
library(shiny)
runApp()

