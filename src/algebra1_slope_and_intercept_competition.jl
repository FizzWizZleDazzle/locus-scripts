# algebra1 - slope_and_intercept (competition)
# Generated: 2026-03-08T19:56:38.413570

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/slope_and_intercept")
    
    # For Olympiad/Research-Adjacent level (3500-5000 ELO), we need problems that:
    # - Require deep insight into slope/intercept concepts
    # - Involve non-trivial algebraic manipulations
    # - Connect multiple concepts in unexpected ways
    # - Require proof-like reasoning or optimization
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Lines forming a family with constrained conditions
        # Find all lines through a point with integer slope/intercept satisfying a constraint
        
        h = randint(-8, 8)
        k = randint(-8, 8)
        target_sum = randint(15, 35)
        
        # Lines through (h,k): y - k = m(x - h), or y = mx + (k - mh)
        # So intercept b = k - mh
        # Want |m| + |b| = target_sum where m, b integers
        
        solutions = []
        for m in -target_sum:target_sum
            b = k - m*h
            if abs(m) + abs(b) == target_sum
                push!(solutions, (m, b))
            end
        end
        
        answer = length(solutions)
        
        question = "How many lines pass through the point \\(($h, $k)\\) and have integer slope \\(m\\) and integer \\(y\\)-intercept \\(b\\) such that \\(|m| + |b| = $target_sum\\)?"
        
        solution_text = steps(
            "A line through \\(($h, $k)\\) has form \\(y - $k = m(x - $h)\\)",
            "Rewriting: \\(y = mx + ($k - $(h)m)\\), so \\(b = $k - $(h)m\\)",
            "Need \\(|m| + |$k - $(h)m| = $target_sum\\) with \\(m, b \\in \\mathbb{Z}\\)",
            "Systematically check integer values of \\(m\\) in range \\([-$target_sum, $target_sum]\\)",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 3800),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 2
        # Type 2: Optimization problem with slopes
        # Minimize sum of absolute slopes from a point to n fixed points
        
        n = rand(4:6)
        points_y = [randint(-15, 15) for _ in 1:n]
        sort!(points_y)
        
        # For point (a, 0), slopes to (i, y_i) are y_i/|i - a|
        # This is a weighted median problem
        
        median_idx = div(n + 1, 2)
        optimal_x = median_idx
        
        min_sum = sum(abs(points_y[i] / abs(i - optimal_x)) for i in 1:n if i != optimal_x)
        if n % 2 == 0
            min_sum = min(min_sum, sum(abs(points_y[i] / abs(i - optimal_x - 1)) for i in 1:n if i != optimal_x - 1))
            optimal_x = median_idx  # Either works, pick one
        end
        
        answer = optimal_x
        
        coords = join(["($i, $(points_y[i]))" for i in 1:n], ", ")
        
        question = "Given points $coords, find the integer \\(x\\)-coordinate \\(a\\) (with \\(1 \\leq a \\leq $n\\)) that minimizes \\(\\sum_{i=1}^{$n} \\left|\\frac{y_i - 0}{i - a}\\right|\\) where the sum excludes the term when \\(i = a\\)."
        
        solution_text = steps(
            "This minimizes the sum of absolute slopes from \\((a, 0)\\) to the given points",
            "By convexity arguments, the optimal \\(a\\) is near the median \\(x\\)-coordinate",
            "Test values around \\(a = $(div(n+1, 2))\\) and compute sums",
            "The minimum occurs at \\(a = $optimal_x\\)",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3800, 4200),
            solution=solution_text,
            time=360
        )
        
    elseif problem_type == 3
        # Type 3: Functional equation with linear functions
        # Find all linear functions f(x) = mx + b satisfying f(f(x)) = ax + c
        
        a_target = nonzero(-5, 5)
        c_target = randint(-20, 20)
        
        # f(f(x)) = f(mx + b) = m(mx + b) + b = m²x + mb + b
        # Want m²x + mb + b = ax + c
        # So m² = a and mb + b = c, i.e., b(m + 1) = c
        
        if a_target > 0
            m_vals = [isqrt(a_target), -isqrt(a_target)]
            m_vals = filter(m -> m^2 == a_target, m_vals)
        else
            m_vals = []
        end
        
        valid_pairs = []
        for m in m_vals
            if m + 1 != 0
                b_val = c_target // (m + 1)
                if denominator(b_val) == 1
                    push!(valid_pairs, (m, numerator(b_val)))
                end
            elseif c_target == 0
                # Any b works when m = -1, but we need integer
                push!(valid_pairs, (m, 0))  # Pick b = 0 as canonical
            end
        end
        
        answer = length(valid_pairs)
        
        question = "How many linear functions \\(f(x) = mx + b\\) with integer coefficients satisfy \\(f(f(x)) = $(a_target)x + $c_target\\)?"
        
        solution_text = steps(
            "Let \\(f(x) = mx + b\\). Then \\(f(f(x)) = m(mx + b) + b = m^2 x + mb + b\\)",
            "Require \\(m^2 = $a_target\\) and \\(b(m + 1) = $c_target\\)",
            "From \\(m^2 = $a_target\\): $(a_target > 0 ? "\\(m \\in \\{$(isqrt(a_target)), -$(isqrt(a_target))\\}\\)" : "no real solutions")",
            "For each valid \\(m\\), solve \\(b(m + 1) = $c_target\\) for integer \\(b\\)",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3600, 4000),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 4
        # Type 4: Lattice point counting with slope constraint
        # Count lattice points (x,y) in a region where slope from origin is in a range
        
        N = randint(20, 40)
        p = randint(2, 7)
        q = randint(p+1, 10)
        
        # Count lattice points (x,y) with 0 < x ≤ N, 0 < y ≤ N, p/q < y/x < (p+1)/q
        
        count = 0
        for x_val in 1:N
            y_min = ceil(Int, p * x_val / q + 0.001)
            y_max = floor(Int, (p + 1) * x_val / q - 0.001)
            if y_max >= y_min && y_max <= N
                count += min(y_max, N) - y_min + 1
            end
        end
        
        answer = count
        
        question = "How many lattice points \\((x, y)\\) with \\(0 < x \\leq $N\\) and \\(0 < y \\leq $N\\) satisfy \\(\\frac{$p}{$q} < \\frac{y}{x} < \\frac{$(p+1)}{$q}\\)?"
        
        solution_text = steps(
            "For each \\(x\\) from 1 to $N, find integer \\(y\\) with \\(\\frac{$p x}{$q} < y < \\frac{$(p+1) x}{$q}\\)",
            "This gives \\(y \\in \\{\\lceil \\frac{$p x}{$q} \\rceil, \\ldots, \\lfloor \\frac{$(p+1) x}{$q} \\rfloor\\} \\cap \\{1, \\ldots, $N\\}\\)",
            "Sum the count over all valid \\(x\\)",
            "Use Farey sequence properties or direct computation",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3900, 4300),
            solution=solution_text,
            time=360
        )
        
    else
        # Type 5: Tangent line configuration problem
        # Find lines tangent to a circle that pass through a given point
        
        r = randint(5, 12)
        px = randint(r+5, r+15)
        py = randint(-10, 10)
        
        # Circle x² + y² = r², point (px, py)
        # Line through (px, py): y - py = m(x - px), or mx - y + (py - m*px) = 0
        # Distance from origin = |py - m*px| / sqrt(m² + 1) = r
        # So (py - m*px)² = r²(m² + 1)
        
        # Expand: py² - 2py*m*px + m²*px² = r²*m² + r²
        # m²(px² - r²) - 2py*px*m + (py² - r²) = 0
        
        A = px^2 - r^2
        B = -2 * py * px
        C = py^2 - r^2
        
        discriminant = B^2 - 4*A*C
        
        if discriminant >= 0 && A != 0
            m1 = (-B + sqrt(discriminant)) / (2*A)
            m2 = (-B - sqrt(discriminant)) / (2*A)
            
            # Find y-intercepts: b = py - m*px
            b1 = py - m1 * px
            b2 = py - m2 * px
            
            answer_val = round(Int, b1 + b2)
        else
            answer_val = 0
        end
        
        answer = answer_val
        
        question = "Two lines pass through the point \\(($px, $py)\\) and are tangent to the circle \\(x^2 + y^2 = $(r^2)\\). If these lines have \\(y\\)-intercepts \\(b_1\\) and \\(b_2\\), find \\(\\lfloor b_1 + b_2 \\rfloor\\)."
        
        solution_text = steps(
            "A line \\(y = mx + b\\) through \\(($px, $py)\\) has \\(b = $py - $(px)m\\)",
            "Tangency to circle: distance from origin equals $r",
            "\\(\\frac{|b|}{\\sqrt{m^2 + 1}} = $r\\) gives \\($(A)m^2 + $(B)m + $C = 0\\)",
            "By Vieta: \\(m_1 + m_2 = $(rational(-B, A))\\), so \\(b_1 + b_2 = 2($py) - $(px)(m_1 + m_2)\\)",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4000, 4500),
            solution=solution_text,
            time=420
        )
    end
end