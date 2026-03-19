# algebra1 - systems_substitution (very_easy)
# Generated: 2026-03-08T19:57:10.717555

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/systems_substitution")
    
    # Target: FOUNDATIONAL/ELEMENTARY (100-700 ELO)
    # For this range, keep systems very simple with integer solutions
    
    difficulty_level = rand(1:3)
    
    if difficulty_level == 1
        # ELO 200-400: Very basic, x already isolated
        # Start with answer
        x_val = randint(-8, 8)
        y_val = randint(-8, 8)
        
        # First equation: x = [value]
        # Second equation: simple like y = 2x + b or ax + y = c
        
        if rand(Bool)
            # x = x_val, y = mx + b form
            m = nonzero(-4, 4)
            b = y_val - m * x_val
            
            problem(
                question = "Solve the system using substitution:\n\$\$\\begin{cases} x = $(x_val) \\\\ y = $(m)x + $(b) \\end{cases}\$\$",
                answer = fmt_tuple((x_val, y_val)),
                difficulty = (200, 400),
                answer_type = "tuple",
                solution = steps(
                    "From the first equation: \$x = $(x_val)\$",
                    "Substitute into the second equation: \$y = $(m)($(x_val)) + $(b) = $(m * x_val + b)\$",
                    sol("Solution", (x_val, y_val))
                ),
                time = 45
            )
        else
            # x = x_val, ax + by = c form
            a = nonzero(-5, 5)
            b = nonzero(-5, 5)
            c = a * x_val + b * y_val
            
            problem(
                question = "Solve the system using substitution:\n\$\$\\begin{cases} x = $(x_val) \\\\ $(a)x + $(b)y = $(c) \\end{cases}\$\$",
                answer = fmt_tuple((x_val, y_val)),
                difficulty = (250, 450),
                answer_type = "tuple",
                solution = steps(
                    "From the first equation: \$x = $(x_val)\$",
                    "Substitute into the second equation: \$$(a)($(x_val)) + $(b)y = $(c)\$",
                    "Simplify: \$$(a * x_val) + $(b)y = $(c)\$, so \$$(b)y = $(c - a * x_val)\$, thus \$y = $(y_val)\$",
                    sol("Solution", (x_val, y_val))
                ),
                time = 60
            )
        end
        
    elseif difficulty_level == 2
        # ELO 400-550: y isolated, substitute into simple equation
        x_val = randint(-10, 10)
        y_val = randint(-10, 10)
        
        # First equation: y = mx + b (where m*x_val + b = y_val)
        m = nonzero(-5, 5)
        b = y_val - m * x_val
        
        # Second equation: ax + by = c
        a = nonzero(-6, 6)
        b_coef = nonzero(-6, 6)
        c = a * x_val + b_coef * y_val
        
        problem(
            question = "Solve the system using substitution:\n\$\$\\begin{cases} y = $(m)x + $(b) \\\\ $(a)x + $(b_coef)y = $(c) \\end{cases}\$\$",
            answer = fmt_tuple((x_val, y_val)),
            difficulty = (400, 550),
            answer_type = "tuple",
            solution = steps(
                "From the first equation: \$y = $(m)x + $(b)\$",
                "Substitute into the second equation: \$$(a)x + $(b_coef)($(m)x + $(b)) = $(c)\$",
                "Expand: \$$(a)x + $(b_coef * m)x + $(b_coef * b) = $(c)\$",
                "Combine: \$$(a + b_coef * m)x = $(c - b_coef * b)\$, so \$x = $(x_val)\$",
                "Substitute back: \$y = $(m)($(x_val)) + $(b) = $(y_val)\$",
                sol("Solution", (x_val, y_val))
            ),
            time = 90
        )
        
    else
        # ELO 550-700: Need to isolate a variable first, then substitute
        x_val = randint(-8, 8)
        y_val = randint(-8, 8)
        
        # First equation: ax + by = c (will isolate one variable)
        a1 = nonzero(-4, 4)
        b1 = nonzero(-4, 4)
        c1 = a1 * x_val + b1 * y_val
        
        # Second equation: dx + ey = f
        a2 = nonzero(-5, 5)
        b2 = nonzero(-5, 5)
        c2 = a2 * x_val + b2 * y_val
        
        # We'll isolate x from first equation
        # ax + by = c => x = (c - by)/a
        
        problem(
            question = "Solve the system using substitution:\n\$\$\\begin{cases} $(a1)x + $(b1)y = $(c1) \\\\ $(a2)x + $(b2)y = $(c2) \\end{cases}\$\$",
            answer = fmt_tuple((x_val, y_val)),
            difficulty = (550, 700),
            answer_type = "tuple",
            solution = steps(
                "From the first equation, solve for \$x\$: \$$(a1)x = $(c1) - $(b1)y\$",
                "So \$x = \\frac{$(c1) - $(b1)y}{$(a1)}\$",
                "Substitute into the second equation: \$$(a2)\\left(\\frac{$(c1) - $(b1)y}{$(a1)}\\right) + $(b2)y = $(c2)\$",
                "Multiply through by $(a1) and solve: \$$(a2)($(c1) - $(b1)y) + $(a1 * b2)y = $(a1 * c2)\$",
                "Simplify to find \$y = $(y_val)\$, then \$x = $(x_val)\$",
                sol("Solution", (x_val, y_val))
            ),
            time = 120
        )
    end
end