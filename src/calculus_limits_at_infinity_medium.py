"""
calculus - limits_at_infinity (medium)
Generated: 2026-02-22T05:00:17.007883
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Polynomial over polynomial (standard limit at infinity)
        # Choose degree relationship
        deg_relationship = choice(['same', 'top_higher', 'bottom_higher'])
        
        if deg_relationship == 'same':
            # Same degree: limit is ratio of leading coefficients
            deg = randint(2, 4)
            a_lead = nonzero(-5, 5)
            b_lead = nonzero(-5, 5)
            
            # Build polynomials
            top_terms = [a_lead * x**deg]
            bottom_terms = [b_lead * x**deg]
            
            for i in range(1, deg):
                top_terms.append(nonzero(-8, 8) * x**(deg - i))
                bottom_terms.append(nonzero(-8, 8) * x**(deg - i))
            
            top = sum(top_terms)
            bottom = sum(bottom_terms)
            expr = top / bottom
            ans = Rational(a_lead, b_lead)
            
            question = f"\\lim_{{x \\to \\infty}} {latex(expr)}"
            solution = steps(
                f"The highest degree term in numerator is ${latex(a_lead * x**deg)}$",
                f"The highest degree term in denominator is ${latex(b_lead * x**deg)}$",
                f"Since degrees are equal, the limit is the ratio of leading coefficients: $\\frac{{{a_lead}}}{{{b_lead}}} = {latex(ans)}$"
            )
            difficulty = (1300, 1400)
            
        elif deg_relationship == 'top_higher':
            # Top degree higher: limit is ±∞
            top_deg = randint(3, 5)
            bottom_deg = top_deg - randint(1, 2)
            a_lead = nonzero(-4, 4)
            b_lead = choice([i for i in range(1, 5)])  # positive denominator
            
            top = a_lead * x**top_deg + nonzero(-5, 5) * x**(top_deg - 1)
            bottom = b_lead * x**bottom_deg + nonzero(-5, 5) * x**(bottom_deg - 1)
            expr = top / bottom
            
            if a_lead > 0:
                ans = oo
                ans_str = "\\infty"
            else:
                ans = -oo
                ans_str = "-\\infty"
            
            question = f"\\lim_{{x \\to \\infty}} {latex(expr)}"
            solution = steps(
                f"Degree of numerator ({top_deg}) > degree of denominator ({bottom_deg})",
                f"Leading coefficient of numerator is ${a_lead}$ (positive)" if a_lead > 0 else f"Leading coefficient of numerator is ${a_lead}$ (negative)",
                f"Therefore the limit is ${ans_str}$"
            )
            difficulty = (1400, 1500)
            
        else:  # bottom_higher
            # Bottom degree higher: limit is 0
            bottom_deg = randint(3, 5)
            top_deg = bottom_deg - randint(1, 2)
            
            top = nonzero(-5, 5) * x**top_deg + nonzero(-5, 5) * x**(top_deg - 1)
            bottom = nonzero(-5, 5) * x**bottom_deg + nonzero(-5, 5) * x**(bottom_deg - 1)
            expr = top / bottom
            ans = 0
            
            question = f"\\lim_{{x \\to \\infty}} {latex(expr)}"
            solution = steps(
                f"Degree of numerator ({top_deg}) < degree of denominator ({bottom_deg})",
                f"Therefore the limit is $0$"
            )
            difficulty = (1300, 1400)
    
    elif problem_type == 2:
        # Exponential growth dominates polynomial
        power = randint(2, 4)
        coeff = nonzero(-5, 5)
        poly_term = nonzero(-10, 10) * x**randint(1, 3)
        
        expr = (poly_term) / exp(x)
        ans = 0
        
        question = f"\\lim_{{x \\to \\infty}} {latex(expr)}"
        solution = steps(
            f"Exponential functions grow faster than polynomial functions",
            f"As $x \\to \\infty$, $e^x$ grows much faster than ${latex(poly_term)}$",
            f"Therefore the limit is $0$"
        )
        difficulty = (1400, 1550)
    
    elif problem_type == 3:
        # Square root expressions
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        # sqrt(a*x^2 + b*x) - sqrt(c*x^2)
        if a > 0 and c > 0:
            expr = sqrt(a*x**2 + b*x) - sqrt(c*x**2)
            # Factor out x from inside sqrt for large x
            # sqrt(a*x^2) - sqrt(c*x^2) dominates
            # = x*sqrt(a) - x*sqrt(c) = x(sqrt(a) - sqrt(c))
            # But b*x term matters
            
            # Simpler version: just sqrt difference
            expr = sqrt(x**2 + b*x) - x
            ans = Rational(b, 2)
            
            question = f"\\lim_{{x \\to \\infty}} \\left({latex(expr)}\\right)"
            solution = steps(
                f"Multiply by conjugate: $\\frac{{\\sqrt{{x^2 + {b}x}} - x}}{{1}} \\cdot \\frac{{\\sqrt{{x^2 + {b}x}} + x}}{{\\sqrt{{x^2 + {b}x}} + x}}$",
                f"$= \\frac{{x^2 + {b}x - x^2}}{{\\sqrt{{x^2 + {b}x}} + x}} = \\frac{{{b}x}}{{\\sqrt{{x^2 + {b}x}} + x}}$",
                f"Divide numerator and denominator by $x$: $\\frac{{{b}}}{{\\sqrt{{1 + \\frac{{{b}}}{{x}}}} + 1}}$",
                f"As $x \\to \\infty$: $\\frac{{{b}}}{{1 + 1}} = {latex(ans)}$"
            )
            difficulty = (1500, 1600)
        else:
            # Fall back to simpler polynomial ratio
            a = choice([i for i in range(1, 6)])
            b = choice([i for i in range(1, 6)])
            expr = (a*x**2) / (b*x**2 + x)
            ans = Rational(a, b)
            
            question = f"\\lim_{{x \\to \\infty}} {latex(expr)}"
            solution = steps(
                f"Divide numerator and denominator by $x^2$",
                f"$= \\lim_{{x \\to \\infty}} \\frac{{{a}}}{{{b} + \\frac{{1}}{{x}}}}$",
                f"As $x \\to \\infty$, $\\frac{{1}}{{x}} \\to 0$, so limit is $\\frac{{{a}}}{{{b}}} = {latex(ans)}$"
            )
            difficulty = (1300, 1400)
    
    elif problem_type == 4:
        # Rational with square roots
        a = choice([i for i in range(1, 5)])
        b = nonzero(-5, 5)
        c = choice([i for i in range(1, 5)])
        
        expr = (a*x + b) / sqrt(c*x**2 + x)
        # Divide by x: (a + b/x) / sqrt(c + 1/x)
        # limit is a/sqrt(c)
        ans = a / sqrt(c)
        
        question = f"\\lim_{{x \\to \\infty}} {latex(expr)}"
        solution = steps(
            f"Divide numerator and denominator by $x$",
            f"$= \\lim_{{x \\to \\infty}} \\frac{{{a} + \\frac{{{b}}}{{x}}}}{{\\sqrt{{{c} + \\frac{{1}}{{x}}}}}}$",
            f"As $x \\to \\infty$: $\\frac{{{a}}}{{\\sqrt{{{c}}}}} = {latex(ans)}$"
        )
        difficulty = (1400, 1550)
    
    else:  # problem_type == 5
        # Simple polynomial ratio (most standard)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = nonzero(-6, 6)
        
        expr = (a*x**2 + b*x) / (c*x**2 + d)
        ans = Rational(a, c)
        
        question = f"\\lim_{{x \\to \\infty}} {latex(expr)}"
        solution = steps(
            f"Divide numerator and denominator by $x^2$",
            f"$= \\lim_{{x \\to \\infty}} \\frac{{{a} + \\frac{{{b}}}{{x}}}}{{{c} + \\frac{{{d}}}{{x^2}}}}$",
            f"As $x \\to \\infty$, terms with $x$ in denominator approach $0$",
            f"Limit is $\\frac{{{a}}}{{{c}}} = {latex(ans)}$"
        )
        difficulty = (1300, 1400)
    
    return problem(
        question=question,
        answer=ans,
        difficulty=difficulty,
        topic="calculus/limits_at_infinity",
        solution=solution
    )

emit(generate())