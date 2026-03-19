# algebra2 - exponential_growth_decay (easy)
# Generated: 2026-03-08T20:18:42.979632

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("algebra2/exponential_growth_decay")
    
    problem_type = choice([:growth_formula, :decay_formula, :half_life, :doubling_time, :compound_interest, :population_growth, :radioactive_decay, :bacteria_growth, :depreciation, :continuous_growth])
    
    if problem_type == :growth_formula
        # Simple exponential growth: P(t) = P0 * r^t, find P(t)
        P0 = randint(100, 1000)
        r = choice([2, 3, 1.5, 2.5, 1.2, 1.1])
        time_val = randint(2, 6)
        ans = P0 * r^time_val
        
        problem(
            question="A population starts at $(P0) and grows according to P(t) = $(P0) \\cdot $(r)^t. Find P($(time_val)).",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Given: P(t) = $(P0) \\cdot $(r)^t",
                "Substitute t = $(time_val)",
                sol("P($(time_val))", P0 * r^time_val)
            ),
            time=60
        )
        
    elseif problem_type == :decay_formula
        # Simple exponential decay: A(t) = A0 * (1/2)^t, find A(t)
        A0 = randint(800, 3200)
        time_val = randint(2, 5)
        ans = A0 // 2^time_val
        
        problem(
            question="A substance decays according to A(t) = $(A0) \\cdot \\left(\\frac{1}{2}\\right)^t. Find A($(time_val)).",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Given: A(t) = $(A0) \\cdot \\left(\\frac{1}{2}\\right)^$(time_val)",
                "Evaluate the exponent",
                sol("A($(time_val))", ans)
            ),
            time=60
        )
        
    elseif problem_type == :half_life
        # Find remaining amount after n half-lives
        initial = randint(400, 1600)
        half_life = choice([2, 3, 4, 5, 6])
        elapsed = half_life * randint(2, 4)
        n_half_lives = elapsed ÷ half_life
        ans = initial // 2^n_half_lives
        
        problem(
            question="A radioactive substance has a half-life of $(half_life) years. If you start with $(initial) grams, how much remains after $(elapsed) years?",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                "Number of half-lives: $(elapsed) ÷ $(half_life) = $(n_half_lives)",
                "Amount remaining: $(initial) \\cdot \\left(\\frac{1}{2}\\right)^$(n_half_lives)",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == :doubling_time
        # Find amount after n doubling times
        initial = randint(50, 200)
        doubling_time = choice([2, 3, 4, 5])
        elapsed = doubling_time * randint(2, 4)
        n_doublings = elapsed ÷ doubling_time
        ans = initial * 2^n_doublings
        
        problem(
            question="A bacteria population doubles every $(doubling_time) hours. If the initial population is $(initial), what is the population after $(elapsed) hours?",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                "Number of doublings: $(elapsed) ÷ $(doubling_time) = $(n_doublings)",
                "Population: $(initial) \\cdot 2^$(n_doublings)",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == :compound_interest
        # Simple compound interest A = P(1+r)^t
        P = randint(1000, 5000)
        r_percent = choice([5, 10, 15, 20])
        r = r_percent // 100
        time_val = randint(2, 4)
        multiplier = (100 + r_percent) // 100
        ans = P * multiplier^time_val
        
        problem(
            question="An investment of \\\$$(P) grows at $(r_percent)% per year, compounded annually. What is the value after $(time_val) years?",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "Formula: A = P(1 + r)^t",
                "A = $(P) \\cdot \\left(\\frac{$(100 + r_percent)}{100}\\right)^$(time_val)",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == :population_growth
        # P(t) = P0 * (1 + r)^t, solve for t
        P0 = randint(100, 500)
        r_percent = choice([10, 20, 25, 50])
        multiplier = (100 + r_percent) // 100
        time_val = randint(2, 4)
        final_pop = P0 * multiplier^time_val
        
        problem(
            question="A town's population grows at $(r_percent)% per year. If the current population is $(P0), what will it be in $(time_val) years?",
            answer=final_pop,
            difficulty=(800, 1000),
            solution=steps(
                "Growth rate: r = $(r_percent)% = $(r_percent//100)",
                "P($(time_val)) = $(P0) \\cdot \\left(1 + \\frac{$(r_percent)}{100}\\right)^$(time_val)",
                sol("Answer", final_pop)
            ),
            time=90
        )
        
    elseif problem_type == :radioactive_decay
        # A = A0 * (1 - r)^t, find remaining amount
        A0 = randint(500, 2000)
        decay_percent = choice([10, 20, 25, 50])
        multiplier = (100 - decay_percent) // 100
        time_val = randint(2, 3)
        ans = A0 * multiplier^time_val
        
        problem(
            question="A radioactive element decays at $(decay_percent)% per year. Starting with $(A0) grams, how much remains after $(time_val) years?",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "Decay formula: A = A_0(1 - r)^t",
                "A = $(A0) \\cdot \\left(\\frac{$(100 - decay_percent)}{100}\\right)^$(time_val)",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == :bacteria_growth
        # Exponential growth with specific rate
        initial = randint(100, 500)
        rate = choice([2, 3, 4])
        time_val = randint(3, 5)
        ans = initial * rate^time_val
        
        problem(
            question="A bacteria culture triples every hour. If there are initially $(initial) bacteria, how many are there after $(time_val) hours?",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Growth factor: 3 per hour",
                "After $(time_val) hours: $(initial) \\cdot 3^$(time_val)",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == :depreciation
        # Car value depreciation
        initial_value = randint(15000, 30000)
        depreciation_percent = choice([10, 15, 20])
        years = randint(2, 4)
        multiplier = (100 - depreciation_percent) // 100
        ans = initial_value * multiplier^years
        
        problem(
            question="A car worth \\\$$(initial_value) depreciates at $(depreciation_percent)% per year. What is its value after $(years) years?",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "Depreciation formula: V = V_0(1 - r)^t",
                "V = $(initial_value) \\cdot \\left(\\frac{$(100 - depreciation_percent)}{100}\\right)^$(years)",
                sol("Answer", ans)
            ),
            time=120
        )
        
    else  # continuous_growth
        # Simple continuous growth problem A = A0 * e^(kt), with nice values
        A0 = randint(100, 500)
        k = choice([1, 2])
        time_val = choice([1, 2])
        # For simple problems, we'll just compute numerically
        e_val = choice([2.718, 7.389, 20.086])  # e^1, e^2, e^3 approximately
        kt = k * time_val
        
        if kt == 1
            multiplier = 2.718
        elseif kt == 2
            multiplier = 7.389
        elseif kt == 3
            multiplier = 20.086
        else
            multiplier = 2.718^kt
        end
        
        ans = round(Int, A0 * multiplier)
        
        problem(
            question="A population grows continuously at rate k = $(k). If P(0) = $(A0), find P($(time_val)) using P(t) = P_0 e^{kt}. Round to the nearest whole number.",
            answer=ans,
            difficulty=(1000, 1200),
            solution=steps(
                "Given: P(t) = $(A0)e^{$(k)t}",
                "P($(time_val)) = $(A0)e^{$(kt)} ≈ $(A0) \\cdot $(round(multiplier, digits=3))",
                sol("Answer", ans)
            ),
            time=120,
            calculator="scientific"
        )
    end
end