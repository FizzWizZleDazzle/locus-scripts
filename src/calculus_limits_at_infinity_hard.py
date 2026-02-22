"""
calculus - limits_at_infinity (hard)
Generated: 2026-02-22T05:00:47.633070
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Rational function with leading coefficients
        a1 = nonzero(-5, 5)
        b1 = nonzero(-5, 5)
        c1 = nonzero(-5, 5)
        a2 = nonzero(-5, 5)
        b2 = nonzero(-5, 5)
        
        degree = choice([2, 3])
        if degree == 2:
            num = a1*x**2 + b1*x + c1
            den = a2*x**2 + b2*x + randint(-5, 5)
        else:
            num = a1*x**3 + b1*x**2 + c1*x + randint(-5, 5)
            den = a2*x**3 + b2*x**2 + randint(-5, 5)*x + randint(-5, 5)
        
        expr = num / den
        ans = Rational(a1, a2)
        
        return problem(
            question=f"\\lim_{{x \\to \\infty}} {latex(expr)}",
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/limits_at_infinity",
            solution=steps(
                f"Divide numerator and denominator by highest power of $x$: $x^{degree}$",
                f"$\\lim_{{x \\to \\infty}} \\frac{{{latex(num/x**degree)}}}{{{latex(den/x**degree)}}}$",
                f"As $x \\to \\infty$, terms with $x$ in denominator approach $0$",
                f"$\\lim_{{x \\to \\infty}} \\frac{{{a1}}}{{{a2}}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Exponential with polynomial
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(1, 5)
        
        sign = choice([1, -1])
        if sign == 1:
            expr = (a*x**2 + b*x) * exp(-c*x)
            ans = 0
            limit_dir = "\\infty"
        else:
            expr = (a*x**2 + b*x) * exp(c*x)
            if a > 0:
                ans = oo
                limit_dir = "\\infty"
            else:
                ans = -oo
                limit_dir = "\\infty"
        
        return problem(
            question=f"\\lim_{{x \\to {limit_dir}}} {latex(expr)}",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/limits_at_infinity",
            solution=steps(
                f"Rewrite as $\\lim_{{x \\to {limit_dir}}} \\frac{{{latex(a*x**2 + b*x)}}}{{e^{{{latex(c*x)}}}}}$" if sign == 1 else f"Exponential growth dominates polynomial growth",
                f"Apply L'Hôpital's rule or recognize exponential dominates polynomial" if sign == 1 else f"As $x \\to \\infty$, $e^{{{latex(c*x)}}}$ grows faster than any polynomial",
                f"Result: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Sqrt difference
        a = randint(1, 4)
        b = nonzero(-5, 5)
        c = randint(1, 4)
        
        expr = sqrt(a*x**2 + b*x + randint(-5, 5)) - sqrt(c*x**2 + randint(-5, 5)*x + randint(-5, 5))
        ans = sqrt(a) - sqrt(c)
        
        return problem(
            question=f"\\lim_{{x \\to \\infty}} \\left({latex(expr)}\\right)",
            answer=ans,
            difficulty=(1700, 1800),
            topic="calculus/limits_at_infinity",
            solution=steps(
                f"Factor out $x^2$ from each square root",
                f"$\\lim_{{x \\to \\infty}} x\\left(\\sqrt{{{a} + \\frac{{{b}}}{{x}} + \\frac{{...}}{{x^2}}}} - \\sqrt{{{c} + \\frac{{...}}{{x}} + \\frac{{...}}{{x^2}}}}\\right)$",
                f"This form is $\\infty \\cdot 0$, so multiply by conjugate",
                f"After simplification and taking limit: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Rational with trig
        a = nonzero(-5, 5)
        b = nonzero(1, 5)
        
        expr = (a*x + sin(b*x)) / x
        ans = a
        
        return problem(
            question=f"\\lim_{{x \\to \\infty}} {latex(expr)}",
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/limits_at_infinity",
            solution=steps(
                f"Split the fraction: $\\lim_{{x \\to \\infty}} \\left({a} + \\frac{{\\sin({b}x)}}{{x}}\\right)$",
                f"Since $-1 \\leq \\sin({b}x) \\leq 1$, we have $-\\frac{{1}}{{x}} \\leq \\frac{{\\sin({b}x)}}{{x}} \\leq \\frac{{1}}{{x}}$",
                f"By squeeze theorem, $\\lim_{{x \\to \\infty}} \\frac{{\\sin({b}x)}}{{x}} = 0$",
                f"Therefore, limit is ${a}$"
            ),
        )
    
    elif problem_type == 5:
        # Power of rational function
        a = nonzero(1, 4)
        b = nonzero(-5, 5)
        c = nonzero(1, 4)
        d = nonzero(-5, 5)
        k = randint(2, 4)
        
        expr = ((a*x + b) / (c*x + d))**k
        ans = (Rational(a, c))**k
        
        return problem(
            question=f"\\lim_{{x \\to \\infty}} {latex(expr)}",
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/limits_at_infinity",
            solution=steps(
                f"First find $\\lim_{{x \\to \\infty}} \\frac{{{a}x + {b}}}{{{c}x + {d}}}$",
                f"Divide by $x$: $\\lim_{{x \\to \\infty}} \\frac{{{a} + {b}/x}}{{{c} + {d}/x}} = \\frac{{{a}}}{{{c}}}$",
                f"Then raise to power $k = {k}$",
                f"$\\left(\\frac{{{a}}}{{{c}}}\\right)^{k} = {latex(ans)}$"
            ),
        )
    
    else:
        # Limit with absolute value
        a = nonzero(1, 5)
        b = nonzero(-5, 5)
        c = nonzero(1, 5)
        
        sign = choice([-1, 1])
        if sign == 1:
            # x -> +infinity
            expr = (a*x + b) / sqrt(c*x**2 + randint(1, 5))
            ans = Rational(a, sqrt(c))
            limit_dir = "\\infty"
        else:
            # x -> -infinity
            expr = (a*x + b) / sqrt(c*x**2 + randint(1, 5))
            ans = -Rational(a, sqrt(c))
            limit_dir = "-\\infty"
        
        return problem(
            question=f"\\lim_{{x \\to {limit_dir}}} {latex(expr)}",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/limits_at_infinity",
            solution=steps(
                f"Factor $x^2$ from square root: $\\sqrt{{x^2 \\cdot (...)}} = |x| \\cdot \\sqrt{{...}}$",
                f"For $x \\to {limit_dir}$, $|x| = {'x' if sign == 1 else '-x'}$",
                f"Divide numerator and denominator by $x$ (with correct sign)",
                f"As $x \\to {limit_dir}$, terms with $1/x$ approach $0$",
                f"Result: ${latex(ans)}$"
            ),
        )

emit(generate())