"""
algebra2 - rational_equations (medium)
Generated: 2026-02-22T04:24:49.775620
"""

from problem_utils import *

def generate():
    problem_type = choice([1, 2, 3, 4])
    
    if problem_type == 1:
        # Solve a/(x+b) = c/(x+d), difficulty ~1300-1400
        a_val = nonzero(-10, 10)
        b_val = nonzero(-8, 8)
        c_val = nonzero(-10, 10)
        d_val = nonzero(-8, 8)
        
        # Ensure b != d to avoid trivial equation
        while b_val == d_val:
            d_val = nonzero(-8, 8)
        
        # Solve for x to get clean answer
        # a/(x+b) = c/(x+d)
        # a(x+d) = c(x+b)
        # ax + ad = cx + cb
        # ax - cx = cb - ad
        # x(a-c) = cb - ad
        
        if a_val == c_val:
            # Regenerate to avoid no solution or all solutions
            c_val = a_val + nonzero(-3, 3)
        
        solution_x = Rational(c_val * b_val - a_val * d_val, a_val - c_val)
        
        # Check that solution doesn't make denominators zero
        if solution_x == -b_val or solution_x == -d_val:
            solution_x = nonzero(-10, 10)
        
        equation = Eq(a_val / (x + b_val), c_val / (x + d_val))
        
        return problem(
            question=f"Solve for $x$: ${latex(equation)}$",
            answer=solution_x,
            difficulty=(1300, 1400),
            topic="algebra2/rational_equations",
            solution=steps(
                f"Cross multiply: ${a_val}(x + {b_val}) = {c_val}(x + {d_val})$",
                f"Expand: ${a_val}x + {a_val * b_val} = {c_val}x + {c_val * d_val}$",
                f"Collect terms: ${a_val - c_val}x = {c_val * d_val - a_val * b_val}$",
                f"$x = {latex(solution_x)}$"
            )
        )
    
    elif problem_type == 2:
        # Solve 1/x + 1/(x+a) = b/(x(x+a)), difficulty ~1400-1500
        a_val = nonzero(-8, 8)
        b_val = nonzero(2, 10)
        
        # 1/x + 1/(x+a) = b/(x(x+a))
        # (x+a + x)/(x(x+a)) = b/(x(x+a))
        # 2x + a = b
        # x = (b-a)/2
        
        solution_x = Rational(b_val - a_val, 2)
        
        # Check that solution doesn't make denominators zero
        if solution_x == 0 or solution_x == -a_val:
            solution_x = nonzero(-10, 10)
        
        lhs = 1/x + 1/(x + a_val)
        rhs = b_val / (x * (x + a_val))
        
        return problem(
            question=f"Solve for $x$: $\\frac{{1}}{{x}} + \\frac{{1}}{{x + {a_val}}} = \\frac{{{b_val}}}{{x(x + {a_val})}}$",
            answer=solution_x,
            difficulty=(1400, 1500),
            topic="algebra2/rational_equations",
            solution=steps(
                f"Multiply both sides by $x(x + {a_val})$:",
                f"$(x + {a_val}) + x = {b_val}$",
                f"$2x + {a_val} = {b_val}$",
                f"$2x = {b_val - a_val}$",
                f"$x = {latex(solution_x)}$"
            )
        )
    
    elif problem_type == 3:
        # Solve (x+a)/(x-b) = c, difficulty ~1300-1400
        a_val = nonzero(-8, 8)
        b_val = nonzero(-8, 8)
        c_val = nonzero(-5, 5)
        
        # Ensure c != 1 to avoid trivial solution
        while c_val == 1:
            c_val = nonzero(-5, 5)
        
        # (x+a)/(x-b) = c
        # x+a = c(x-b)
        # x+a = cx - cb
        # x - cx = -cb - a
        # x(1-c) = -cb - a
        # x = (-cb - a)/(1-c)
        
        solution_x = Rational(-c_val * b_val - a_val, 1 - c_val)
        
        # Check that solution doesn't equal b (would make denominator zero)
        if solution_x == b_val:
            solution_x = b_val + nonzero(1, 5)
        
        return problem(
            question=f"Solve for $x$: $\\frac{{x + {a_val}}}{{x - {b_val}}} = {c_val}$",
            answer=solution_x,
            difficulty=(1300, 1400),
            topic="algebra2/rational_equations",
            solution=steps(
                f"Multiply both sides by $(x - {b_val})$:",
                f"$x + {a_val} = {c_val}(x - {b_val})$",
                f"$x + {a_val} = {c_val}x - {c_val * b_val}$",
                f"${1 - c_val}x = {-c_val * b_val - a_val}$",
                f"$x = {latex(solution_x)}$"
            )
        )
    
    else:  # problem_type == 4
        # Solve a/(x-b) + c/(x-d) = e, difficulty ~1500-1600
        a_val = nonzero(-8, 8)
        b_val = nonzero(-6, 6)
        c_val = nonzero(-8, 8)
        d_val = nonzero(-6, 6)
        e_val = nonzero(-4, 4)
        
        # Ensure b != d
        while b_val == d_val:
            d_val = nonzero(-6, 6)
        
        # a/(x-b) + c/(x-d) = e
        # [a(x-d) + c(x-b)]/[(x-b)(x-d)] = e
        # a(x-d) + c(x-b) = e(x-b)(x-d)
        # ax - ad + cx - cb = e(x^2 - (b+d)x + bd)
        # (a+c)x - ad - cb = ex^2 - e(b+d)x + ebd
        # 0 = ex^2 - [e(b+d) + a + c]x + ebd + ad + cb
        
        # For simplicity, choose parameters that give a linear equation (e=0 gives linear)
        # Instead, let's solve directly
        eq = Eq(a_val/(x - b_val) + c_val/(x - d_val), e_val)
        solutions = solve(eq, x)
        
        if len(solutions) > 0 and solutions[0].is_real:
            solution_x = solutions[0]
            
            # Verify it doesn't make denominators zero
            if solution_x != b_val and solution_x != d_val:
                return problem(
                    question=f"Solve for $x$: $\\frac{{{a_val}}}{{x - {b_val}}} + \\frac{{{c_val}}}{{x - {d_val}}} = {e_val}$",
                    answer=solution_x,
                    difficulty=(1500, 1600),
                    topic="algebra2/rational_equations",
                    solution=steps(
                        f"Multiply both sides by $(x - {b_val})(x - {d_val})$:",
                        f"${a_val}(x - {d_val}) + {c_val}(x - {b_val}) = {e_val}(x - {b_val})(x - {d_val})$",
                        f"Expand and simplify to solve for $x$",
                        f"$x = {latex(solution_x)}$"
                    )
                )
        
        # Fallback to simpler problem type
        return generate()

emit(generate())