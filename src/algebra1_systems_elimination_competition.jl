# algebra1 - systems_elimination (competition)
# Generated: 2026-03-08T19:58:32.863065

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra1/systems_elimination")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Olympiad-level: 3x3 system with parametric solution requiring deep insight
        # Choose parameters such that the system has infinitely many solutions along a line
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        e = nonzero(-8, 8)
        f = nonzero(-8, 8)
        
        # Construct a degenerate 3x3 system where third equation is linear combination
        k = nonzero(-3, 3)
        m = nonzero(-3, 3)
        
        eq1 = a*x + b*y + c*z
        eq2 = d*x + e*y + f*z
        eq3 = expand(k*eq1 + m*eq2)
        
        rhs1 = randint(-20, 20)
        rhs2 = randint(-20, 20)
        rhs3 = k*rhs1 + m*rhs2
        
        # The system has infinitely many solutions - find the parametric form
        # This requires solving for two variables in terms of the third
        
        problem(
            question="Consider the system:<br>\$$(tex(eq1)) = $(rhs1)\$<br>\$$(tex(eq2)) = $(rhs2)\$<br>\$$(tex(eq3)) = $(rhs3)\$<br><br>Prove that this system has infinitely many solutions and express the solution set parametrically in terms of \$t = z\$. Give your answer as an ordered triple \$(x(t), y(t), z(t))\$ where \$x\$ and \$y\$ are linear functions of \$t\$.",
            answer="infinitely_many",
            difficulty=(3500, 4000),
            answer_type="text",
            solution=steps(
                "Observe that the third equation is \$$(k)\$ times the first equation plus \$$(m)\$ times the second equation",
                "This means the system is degenerate (rank < 3), so solutions form a line in 3D space",
                "Let \$z = t\$ be the parameter. Solve the first two equations for \$x\$ and \$y\$ in terms of \$t\$",
                "Using elimination on equations 1 and 2, we express \$x\$ and \$y\$ as linear functions of \$t\$",
                "The solution set is a line in 3-space, demonstrating the geometric nature of dependent linear systems"
            ),
            time=300,
        )
        
    elseif problem_type == 2
        # Research-adjacent: System with integer constraints requiring number-theoretic insight
        a = nonzero(3, 12)
        b = nonzero(3, 12)
        c = nonzero(2, 8)
        d = nonzero(2, 8)
        
        # Construct system where we need to count integer solutions in a bounded region
        rhs1 = randint(50, 150)
        rhs2 = randint(50, 150)
        
        problem(
            question="Find the number of positive integer solutions \$(x, y)\$ to the system:<br>\$$(a)x + $(b)y \\leq $(rhs1)\$<br>\$$(c)x + $(d)y \\leq $(rhs2)\$<br><br>where both \$x \\geq 1\$ and \$y \\geq 1\$.",
            answer="count",
            difficulty=(4000, 4500),
            answer_type="text",
            solution=steps(
                "This is a lattice point counting problem in a convex polygon",
                "Find the vertices of the feasible region by solving pairs of boundary equations",
                "The region is bounded by the two inequalities and the axes",
                "Use Pick's theorem or systematic enumeration to count integer points",
                "Requires careful analysis of boundary cases and vertex coordinates",
                "Advanced technique: Generate function or inclusion-exclusion on the constraints"
            ),
            time=300,
        )
        
    elseif problem_type == 3
        # Olympiad: Homogeneous system with constraint on solution set
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        c = nonzero(-7, 7)
        d = nonzero(-7, 7)
        e = nonzero(-7, 7)
        f = nonzero(-7, 7)
        
        # Ensure the system has nontrivial solutions
        # Make third equation a specific combination
        k = nonzero(-4, 4)
        
        problem(
            question="Consider the homogeneous system:<br>\$$(a)x + $(b)y + $(c)z = 0\$<br>\$$(d)x + $(e)y + $(f)z = 0\$<br>\$($(k*a))x + ($(k*b))y + ($(k*c))z = 0\$<br><br>Find all values of \$k\$ for which the system has nontrivial solutions, and for each such \$k\$, determine the dimension of the solution space. Then, for the smallest positive value of \$k\$ you found, explicitly describe the solution space.",
            answer="k_values",
            difficulty=(3800, 4200),
            answer_type="text",
            solution=steps(
                "A homogeneous system has nontrivial solutions if and only if the coefficient matrix has determinant zero",
                "Observe that the third equation is already \$k\$ times the first equation for any \$k\$",
                "This means the system is automatically degenerate for all values of \$k\$",
                "The rank of the coefficient matrix is at most 2, so the solution space has dimension at least 1",
                "Express the general solution parametrically using the nullspace",
                "The solution space is a line through the origin in 3D space for generic \$k\$"
            ),
            time=300,
        )
        
    elseif problem_type == 4
        # Research-adjacent: Non-linear system requiring substitution and advanced techniques
        a = nonzero(2, 8)
        b = nonzero(2, 8)
        p = choice([2, 3, 4])
        q = choice([2, 3])
        
        target1 = randint(20, 80)
        target2 = randint(20, 80)
        
        problem(
            question="Solve the system:<br>\$$(a)x^$(p) + $(b)y^$(q) = $(target1)\$<br>\$$(b)x^$(p) - $(a)y^$(q) = $(target2)\$<br><br>Find all real solutions \$(x, y)\$ and prove that your list is complete. Express irrational answers in exact form.",
            answer="nonlinear_solutions",
            difficulty=(4200, 4700),
            answer_type="text",
            solution=steps(
                "Add the two equations to eliminate \$y^$(q)\$: \$$(a+b)x^$(p) = $(target1 + target2)\$",
                "This gives \$x^$(p) = $(Rational(target1 + target2, a+b))\$",
                "Subtract the second from the first to eliminate \$x^$(p)\$: \$$(2*b)y^$(q) = $(target1 - target2)\$",
                "This gives \$y^$(q) = $(Rational(target1 - target2, 2*b))\$",
                "For each equation, determine how many real \$$(p)\$-th and \$$(q)\$-th roots exist",
                "Combine all valid combinations of roots to get the complete solution set",
                "Verify each solution by substitution into both original equations"
            ),
            time=300,
        )
        
    else
        # Olympiad-level: System with absolute values requiring case analysis
        a = nonzero(2, 9)
        b = nonzero(2, 9)
        c = nonzero(2, 9)
        d = nonzero(2, 9)
        
        rhs1 = randint(15, 45)
        rhs2 = randint(15, 45)
        
        problem(
            question="Solve the system:<br>\$|$(a)x + $(b)y| = $(rhs1)\$<br>\$|$(c)x - $(d)y| = $(rhs2)\$<br><br>Find all real solutions \$(x, y)\$. How many distinct solutions exist?",
            answer="abs_value_system",
            difficulty=(3600, 4100),
            answer_type="text",
            solution=steps(
                "The absolute value equations create four cases based on the signs of the expressions inside",
                "Case 1: Both expressions positive: \$$(a)x + $(b)y = $(rhs1)\$ and \$$(c)x - $(d)y = $(rhs2)\$",
                "Case 2: First positive, second negative: \$$(a)x + $(b)y = $(rhs1)\$ and \$$(c)x - $(d)y = $(-rhs2)\$",
                "Case 3: First negative, second positive: \$$(a)x + $(b)y = $(-rhs1)\$ and \$$(c)x - $(d)y = $(rhs2)\$",
                "Case 4: Both expressions negative: \$$(a)x + $(b)y = $(-rhs1)\$ and \$$(c)x - $(d)y = $(-rhs2)\$",
                "Solve each linear system and verify which solutions satisfy the original sign assumptions",
                "The final answer typically has 4 or fewer distinct solutions depending on the feasible cases"
            ),
            time=300,
        )
    end
end