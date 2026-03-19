# algebra2 - exponential_growth_decay (very_hard)
# Generated: 2026-03-08T20:19:37.463495

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t n k begin
    set_topic!("algebra2/exponential_growth_decay")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Competition: Multi-stage exponential growth with optimization
        # Two populations growing exponentially, find when ratio reaches a certain value
        P1_0 = randint(500, 2000)
        P2_0 = randint(500, 2000)
        r1 = randint(3, 12) / 100  # growth rate as decimal
        r2 = randint(3, 12) / 100
        
        # Ensure r1 > r2 so P1 eventually dominates
        if r1 <= r2
            r1, r2 = r2, r1
            P1_0, P2_0 = P2_0, P1_0
        end
        
        target_ratio = choice([2, 3, 4, 5])
        
        # P1(t) = P1_0 * e^(r1*t), P2(t) = P2_0 * e^(r2*t)
        # Find t when P1(t)/P2(t) = target_ratio
        # P1_0 * e^(r1*t) / (P2_0 * e^(r2*t)) = target_ratio
        # P1_0 / P2_0 * e^((r1-r2)*t) = target_ratio
        # e^((r1-r2)*t) = target_ratio * P2_0 / P1_0
        # (r1-r2)*t = ln(target_ratio * P2_0 / P1_0)
        
        ans = log(target_ratio * P2_0 / P1_0) / (r1 - r2)
        
        problem(
            question="Two bacterial colonies are growing exponentially. Colony A starts with $(P1_0) bacteria and grows at a continuous rate of $(Int(round(r1*100)))% per hour. Colony B starts with $(P2_0) bacteria and grows at a continuous rate of $(Int(round(r2*100)))% per hour. After how many hours will the population of Colony A be exactly $(target_ratio) times the population of Colony B? Round to two decimal places.",
            answer=round(ans, digits=2),
            difficulty=(2500, 2700),
            solution=steps(
                "Colony A: \\\$P_A(t) = $(P1_0)e^{$(round(r1, digits=4))t}\\\$",
                "Colony B: \\\$P_B(t) = $(P2_0)e^{$(round(r2, digits=4))t}\\\$",
                "Set up equation: \\\$\\frac{P_A(t)}{P_B(t)} = $(target_ratio)\\\$",
                "Substitute: \\\$\\frac{$(P1_0)e^{$(round(r1, digits=4))t}}{$(P2_0)e^{$(round(r2, digits=4))t}} = $(target_ratio)\\\$",
                "Simplify: \\\$\\frac{$(P1_0)}{$(P2_0)}e^{$(round(r1-r2, digits=4))t} = $(target_ratio)\\\$",
                "Take natural log: \\\$$(round(r1-r2, digits=4))t = \\ln\\left(\\frac{$(target_ratio) \\cdot $(P2_0)}{$(P1_0)}\\right)\\\$",
                sol("Answer", round(ans, digits=2))
            ),
            time=240,
            calculator="scientific"
        )
        
    elseif problem_type == 2
        # Olympiad: Compound interest with variable deposits
        # Find when continuously compounded investment with annual deposits reaches a target
        P = randint(5, 20) * 1000  # initial investment
        r = randint(4, 9) / 100  # annual rate
        annual_deposit = randint(1, 5) * 1000
        target = randint(80, 150) * 1000
        
        # A(t) = P*e^(rt) + D*∫[0,t] e^(r(t-s)) ds (continuous deposits)
        # For annual deposits at end of each year:
        # A(n) = P*e^(rn) + D*(e^(r(n-1)) + e^(r(n-2)) + ... + e^0)
        # This is geometric series with ratio e^r
        # Sum = e^0 * (e^(rn) - 1)/(e^r - 1) = (e^(rn) - 1)/(e^r - 1)
        
        # Solve: P*e^(rn) + D*(e^(rn) - 1)/(e^r - 1) = target
        # This requires numerical methods, but we can approximate
        
        # For competition level, simplify to find n such that total ≈ target
        # Use iterative approach or logarithmic approximation
        
        n_years = 1
        while n_years < 50
            val = P * exp(r * n_years) + annual_deposit * (exp(r * n_years) - 1) / (exp(r) - 1)
            if val >= target
                break
            end
            n_years += 1
        end
        
        ans = n_years
        
        problem(
            question="An investment account starts with \\\$$(P) and earns interest at a continuous rate of $(Int(round(r*100)))% per year. At the end of each year, an additional \\\$$(annual_deposit) is deposited. After how many complete years will the account first exceed \\\$$(target)? (Deposits are made at the end of each year, after interest has been compounded.)",
            answer=ans,
            difficulty=(2800, 3100),
            solution=steps(
                "Amount after n years: \\\$A(n) = $(P)e^{$(round(r, digits=3))n} + $(annual_deposit)\\sum_{k=0}^{n-1}e^{$(round(r, digits=3))k}\\\$",
                "Geometric series: \\\$\\sum_{k=0}^{n-1}e^{$(round(r, digits=3))k} = \\frac{e^{$(round(r, digits=3))n}-1}{e^{$(round(r, digits=3))}-1}\\\$",
                "Combined: \\\$A(n) = $(P)e^{$(round(r, digits=3))n} + $(annual_deposit)\\cdot\\frac{e^{$(round(r, digits=3))n}-1}{$(round(exp(r)-1, digits=4))}\\\$",
                "Test values of n until A(n) > $(target)",
                "For n=$(ans-1): A < $(target)",
                "For n=$(ans): A ≥ $(target)",
                sol("Answer", ans)
            ),
            time=300,
            calculator="scientific"
        )
        
    elseif problem_type == 3
        # Competition: Radioactive decay chain problem
        # Substance A decays to B, B decays to C (stable)
        # Find when B is maximized
        N0 = randint(500, 2000)
        lambda1 = randint(2, 8) / 10  # decay constant for A
        lambda2 = randint(1, 6) / 10  # decay constant for B (must be < lambda1)
        
        if lambda2 >= lambda1
            lambda1, lambda2 = lambda2, lambda1
        end
        
        # N_A(t) = N0 * e^(-lambda1*t)
        # N_B(t) = N0 * lambda1/(lambda1-lambda2) * (e^(-lambda2*t) - e^(-lambda1*t))
        # Maximum when dN_B/dt = 0
        # t_max = ln(lambda1/lambda2)/(lambda1-lambda2)
        
        t_max = log(lambda1/lambda2)/(lambda1-lambda2)
        N_B_max = N0 * lambda1/(lambda1-lambda2) * (exp(-lambda2*t_max) - exp(-lambda1*t_max))
        
        problem(
            question="Radioactive isotope A (initial amount $(N0) grams) decays to isotope B with decay constant λ₁ = $(round(lambda1, digits=2)) hr⁻¹. Isotope B decays to stable isotope C with decay constant λ₂ = $(round(lambda2, digits=2)) hr⁻¹. At what time (in hours) does the amount of isotope B reach its maximum? Round to two decimal places.",
            answer=round(t_max, digits=2),
            difficulty=(2600, 2900),
            solution=steps(
                "Amount of A: \\\$N_A(t) = $(N0)e^{-$(round(lambda1, digits=2))t}\\\$",
                "Amount of B: \\\$N_B(t) = $(N0)\\cdot\\frac{$(round(lambda1, digits=2))}{$(round(lambda1-lambda2, digits=3))}\\left(e^{-$(round(lambda2, digits=2))t} - e^{-$(round(lambda1, digits=2))t}\\right)\\\$",
                "To find maximum, set \\\$\\frac{dN_B}{dt} = 0\\\$",
                "This gives: \\\$-$(round(lambda2, digits=2))e^{-$(round(lambda2, digits=2))t} + $(round(lambda1, digits=2))e^{-$(round(lambda1, digits=2))t} = 0\\\$",
                "Solve: \\\$e^{-$(round(lambda2, digits=2))t} = \\frac{$(round(lambda1, digits=2))}{$(round(lambda2, digits=2))}e^{-$(round(lambda1, digits=2))t}\\\$",
                "Taking logarithms: \\\$t = \\frac{\\ln($(round(lambda1/lambda2, digits=3)))}{$(round(lambda1-lambda2, digits=3))}\\\$",
                sol("Answer", round(t_max, digits=2))
            ),
            time=270,
            calculator="scientific"
        )
        
    elseif problem_type == 4
        # Olympiad: Mixing problem with exponential approach
        # Tank with salt solution, pure water flows in and mixed solution flows out
        # Find when concentration reaches specific level
        V = randint(500, 1500)  # volume in liters
        C0 = randint(5, 15)  # initial concentration kg/L
        flow_rate = randint(10, 30)  # L/min
        target_conc = randint(1, 4)  # target concentration
        
        # C(t) = C0 * e^(-rt/V) where r is flow rate
        # Solve for t when C(t) = target_conc
        # target_conc = C0 * e^(-rt/V)
        # ln(target_conc/C0) = -rt/V
        # t = -V/r * ln(target_conc/C0)
        
        if target_conc >= C0
            target_conc = C0 // 2
        end
        
        ans = -V/flow_rate * log(target_conc/C0)
        
        problem(
            question="A tank contains $(V) liters of brine with $(C0) kg of salt per liter. Pure water flows into the tank at $(flow_rate) liters per minute, and the well-stirred mixture flows out at the same rate. How many minutes will it take for the salt concentration to drop to $(target_conc) kg/L? Round to the nearest minute.",
            answer=round(Int, ans),
            difficulty=(2700, 3000),
            solution=steps(
                "Let C(t) be concentration at time t",
                "Rate of salt change: \\\$\\frac{dS}{dt} = -$(flow_rate)C(t)\\\$ where S is total salt",
                "Since S = V·C: \\\$V\\frac{dC}{dt} = -$(flow_rate)C\\\$",
                "Differential equation: \\\$\\frac{dC}{dt} = -\\frac{$(flow_rate)}{$(V)}C\\\$",
                "Solution: \\\$C(t) = $(C0)e^{-$(round(flow_rate/V, digits=5))t}\\\$",
                "Set C(t) = $(target_conc): \\\$$(target_conc) = $(C0)e^{-$(round(flow_rate/V, digits=5))t}\\\$",
                "Solve: \\\$t = -\\frac{$(V)}{$(flow_rate)}\\ln\\left(\\frac{$(target_conc)}{$(C0)}\\right)\\\$",
                sol("Answer", round(Int, ans))
            ),
            time=300,
            calculator="scientific"
        )
        
    else
        # Competition: Newton's Law of Cooling with twist
        # Object cooling in changing ambient temperature
        T0 = randint(80, 100)  # initial temp in °C
        T_amb_start = randint(15, 25)  # ambient temp
        k = randint(1, 4) / 100  # cooling constant
        time_point = randint(20, 40)  # time to evaluate
        
        # Standard Newton cooling: T(t) = T_amb + (T0 - T_amb)*e^(-kt)
        temp_at_time = T_amb_start + (T0 - T_amb_start) * exp(-k * time_point)
        
        # Find when temperature reaches halfway between initial and ambient
        target_temp = (T0 + T_amb_start) / 2
        ans = -log((target_temp - T_amb_start)/(T0 - T_amb_start)) / k
        
        problem(
            question="A hot object at $(T0)°C is placed in a room at constant temperature $(T_amb_start)°C. The object cools according to Newton's Law of Cooling with constant k = $(round(k, digits=3)) min⁻¹. How many minutes will it take for the object's temperature to reach $(round(target_temp, digits=1))°C? Round to one decimal place.",
            answer=round(ans, digits=1),
            difficulty=(2500, 2800),
            solution=steps(
                "Newton's Law: \\\$T(t) = T_{\\text{amb}} + (T_0 - T_{\\text{amb}})e^{-kt}\\\$",
                "Substitute values: \\\$T(t) = $(T_amb_start) + $(T0 - T_amb_start)e^{-$(round(k, digits=3))t}\\\$",
                "Set T(t) = $(round(target_temp, digits=1)): \\\$$(round(target_temp, digits=1)) = $(T_amb_start) + $(T0 - T_amb_start)e^{-$(round(k, digits=3))t}\\\$",
                "Isolate exponential: \\\$e^{-$(round(k, digits=3))t} = \\frac{$(round(target_temp - T_amb_start, digits=1))}{$(T0 - T_amb_start)}\\\$",
                "Take natural log: \\\$-$(round(k, digits=3))t = \\ln\\left(\\frac{$(round(target_temp - T_amb_start, digits=1))}{$(T0 - T_amb_start)}\\right)\\\$",
                "Solve for t: \\\$t = -\\frac{1}{$(round(k, digits=3))}\\ln\\left(\\frac{$(round(target_temp - T_amb_start, digits=1))}{$(T0 - T_amb_start)}\\right)\\\$",
                sol("Answer", round(ans, digits=1))
            ),
            time=300,
            calculator="scientific"
        )
    end
end
