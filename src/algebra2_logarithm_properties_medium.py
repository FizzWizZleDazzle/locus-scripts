"""
algebra2 - logarithm_properties (medium)
Generated: 2026-02-22T04:31:04.009558
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Expand logarithm using product rule: log(ab) = log(a) + log(b)
        base = choice([2, 3, 5, 10])
        coeff1 = randint(2, 9)
        coeff2 = randint(2, 9)
        
        if randint(0, 1) == 0:
            # log_b(m*n)
            expr_inside = coeff1 * coeff2
            question = f"\\log_{{{base}}}({coeff1} \\cdot {coeff2})"
            ans = f"\\log_{{{base}}}({coeff1}) + \\log_{{{base}}}({coeff2})"
            solution_text = steps(
                f"Apply the product rule: $\\log_b(mn) = \\log_b(m) + \\log_b(n)$",
                f"${question} = {ans}$"
            )
        else:
            # log_b(x*y) with variables
            question = f"\\log_{{{base}}}(xy)"
            ans = f"\\log_{{{base}}}(x) + \\log_{{{base}}}(y)"
            solution_text = steps(
                f"Apply the product rule: $\\log_b(mn) = \\log_b(m) + \\log_b(n)$",
                f"${question} = {ans}$"
            )
        
        return problem(
            question=f"Expand using logarithm properties: ${question}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/logarithm_properties",
            solution=solution_text,
            answer_type="expression"
        )
    
    elif problem_type == 2:
        # Expand logarithm using quotient rule: log(a/b) = log(a) - log(b)
        base = choice([2, 3, 5, 10])
        
        if randint(0, 1) == 0:
            num = randint(12, 50)
            denom = randint(2, 9)
            question = f"\\log_{{{base}}}\\left(\\frac{{{num}}}{{{denom}}}\\right)"
            ans = f"\\log_{{{base}}}({num}) - \\log_{{{base}}}({denom})"
            solution_text = steps(
                f"Apply the quotient rule: $\\log_b\\left(\\frac{{m}}{{n}}\\right) = \\log_b(m) - \\log_b(n)$",
                f"${question} = {ans}$"
            )
        else:
            question = f"\\log_{{{base}}}\\left(\\frac{{x}}{{y}}\\right)"
            ans = f"\\log_{{{base}}}(x) - \\log_{{{base}}}(y)"
            solution_text = steps(
                f"Apply the quotient rule: $\\log_b\\left(\\frac{{m}}{{n}}\\right) = \\log_b(m) - \\log_b(n)$",
                f"${question} = {ans}$"
            )
        
        return problem(
            question=f"Expand using logarithm properties: ${question}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/logarithm_properties",
            solution=solution_text,
            answer_type="expression"
        )
    
    elif problem_type == 3:
        # Expand logarithm using power rule: log(a^n) = n*log(a)
        base = choice([2, 3, 5, 10])
        power = randint(2, 5)
        
        if randint(0, 1) == 0:
            value = randint(2, 12)
            question = f"\\log_{{{base}}}({value}^{{{power}}})"
            ans = f"{power} \\log_{{{base}}}({value})"
            solution_text = steps(
                f"Apply the power rule: $\\log_b(m^n) = n \\log_b(m)$",
                f"${question} = {ans}$"
            )
        else:
            question = f"\\log_{{{base}}}(x^{{{power}}})"
            ans = f"{power} \\log_{{{base}}}(x)"
            solution_text = steps(
                f"Apply the power rule: $\\log_b(m^n) = n \\log_b(m)$",
                f"${question} = {ans}$"
            )
        
        return problem(
            question=f"Expand using logarithm properties: ${question}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/logarithm_properties",
            solution=solution_text,
            answer_type="expression"
        )
    
    elif problem_type == 4:
        # Combined expansion: log(ab^n/c)
        base = choice([2, 3, 5, 10])
        power = randint(2, 4)
        
        if randint(0, 1) == 0:
            # With variables
            question = f"\\log_{{{base}}}\\left(\\frac{{x y^{{{power}}}}}{{z}}\\right)"
            ans = f"\\log_{{{base}}}(x) + {power} \\log_{{{base}}}(y) - \\log_{{{base}}}(z)"
            solution_text = steps(
                f"Apply quotient rule: $\\log_b\\left(\\frac{{m}}{{n}}\\right) = \\log_b(m) - \\log_b(n)$",
                f"$= \\log_{{{base}}}(x y^{{{power}}}) - \\log_{{{base}}}(z)$",
                f"Apply product rule: $\\log_b(mn) = \\log_b(m) + \\log_b(n)$",
                f"$= \\log_{{{base}}}(x) + \\log_{{{base}}}(y^{{{power}}}) - \\log_{{{base}}}(z)$",
                f"Apply power rule: $\\log_b(m^n) = n \\log_b(m)$",
                f"$= {ans}$"
            )
        else:
            # Simpler: log(x^m * y)
            power = randint(2, 5)
            question = f"\\log_{{{base}}}(x^{{{power}}} y)"
            ans = f"{power} \\log_{{{base}}}(x) + \\log_{{{base}}}(y)"
            solution_text = steps(
                f"Apply product rule: $\\log_b(mn) = \\log_b(m) + \\log_b(n)$",
                f"$= \\log_{{{base}}}(x^{{{power}}}) + \\log_{{{base}}}(y)$",
                f"Apply power rule: $\\log_b(m^n) = n \\log_b(m)$",
                f"$= {ans}$"
            )
        
        return problem(
            question=f"Expand using logarithm properties: ${question}$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="algebra2/logarithm_properties",
            solution=solution_text,
            answer_type="expression"
        )
    
    else:
        # Condense to single logarithm
        base = choice([2, 3, 5, 10])
        coeff = randint(2, 4)
        
        if randint(0, 1) == 0:
            # Condense: a*log(x) + log(y)
            question = f"{coeff} \\log_{{{base}}}(x) + \\log_{{{base}}}(y)"
            ans = f"\\log_{{{base}}}(x^{{{coeff}}} y)"
            solution_text = steps(
                f"Apply power rule: $n \\log_b(m) = \\log_b(m^n)$",
                f"$= \\log_{{{base}}}(x^{{{coeff}}}) + \\log_{{{base}}}(y)$",
                f"Apply product rule: $\\log_b(m) + \\log_b(n) = \\log_b(mn)$",
                f"$= {ans}$"
            )
        else:
            # Condense: log(x) - log(y)
            question = f"\\log_{{{base}}}(x) - \\log_{{{base}}}(y)"
            ans = f"\\log_{{{base}}}\\left(\\frac{{x}}{{y}}\\right)"
            solution_text = steps(
                f"Apply quotient rule: $\\log_b(m) - \\log_b(n) = \\log_b\\left(\\frac{{m}}{{n}}\\right)$",
                f"$= {ans}$"
            )
        
        return problem(
            question=f"Write as a single logarithm: ${question}$",
            answer=ans,
            difficulty=(1350, 1500),
            topic="algebra2/logarithm_properties",
            solution=solution_text,
            answer_type="expression"
        )

emit(generate())