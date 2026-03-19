# algebra2 - exponential_growth_decay (medium)
# Generated: 2026-03-08T20:18:53.563798

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("algebra2/exponential_growth_decay")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Exponential growth: population/bacteria/investment
        context = choice(["bacteria", "population", "investment"])
        
        if context == "bacteria"
            initial = randint(100, 2000)
            growth_rate = choice([0.05, 0.08, 0.10, 0.12, 0.15, 0.20, 0.25])
            time_val = randint(3, 12)
            
            final_amount = round(Int, initial * (1 + growth_rate)^time_val)
            
            problem(
                question="A bacteria culture starts with $(initial) bacteria and grows at a rate of $(round(Int, growth_rate*100))% per hour. How many bacteria will there be after $(time_val) hours? Round to the nearest whole number.",
                answer=final_amount,
                difficulty=(1200, 1400),
                solution=steps(
                    "Use exponential growth formula: \$N(t) = N_0(1 + r)^t\$",
                    sol("Substitute values", "N($(time_val)) = $(initial)(1 + $(growth_rate))^{$(time_val)}"),
                    sol("Calculate", "N($(time_val)) = $(initial)($(1 + growth_rate))^{$(time_val)} = $(final_amount)"),
                    "After $(time_val) hours, there are $(final_amount) bacteria"
                ),
                time=120
            )
            
        elseif context == "population"
            initial = randint(5000, 50000)
            growth_rate = choice([0.02, 0.03, 0.04, 0.05, 0.06])
            time_val = randint(5, 20)
            
            final_amount = round(Int, initial * (1 + growth_rate)^time_val)
            
            problem(
                question="A city has a population of $(initial) and grows at $(round(Int, growth_rate*100))% per year. What will the population be after $(time_val) years? Round to the nearest whole number.",
                answer=final_amount,
                difficulty=(1200, 1400),
                solution=steps(
                    "Use exponential growth formula: \$P(t) = P_0(1 + r)^t\$",
                    sol("Substitute", "P($(time_val)) = $(initial)(1.0$(lpad(round(Int, growth_rate*100), 2, '0')))^{$(time_val)}"),
                    sol("Calculate", "P($(time_val)) = $(final_amount)"),
                    "The population after $(time_val) years is $(final_amount)"
                ),
                time=120
            )
            
        else  # investment
            initial = randint(1000, 10000)
            rate = choice([0.03, 0.04, 0.05, 0.06, 0.07, 0.08])
            time_val = randint(5, 15)
            
            final_amount = round(initial * (1 + rate)^time_val, digits=2)
            
            problem(
                question="An investment of \\\$$(initial) grows at $(round(Int, rate*100))% per year, compounded annually. What is the value after $(time_val) years? Round to the nearest cent.",
                answer=final_amount,
                difficulty=(1200, 1400),
                solution=steps(
                    "Use compound interest formula: \$A = P(1 + r)^t\$",
                    sol("Substitute", "A = $(initial)(1 + $(rate))^{$(time_val)}"),
                    sol("Calculate", "A = $(initial)($(1 + rate))^{$(time_val)} \\approx $(final_amount)"),
                    "The investment is worth \\\$$(final_amount) after $(time_val) years"
                ),
                time=120
            )
        end
        
    elseif problem_type == 2
        # Exponential decay: radioactive/depreciation/medicine
        context = choice(["radioactive", "car", "medicine"])
        
        if context == "radioactive"
            initial = randint(100, 500)
            half_life = choice([2, 3, 4, 5, 6, 8, 10])
            time_val = randint(2, 5) * half_life
            
            remaining = initial * (0.5)^(time_val / half_life)
            
            problem(
                question="A radioactive substance has a half-life of $(half_life) years. If you start with $(initial) grams, how much remains after $(time_val) years?",
                answer=remaining,
                difficulty=(1300, 1500),
                solution=steps(
                    "Use half-life formula: \$N(t) = N_0 \\left(\\frac{1}{2}\\right)^{t/h}\$",
                    sol("Substitute", "N($(time_val)) = $(initial)\\left(\\frac{1}{2}\\right)^{$(time_val)/$(half_life)}"),
                    sol("Calculate", "N($(time_val)) = $(initial)\\left(\\frac{1}{2}\\right)^{$(div(time_val, half_life))} = $(remaining)"),
                    "After $(time_val) years, $(remaining) grams remain"
                ),
                time=150
            )
            
        elseif context == "car"
            initial = randint(15000, 40000)
            decay_rate = choice([0.12, 0.15, 0.18, 0.20, 0.25])
            time_val = randint(3, 8)
            
            final_value = round(initial * (1 - decay_rate)^time_val, digits=2)
            
            problem(
                question="A car purchased for \\\$$(initial) depreciates at $(round(Int, decay_rate*100))% per year. What is its value after $(time_val) years? Round to the nearest cent.",
                answer=final_value,
                difficulty=(1300, 1500),
                solution=steps(
                    "Use exponential decay formula: \$V(t) = V_0(1 - r)^t\$",
                    sol("Substitute", "V($(time_val)) = $(initial)(1 - $(decay_rate))^{$(time_val)}"),
                    sol("Calculate", "V($(time_val)) = $(initial)($(1 - decay_rate))^{$(time_val)} \\approx $(final_value)"),
                    "The car's value after $(time_val) years is \\\$$(final_value)"
                ),
                time=150
            )
            
        else  # medicine
            initial = randint(100, 800)
            half_life = choice([2, 3, 4, 6, 8])
            time_val = randint(1, 3) * half_life
            
            remaining = initial * (0.5)^(time_val / half_life)
            
            problem(
                question="A medication has a half-life of $(half_life) hours in the body. If $(initial) mg is administered, how much remains after $(time_val) hours?",
                answer=remaining,
                difficulty=(1300, 1500),
                solution=steps(
                    "Use half-life decay: \$A(t) = A_0 \\left(\\frac{1}{2}\\right)^{t/h}\$",
                    sol("Substitute", "A($(time_val)) = $(initial)\\left(\\frac{1}{2}\\right)^{$(time_val)/$(half_life)}"),
                    sol("Calculate", "A($(time_val)) = $(initial) \\cdot \\frac{1}{$(2^div(time_val, half_life))} = $(remaining)"),
                    "After $(time_val) hours, $(remaining) mg remain in the body"
                ),
                time=150
            )
        end
        
    elseif problem_type == 3
        # Solve for time given initial and final amounts
        initial = randint(1000, 5000)
        rate = choice([0.04, 0.05, 0.06, 0.08, 0.10])
        time_val = randint(5, 15)
        final_amount = round(Int, initial * (1 + rate)^time_val)
        
        problem(
            question="An investment of \\\$$(initial) grows at $(round(Int, rate*100))% per year. How many years will it take to reach \\\$$(final_amount)? Round to the nearest year.",
            answer=time_val,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Set up equation", "$(final_amount) = $(initial)(1 + $(rate))^t"),
                sol("Divide both sides", "\\frac{$(final_amount)}{$(initial)} = ($(1 + rate))^t"),
                sol("Take logarithm", "t = \\frac{\\log($(final_amount/initial))}{\\log($(1 + rate))} \\approx $(time_val)"),
                "It takes approximately $(time_val) years"
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Continuous growth: A = Pe^(rt)
        initial = randint(1000, 8000)
        rate = choice([0.03, 0.04, 0.05, 0.06, 0.07])
        time_val = randint(5, 15)
        
        e_val = 2.71828
        final_amount = round(initial * e_val^(rate * time_val), digits=2)
        
        problem(
            question="An investment of \\\$$(initial) grows continuously at $(round(Int, rate*100))% per year. What is the value after $(time_val) years? Use \$e \\approx 2.71828\$ and round to the nearest cent.",
            answer=final_amount,
            difficulty=(1500, 1700),
            solution=steps(
                "Use continuous growth formula: \$A = Pe^{rt}\$",
                sol("Substitute", "A = $(initial)e^{$(rate) \\cdot $(time_val)}"),
                sol("Calculate exponent", "A = $(initial)e^{$(rate * time_val)} \\approx $(initial)($(round(e_val^(rate * time_val), digits=5)))"),
                sol("Final answer", "A \\approx $(final_amount)"),
                "The investment is worth \\\$$(final_amount)"
            ),
            time=180
        )
        
    else  # problem_type == 5
        # Word problem: find growth/decay rate
        initial = randint(2000, 10000)
        time_val = randint(5, 12)
        multiplier = choice([2, 3, 4])
        final_amount = initial * multiplier
        
        # Solve for r: final = initial(1 + r)^t
        # multiplier = (1 + r)^t
        # r = multiplier^(1/t) - 1
        rate = round((multiplier^(1/time_val) - 1) * 100, digits=2)
        
        problem(
            question="A population grows from $(initial) to $(final_amount) in $(time_val) years. What is the annual growth rate as a percentage? Round to two decimal places.",
            answer=rate,
            difficulty=(1600, 1800),
            solution=steps(
                sol("Set up equation", "$(final_amount) = $(initial)(1 + r)^{$(time_val)}"),
                sol("Divide both sides", "$(multiplier) = (1 + r)^{$(time_val)}"),
                sol("Take $(time_val)-th root", "1 + r = $(multiplier)^{1/$(time_val)} \\approx $(round(multiplier^(1/time_val), digits=5))"),
                sol("Solve for r", "r \\approx $(round(multiplier^(1/time_val) - 1, digits=5)) = $(rate)\\%"),
                "The annual growth rate is approximately $(rate)%"
            ),
            time=200
        )
    end
end