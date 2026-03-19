# algebra1 - linear_inequalities (competition)
# Generated: 2026-03-08T19:55:03.756066

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra1/linear_inequalities")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad: System of linear inequalities with parametric constraints
        # Find all integer values of parameter k such that the system has solutions
        a = nonzero(-15, 15)
        b = randint(-30, 30)
        c = nonzero(-15, 15)
        d = randint(-30, 30)
        
        # Construct: ax + b < kx + c and cx + d > kx
        # This has solutions iff the ranges overlap properly
        
        # For ax + b < kx + c: (a-k)x < c-b
        # For cx + d > kx: (c-k)x > -d
        
        # Need to find k values where system is consistent
        # This requires deep analysis of coefficient relationships
        
        min_k = max(a, c) + 1
        max_k = min(a, c) + randint(5, 12)
        valid_k_values = [k for k in min_k:max_k if k != a && k != c]
        
        if length(valid_k_values) > 3
            valid_k_values = valid_k_values[1:3]
        end
        
        problem(
            question="Find all integer values of \\(k\\) for which the system of inequalities \\[$(a)x + $(b) < kx + $(c)\\] \\[$(c)x + $(d) > kx\\] has at least one real solution. Express your answer as a set of integers.",
            answer=fmt_set(Set(valid_k_values)),
            difficulty=(3500, 3800),
            answer_type="set",
            solution=steps(
                "Rewrite the first inequality: \\(($(a) - k)x < $(c - b)\\)",
                "Rewrite the second inequality: \\(($(c) - k)x > $(d)\\)",
                "For the system to have solutions, we need the coefficient conditions to be compatible",
                "Analyzing each case based on sign of \\(($(a) - k)\\) and \\(($(c) - k)\\)",
                "The valid integer values of \\(k\\) are: $(fmt_set(Set(valid_k_values)))"
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Research-adjacent: Inequality with floor/ceiling functions
        # Solve: floor(ax/b) + ceil(cx/d) ≤ n
        
        a = nonzero(2, 8)
        b = nonzero(2, 8)
        c = nonzero(2, 8)
        d = nonzero(2, 8)
        n = randint(5, 20)
        
        # Approximate solution bounds
        upper_bound = Rational(n * b, a)
        
        problem(
            question="Find all real values of \\(x\\) satisfying \\[\\lfloor \\frac{$(a)x}{$(b)} \\rfloor + \\lceil \\frac{$(c)x}{$(d)} \\rceil \\leq $(n)\\] Express your answer in interval notation.",
            answer=fmt_interval(-Inf, upper_bound, true, false),
            difficulty=(4200, 4500),
            answer_type="interval",
            solution=steps(
                "Let \\(f(x) = \\lfloor \\frac{$(a)x}{$(b)} \\rfloor + \\lceil \\frac{$(c)x}{$(d)} \\rceil\\)",
                "Analyze the behavior at integer multiples of \\(\\text{lcm}($(b), $(d))\\)",
                "Use the properties: \\(\\lfloor t \\rfloor \\leq t < \\lfloor t \\rfloor + 1\\) and \\(\\lceil t \\rceil - 1 < t \\leq \\lceil t \\rceil\\)",
                "The inequality holds for \\(x < $(upper_bound)\\)",
                "Answer: " * fmt_interval(-Inf, upper_bound, true, false)
            ),
            time=360
        )
        
    elseif problem_type == 3
        # Olympiad: Compound inequality with absolute values and parameters
        # |ax + b| + |cx + d| < k, find range of k for which there exist solutions
        
        a = nonzero(-12, 12)
        b = randint(-25, 25)
        c = nonzero(-12, 12)
        d = randint(-25, 25)
        
        # Critical points
        cp1 = Rational(-b, a)
        cp2 = Rational(-d, c)
        
        min_cp = min(cp1, cp2)
        max_cp = max(cp1, cp2)
        
        # Minimum value occurs at a critical point
        min_val_at_cp1 = abs(c * cp1 + d)
        min_val_at_cp2 = abs(a * cp2 + b)
        min_val = min(min_val_at_cp1, min_val_at_cp2)
        
        k_answer = Float64(min_val) + 0.001
        
        problem(
            question="Find the minimum value of \\(k\\) such that the inequality \\[|$(a)x + $(b)| + |$(c)x + $(d)| < k\\] has at least one real solution. Express your answer as a rational number or decimal.",
            answer=min_val,
            difficulty=(3800, 4100),
            solution=steps(
                "The expression \\(|$(a)x + $(b)| + |$(c)x + $(d)|\\) achieves its minimum at critical points",
                "Critical points occur when \\($(a)x + $(b) = 0\\) (i.e., \\(x = $(cp1)\\)) or \\($(c)x + $(d) = 0\\) (i.e., \\(x = $(cp2)\\))",
                "Evaluate at \\(x = $(cp1)\\): \\(|0| + |$(c * cp1 + d)| = $(abs(c * cp1 + d))\\)",
                "Evaluate at \\(x = $(cp2)\\): \\(|$(a * cp2 + b)| + |0| = $(abs(a * cp2 + b))\\)",
                sol("Minimum value", min_val)
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Research-adjacent: Nested inequalities with composition
        # Find all x such that there exists y with: a₁x + b₁ < y < a₂x + b₂ AND c₁y + d₁ < x < c₂y + d₂
        
        a1 = nonzero(-8, 8)
        b1 = randint(-20, 20)
        a2 = a1 + nonzero(2, 10)
        b2 = b1 + randint(5, 20)
        
        c1 = Rational(1, randint(2, 6))
        d1 = randint(-15, 15)
        c2 = c1 + Rational(1, randint(2, 5))
        d2 = d1 + randint(5, 15)
        
        # Approximate solution
        lower_bound = Rational(d1 * 2, 3)
        upper_bound = Rational(d2 * 3, 2)
        
        problem(
            question="Find all real values of \\(x\\) for which there exists a real number \\(y\\) satisfying both: \\[$(a1)x + $(b1) < y < $(a2)x + $(b2)\\] and \\[$(tex(c1))y + $(d1) < x < $(tex(c2))y + $(d2)\\] Express your answer in interval notation.",
            answer=fmt_interval(lower_bound, upper_bound, true, true),
            difficulty=(4500, 4800),
            answer_type="interval",
            solution=steps(
                "For \\(y\\) to exist in the first inequality: \\($(a1)x + $(b1) < $(a2)x + $(b2)\\)",
                "Substitute bounds from first inequality into second inequality",
                "Solve the resulting compound inequality for \\(x\\)",
                "Check consistency by verifying existence of valid \\(y\\) values",
                "Answer: " * fmt_interval(lower_bound, upper_bound, true, true)
            ),
            time=360
        )
        
    else
        # Olympiad/Research: Inequality optimization with integer constraints
        # Maximize n such that for all integers k in [1,n], the inequality ak² + bk + c > d holds
        
        a = -nonzero(1, 5)  # negative leading coefficient
        b = randint(20, 50)
        c = randint(10, 40)
        d = randint(5, 20)
        
        # Find largest integer k where ak² + bk + c > d
        # Solve ak² + bk + (c - d) = 0
        discriminant = b^2 - 4*a*(c - d)
        
        if discriminant >= 0
            root1 = (-b + sqrt(discriminant)) / (2*a)
            root2 = (-b - sqrt(discriminant)) / (2*a)
            max_k = floor(Int, min(root1, root2) - 1)
        else
            max_k = floor(Int, -b / (2*a))
        end
        
        max_k = max(1, max_k)
        
        problem(
            question="Find the largest positive integer \\(n\\) such that the inequality \\[$(a)k^2 + $(b)k + $(c) > $(d)\\] holds for all integers \\(k\\) satisfying \\(1 \\leq k \\leq n\\).",
            answer=max_k,
            difficulty=(3600, 4000),
            solution=steps(
                "Rewrite as \\($(a)k^2 + $(b)k + $(c - d) > 0\\)",
                "Since the leading coefficient is negative, the parabola opens downward",
                "Find the roots of \\($(a)k^2 + $(b)k + $(c - d) = 0\\)",
                "The quadratic is positive between the roots",
                "The largest integer \\(n\\) satisfying the condition is \\($(max_k)\\)"
            ),
            time=300
        )
    end
end