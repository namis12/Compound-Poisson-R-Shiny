# app.R
# --------------------------------------
# R Shiny app: Compound Poisson process S(t) = sum_{i=1}^{N(t)} X_i
# N(t) ~ Poisson(lambda * t), X_i ~ Exp(mu) i.i.d.

library(shiny)

f_theoretical <- function(s, lambda, mu, t) {
  out <- numeric(length(s))
  pos <- s > 0
  if (any(pos)) {
    arg <- 2 * sqrt(lambda * mu * t * s[pos])
    b   <- besselI(arg, 1)
    out[pos] <- exp(-lambda * t - mu * s[pos]) * sqrt(lambda * mu * t) / sqrt(s[pos]) * b
  }
  out
}

simulate_S <- function(lambda, mu, t, nsim) {
  N <- rpois(nsim, lambda * t)
  S <- sapply(N, function(k) if (k == 0) 0 else sum(rexp(k, rate = mu)))
  S
}

ui <- fluidPage(
  titlePanel("Compound Poisson process S(t) = sum_{i=1}^{N(t)} X_i"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("lambda", "Lambda (arrival rate):", min = 0.01, max = 5, value = 1, step = 0.01),
      sliderInput("mu", "Mu (rate of Exp jumps):", min = 0.01, max = 5, value = 1, step = 0.01),
      selectInput(
        "time_preset", "Choose t preset:",
        choices = c("Custom", "10", "100", "1000", "10000"),
        selected = "Custom"
      ),
      numericInput("t", "Time t:", value = 10, min = 0.1),
      numericInput("nsim", "Number of simulations:", value = 20000, min = 100, step = 100),
      actionButton("resim", "Resimulate")
    ),
    mainPanel(
      plotOutput("histPlot", height = "480px"),
      verbatimTextOutput("stats")
    )
  )
)

server <- function(input, output, session) {
  
  observeEvent(input$time_preset, {
    if (input$time_preset != "Custom") {
      updateNumericInput(session, "t", value = as.numeric(input$time_preset))
    }
  })
  
  sims <- reactiveVal(NULL)
  
  observeEvent(input$resim, {
    sims(simulate_S(input$lambda, input$mu, input$t, input$nsim))
  })
  
  observe({
    if (is.null(sims())) {
      sims(simulate_S(input$lambda, input$mu, input$t, input$nsim))
    }
  })
  
  output$histPlot <- renderPlot({
    S <- sims()
    if (is.null(S)) return()
    lambda <- input$lambda
    mu     <- input$mu
    t      <- input$t
    
    hist(
      S,
      breaks = 100,
      probability = TRUE,
      main = paste0("Histogram of S(t) at t = ", t,
                    " (lambda=", lambda, ", mu=", mu, ")"),
      xlab = "S(t)"
    )
    
    xgrid <- seq(0, max(S) * 1.01, length.out = 1000)
    dens  <- f_theoretical(xgrid, lambda, mu, t)
    lines(xgrid, dens, lwd = 2)
    
    p0   <- exp(-lambda * t)
    ylim <- par("usr")[4]
    points(0, ylim * 0.95, pch = 19)
    text(0, ylim * 0.95, labels = paste0("P(S=0)=", signif(p0, 4)), pos = 4, cex = 0.8)
  })
  
  output$stats <- renderPrint({
    S <- sims()
    if (is.null(S)) return()
    lambda <- input$lambda
    mu     <- input$mu
    t      <- input$t
    
    cat("Monte Carlo (nsim =", length(S), ")\n")
    cat("Sample mean   :", mean(S), "\n")
    cat("Sample var    :", var(S),  "\n\n")
    
    cat("Theoretical:\n")
    cat("P(S=0)        = exp(-lambda * t)       =", exp(-lambda * t), "\n")
    cat("E[S(t)]       = lambda * t / mu        =", lambda * t / mu,  "\n")
    cat("Var[S(t)]     = lambda * t * 2 / mu^2  =", lambda * t * (2 / mu^2), "\n")
  })
}

shinyApp(ui, server)

