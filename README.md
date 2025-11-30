# Compound Poisson Process – R Shiny Application

This project provides an interactive R Shiny application to visualize, simulate, and analyze the Compound Poisson Process:

$$S(t) = \sum_{i=1}^{N(t)} X_i$$

Where:

$N(t) \sim \text{Poisson}(\lambda t)$

$X_i \sim \text{Exponential}(\mu)$

# Project Description

This application demonstrates:

How exponential interarrival times (rate $\lambda$) generate a Poisson($\lambda t$) arrival process.

How exponential jump sizes (rate $\mu$) accumulate into a total claim process.

How changes in parameters affect the distribution of aggregate values $S(t)$.

The tool is designed for simulation, mathematical education, actuarial modeling, and stochastic process visualization.

# Mathematical Framework

Components of the Process

Arrival Process:


$$N(t) \sim \text{Poisson}(\lambda t)$$

Jump Sizes:


$$X_i \sim \text{Exponential}(\mu)$$

Aggregate Process:


$$S(t) = \sum_{i=1}^{N(t)} X_i$$

# Key Properties

1. Point Mass at 0:


$$P(S(t)=0) = e^{-\lambda t}$$

2. Probability Density Function (for $s > 0$):
Using the modified Bessel function of the first kind $I_1(\cdot)$:

$$f_{S(t)}(s) = e^{-\lambda t - \mu s} \, \frac{\sqrt{\lambda \mu t}}{\sqrt{s}} \, I_1\left(2\sqrt{\lambda\mu t s}\right)$$

3. Expected Value:


$$\mathbb{E}[S(t)] = \frac{\lambda t}{\mu}$$

4. Variance:


$$\mathrm{Var}[S(t)] = \lambda t \cdot \frac{2}{\mu^2}$$

# Features

- Interactive Interface: R Shiny App to explore the Compound Poisson process in real time.
- Dynamic Visualization: Histograms of $S(t)$ at $t = 10, 100, 1000, 10000$.

- Parameter Sensitivity: Adjust $\lambda$ and $\mu$ and instantly see the effect on the distribution.

- Theory vs. Simulation: Theoretical PDF overlay for comparison with Monte Carlo simulation.

- Statistical Outputs: Real-time calculation of sample mean/variance vs. theoretical mean/variance.

#  How to Run

Ensure you have R installed.

Install the required packages:

install.packages("shiny")


Run the application:

library(shiny)
runApp("path_to_your_app_folder")


