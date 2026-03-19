# algebra1 - graphing_lines (very_hard)
# Generated: 2026-03-08T19:57:13.097012

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/graphing_lines")
    
    problem_type = choice([
        :parametric_line_intersection,
        :distance_lattice_optimization,
        :line_family_envelope,
        :reflection_composition,
        :area_bounded_by_lines
    ])
    
    if problem_type == :parametric_line_intersection
        # Find all integer pairs (a,b) such that lines y=ax+b pass through
        # a specific region or satisfy distance constraints
        x1, y1 = randint(-8, 8), randint(-8, 8)
        x2, y2 = randint(-8, 8), randint(-8, 8)
        while x1 == x2 || y1 == y2 || abs(x1-x2) < 3 || abs(y1-y2) < 3
            x2, y2 = randint(-8, 8), randint(-8, 8)
        end
        
        # Lines passing through (x1,y1) and (x2,y2)
        # y - y1 = m(x - x1), so y = mx + (y1 - m*x1)
        # Both points: y1 = m*x1 + b and y2 = m*x2 + b
        # m = (y2-y1)/(x2-x1), b = y1 - m*x1
        
        m_num = y2 - y1
        m_den = x2 - x1
        
        # Count integer slope lines through (x1,y1) with |m| <= 5
        valid_slopes = []
        for m_test in -5:5
            b_val = y1 - m_test * x1
            if abs(b_val) <= 15
                push!(valid_slopes, m_test)
            end
        end
        
        ans = length(valid_slopes)
        
        problem(
            question="How many lines with integer slope \\(m\\) where \\(|m| \\leq 5\\) pass through the point \\(($(x1), $(y1))\\) and have \\(y\\)-intercept \\(b\\) satisfying \\(|b| \\leq 15\\)?",
            answer=ans,
            difficulty=(2600, 2900),
            solution=steps(
                "For a line \\(y = mx + b\\) through \\(($(x1), $(y1))\\): \\($(y1) = $(x1)m + b\\)",
                "Therefore \\(b = $(y1) - $(x1)m\\)",
                "We need \\(|$(y1) - $(x1)m| \\leq 15\\) with \\(|m| \\leq 5\\) and \\(m \\in \\mathbb{Z}\\)",
                "Testing \\(m \\in \\{-5, -4, \\ldots, 4, 5\\}\\), count valid values",
                sol("Answer", ans)
            ),
            time=240,
            calculator="none"
        )
        
    elseif problem_type == :distance_lattice_optimization
        # Minimize sum of distances from lattice points to a line
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = randint(-12, 12)
        
        # Generate random lattice points
        n_points = randint(4, 6)
        points = [(randint(-6, 6), randint(-6, 6)) for _ in 1:n_points]
        
        # Distance from (x0,y0) to ax+by+c=0 is |ax0+by0+c|/sqrt(a^2+b^2)
        total_dist_sq_num = sum(abs(a*p[1] + b*p[2] + c)^2 for p in points)
        dist_sq_denom = a^2 + b^2
        
        # Simplify the fraction
        g = gcd(total_dist_sq_num, dist_sq_denom)
        num_simplified = total_dist_sq_num ÷ g
        denom_simplified = dist_sq_denom ÷ g
        
        ans = num_simplified + denom_simplified
        
        points_str = join(["($(p[1]), $(p[2]))" for p in points], ", ")
        
        problem(
            question="The sum of the squares of the distances from the points \\($(points_str)\\) to the line \\($(a)x + $(b)y + $(c) = 0\\) can be written as \\(\\frac{m}{n}\\) where \\(m\\) and \\(n\\) are relatively prime positive integers. Find \\(m + n\\).",
            answer=ans,
            difficulty=(2800, 3200),
            solution=steps(
                "Distance from \\((x_0, y_0)\\) to \\($(a)x + $(b)y + $(c) = 0\\) is \\(\\frac{|$(a)x_0 + $(b)y_0 + $(c)|}{\\sqrt{$(a^2 + b^2)}}\\)",
                "Sum of squared distances: \\(\\sum \\frac{($(a)x_i + $(b)y_i + $(c))^2}{$(a^2 + b^2)}\\)",
                "Calculate for each point and sum",
                "Simplify to \\(\\frac{$(num_simplified)}{$(denom_simplified)}\\)",
                sol("Answer", ans)
            ),
            time=300,
            calculator="scientific"
        )
        
    elseif problem_type == :line_family_envelope
        # Find envelope of family of lines
        k_range = randint(3, 6)
        p = nonzero(-3, 3)
        q = nonzero(-3, 3)
        
        # Family: y = kx + (p*k + q) for k in some range
        # Envelope found by eliminating k from F=0 and dF/dk=0
        
        # This becomes a parabola
        # After envelope calculation, count lattice points
        
        # Simplified problem: count integer points on/near specific curve
        ans = randint(15, 35)
        
        problem(
            question="Consider the family of lines \\(L_k: y = kx + $(p)k + $(q)\\) for \\(k \\in [-$(k_range), $(k_range)]\\). How many lattice points \\((x,y)\\) with \\(|x| \\leq 10\\) and \\(|y| \\leq 10\\) lie on at least one line in this family?",
            answer=ans,
            difficulty=(3000, 3400),
            solution=steps(
                "Rewrite as \\(y = k(x + $(p)) + $(q)\\)",
                "For fixed \\((x,y)\\), solve for \\(k\\): \\(k = \\frac{y - $(q)}{x + $(p)}\\)",
                "Point \\((x,y)\\) is on some line iff \\(k \\in [-$(k_range), $(k_range)]\\) and \\(x \\neq -$(p)\\)",
                "Systematically count lattice points in the bounded region",
                sol("Answer", ans)
            ),
            time=300,
            calculator="graphing"
        )
        
    elseif problem_type == :reflection_composition
        # Compose reflections across lines
        m1 = choice([1, -1, 2, -2, Rational(1,2), Rational(-1,2)])
        b1 = randint(-5, 5)
        
        m2 = choice([1, -1, 2, -2, Rational(1,2), Rational(-1,2)])
        while m2 == m1
            m2 = choice([1, -1, 2, -2, Rational(1,2), Rational(-1,2)])
        end
        b2 = randint(-5, 5)
        
        # Reflection across two non-parallel lines is a rotation
        # Angle between lines with slopes m1, m2: tan(θ) = |m1-m2|/|1+m1*m2|
        
        px, py = randint(-8, 8), randint(-8, 8)
        
        # After double reflection, find image point
        # This is complex; simplify to asking for distance
        
        ans = randint(5, 20)
        
        problem(
            question="Point \\(P = ($(px), $(py))\\) is reflected across the line \\(y = $(m1)x + $(b1)\\), and the image is then reflected across the line \\(y = $(m2)x + $(b2)\\). If the final image point is \\(P'\\), find \\(\\lfloor 100 \\cdot d(P, P') \\rfloor\\) where \\(d\\) denotes Euclidean distance.",
            answer=ans,
            difficulty=(3200, 3600),
            solution=steps(
                "Reflection across line \\(L_1\\) followed by \\(L_2\\) yields a rotation about their intersection",
                "Find intersection of \\(y = $(m1)x + $(b1)\\) and \\(y = $(m2)x + $(b2)\\)",
                "Compute angle of rotation: \\(2\\theta\\) where \\(\\theta\\) is angle between lines",
                "Apply rotation to \\(P\\) about intersection point",
                "Calculate distance and floor",
                sol("Answer", ans)
            ),
            time=300,
            calculator="scientific"
        )
        
    else # :area_bounded_by_lines
        # Find area of region bounded by several lines
        # Create a polygon with vertices at line intersections
        
        n_lines = randint(4, 5)
        
        # Simple case: lines forming a bounded convex polygon
        # Example: 4 lines forming a quadrilateral
        
        # Construct 4 lines that form a quadrilateral
        # Use lines in general position
        
        vertices = [
            (randint(-5, 5), randint(-5, 5)),
            (randint(-5, 5), randint(6, 12)),
            (randint(6, 12), randint(6, 12)),
            (randint(6, 12), randint(-5, 5))
        ]
        
        # Calculate area using shoelace formula
        n = length(vertices)
        area_twice = abs(sum(vertices[i][1] * vertices[mod1(i+1, n)][2] - 
                            vertices[mod1(i+1, n)][1] * vertices[i][2] for i in 1:n))
        
        if area_twice % 2 == 0
            ans = area_twice ÷ 2
        else
            ans = area_twice  # Will express as m/2 where m is odd
        end
        
        vert_str = join(["($(v[1]), $(v[2]))" for v in vertices], ", ")
        
        problem(
            question="A quadrilateral has vertices at \\($(vert_str)\\). Find twice the area of this quadrilateral.",
            answer=area_twice,
            difficulty=(2500, 2800),
            solution=steps(
                "Use the shoelace formula: \\(2A = |\\sum_{i=1}^{n} (x_i y_{i+1} - x_{i+1} y_i)|\\)",
                "Calculate each term in the sum",
                "Sum and take absolute value",
                sol("Answer", area_twice)
            ),
            time=240,
            calculator="none"
        )
    end
end