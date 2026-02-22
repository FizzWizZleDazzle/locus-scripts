"""
algebra2 - logarithmic_equations (hard)
Generated: 2026-02-22T04:33:17.353845
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Logarithmic equation with different bases requiring change of base or properties
        # log_a(x) = log_b(x) type problems
        base1 = choice([2, 3, 4, 5])
        base2 = choice([b for b in [2, 3, 4, 5, 6, 7, 8, 9] if b != base1])
        
        # Answer will be x = 1 (only solution where log_a(1) = log_b(1) = 0)
        # Or we can construct: log_base1(x) = k, log_base2(x) = m where x = base1^k = base2^m
        
        # Let's make: log_2(x^2) = log_4(x^3)
        # This gives: 2*log_2(x) = (3/2)*log_2(x)
        # So (1/2)*log_2(x) = 0, thus x = 1
        
        # Better: log_base1(x + a) + log_base1(x + b) = c
        base = choice([2, 3, 5])
        a_val = randint(1, 4)
        b_val = randint(1, 4)
        
        # Construct: log_base(x+a) + log_base(x+b) = log_base(product)
        # (x+a)(x+b) = base^c
        c_val = randint(2, 3)
        product = base**c_val
        
        # Solve: (x+a)(x+b) = product
        # x^2 + (a+b)x + ab = product
        # x^2 + (a+b)x + (ab - product) = 0
        
        coeffs_sum = a_val + b_val
        constant = a_val * b_val - product
        
        solutions = solve(x**2 + coeffs_sum*x + constant, x)
        valid_solutions = [sol for sol in solutions if sol > -min(a_val, b_val)]
        
        if len(valid_solutions) == 1:
            ans = valid_solutions[0]
        else:
            ans = max(valid_solutions)
        
        return problem(
            question=f"\\log_{{{base}}}(x + {a_val}) + \\log_{{{base}}}(x + {b_val}) = {c_val}",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Use the logarithm property: $\\log_b(m) + \\log_b(n) = \\log_b(mn)$",
                f"$\\log_{{{base}}}[(x + {a_val})(x + {b_val})] = {c_val}$",
                f"Convert to exponential form: $(x + {a_val})(x + {b_val}) = {base}^{{{c_val}}} = {product}$",
                f"Expand: $x^2 + {coeffs_sum}x + {a_val * b_val} = {product}$",
                f"$x^2 + {coeffs_sum}x + {constant} = 0$",
                f"Solve using quadratic formula to get $x = {latex(ans)}$",
                f"Check that $x + {a_val} > 0$ and $x + {b_val} > 0$ (both satisfied)"
            ),
        )
    
    elif problem_type == 2:
        # Equation with log on both sides: log_a(f(x)) = log_a(g(x))
        base = choice([2, 3, 5])
        
        # log_base(x^2 - k) = log_base(mx)
        # So x^2 - k = mx
        # x^2 - mx - k = 0
        
        m_val = randint(2, 5)
        k_val = randint(3, 8)
        
        solutions = solve(x**2 - m_val*x - k_val, x)
        
        # Filter positive solutions that make arguments positive
        valid_solutions = []
        for sol in solutions:
            if sol > 0 and sol**2 - k_val > 0:
                valid_solutions.append(sol)
        
        if len(valid_solutions) > 0:
            ans = max(valid_solutions)
        else:
            # Reconstruct with guaranteed positive solution
            ans = randint(4, 8)
            k_val = ans**2 - m_val*ans
        
        return problem(
            question=f"\\log_{{{base}}}(x^2 - {k_val}) = \\log_{{{base}}}({m_val}x)",
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Since the logarithms have the same base, set arguments equal:",
                f"$x^2 - {k_val} = {m_val}x$",
                f"$x^2 - {m_val}x - {k_val} = 0$",
                f"Solve: $x = {latex(ans)}$ or $x = {latex(m_val - ans)}$",
                f"Check domain: need $x^2 - {k_val} > 0$ and ${m_val}x > 0$",
                f"Only $x = {latex(ans)}$ satisfies both conditions"
            ),
        )
    
    elif problem_type == 3:
        # Natural log equation: ln(f(x)) + ln(g(x)) = k
        a_val = randint(2, 5)
        b_val = randint(1, 3)
        
        # ln(x) + ln(x - a) = ln(b)
        # x(x - a) = b
        # x^2 - ax - b = 0
        
        solutions = solve(x**2 - a_val*x - b_val, x)
        valid_solutions = [sol for sol in solutions if sol > a_val]
        
        if len(valid_solutions) > 0:
            ans = valid_solutions[0]
        else:
            ans = a_val + randint(1, 3)
            b_val = ans**2 - a_val*ans
        
        return problem(
            question=f"\\ln(x) + \\ln(x - {a_val}) = \\ln({b_val})",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Use $\\ln(m) + \\ln(n) = \\ln(mn)$:",
                f"$\\ln[x(x - {a_val})] = \\ln({b_val})$",
                f"Since $\\ln$ is one-to-one: $x(x - {a_val}) = {b_val}$",
                f"$x^2 - {a_val}x - {b_val} = 0$",
                f"Solving gives $x = {latex(ans)}$",
                f"Check: $x > {a_val}$ ✓"
            ),
        )
    
    elif problem_type == 4:
        # Subtraction of logs: log_b(f(x)) - log_b(g(x)) = k
        base = choice([2, 3, 4, 5])
        a_val = randint(2, 6)
        k_val = randint(1, 2)
        
        # log_base(x + a) - log_base(x) = k
        # (x + a)/x = base^k
        # x + a = x * base^k
        # a = x(base^k - 1)
        # x = a/(base^k - 1)
        
        power = base**k_val
        ans = Rational(a_val, power - 1)
        
        return problem(
            question=f"\\log_{{{base}}}(x + {a_val}) - \\log_{{{base}}}(x) = {k_val}",
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Use $\\log_b(m) - \\log_b(n) = \\log_b(m/n)$:",
                f"$\\log_{{{base}}}\\left(\\frac{{x + {a_val}}}{{x}}\\right) = {k_val}$",
                f"Convert to exponential form: $\\frac{{x + {a_val}}}{{x}} = {base}^{{{k_val}}} = {power}$",
                f"$x + {a_val} = {power}x$",
                f"${a_val} = {power - 1}x$",
                f"$x = \\frac{{{a_val}}}{{{power - 1}}} = {latex(ans)}$"
            ),
        )
    
    else:
        # Complex equation: log_base(x) = a - b*log_base(c)
        base = choice([2, 3, 5])
        c_val = randint(2, 4)
        a_val = randint(2, 4)
        b_val = randint(1, 2)
        
        # log_base(x) + b*log_base(c) = a
        # log_base(x) + log_base(c^b) = a
        # log_base(x * c^b) = a
        # x * c^b = base^a
        # x = base^a / c^b
        
        numerator = base**a_val
        denominator = c_val**b_val
        ans = Rational(numerator, denominator)
        
        return problem(
            question=f"\\log_{{{base}}}(x) + {b_val}\\log_{{{base}}}({c_val}) = {a_val}",
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Use ${b_val}\\log_{{{base}}}({c_val}) = \\log_{{{base}}}({c_val}^{{{b_val}}}) = \\log_{{{base}}}({denominator})$",
                f"$\\log_{{{base}}}(x) + \\log_{{{base}}}({denominator}) = {a_val}$",
                f"$\\log_{{{base}}}({denominator}x) = {a_val}$",
                f"Convert to exponential: ${denominator}x = {base}^{{{a_val}}} = {numerator}$",
                f"$x = \\frac{{{numerator}}}{{{denominator}}} = {latex(ans)}$"
            ),
        )

emit(generate())