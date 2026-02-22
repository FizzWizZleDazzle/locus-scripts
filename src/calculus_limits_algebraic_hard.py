"""
calculus - limits_algebraic (hard)
Generated: 2026-02-22T04:59:25.861963
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Limit involving factoring and cancellation with higher powers
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        while r2 == r1:
            r2 = nonzero(-5, 5)
        
        # Numerator and denominator both have (x - r1) as a factor
        # Make it more complex with additional terms
        p = nonzero(-4, 4)
        q = nonzero(-4, 4)
        
        numerator = expand((x - r1) * (x**2 + p*x + q))
        denominator = expand((x - r1) * (x - r2))
        
        # The limit as x approaches r1
        # After canceling (x - r1), we get (x^2 + p*x + q) / (x - r2)
        ans = (r1**2 + p*r1 + q) / (r1 - r2)
        ans = simplify(ans)
        
        return problem(
            question=f"\\lim_{{x \\to {r1}}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1600, 1750),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Factor the numerator: ${latex(numerator)} = {latex(factor(numerator))}$",
                f"Factor the denominator: ${latex(denominator)} = {latex(factor(denominator))}$",
                f"Cancel the common factor $(x - {r1})$",
                f"$\\lim_{{x \\to {r1}}} \\frac{{{latex(x**2 + p*x + q)}}}{{{latex(x - r2)}}}$",
                f"Substitute $x = {r1}$: $\\frac{{{r1**2 + p*r1 + q}}}{{{r1 - r2}}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Limit with nested radicals requiring rationalization
        a = randint(1, 5)
        b = randint(1, 5)
        c = nonzero(-4, 4)
        
        # lim (sqrt(ax + b) - sqrt(b)) / x as x -> 0
        # Multiply by conjugate, answer is a/(2*sqrt(b))
        ans = Rational(a, 2) / sqrt(b)
        ans = simplify(ans)
        
        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{\\sqrt{{{a}x + {b}}} - \\sqrt{{{b}}}}}{{x}}",
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Multiply numerator and denominator by the conjugate $\\sqrt{{{a}x + {b}}} + \\sqrt{{{b}}}$",
                f"$\\lim_{{x \\to 0}} \\frac{{({a}x + {b}) - {b}}}{{x(\\sqrt{{{a}x + {b}}} + \\sqrt{{{b}}})}}$",
                f"$\\lim_{{x \\to 0}} \\frac{{{a}x}}{{x(\\sqrt{{{a}x + {b}}} + \\sqrt{{{b}}})}}$",
                f"Cancel $x$: $\\lim_{{x \\to 0}} \\frac{{{a}}}{{\\sqrt{{{a}x + {b}}} + \\sqrt{{{b}}}}}$",
                f"Substitute $x = 0$: $\\frac{{{a}}}{{\\sqrt{{{b}}} + \\sqrt{{{b}}}}} = \\frac{{{a}}}{{{2}\\sqrt{{{b}}}}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Limit involving absolute value requiring one-sided analysis
        a = nonzero(-5, 5)
        b = nonzero(-3, 3)
        
        # lim (|x - a| + b(x - a)) / (x - a) as x -> a
        # From right: (x-a + b(x-a))/(x-a) = 1 + b
        # From left: (-(x-a) + b(x-a))/(x-a) = -1 + b
        # Limit exists only if 1 + b = -1 + b, which is false
        # So we need to pick one side or make them equal
        
        # Instead, let's do a problem where limit exists
        # lim (x^2 - a^2) / |x - a| as x -> a from right
        # = lim (x+a)(x-a) / (x-a) = lim (x+a) = 2a
        
        ans = 2 * a
        
        return problem(
            question=f"\\lim_{{x \\to {a}^+}} \\frac{{x^2 - {a**2}}}{{|x - {a}|}}",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Since $x \\to {a}^+$, we have $x > {a}$, so $|x - {a}| = x - {a}$",
                f"$\\lim_{{x \\to {a}^+}} \\frac{{x^2 - {a**2}}}{{x - {a}}}$",
                f"Factor: $x^2 - {a**2} = (x - {a})(x + {a})$",
                f"$\\lim_{{x \\to {a}^+}} \\frac{{(x - {a})(x + {a})}}{{x - {a}}}$",
                f"Cancel $(x - {a})$: $\\lim_{{x \\to {a}^+}} (x + {a})$",
                f"Substitute: ${a} + {a} = {ans}$"
            ),
        )
    
    elif problem_type == 4:
        # Limit with difference of cube roots
        a = randint(1, 4)
        b = randint(1, 4)
        
        # lim (cuberoot(ax + b) - cuberoot(b)) / x as x -> 0
        # Use a^3 - b^3 = (a-b)(a^2 + ab + b^2) formula
        # Answer is a / (3 * b^(2/3))
        
        ans = Rational(a, 3) / (b**Rational(2, 3))
        ans = simplify(ans)
        
        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{\\sqrt[3]{{{a}x + {b}}} - \\sqrt[3]{{{b}}}}}{{x}}",
            answer=ans,
            difficulty=(1750, 1900),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Let $u = \\sqrt[3]{{{a}x + {b}}}$ and $v = \\sqrt[3]{{{b}}}$",
                f"Use the identity $u - v = \\frac{{u^3 - v^3}}{{u^2 + uv + v^2}}$",
                f"$u^3 - v^3 = {a}x + {b} - {b} = {a}x$",
                f"$\\lim_{{x \\to 0}} \\frac{{{a}x}}{{x(u^2 + uv + v^2)}}$",
                f"Cancel $x$: $\\lim_{{x \\to 0}} \\frac{{{a}}}{{u^2 + uv + v^2}}$",
                f"As $x \\to 0$: $u \\to \\sqrt[3]{{{b}}} = v$",
                f"$\\frac{{{a}}}{{v^2 + v \\cdot v + v^2}} = \\frac{{{a}}}{{3v^2}} = \\frac{{{a}}}{{3 \\cdot {b}^{{2/3}}}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 5:
        # Limit requiring polynomial division/simplification
        p = nonzero(-3, 3)
        q = nonzero(-3, 3)
        
        # lim (x^3 + px^2 + qx) / (x^2 + px + q) as x -> infinity
        # Divide numerator and denominator by x^2
        # = lim (x + p + q/x) / (1 + p/x + q/x^2)
        # Answer is infinity or -infinity depending on sign
        
        # To get a finite limit, we need degree of num = degree of denom
        # lim (x^2 + px + q) / (x^2 + rx + s) as x -> infinity = 1
        
        r = nonzero(-4, 4)
        s = nonzero(-4, 4)
        
        numerator = x**2 + p*x + q
        denominator = x**2 + r*x + s
        
        # Leading coefficient ratio
        ans = 1
        
        return problem(
            question=f"\\lim_{{x \\to \\infty}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Divide numerator and denominator by $x^2$ (highest power)",
                f"$\\lim_{{x \\to \\infty}} \\frac{{1 + \\frac{{{p}}}{{x}} + \\frac{{{q}}}{{x^2}}}}{{1 + \\frac{{{r}}}{{x}} + \\frac{{{s}}}{{x^2}}}}$",
                f"As $x \\to \\infty$, all terms with $x$ in denominator approach $0$",
                f"$\\frac{{1 + 0 + 0}}{{1 + 0 + 0}} = 1$"
            ),
        )
    
    else:  # problem_type == 6
        # Limit with trigonometric-like algebraic manipulation
        a = randint(2, 5)
        b = randint(1, 4)
        r = nonzero(-4, 4)
        
        # lim ((x+r)^a - r^a) / x as x -> 0
        # Using binomial or L'Hopital conceptually
        # derivative of (x+r)^a at x=0 gives a*r^(a-1)
        
        ans = a * (r**(a-1))
        
        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{(x + {r})^{a} - {r**a}}}{{x}}",
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Recognize this as the definition of a derivative: $f'(0)$ where $f(x) = (x + {r})^{a}$",
                f"Alternatively, expand using binomial theorem:",
                f"$(x + {r})^{a} = {r**a} + {a}\\cdot{r**(a-1)}\\cdot x + \\text{{higher order terms}}$",
                f"$\\lim_{{x \\to 0}} \\frac{{{r**a} + {a*r**(a-1)}x + ... - {r**a}}}{{x}}$",
                f"$\\lim_{{x \\to 0}} \\frac{{{a*r**(a-1)}x + ...}}{{x}}$",
                f"$\\lim_{{x \\to 0}} ({a*r**(a-1)} + ...) = {ans}$"
            ),
        )

emit(generate())