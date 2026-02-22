"""
precalculus - domain_and_range (easy)
Generated: 2026-02-22T04:36:06.488951
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Type 1: Domain of a polynomial (1000-1100)
        # Polynomials have domain of all real numbers
        degree = randint(1, 3)
        coeff = nonzero(-5, 5)
        if degree == 1:
            func = coeff * x + randint(-10, 10)
        elif degree == 2:
            func = coeff * x**2 + nonzero(-5, 5) * x + randint(-10, 10)
        else:
            func = coeff * x**3 + nonzero(-5, 5) * x**2 + randint(-10, 10)
        
        return problem(
            question=f"Find the domain of $f(x) = {latex(func)}$",
            answer="(-oo, oo)",
            difficulty=(1000, 1100),
            topic="precalculus/domain_and_range",
            answer_type="interval",
            solution=steps(
                f"$f(x) = {latex(func)}$ is a polynomial function",
                "Polynomial functions are defined for all real numbers",
                "Domain: $(-\\infty, \\infty)$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Domain of a simple rational function (1100-1200)
        # Exclude where denominator = 0
        excluded = nonzero(-8, 8)
        numerator = nonzero(-5, 5) * x + randint(-10, 10)
        denominator = x - excluded
        
        return problem(
            question=f"Find the domain of $f(x) = \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            answer=f"(-oo, {excluded}) U ({excluded}, oo)",
            difficulty=(1100, 1200),
            topic="precalculus/domain_and_range",
            answer_type="interval",
            solution=steps(
                f"The function is undefined when the denominator equals zero",
                f"Set ${latex(denominator)} = 0$",
                f"$x = {excluded}$",
                f"Domain: all real numbers except ${excluded}$",
                f"Domain: $(-\\infty, {excluded}) \\cup ({excluded}, \\infty)$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Domain of simple square root (1150-1250)
        # Need argument >= 0
        a_val = choice([1, -1])
        b_val = nonzero(-10, 10)
        if a_val == 1:
            # sqrt(x + b), need x >= -b
            boundary = -b_val
            return problem(
                question=f"Find the domain of $f(x) = \\sqrt{{{latex(x + b_val)}}}$",
                answer=f"[{boundary}, oo)",
                difficulty=(1150, 1250),
                topic="precalculus/domain_and_range",
                answer_type="interval",
                solution=steps(
                    "The square root function requires a non-negative argument",
                    f"We need ${latex(x + b_val)} \\geq 0$",
                    f"$x \\geq {boundary}$",
                    f"Domain: $[{boundary}, \\infty)$"
                ),
            )
        else:
            # sqrt(-x + b) = sqrt(b - x), need x <= b
            boundary = b_val
            return problem(
                question=f"Find the domain of $f(x) = \\sqrt{{{latex(-x + b_val)}}}$",
                answer=f"(-oo, {boundary}]",
                difficulty=(1150, 1250),
                topic="precalculus/domain_and_range",
                answer_type="interval",
                solution=steps(
                    "The square root function requires a non-negative argument",
                    f"We need ${latex(-x + b_val)} \\geq 0$",
                    f"${-b_val} \\geq x$",
                    f"$x \\leq {boundary}$",
                    f"Domain: $(-\\infty, {boundary}]$"
                ),
            )
    
    elif problem_type == 4:
        # Type 4: Range of a constant function (1000-1100)
        c_val = randint(-10, 10)
        return problem(
            question=f"Find the range of $f(x) = {c_val}$",
            answer=f"{{{c_val}}}",
            difficulty=(1000, 1100),
            topic="precalculus/domain_and_range",
            answer_type="set",
            solution=steps(
                f"$f(x) = {c_val}$ is a constant function",
                f"The output is always ${c_val}$ regardless of the input",
                f"Range: $\\{{{c_val}\\}}$"
            ),
        )
    
    elif problem_type == 5:
        # Type 5: Range of a linear function (1050-1150)
        m_val = nonzero(-5, 5)
        b_val = randint(-10, 10)
        func = m_val * x + b_val
        
        return problem(
            question=f"Find the range of $f(x) = {latex(func)}$",
            answer="(-oo, oo)",
            difficulty=(1050, 1150),
            topic="precalculus/domain_and_range",
            answer_type="interval",
            solution=steps(
                f"$f(x) = {latex(func)}$ is a linear function with non-zero slope",
                "Linear functions with non-zero slope can output any real number",
                "Range: $(-\\infty, \\infty)$"
            ),
        )
    
    else:
        # Type 6: Range from a simple graph description (1200-1300)
        y_min = randint(-5, 5)
        y_max = y_min + randint(3, 8)
        
        return problem(
            question=f"A function has a graph where the lowest point is at $y = {y_min}$ and the highest point is at $y = {y_max}$. What is the range of the function?",
            answer=f"[{y_min}, {y_max}]",
            difficulty=(1200, 1300),
            topic="precalculus/domain_and_range",
            answer_type="interval",
            solution=steps(
                "The range consists of all possible output values",
                f"The minimum output value is ${y_min}$",
                f"The maximum output value is ${y_max}$",
                f"Range: $[{y_min}, {y_max}]$"
            ),
        )

emit(generate())