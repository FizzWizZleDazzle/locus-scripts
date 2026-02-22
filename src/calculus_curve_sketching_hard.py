"""
calculus - curve_sketching (hard)
Generated: 2026-02-22T05:08:18.609974
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Critical points and inflection points with rational function
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(1, 4)
        
        # f(x) = (ax^2 + b) / (x^2 + c)
        numer = a*x**2 + b
        denom = x**2 + c
        f = numer / denom
        
        # First derivative
        f_prime = diff(f, x)
        f_prime_simplified = simplify(f_prime)
        
        # Second derivative
        f_double_prime = diff(f_prime, x)
        f_double_prime_simplified = simplify(f_double_prime)
        
        # Find critical points
        critical_pts = solve(f_prime, x)
        critical_pts_real = [pt for pt in critical_pts if pt.is_real]
        
        # Find inflection points
        inflection_pts = solve(f_double_prime, x)
        inflection_pts_real = [pt for pt in inflection_pts if pt.is_real]
        
        if len(critical_pts_real) > 0:
            ans = critical_pts_real[0] if len(critical_pts_real) == 1 else min(critical_pts_real, key=lambda p: abs(p))
        else:
            ans = 0  # DNE case
        
        return problem(
            question=f"Find all critical points of $f(x) = {latex(f)}$. Enter the x-coordinate of the critical point closest to the origin (or 0 if none exist).",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/curve_sketching",
            solution=steps(
                f"Find $f'(x)$ using the quotient rule:",
                f"$f'(x) = {latex(f_prime_simplified)}$",
                f"Set $f'(x) = 0$ and solve for $x$:",
                f"Critical point(s): ${latex(critical_pts_real) if critical_pts_real else 'None'}$",
                f"Answer: ${latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Concavity intervals for polynomial
        a = nonzero(-2, 2)
        b = nonzero(-4, 4)
        c = nonzero(-3, 3)
        
        # f(x) = ax^4 + bx^3 + cx^2
        f = a*x**4 + b*x**3 + c*x**2
        
        f_prime = diff(f, x)
        f_double_prime = diff(f_prime, x)
        f_double_prime_simplified = simplify(f_double_prime)
        
        inflection_pts = solve(f_double_prime, x)
        inflection_pts_sorted = sorted([pt.evalf() for pt in inflection_pts if pt.is_real])
        
        # Determine where f''(x) > 0 (concave up)
        if len(inflection_pts_sorted) >= 2:
            test_pt = (inflection_pts_sorted[0] + inflection_pts_sorted[1]) / 2
            test_val = f_double_prime.subs(x, test_pt)
            if test_val > 0:
                ans_left = inflection_pts_sorted[0]
                ans_right = inflection_pts_sorted[1]
            else:
                ans_left = inflection_pts_sorted[1]
                ans_right = inflection_pts_sorted[-1] if len(inflection_pts_sorted) > 2 else inflection_pts_sorted[1] + 1
        else:
            ans_left = 0
            ans_right = 1
        
        return problem(
            question=f"For $f(x) = {latex(f)}$, find the smallest value of $x$ where the function changes from concave down to concave up.",
            answer=min(inflection_pts_sorted) if inflection_pts_sorted else 0,
            difficulty=(1600, 1700),
            topic="calculus/curve_sketching",
            solution=steps(
                f"Find the second derivative:",
                f"$f''(x) = {latex(f_double_prime_simplified)}$",
                f"Set $f''(x) = 0$:",
                f"Inflection points at: $x = {', '.join([latex(pt) for pt in inflection_pts_sorted])}$",
                f"The function changes from concave down to concave up at $x = {latex(min(inflection_pts_sorted)) if inflection_pts_sorted else 0}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Absolute extrema on closed interval
        a = nonzero(-2, 2)
        b = nonzero(-5, 5)
        
        # f(x) = x^3 + ax^2 + b on interval [-3, 3]
        f = x**3 + a*x**2 + b
        f_prime = diff(f, x)
        
        critical_pts = solve(f_prime, x)
        
        # Evaluate at critical points and endpoints
        test_points = [-3, 3]
        for pt in critical_pts:
            if pt.is_real and -3 <= pt <= 3:
                test_points.append(pt)
        
        values = [(pt, f.subs(x, pt)) for pt in test_points]
        max_pt, max_val = max(values, key=lambda v: v[1])
        
        return problem(
            question=f"Find the absolute maximum value of $f(x) = {latex(f)}$ on the interval $[-3, 3]$.",
            answer=max_val,
            difficulty=(1650, 1750),
            topic="calculus/curve_sketching",
            solution=steps(
                f"Find critical points: $f'(x) = {latex(f_prime)} = 0$",
                f"Critical points: ${latex(critical_pts)}$",
                f"Evaluate $f(x)$ at critical points in $[-3,3]$ and endpoints",
                f"Test points and values: ${latex([{latex(pt)}: {latex(val)} for pt, val in values])}$",
                f"Maximum value: ${latex(max_val)}$ at $x = {latex(max_pt)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Local extrema classification
        a = nonzero(-3, 3)
        b = nonzero(1, 4)
        
        # f(x) = x^4 - ax^2 + b
        f = x**4 - a*x**2 + b
        f_prime = diff(f, x)
        f_double_prime = diff(f_prime, x)
        
        critical_pts = solve(f_prime, x)
        critical_pts_real = [pt for pt in critical_pts if pt.is_real]
        
        # Count local minima
        local_minima = []
        for pt in critical_pts_real:
            second_deriv_val = f_double_prime.subs(x, pt)
            if second_deriv_val > 0:
                local_minima.append(pt)
        
        ans = len(local_minima)
        
        return problem(
            question=f"How many local minimum points does $f(x) = {latex(f)}$ have?",
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/curve_sketching",
            solution=steps(
                f"Find critical points: $f'(x) = {latex(f_prime)} = 0$",
                f"Critical points: ${', '.join([latex(pt) for pt in critical_pts_real])}$",
                f"Use second derivative test: $f''(x) = {latex(f_double_prime)}$",
                f"Evaluate $f''(x)$ at each critical point",
                f"Number of local minima (where $f''(x) > 0$): ${ans}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Asymptotes and behavior
        a = nonzero(-4, 4)
        b = nonzero(1, 3)
        c = nonzero(-3, 3)
        
        # f(x) = (ax + b) / (x^2 - c)
        numer = a*x + b
        denom = x**2 - c
        f = numer / denom
        
        # Find vertical asymptotes
        vertical_asymptotes = solve(denom, x)
        vertical_asymptotes_real = [pt for pt in vertical_asymptotes if pt.is_real]
        
        # Horizontal asymptote (degree of num < degree of denom, so y = 0)
        horiz_asymptote = 0
        
        # Find number of vertical asymptotes
        ans = len(vertical_asymptotes_real)
        
        return problem(
            question=f"How many vertical asymptotes does $f(x) = {latex(f)}$ have?",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/curve_sketching",
            solution=steps(
                f"Vertical asymptotes occur where the denominator is zero and numerator is non-zero",
                f"Solve ${latex(denom)} = 0$:",
                f"$x = {', '.join([latex(pt) for pt in vertical_asymptotes_real])}$",
                f"Check that numerator is non-zero at these points",
                f"Number of vertical asymptotes: ${ans}$"
            ),
            calculator="scientific"
        )

emit(generate())