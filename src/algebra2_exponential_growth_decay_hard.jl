# algebra2 - exponential_growth_decay (hard)
# Generated: 2026-03-08T20:19:11.023078

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("algebra2/exponential_growth_decay")
    
    problem_type = choice([
        :compound_interest_solve_time,
        :half_life_remaining,
        :population_growth_rate,
        :exponential_equation_logs,
        :doubling_time_derive,
        :decay_compare_models,
        :continuous_vs_discrete,
        :inverse_exponential_application
    ])
    
    if problem_type == :compound_interest_solve_time
        P = randint(500, 5000)
        A = randint(2, 5) * P
        r = choice([0.045, 0.055, 0.065, 0.072, 0.083, 0.095])
        n = choice([1, 2, 4, 12])
        
        t_exact = log(A/P) / (n * log(1 + r/n))
        t_ans = round(t_exact, digits=2)
        
        freq_name = n == 1 ? "annually" : n == 2 ? "semi-annually" : n == 4 ? "quarterly" : "monthly"
        
        problem(
            question="An investment of \\\$$(P) grows to \\\$$(A) with interest compounded $(freq_name) at $(r*100)% annual rate. How many years does this take? Round to 2 decimal places.",
            answer=t_ans,
            difficulty=(1850, 2050),
            solution=steps(
                "Use compound interest formula: \\\$A = P\\left(1 + \\frac{r}{n}\\right)^{nt}\\\$",
                "Substitute: \\\$$(A) = $(P)\\left(1 + \\frac{$(r)}{$(n)}\\right)^{$(n)t}\\\$",
                "Divide: \\\$\\frac{$(A)}{$(P)} = \\left($(round(1 + r/n, digits=6))\\right)^{$(n)t}\\\$",
                "Take logarithm: \\\$\\ln\\left($(round(A/P, digits=4))\\right) = $(n)t \\cdot \\ln\\left($(round(1 + r/n, digits=6))\\right)\\\$",
                "Solve: \\\$t = \\frac{\\ln($(round(A/P, digits=4)))}{$(n) \\cdot \\ln($(round(1 + r/n, digits=6)))} \\approx $(t_ans)\\\$ years"
            ),
            time=180
        )
        
    elseif problem_type == :half_life_remaining
        half_life = choice([5, 8, 12, 15, 20, 24, 30])
        initial = randint(400, 2000)
        time_elapsed = choice([half_life, 2*half_life, 3*half_life, half_life÷2, 3*half_life÷2])
        
        n_half_lives = time_elapsed / half_life
        remaining = initial * (1//2)^n_half_lives
        
        problem(
            question="A radioactive substance has a half-life of $(half_life) years. If you start with $(initial) grams, how much remains after $(time_elapsed) years?",
            answer=remaining,
            difficulty=(1800, 1950),
            solution=steps(
                "Use decay formula: \\\$N(t) = N_0 \\left(\\frac{1}{2}\\right)^{t/h}\\\$ where \\\$h\\\$ is half-life",
                "Number of half-lives: \\\$\\frac{$(time_elapsed)}{$(half_life)} = $(n_half_lives)\\\$",
                "Calculate: \\\$N($(time_elapsed)) = $(initial) \\cdot \\left(\\frac{1}{2}\\right)^{$(n_half_lives)}\\\$",
                sol("Answer", "$(remaining) grams")
            ),
            time=120
        )
        
    elseif problem_type == :population_growth_rate
        P0 = randint(5000, 25000)
        years = choice([10, 15, 20, 25])
        growth_factor = choice([1.8, 2.0, 2.5, 3.0, 1.5, 2.2])
        Pt = round(Int, P0 * growth_factor)
        
        r_exact = (growth_factor^(1/years) - 1)
        r_percent = round(r_exact * 100, digits=2)
        
        problem(
            question="A town's population grows from $(P0) to $(Pt) in $(years) years. Assuming exponential growth \\\$P(t) = P_0 e^{rt}\\\$, find the annual growth rate \\\$r\\\$ as a percentage. Round to 2 decimal places.",
            answer=r_percent,
            difficulty=(1900, 2100),
            solution=steps(
                "Use \\\$P(t) = P_0 e^{rt}\\\$",
                "Substitute: \\\$$(Pt) = $(P0) e^{$(years)r}\\\$",
                "Divide: \\\$e^{$(years)r} = \\frac{$(Pt)}{$(P0)} = $(round(growth_factor, digits=4))\\\$",
                "Take natural log: \\\$$(years)r = \\ln($(round(growth_factor, digits=4)))\\\$",
                "Solve: \\\$r = \\frac{\\ln($(round(growth_factor, digits=4)))}{$(years)} \\approx $(round(r_exact, digits=4))\\\$",
                sol("Answer", "$(r_percent)% annual growth rate")
            ),
            time=180
        )
        
    elseif problem_type == :exponential_equation_logs
        base = choice([2, 3, 5, 7])
        a = nonzero(-5, 5)
        b = randint(10, 50)
        
        # base^(ax) = b
        # ax = log_base(b)
        # x = log_base(b) / a
        
        x_exact = log(b) / (a * log(base))
        x_ans = round(x_exact, digits=3)
        
        problem(
            question="Solve for \\\$x\\\$: \\\$$(base)^{$(a)x} = $(b)\\\$. Round to 3 decimal places.",
            answer=x_ans,
            difficulty=(1850, 2000),
            solution=steps(
                sol("Given", "$(base)^{$(a)x} = $(b)"),
                "Take logarithm base $(base) of both sides: \\\$$(a)x = \\log_{$(base)}($(b))\\\$",
                "Use change of base: \\\$\\log_{$(base)}($(b)) = \\frac{\\ln($(b))}{\\ln($(base))}\\\$",
                "Solve: \\\$x = \\frac{\\ln($(b))}{$(a) \\cdot \\ln($(base))} \\approx $(x_ans)\\\$"
            ),
            time=150
        )
        
    elseif problem_type == :doubling_time_derive
        r = choice([0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09])
        r_percent = r * 100
        
        doubling_time = log(2) / r
        t_ans = round(doubling_time, digits=2)
        
        problem(
            question="A quantity grows continuously at a rate of $(r_percent)% per year according to \\\$Q(t) = Q_0 e^{rt}\\\$. Find the doubling time in years. Round to 2 decimal places.",
            answer=t_ans,
            difficulty=(1900, 2150),
            solution=steps(
                "Set up doubling condition: \\\$2Q_0 = Q_0 e^{rt}\\\$",
                "Simplify: \\\$2 = e^{rt}\\\$",
                "Take natural log: \\\$\\ln(2) = rt\\\$",
                "Solve for \\\$t\\\$: \\\$t = \\frac{\\ln(2)}{r} = \\frac{\\ln(2)}{$(r)}\\\$",
                sol("Answer", "$(t_ans) years")
            ),
            time=150
        )
        
    elseif problem_type == :decay_compare_models
        initial = randint(800, 2000)
        rate = choice([0.12, 0.15, 0.18, 0.20, 0.25])
        time = choice([5, 6, 8, 10])
        
        discrete = initial * (1 - rate)^time
        continuous = initial * exp(-rate * time)
        
        difference = round(abs(discrete - continuous), digits=2)
        
        problem(
            question="A substance decays at $(rate*100)% per year. Starting with $(initial) grams, find the absolute difference between discrete decay \\\$N(t) = N_0(1-r)^t\\\$ and continuous decay \\\$N(t) = N_0 e^{-rt}\\\$ after $(time) years. Round to 2 decimal places.",
            answer=difference,
            difficulty=(2000, 2250),
            solution=steps(
                "Discrete model: \\\$N_{discrete} = $(initial)(1 - $(rate))^{$(time)} = $(initial)($(1-rate))^{$(time)}\\\$",
                "Calculate discrete: \\\$N_{discrete} \\approx $(round(discrete, digits=2))\\\$ grams",
                "Continuous model: \\\$N_{continuous} = $(initial)e^{-$(rate) \\cdot $(time)} = $(initial)e^{-$(rate*time)}\\\$",
                "Calculate continuous: \\\$N_{continuous} \\approx $(round(continuous, digits=2))\\\$ grams",
                sol("Difference", "|$(round(discrete, digits=2)) - $(round(continuous, digits=2))| = $(difference) grams")
            ),
            time=210
        )
        
    elseif problem_type == :continuous_vs_discrete
        P = randint(1000, 5000)
        r = choice([0.06, 0.08, 0.10, 0.12])
        years = choice([8, 10, 12, 15])
        
        A_continuous = P * exp(r * years)
        A_annual = P * (1 + r)^years
        
        difference = round(A_continuous - A_annual, digits=2)
        
        problem(
            question="Compare \\\$$(P) invested for $(years) years at $(r*100)% interest. How much more does continuous compounding earn versus annual compounding? Round to 2 decimal places.",
            answer=difference,
            difficulty=(1950, 2200),
            solution=steps(
                "Continuous: \\\$A = $(P)e^{$(r) \\cdot $(years)} = $(P)e^{$(r*years)}\\\$",
                "Calculate: \\\$A_{continuous} \\approx \\\$$(round(A_continuous, digits=2))\\\$",
                "Annual: \\\$A = $(P)(1 + $(r))^{$(years)} = $(P)($(1+r))^{$(years)}\\\$",
                "Calculate: \\\$A_{annual} \\approx \\\$$(round(A_annual, digits=2))\\\$",
                sol("Difference", "\\\$$(round(A_continuous, digits=2)) - \\\$$(round(A_annual, digits=2)) = \\\$$(difference)")
            ),
            time=180
        )
        
    else # :inverse_exponential_application
        initial_temp = randint(80, 95)
        room_temp = randint(18, 25)
        k = choice([0.08, 0.10, 0.12, 0.15])
        target_temp = randint(35, 50)
        
        # T(t) = room_temp + (initial_temp - room_temp)*e^(-kt)
        # target_temp = room_temp + (initial_temp - room_temp)*e^(-kt)
        # (target_temp - room_temp)/(initial_temp - room_temp) = e^(-kt)
        
        ratio = (target_temp - room_temp) / (initial_temp - room_temp)
        t_exact = -log(ratio) / k
        t_ans = round(t_exact, digits=2)
        
        problem(
            question="A cup of coffee at $(initial_temp)°C is placed in a room at $(room_temp)°C. Newton's Law of Cooling states \\\$T(t) = T_s + (T_0 - T_s)e^{-kt}\\\$ where \\\$k = $(k)\\\$. How many minutes until the coffee reaches $(target_temp)°C? Round to 2 decimal places.",
            answer=t_ans,
            difficulty=(2100, 2400),
            solution=steps(
                "Use Newton's Law: \\\$T(t) = $(room_temp) + ($(initial_temp) - $(room_temp))e^{-$(k)t}\\\$",
                "Set \\\$T(t) = $(target_temp)\\\$: \\\$$(target_temp) = $(room_temp) + $(initial_temp - room_temp)e^{-$(k)t}\\\$",
                "Isolate exponential: \\\$$(target_temp - room_temp) = $(initial_temp - room_temp)e^{-$(k)t}\\\$",
                "Divide: \\\$e^{-$(k)t} = \\frac{$(target_temp - room_temp)}{$(initial_temp - room_temp)} = $(round(ratio, digits=4))\\\$",
                "Take natural log: \\\$-$(k)t = \\ln($(round(ratio, digits=4)))\\\$",
                sol("Answer", "t = $(t_ans) minutes")
            ),
            time=240
        )
    end
end