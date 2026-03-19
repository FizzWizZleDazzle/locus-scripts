# arithmetic - ratios_proportions (hard)
# Generated: 2026-03-08T19:51:58.116990

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("arithmetic/ratios_proportions")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Complex mixture/alligation problem
        conc1 = randint(10, 40)
        conc2 = randint(50, 90)
        while abs(conc2 - conc1) < 20
            conc2 = randint(50, 90)
        end
        target = randint(conc1 + 5, conc2 - 5)
        
        # Using alligation: ratio = (conc2 - target) : (target - conc1)
        diff1 = conc2 - target
        diff2 = target - conc1
        g = gcd(diff1, diff2)
        ratio1 = diff1 ÷ g
        ratio2 = diff2 ÷ g
        
        total_parts = ratio1 + ratio2
        total_volume = choice([100, 120, 150, 180, 200, 240, 300])
        
        vol1 = (total_volume * ratio1) // total_parts
        vol2 = (total_volume * ratio2) // total_parts
        
        problem(
            question="A chemist needs to create $(total_volume) mL of a $(target)% acid solution by mixing a $(conc1)% acid solution with a $(conc2)% acid solution. How many mL of the $(conc1)% solution should be used?",
            answer=vol1,
            difficulty=(1900, 2200),
            solution=steps(
                "Let x = volume of $(conc1)% solution, then $(total_volume) - x = volume of $(conc2)% solution",
                sol("Equation", "$(conc1//100)*x + $(conc2//100)*($(total_volume) - x) = $(target//100)*$(total_volume)"),
                "By alligation method: ratio = ($(conc2) - $(target)) : ($(target) - $(conc1)) = $(diff1) : $(diff2) = $(ratio1) : $(ratio2)",
                sol("Volume of $(conc1)% solution", "$(total_volume) × $(ratio1)/($(ratio1) + $(ratio2)) = $(vol1) mL")
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Multi-step ratio problem with scaling
        a = randint(3, 8)
        b = randint(3, 8)
        c = randint(3, 8)
        while gcd(gcd(a, b), c) > 1
            a = randint(3, 8)
            b = randint(3, 8)
            c = randint(3, 8)
        end
        
        multiplier = randint(4, 12)
        total = multiplier * (a + b + c)
        
        # Add a constraint
        constraint_val = multiplier * choice([a, b, c])
        constraint_var = constraint_val == multiplier * a ? "A" : (constraint_val == multiplier * b ? "B" : "C")
        
        ans_A = multiplier * a
        ans_B = multiplier * b
        ans_C = multiplier * c
        
        problem(
            question="Three partners A, B, and C share profits in the ratio $(a):$(b):$(c). If the total profit is \\\$$(total) and partner $(constraint_var) receives \\\$$(constraint_val), find the amounts received by all three partners (in the order A, B, C).",
            answer=fmt_tuple((ans_A, ans_B, ans_C)),
            difficulty=(1800, 2100),
            answer_type="tuple",
            solution=steps(
                "Given ratio A:B:C = $(a):$(b):$(c), total parts = $(a + b + c)",
                "Verify: Partner $(constraint_var) should get $(constraint_val) ÷ (total/parts) = $(constraint_val) ÷ $(total÷(a+b+c)) = $(multiplier) parts",
                sol("Partner A", "$(total) × $(a)/($(a+b+c)) = \\\$$(ans_A)"),
                sol("Partner B", "$(total) × $(b)/($(a+b+c)) = \\\$$(ans_B)"),
                sol("Partner C", "$(total) × $(c)/($(a+b+c)) = \\\$$(ans_C)")
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Inverse proportion with work/time
        workers1 = randint(4, 12)
        days1 = randint(6, 20)
        workers2 = randint(4, 12)
        while workers2 == workers1
            workers2 = randint(4, 12)
        end
        
        # Work = workers × days (constant)
        work = workers1 * days1
        days2 = work // workers2
        
        # Add complexity: some workers leave
        workers_leave = randint(1, workers1 - 2)
        remaining = workers1 - workers_leave
        days_remaining = work // remaining
        
        problem(
            question="If $(workers1) workers can complete a project in $(days1) days, how many days would it take for $(remaining) workers to complete the same project? (Assume all workers work at the same rate.)",
            answer=days_remaining,
            difficulty=(1850, 2150),
            solution=steps(
                "Total work = workers × days = $(workers1) × $(days1) = $(work) worker-days",
                "For inverse proportion: W₁ × D₁ = W₂ × D₂",
                sol("With $(remaining) workers", "$(remaining) × D = $(work)"),
                sol("Days required", "D = $(work) ÷ $(remaining) = $(days_remaining) days")
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Compound ratio problem
        a1 = randint(2, 7)
        b1 = randint(2, 7)
        a2 = randint(2, 7)
        b2 = randint(2, 7)
        while gcd(a1, b1) > 1 || gcd(a2, b2) > 1
            a1 = randint(2, 7)
            b1 = randint(2, 7)
            a2 = randint(2, 7)
            b2 = randint(2, 7)
        end
        
        compound_num = a1 * a2
        compound_den = b1 * b2
        g = gcd(compound_num, compound_den)
        simple_num = compound_num ÷ g
        simple_den = compound_den ÷ g
        
        total_quantity = simple_num + simple_den
        scale = randint(5, 15)
        actual_total = total_quantity * scale
        
        ans = simple_num * scale
        
        problem(
            question="The ratio of boys to girls in School A is $(a1):$(b1), and the ratio of boys to girls in School B is $(a2):$(b2). If we combine both schools and they have the same number of students, what is the simplified overall ratio of boys to girls? If the combined total is $(actual_total) students, how many are boys?",
            answer=ans,
            difficulty=(2000, 2400),
            solution=steps(
                "Assuming equal students from each school, compound ratio of boys to girls:",
                sol("Compound ratio", "($(a1) × $(a2)) : ($(b1) × $(b2)) = $(compound_num) : $(compound_den)"),
                sol("Simplified", "$(simple_num) : $(simple_den) (dividing by $(g))"),
                "Total parts = $(simple_num) + $(simple_den) = $(total_quantity)",
                sol("Number of boys", "$(actual_total) × $(simple_num)/$(total_quantity) = $(ans)")
            ),
            time=210
        )
        
    else
        # Proportional division with remainder
        a = randint(3, 9)
        b = randint(3, 9)
        c = randint(3, 9)
        while gcd(gcd(a, b), c) > 1
            a = randint(3, 9)
            b = randint(3, 9)
            c = randint(3, 9)
        end
        
        base_total = a + b + c
        multiplier = randint(8, 20)
        amount = base_total * multiplier + randint(1, base_total - 1)
        
        remainder = amount % base_total
        divisible_part = amount - remainder
        
        share_a = (divisible_part * a) ÷ base_total
        share_b = (divisible_part * b) ÷ base_total
        share_c = (divisible_part * c) ÷ base_total + remainder
        
        problem(
            question="Divide \\\$$(amount) among three people A, B, and C in the ratio $(a):$(b):$(c). If any amount cannot be divided evenly, give the remainder to person C. How much does person B receive?",
            answer=share_b,
            difficulty=(1900, 2250),
            solution=steps(
                "Total ratio parts = $(a) + $(b) + $(c) = $(base_total)",
                "Amount ÷ parts = $(amount) ÷ $(base_total) = $(divisible_part) with remainder $(remainder)",
                sol("Person A", "$(divisible_part) × $(a)/$(base_total) = \\\$$(share_a)"),
                sol("Person B", "$(divisible_part) × $(b)/$(base_total) = \\\$$(share_b)"),
                sol("Person C", "$(divisible_part) × $(c)/$(base_total) + $(remainder) = \\\$$(share_c)")
            ),
            time=180
        )
    end
end