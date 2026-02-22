"""
calculus - curve_sketching (medium)
Generated: 2026-02-22T05:07:47.153656
"""

from problem_utils import *

def generate():
    problem_type = choice(['critical_points', 'intervals', 'concavity', 'inflection_points'])
    
    if problem_type == 'critical_points':
        # Generate polynomial with known critical points
        c1, c2 = nonzero(-4, 4), nonzero(-4, 4)
        while c1 == c2:
            c2 = nonzero(-4, 4)
        
        # f'(x) = a(x - c1)(x - c2)
        a = choice([-2, -1, 1, 2])
        f_prime = expand(a * (x - c1) * (x - c2))
        f = integrate(f_prime, x) + randint(-5, 5)
        
        critical_pts = sorted([c1, c2])
        ans = FiniteSet(*critical_pts)
        
        return problem(
            question=f"Find all critical points of $f(x) = {latex(f)}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="calculus/curve_sketching",
            solution=steps(
                f"Find the derivative: $f'(x) = {latex(f_prime)}$",
                f"Set $f'(x) = 0$ and solve: ${latex(f_prime)} = 0$",
                f"Factor: ${latex(factor(f_prime))} = 0$",
                f"Critical points: $x = {critical_pts[0]}, {critical_pts[1]}$",
                f"Answer: ${fmt_set(ans)}$"
            ),
        )
    
    elif problem_type == 'intervals':
        # Increasing/decreasing intervals
        c = nonzero(-3, 3)
        a = choice([-3, -2, -1, 1, 2, 3])
        
        # Parabola with vertex at x = c
        f_prime = a * (x - c)
        f = integrate(f_prime, x) + randint(-5, 5)
        
        if a > 0:
            interval_type = "increasing"
            ans_text = f"({c}, \\infty)"
        else:
            interval_type = "increasing"
            ans_text = f"(-\\infty, {c})"
        
        return problem(
            question=f"Find the interval(s) where $f(x) = {latex(f)}$ is {interval_type}.",
            answer=ans_text,
            difficulty=(1400, 1500),
            topic="calculus/curve_sketching",
            solution=steps(
                f"Find the derivative: $f'(x) = {latex(f_prime)}$",
                f"Set $f'(x) = 0$: $x = {c}$",
                f"Test intervals around $x = {c}$",
                f"$f'(x) {'> 0' if a > 0 else '< 0'}$ when $x {'>' if a > 0 else '<'} {c}$",
                f"Function is {interval_type} on ${ans_text}$"
            ),
        )
    
    elif problem_type == 'concavity':
        # Find where function is concave up/down
        c = nonzero(-3, 3)
        a = choice([1, 2, 3, -1, -2, -3])
        
        # f''(x) = a(x - c), so f'(x) = (a/2)(x-c)^2 + k, f(x) is cubic
        f_double_prime = a * (x - c)
        f_prime = integrate(f_double_prime, x)
        f = integrate(f_prime, x) + randint(-5, 5)
        
        concavity = choice(['concave up', 'concave down'])
        
        if concavity == 'concave up':
            if a > 0:
                ans_text = f"({c}, \\infty)"
            else:
                ans_text = f"(-\\infty, {c})"
        else:
            if a > 0:
                ans_text = f"(-\\infty, {c})"
            else:
                ans_text = f"({c}, \\infty)"
        
        return problem(
            question=f"Find the interval(s) where $f(x) = {latex(f)}$ is {concavity}.",
            answer=ans_text,
            difficulty=(1450, 1550),
            topic="calculus/curve_sketching",
            solution=steps(
                f"Find the second derivative: $f'(x) = {latex(f_prime)}$",
                f"$f''(x) = {latex(f_double_prime)}$",
                f"Set $f''(x) = 0$: $x = {c}$",
                f"Test intervals around $x = {c}$",
                f"Function is {concavity} on ${ans_text}$"
            ),
        )
    
    else:  # inflection_points
        # Generate cubic with one inflection point
        c = nonzero(-4, 4)
        a = choice([1, 2, -1, -2])
        
        # f''(x) = a(x - c)
        f_double_prime = a * (x - c)
        f_prime = integrate(f_double_prime, x) + randint(-3, 3)
        f = integrate(f_prime, x) + randint(-5, 5)
        
        ans = c
        
        return problem(
            question=f"Find all inflection points of $f(x) = {latex(f)}$ (give x-coordinates only).",
            answer=ans,
            difficulty=(1400, 1500),
            topic="calculus/curve_sketching",
            solution=steps(
                f"Find the second derivative: $f'(x) = {latex(f_prime)}$",
                f"$f''(x) = {latex(f_double_prime)}$",
                f"Set $f''(x) = 0$: ${latex(f_double_prime)} = 0$",
                f"Solve: $x = {c}$",
                f"Verify concavity changes at $x = {c}$",
                f"Inflection point at $x = {c}$"
            ),
        )

emit(generate())