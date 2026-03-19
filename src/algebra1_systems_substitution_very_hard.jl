# algebra1 - systems_substitution (very_hard)
# Generated: 2026-03-08T19:57:46.527706

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/systems_substitution")
    
    # Competition to Olympiad level: 2500-3500 ELO
    # Create challenging systems with substitution that require deep insight
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: System with symmetric structure requiring clever substitution
        # Pick final solution
        x_sol = randint(-8, 8)
        y_sol = randint(-8, 8)
        
        # Create a system where x+y and xy appear naturally
        s = x_sol + y_sol
        p = x_sol * y_sol
        
        # Create equations that lead to x+y=s and xy=p
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-15, 15)
        
        eq1 = x + y
        eq2 = x * y
        
        # Make it harder: use expressions involving both
        k1 = nonzero(2, 4)
        k2 = nonzero(2, 4)
        rhs1 = k1 * s + c
        rhs2 = k2 * p - c
        
        question_text = "Solve the system using substitution:\n\\begin{align*}\n$(k1)(x+y) &= $(rhs1) \\\\\n$(k2)xy &= $(rhs2)\n\\end{align*}"
        
        answer_text = fmt_set(Set([(x_sol, y_sol), (y_sol, x_sol)]))
        
        solution_text = steps(
            "From the first equation: \\(x + y = $(s)\\)",
            "From the second equation: \\(xy = $(div(rhs2, k2))\\)",
            "These are the sum and product of roots. Use Vieta's formulas:",
            sol("The values satisfy", expand((x - x_sol) * (x - y_sol)) ~ 0),
            "Solution set: \\(\\{($(x_sol), $(y_sol)), ($(y_sol), $(x_sol))\\}\\)"
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(2600, 2900),
            answer_type="set",
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == 2
        # Type 2: Non-linear system requiring substitution of composite expression
        x_sol = nonzero(-6, 6)
        y_sol = nonzero(-6, 6)
        
        # Create system where u = x^2 + y^2 appears in both equations
        u_val = x_sol^2 + y_sol^2
        v_val = x_sol * y_sol
        
        a = nonzero(2, 4)
        b = nonzero(2, 4)
        c = randint(-20, 20)
        
        rhs1 = a * u_val + c
        rhs2 = b * v_val - c
        
        question_text = "Solve the system:\n\\begin{align*}\n$(a)(x^2 + y^2) &= $(rhs1) \\\\\n$(b)xy &= $(rhs2)\n\\end{align*}"
        
        # Solutions are (x_sol, y_sol), (-x_sol, -y_sol), and possibly (y_sol, x_sol), (-y_sol, -x_sol)
        sol_set = Set()
        for (sx, sy) in [(x_sol, y_sol), (-x_sol, -y_sol), (y_sol, x_sol), (-y_sol, -x_sol)]
            if a * (sx^2 + sy^2) == rhs1 && b * sx * sy == rhs2
                push!(sol_set, (sx, sy))
            end
        end
        
        answer_text = fmt_set(sol_set)
        
        solution_text = steps(
            "Let \\(u = x^2 + y^2\\), so \\(u = $(div(rhs1 - c, a))\\)",
            "From second equation: \\(xy = $(div(rhs2 + c, b))\\)",
            "Use identity \\((x+y)^2 = x^2 + y^2 + 2xy\\) and \\((x-y)^2 = x^2 + y^2 - 2xy\\)",
            "Solve the resulting system to find x and y",
            "Solution set: $(answer_text)"
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(2800, 3200),
            answer_type="set",
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 3
        # Type 3: Exponential substitution system
        t_sol = nonzero(2, 5)
        
        # Let 2^x = t, then system becomes polynomial in t
        a = nonzero(2, 6)
        b = nonzero(-8, 8)
        c = randint(-15, 15)
        
        # Create equation in t
        rhs = a * t_sol^2 + b * t_sol + c
        
        # Back to x
        x_sol = log(t_sol) / log(2)
        
        question_text = "Solve for \\(x\\):\n\\[ $(a) \\cdot 4^x + $(b) \\cdot 2^x + $(c) = $(rhs) \\]"
        
        answer_text = x_sol
        
        solution_text = steps(
            "Let \\(u = 2^x\\), then \\(4^x = (2^x)^2 = u^2\\)",
            "Substitute to get: \\($(a)u^2 + $(b)u + $(c) = $(rhs)\\)",
            sol("Simplify", a * t_sol^2 + b * t_sol + c - rhs ~ 0),
            "Solve for \\(u\\): \\(u = $(t_sol)\\)",
            "Since \\(2^x = $(t_sol)\\), we have \\(x = \\log_2($(t_sol))\\)",
            sol("Answer", x_sol)
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(2700, 3100),
            solution=solution_text,
            time=270
        )
        
    else
        # Type 4: Radical system requiring multiple substitutions
        a_sol = nonzero(1, 9)
        b_sol = nonzero(1, 9)
        
        # Create system where sqrt(x) = a, sqrt(y) = b
        x_sol = a_sol^2
        y_sol = b_sol^2
        
        k1 = nonzero(2, 4)
        k2 = nonzero(2, 4)
        c = randint(-10, 10)
        
        rhs1 = k1 * a_sol + k2 * b_sol + c
        rhs2 = k1 * a_sol * b_sol - c
        
        question_text = "Solve the system for positive \\(x, y\\):\n\\begin{align*}\n$(k1)\\sqrt{x} + $(k2)\\sqrt{y} &= $(rhs1) \\\\\n$(k1)\\sqrt{xy} &= $(rhs2)\n\\end{align*}"
        
        answer_text = fmt_tuple([x_sol, y_sol])
        
        solution_text = steps(
            "Let \\(u = \\sqrt{x}\\) and \\(v = \\sqrt{y}\\) where \\(u, v > 0\\)",
            "System becomes: \\($(k1)u + $(k2)v = $(rhs1)\\) and \\($(k1)uv = $(rhs2)\\)",
            "From second equation: \\(uv = $(div(rhs2, k1))\\)",
            "Solve the linear-quadratic system to find \\(u = $(a_sol), v = $(b_sol)\\)",
            "Therefore \\(x = $(x_sol), y = $(y_sol)\\)",
            sol("Answer", (x_sol, y_sol))
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(2900, 3400),
            answer_type="tuple",
            solution=solution_text,
            time=300
        )
    end
end