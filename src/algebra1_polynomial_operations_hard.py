"""
algebra1 - polynomial_operations (hard)
Generated: 2026-02-22T03:59:35.101981
"""

from problem_utils import *

def generate():
    problem_type = choice([
        'multiply_binomials_expanded',
        'factor_difference_of_squares',
        'multiply_three_binomials',
        'factor_perfect_square_trinomial',
        'polynomial_division',
        'multiply_with_distribution',
        'factor_by_grouping',
        'expand_binomial_power'
    ])
    
    if problem_type == 'multiply_binomials_expanded':
        # (ax + b)(cx + d)(ex + f) expanded form
        a_val = nonzero(-3, 3)
        b_val = nonzero(-5, 5)
        c_val = nonzero(-3, 3)
        d_val = nonzero(-5, 5)
        e_val = nonzero(-2, 2)
        f_val = nonzero(-5, 5)
        
        expr1 = a_val*x + b_val
        expr2 = c_val*x + d_val
        expr3 = e_val*x + f_val
        
        full_expr = expr1 * expr2 * expr3
        ans = expand(full_expr)
        
        return problem(
            question=f"Expand $({latex(expr1)})({latex(expr2)})({latex(expr3)})$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra1/polynomial_operations",
            grading_mode="expand",
            solution=steps(
                f"First multiply $({latex(expr1)})({latex(expr2)}) = {latex(expand(expr1*expr2))}$",
                f"Then multiply by $({latex(expr3)})$",
                f"$({latex(expand(expr1*expr2))})({latex(expr3)}) = {latex(ans)}$"
            )
        )
    
    elif problem_type == 'factor_difference_of_squares':
        # Factor a^2x^2 - b^2y^2 type expression
        a_val = randint(2, 5)
        b_val = randint(2, 5)
        
        expr = (a_val*x)**2 - (b_val*y)**2
        ans = factor(expr)
        
        return problem(
            question=f"Factor ${latex(expr)}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/polynomial_operations",
            grading_mode="factor",
            solution=steps(
                f"Recognize difference of squares: $a^2 - b^2 = (a+b)(a-b)$",
                f"Here $a = {a_val}x$ and $b = {b_val}y$",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 'multiply_three_binomials':
        # (x + a)(x + b)(x + c) - find the coefficient of x^2 or x term
        a_val = nonzero(-6, 6)
        b_val = nonzero(-6, 6)
        c_val = nonzero(-6, 6)
        
        expr1 = x + a_val
        expr2 = x + b_val
        expr3 = x + c_val
        
        expanded = expand(expr1 * expr2 * expr3)
        coeff_x2 = expanded.as_coefficients_dict()[x**2]
        
        return problem(
            question=f"What is the coefficient of $x^2$ in the expansion of $({latex(expr1)})({latex(expr2)})({latex(expr3)})$?",
            answer=coeff_x2,
            difficulty=(1700, 1800),
            topic="algebra1/polynomial_operations",
            solution=steps(
                f"Expand $({latex(expr1)})({latex(expr2)})({latex(expr3)})$",
                f"Full expansion: ${latex(expanded)}$",
                f"Coefficient of $x^2$ is ${coeff_x2}$",
                f"Alternatively: coefficient of $x^2$ is $({a_val}) + ({b_val}) + ({c_val}) = {coeff_x2}$"
            )
        )
    
    elif problem_type == 'factor_perfect_square_trinomial':
        # Factor ax^2 + 2abx + b^2 or similar
        a_val = choice([2, 3, 4, 5])
        b_val = nonzero(-7, 7)
        
        expr = expand((a_val*x + b_val)**2)
        ans = factor(expr)
        
        return problem(
            question=f"Factor ${latex(expr)}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra1/polynomial_operations",
            grading_mode="factor",
            solution=steps(
                f"Recognize perfect square trinomial: $a^2 + 2ab + b^2 = (a+b)^2$",
                f"First term: $({a_val}x)^2$, last term: $({b_val})^2$",
                f"Middle term: $2 \\cdot {a_val}x \\cdot {b_val} = {2*a_val*b_val}x$",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 'polynomial_division':
        # (ax^3 + bx^2 + cx + d) / (x + e), find quotient
        e_val = nonzero(-5, 5)
        a_val = nonzero(-3, 3)
        b_val = randint(-10, 10)
        c_val = randint(-10, 10)
        
        # Make it divide evenly: construct dividend as (x + e) * (quadratic)
        q2 = a_val
        q1 = randint(-5, 5)
        q0 = randint(-5, 5)
        
        quotient = a_val*x**2 + q1*x + q0
        divisor = x + e_val
        dividend = expand(quotient * divisor)
        
        return problem(
            question=f"Divide ${latex(dividend)}$ by ${latex(divisor)}$. What is the quotient?",
            answer=quotient,
            difficulty=(1750, 1850),
            topic="algebra1/polynomial_operations",
            solution=steps(
                f"Use polynomial long division or synthetic division",
                f"Divide ${latex(dividend)}$ by ${latex(divisor)}$",
                f"Quotient: ${latex(quotient)}$"
            )
        )
    
    elif problem_type == 'multiply_with_distribution':
        # (ax^2 + bx + c)(dx + e)
        a_val = nonzero(-4, 4)
        b_val = nonzero(-6, 6)
        c_val = nonzero(-8, 8)
        d_val = nonzero(-3, 3)
        e_val = nonzero(-6, 6)
        
        expr1 = a_val*x**2 + b_val*x + c_val
        expr2 = d_val*x + e_val
        ans = expand(expr1 * expr2)
        
        return problem(
            question=f"Expand $({latex(expr1)})({latex(expr2)})$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/polynomial_operations",
            grading_mode="expand",
            solution=steps(
                f"Distribute each term of ${latex(expr2)}$ to each term of ${latex(expr1)}$",
                f"${latex(d_val*x)} \\cdot ({latex(expr1)}) = {latex(expand(d_val*x*expr1))}$",
                f"${latex(e_val)} \\cdot ({latex(expr1)}) = {latex(expand(e_val*expr1))}$",
                f"Add: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 'factor_by_grouping':
        # Factor ax^3 + bx^2 + cx + d by grouping
        # Construct as (mx + n)(px^2 + q)
        m_val = nonzero(-3, 3)
        n_val = nonzero(-5, 5)
        p_val = nonzero(-3, 3)
        q_val = nonzero(-5, 5)
        
        factor1 = m_val*x + n_val
        factor2 = p_val*x**2 + q_val
        expr = expand(factor1 * factor2)
        ans = factor(expr)
        
        return problem(
            question=f"Factor by grouping: ${latex(expr)}$",
            answer=ans,
            difficulty=(1750, 1850),
            topic="algebra1/polynomial_operations",
            grading_mode="factor",
            solution=steps(
                f"Group terms: $({latex(m_val*p_val*x**3 + m_val*q_val*x)}) + ({latex(n_val*p_val*x**2 + n_val*q_val)})$",
                f"Factor each group: ${latex(m_val*x)}({latex(p_val*x**2 + q_val)}) + {latex(n_val)}({latex(p_val*x**2 + q_val)})$",
                f"Common factor: $({latex(p_val*x**2 + q_val)})({latex(m_val*x + n_val)})$",
                f"${latex(ans)}$"
            )
        )
    
    else:  # expand_binomial_power
        # (ax + b)^3
        a_val = nonzero(-3, 3)
        b_val = nonzero(-4, 4)
        
        expr = (a_val*x + b_val)**3
        ans = expand(expr)
        
        return problem(
            question=f"Expand $({latex(a_val*x + b_val)})^3$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra1/polynomial_operations",
            grading_mode="expand",
            solution=steps(
                f"Use $(a+b)^3 = a^3 + 3a^2b + 3ab^2 + b^3$",
                f"Here $a = {a_val}x$ and $b = {b_val}$",
                f"$({a_val}x)^3 + 3({a_val}x)^2({b_val}) + 3({a_val}x)({b_val})^2 + ({b_val})^3$",
                f"${latex(ans)}$"
            )
        )

emit(generate())