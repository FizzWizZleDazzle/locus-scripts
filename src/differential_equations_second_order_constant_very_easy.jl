# differential_equations - second_order_constant (very_easy)
# Generated: 2026-03-08T20:52:37.748229

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("differential_equations/second_order_constant")
    
    # For foundational/elementary level (100-700), focus on:
    # - Recognizing forms
    # - Simple direct solutions
    # - Characteristic equation basics
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Identify the order and whether it's linear/constant coefficient (100-300 range)
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        a = nonzero(-3, 3)
        b = randint(-8, 8)
        c = randint(-8, 8)
        
        problem(
            question="What is the order of the differential equation \$$(a)y'' + $(b)y' + $(c)y = 0\$?",
            answer=2,
            difficulty=(200, 400),
            solution=steps(
                "The order of a differential equation is the highest derivative present",
                "The highest derivative is \$y''\$, which is the second derivative",
                sol("Answer", 2)
            ),
            time=30
        )
        
    elseif problem_type == 2
        # Type 2: Solve characteristic equation for simple roots (400-600 range)
        r1 = nonzero(-6, 6)
        r2 = nonzero(-6, 6)
        b = -(r1 + r2)
        c = r1 * r2
        
        problem(
            question="Find the roots of the characteristic equation \$r^2 + $(b)r + $(c) = 0\$ for the differential equation \$y'' + $(b)y' + $(c)y = 0\$",
            answer=fmt_set(Set([r1, r2])),
            answer_type="set",
            difficulty=(450, 650),
            solution=steps(
                sol("Characteristic equation", "r^2 + $(b)r + $(c) = 0"),
                "Factor: \$(r - $(r1))(r - $(r2)) = 0\$",
                "The roots are \$r_1 = $(r1)\$ and \$r_2 = $(r2)\$",
                sol("Answer", fmt_set(Set([r1, r2])))
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Type 3: Recognize form of general solution (300-500 range)
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        while r2 == r1
            r2 = nonzero(-5, 5)
        end
        
        problem(
            question="If the characteristic equation of \$y'' - $(r1+r2)y' + $(r1*r2)y = 0\$ has roots \$r_1 = $(r1)\$ and \$r_2 = $(r2)\$, what is the general form of the solution?",
            answer="y = C_1 e^{$(r1)x} + C_2 e^{$(r2)x}",
            answer_type="expression",
            difficulty=(400, 600),
            solution=steps(
                "For a second-order constant coefficient equation with distinct real roots \$r_1\$ and \$r_2\$",
                "The general solution is \$y = C_1 e^{r_1 x} + C_2 e^{r_2 x}\$",
                "Substituting \$r_1 = $(r1)\$ and \$r_2 = $(r2)\$",
                sol("Answer", "y = C_1 e^{$(r1)x} + C_2 e^{$(r2)x}")
            ),
            time=60
        )
        
    else
        # Type 4: Simple verification that a function is a solution (500-700 range)
        r = nonzero(-4, 4)
        a = -r
        
        problem(
            question="Verify that \$y = e^{$(r)x}\$ is a solution to \$y' + $(a)y = 0\$. What is \$y' + $(a)y\$ when \$y = e^{$(r)x}\$?",
            answer=0,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", "y = e^{$(r)x}"),
                "Find \$y'\$: \$y' = $(r)e^{$(r)x}\$",
                "Substitute: \$y' + $(a)y = $(r)e^{$(r)x} + $(a)e^{$(r)x} = ($(r) + $(a))e^{$(r)x} = 0\$",
                sol("Answer", 0)
            ),
            time=90
        )
    end
end