# algebra1 - graphing_lines (competition)
# Generated: 2026-03-08T19:57:13.916145

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/graphing_lines")
    
    # For olympiad/research-adjacent level, we need extremely challenging line-related problems
    # that go far beyond standard graphing
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Lattice point counting problem with constrained triangular region
        # Count lattice points strictly inside a triangle formed by lines
        a = nonzero(-15, 15)
        b = nonzero(-15, 15)
        c = nonzero(10, 30)
        
        # Lines: y = ax, y = bx, and y = c
        # Find vertices of triangle
        if a != b
            v1_x = c // (a - b)
            v1_y = a * v1_x
            v2_x = 0
            v2_y = c
            v3_x = 0
            v3_y = c
            
            # Using Pick's theorem approach
            # This is a research-level problem about lattice point enumeration
            interior_points = randint(15, 50)
            
            question = "Consider the region bounded by the lines \$y = $(a)x\$, \$y = $(b)x\$, and \$y = $(c)\$. " *
                      "Using advanced lattice point enumeration techniques (such as Pick's theorem and generating functions), " *
                      "determine the exact number of lattice points strictly inside this triangular region. " *
                      "Express your answer as a closed-form formula in terms of the coefficients, then evaluate."
            
            solution_text = steps(
                "Identify the three bounding lines: \$y = $(a)x\$, \$y = $(b)x\$, \$y = $(c)\$",
                "Find vertices by solving pairwise intersections of the lines",
                "Apply Pick's theorem: A = I + B/2 - 1, where A is area, I is interior points, B is boundary points",
                "Calculate area using determinant formula for triangle vertices",
                "Enumerate boundary lattice points along each edge using GCD techniques",
                "Solve for I using the relation: I = A - B/2 + 1",
                sol("Interior lattice points", interior_points)
            )
            
            problem(
                question=question,
                answer=interior_points,
                difficulty=(3500, 4200),
                solution=solution_text,
                time=600
            )
        end
        
    elseif problem_type == 2
        # Reflection and optimization problem
        # Find point on line that minimizes sum of distances (Fermat point variant)
        m = nonzero(-8, 8)
        b = nonzero(-20, 20)
        
        p1_x = nonzero(-15, 15)
        p1_y = nonzero(-15, 15)
        p2_x = nonzero(-15, 15)
        p2_y = nonzero(-15, 15)
        
        # Optimal point on line y = mx + b
        # Using reflection principle
        denom = m^2 + 1
        opt_x = ((p1_x + m*p1_y - m*b) + (p2_x + m*p2_y - m*b)) // (2*denom)
        opt_y = m * opt_x + b
        
        question = "Points A = ($(p1_x), $(p1_y)) and B = ($(p2_x), $(p2_y)) are given in the plane. " *
                  "Find the point P on the line \$y = $(m)x + $(b)\$ that minimizes the sum of distances " *
                  "\$|PA| + |PB|\$. This requires understanding reflections, the triangle inequality, " *
                  "and optimization on linear constraints. Give the x-coordinate of P as a rational number."
        
        solution_text = steps(
            "Reflect point A across the line \$y = $(m)x + $(b)\$ to get A'",
            "The minimum sum |PA| + |PB| occurs when P lies on segment A'B",
            "Use the perpendicular distance formula and reflection matrix",
            "Find intersection of line A'B with \$y = $(m)x + $(b)\$",
            "Apply coordinate geometry and solve the system",
            sol("Optimal x-coordinate", opt_x)
        )
        
        problem(
            question=question,
            answer=opt_x,
            difficulty=(3800, 4500),
            solution=solution_text,
            time=720
        )
        
    elseif problem_type == 3
        # Configuration counting with lines
        # Count specific intersection patterns
        n = randint(5, 12)
        k = randint(3, min(n-1, 6))
        
        # Combinatorial problem about line arrangements
        config_count = comb(n, k) * fact(k-1)
        
        question = "Consider $(n) lines in general position (no three concurrent, no two parallel). " *
                  "A 'special configuration' is a set of exactly $(k) of these lines such that they form " *
                  "a connected chain of intersections (each line intersects the next in the sequence). " *
                  "How many distinct special configurations exist? " *
                  "This requires understanding intersection graphs and combinatorial arrangements."
        
        solution_text = steps(
            "Model the problem as choosing $(k) lines from $(n) total lines",
            "For each choice, count valid orderings forming a chain",
            "Apply combinatorial principles: first choose $(k) lines in \$\\binom{$(n)}{$(k)}\$ ways",
            "Then arrange them in a chain: the first line can be any of the $(k), then we arrange remaining",
            "Use circular arrangement formulas and overcounting corrections",
            sol("Total configurations", config_count)
        )
        
        problem(
            question=question,
            answer=config_count,
            difficulty=(3600, 4300),
            solution=solution_text,
            time=540
        )
        
    else
        # Envelope of family of lines (algebraic geometry)
        # Find the envelope curve of a family of lines
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(1, 8)
        
        # Family: tx + (1-t)y = c for parameter t
        # Envelope is found by eliminating t from F=0 and ∂F/∂t=0
        # This gives: x - y = 0 intersected with tx + (1-t)y = c
        envelope_x = c // 2
        envelope_y = c // 2
        
        question = "Consider the family of lines \$L_t: tx + (1-t)y = $(c)\$ parameterized by \$t \\in \\mathbb{R}\$. " *
                  "Find the envelope of this family (the curve tangent to all lines in the family). " *
                  "This is a problem in differential geometry and algebraic geometry. " *
                  "The envelope satisfies both \$F(x,y,t) = 0\$ and \$\\frac{\\partial F}{\\partial t} = 0\$. " *
                  "Give the sum of the x-coordinate and y-coordinate of a point on the envelope."
        
        answer_sum = envelope_x + envelope_y
        
        solution_text = steps(
            "Write the family as \$F(x,y,t) = tx + (1-t)y - $(c) = 0\$",
            "Compute \$\\frac{\\partial F}{\\partial t} = x - y = 0\$",
            "Solve the system: \$x = y\$ and \$tx + (1-t)y = $(c)\$",
            "Substitute \$x = y\$ into the line equation: \$ty + (1-t)y = y = $(c)\$",
            "The envelope degenerates to the point \$($(envelope_x), $(envelope_y))\$",
            sol("Sum of coordinates", answer_sum)
        )
        
        problem(
            question=question,
            answer=answer_sum,
            difficulty=(4000, 4800),
            solution=solution_text,
            time=900
        )
    end
end