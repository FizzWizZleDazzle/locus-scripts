"""
precalculus - domain_and_range (medium)
Generated: 2026-02-22T04:36:32.656728
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Polynomial function - find domain (always all reals for polynomials)
        degree = randint(2, 3)
        coeffs = [nonzero(-5, 5) for _ in range(degree)]
        const = randint(-10, 10)
        
        if degree == 2:
            func = coeffs[0]*x**2 + coeffs[1]*x + const
        else:
            func = coeffs[0]*x**3 + coeffs[1]*x**2 + coeffs[2]*x + const
        
        return problem(
            question=f"Find the domain of $f(x) = {latex(func)}$",
            answer="(-infty,infty)",
            difficulty=(1200, 1300),
            topic="precalculus/domain_and_range",
            answer_type="interval",
            solution=steps(
                f"The function $f(x) = {latex(func)}$ is a polynomial.",
                "Polynomials are defined for all real numbers.",
                "Domain: $(-\\infty, \\infty)$"
            ),
        )
    
    elif problem_type == 2:
        # Rational function with linear denominator - find domain
        num_coeff = nonzero(-5, 5)
        num_const = randint(-10, 10)
        denom_coeff = nonzero(-5, 5)
        denom_const = nonzero(-10, 10)
        
        numerator = num_coeff*x + num_const
        denominator = denom_coeff*x + denom_const
        
        # Find where denominator = 0
        excluded = solve(denominator, x)[0]
        
        # Create interval notation
        answer = f"open:-infty,open:{float(excluded)}U open:{float(excluded)},open:infty"
        
        return problem(
            question=f"Find the domain of $f(x) = \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            answer=answer,
            difficulty=(1300, 1400),
            topic="precalculus/domain_and_range",
            answer_type="interval",
            solution=steps(
                f"The function is undefined when the denominator equals zero.",
                f"Solve ${latex(denominator)} = 0$:",
                f"$x = {latex(excluded)}$",
                f"Domain: $(-\\infty, {latex(excluded)}) \\cup ({latex(excluded)}, \\infty)$"
            ),
        )
    
    elif problem_type == 3:
        # Square root function - find domain
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        
        if a > 0:
            # sqrt(ax + b), need ax + b >= 0
            boundary = Rational(-b, a)
            answer = f"closed:{float(boundary)},open:infty"
            ineq = latex(a*x + b) + " \\geq 0"
            solution_text = steps(
                f"For $\\sqrt{{{latex(a*x + b)}}}$ to be defined, we need ${latex(a*x + b)} \\geq 0$.",
                f"Solve ${ineq}$:",
                f"$x \\geq {latex(boundary)}$",
                f"Domain: $[{latex(boundary)}, \\infty)$"
            )
        else:
            # sqrt(ax + b) where a < 0, need ax + b >= 0
            boundary = Rational(-b, a)
            answer = f"open:-infty,closed:{float(boundary)}"
            ineq = latex(a*x + b) + " \\geq 0"
            solution_text = steps(
                f"For $\\sqrt{{{latex(a*x + b)}}}$ to be defined, we need ${latex(a*x + b)} \\geq 0$.",
                f"Solve ${ineq}$:",
                f"$x \\leq {latex(boundary)}$",
                f"Domain: $(-\\infty, {latex(boundary)}]$"
            )
        
        return problem(
            question=f"Find the domain of $f(x) = \\sqrt{{{latex(a*x + b)}}}$",
            answer=answer,
            difficulty=(1400, 1500),
            topic="precalculus/domain_and_range",
            answer_type="interval",
            solution=solution_text,
        )
    
    elif problem_type == 4:
        # Find range of quadratic function (parabola)
        a = nonzero(-3, 3)
        h = randint(-5, 5)
        k = randint(-8, 8)
        
        # f(x) = a(x - h)^2 + k
        func = a*(x - h)**2 + k
        func_expanded = expand(func)
        
        if a > 0:
            # Opens upward, minimum at k
            answer = f"closed:{k},open:infty"
            vertex_type = "minimum"
            range_desc = f"[{k}, \\infty)"
        else:
            # Opens downward, maximum at k
            answer = f"open:-infty,closed:{k}"
            vertex_type = "maximum"
            range_desc = f"(-\\infty, {k}]"
        
        return problem(
            question=f"Find the range of $f(x) = {latex(func_expanded)}$",
            answer=answer,
            difficulty=(1400, 1600),
            topic="precalculus/domain_and_range",
            answer_type="interval",
            solution=steps(
                f"Rewrite in vertex form: $f(x) = {latex(func)}$",
                f"The vertex is at $({h}, {k})$.",
                f"Since $a = {a}$ {'>' if a > 0 else '<'} 0$, the parabola opens {'upward' if a > 0 else 'downward'}.",
                f"The {vertex_type} value is ${k}$.",
                f"Range: ${range_desc}$"
            ),
        )
    
    else:
        # Rational function with quadratic denominator - find domain
        num = nonzero(-5, 5)*x + randint(-10, 10)
        
        # Create denominator (x - r1)(x - r2)
        r1 = randint(-6, 6)
        r2 = r1
        while r2 == r1:
            r2 = randint(-6, 6)
        
        if r1 > r2:
            r1, r2 = r2, r1
        
        denom = expand((x - r1)*(x - r2))
        
        # Domain excludes r1 and r2
        answer = f"open:-infty,open:{r1}U open:{r1},open:{r2}U open:{r2},open:infty"
        
        return problem(
            question=f"Find the domain of $f(x) = \\frac{{{latex(num)}}}{{{latex(denom)}}}$",
            answer=answer,
            difficulty=(1400, 1550),
            topic="precalculus/domain_and_range",
            answer_type="interval",
            solution=steps(
                f"The function is undefined when the denominator equals zero.",
                f"Factor the denominator: ${latex(denom)} = {latex(factor(denom))}$",
                f"Set equal to zero: $(x - {r1})(x - {r2}) = 0$",
                f"Solutions: $x = {r1}$ and $x = {r2}$",
                f"Domain: $(-\\infty, {r1}) \\cup ({r1}, {r2}) \\cup ({r2}, \\infty)$"
            ),
        )

emit(generate())