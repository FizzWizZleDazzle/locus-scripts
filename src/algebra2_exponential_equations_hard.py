"""
algebra2 - exponential_equations (hard)
Generated: 2026-02-22T04:30:22.234723
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type 1: Exponential equation with different bases that simplify
        # e.g., 2^(3x+1) = 8^(x-2)
        base1 = choice([2, 3, 5])
        power_of_base = choice([2, 3])
        base2 = base1 ** power_of_base
        
        coeff1 = nonzero(-3, 3)
        const1 = nonzero(-4, 4)
        coeff2 = nonzero(-3, 3)
        const2 = nonzero(-4, 4)
        
        # base1^(coeff1*x + const1) = base2^(coeff2*x + const2)
        # base1^(coeff1*x + const1) = base1^(power_of_base*(coeff2*x + const2))
        # coeff1*x + const1 = power_of_base*coeff2*x + power_of_base*const2
        # (coeff1 - power_of_base*coeff2)*x = power_of_base*const2 - const1
        
        if coeff1 - power_of_base * coeff2 == 0:
            coeff1 += 1
        
        ans = Rational(power_of_base * const2 - const1, coeff1 - power_of_base * coeff2)
        
        exp1_str = f"{coeff1}x" if coeff1 != 1 else "x"
        if coeff1 == -1:
            exp1_str = "-x"
        if const1 > 0:
            exp1_str += f" + {const1}"
        elif const1 < 0:
            exp1_str += f" - {-const1}"
            
        exp2_str = f"{coeff2}x" if coeff2 != 1 else "x"
        if coeff2 == -1:
            exp2_str = "-x"
        if const2 > 0:
            exp2_str += f" + {const2}"
        elif const2 < 0:
            exp2_str += f" - {-const2}"
        
        return problem(
            question=f"Solve for $x$: ${base1}^{{{exp1_str}}} = {base2}^{{{exp2_str}}}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"Rewrite ${base2}$ as ${base1}^{{{power_of_base}}}$",
                f"${base1}^{{{exp1_str}}} = ({base1}^{{{power_of_base}}})^{{{exp2_str}}}$",
                f"${base1}^{{{exp1_str}}} = {base1}^{{{power_of_base}({exp2_str})}}$",
                f"Since the bases are equal: ${exp1_str} = {power_of_base}({exp2_str})$",
                f"${exp1_str} = {latex(expand(power_of_base*(coeff2*x + const2)))}$",
                f"${latex((coeff1 - power_of_base*coeff2)*x)} = {power_of_base*const2 - const1}$",
                f"$x = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Exponential equation requiring logarithms with non-standard base
        # a^(bx+c) = d where d is not a clean power of a
        base = choice([2, 3, 5, 7])
        coeff = nonzero(-3, 3)
        const = nonzero(-4, 4)
        value = randint(10, 100)
        while value in [base**k for k in range(1, 8)]:
            value = randint(10, 100)
        
        # base^(coeff*x + const) = value
        # coeff*x + const = log_base(value)
        # x = (log_base(value) - const) / coeff
        
        ans = (log(value, base) - const) / coeff
        
        exp_str = f"{coeff}x" if coeff != 1 else "x"
        if coeff == -1:
            exp_str = "-x"
        if const > 0:
            exp_str += f" + {const}"
        elif const < 0:
            exp_str += f" - {-const}"
        
        return problem(
            question=f"Solve for $x$ (exact answer): ${base}^{{{exp_str}}} = {value}$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"Take $\\log_{{{base}}}$ of both sides",
                f"${exp_str} = \\log_{{{base}}}({value})$",
                f"${latex(coeff*x)} = \\log_{{{base}}}({value}) - {const}$",
                f"$x = \\frac{{\\log_{{{base}}}({value}) - {const}}}{{{coeff}}}$",
                f"$x = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Exponential equation with sum/difference on one side
        # a^x + b*a^x = c or a^(x+k) - a^x = c
        base = choice([2, 3, 5])
        k = randint(1, 3)
        
        if choice([True, False]):
            # a^(x+k) + a^x = c
            # a^x(a^k + 1) = c
            # a^x = c/(a^k + 1)
            factor_val = base**k + 1
            # Pick c so that c/factor_val is a power of base
            power = randint(2, 4)
            c_val = factor_val * (base ** power)
            
            ans = power
            
            return problem(
                question=f"Solve for $x$: ${base}^{{x+{k}}} + {base}^x = {c_val}$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="algebra2/exponential_equations",
                solution=steps(
                    f"Factor out ${base}^x$: ${base}^x \\cdot {base}^{{{k}}} + {base}^x = {c_val}$",
                    f"${base}^x({base}^{{{k}}} + 1) = {c_val}$",
                    f"${base}^x \\cdot {base**k + 1} = {c_val}$",
                    f"${base}^x = {c_val // factor_val}$",
                    f"${base}^x = {base}^{{{power}}}$",
                    f"$x = {ans}$"
                ),
            )
        else:
            # a^(x+k) - a^x = c
            # a^x(a^k - 1) = c
            factor_val = base**k - 1
            power = randint(2, 4)
            c_val = factor_val * (base ** power)
            
            ans = power
            
            return problem(
                question=f"Solve for $x$: ${base}^{{x+{k}}} - {base}^x = {c_val}$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="algebra2/exponential_equations",
                solution=steps(
                    f"Factor out ${base}^x$: ${base}^x \\cdot {base}^{{{k}}} - {base}^x = {c_val}$",
                    f"${base}^x({base}^{{{k}}} - 1) = {c_val}$",
                    f"${base}^x \\cdot {base**k - 1} = {c_val}$",
                    f"${base}^x = {c_val // factor_val}$",
                    f"${base}^x = {base}^{{{power}}}$",
                    f"$x = {ans}$"
                ),
            )
    
    elif problem_type == 4:
        # Type 4: Quadratic in exponential form
        # a^(2x) + b*a^x + c = 0, let u = a^x
        base = choice([2, 3])
        
        # Pick two positive roots for u
        u1 = base ** randint(1, 3)
        u2 = base ** randint(1, 3)
        
        # (u - u1)(u - u2) = u^2 - (u1+u2)u + u1*u2
        b_coeff = -(u1 + u2)
        c_coeff = u1 * u2
        
        # a^x = u1 => x = log_a(u1), a^x = u2 => x = log_a(u2)
        x1 = log(u1, base)
        x2 = log(u2, base)
        
        ans = FiniteSet(x1, x2)
        
        return problem(
            question=f"Solve for $x$: ${base}^{{2x}} {b_coeff:+d} \\cdot {base}^x {c_coeff:+d} = 0$",
            answer=ans,
            difficulty=(1750, 1900),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"Let $u = {base}^x$, then the equation becomes $u^2 {b_coeff:+d}u {c_coeff:+d} = 0$",
                f"Factor: $(u - {u1})(u - {u2}) = 0$",
                f"So $u = {u1}$ or $u = {u2}$",
                f"${base}^x = {u1}$ gives $x = \\log_{{{base}}}({u1}) = {latex(x1)}$",
                f"${base}^x = {u2}$ gives $x = \\log_{{{base}}}({u2}) = {latex(x2)}$",
                f"$x \\in {latex(ans)}$"
            ),
        )
    
    else:
        # Type 5: Exponential equation with natural log/e
        # e^(ax+b) = c where c requires natural log
        coeff = nonzero(-3, 3)
        const = nonzero(-4, 4)
        value = randint(5, 50)
        
        # e^(coeff*x + const) = value
        # coeff*x + const = ln(value)
        # x = (ln(value) - const) / coeff
        
        ans = (log(value) - const) / coeff
        
        exp_str = f"{coeff}x" if coeff != 1 else "x"
        if coeff == -1:
            exp_str = "-x"
        if const > 0:
            exp_str += f" + {const}"
        elif const < 0:
            exp_str += f" - {-const}"
        
        return problem(
            question=f"Solve for $x$ (exact answer): $e^{{{exp_str}}} = {value}$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"Take the natural logarithm of both sides",
                f"$\\ln(e^{{{exp_str}}}) = \\ln({value})$",
                f"${exp_str} = \\ln({value})$",
                f"${latex(coeff*x)} = \\ln({value}) - {const}$",
                f"$x = \\frac{{\\ln({value}) - {const}}}{{{coeff}}}$",
                f"$x = {latex(ans)}$"
            ),
        )

emit(generate())