"""
algebra1 - two_step_equations (hard)
Generated: 2026-02-22T03:48:34.848134
"""

from problem_utils import *

def generate():
    # For HARDER two-step equations (1600-1900), we need:
    # - Equations with fractions/decimals
    # - Distribution on both sides
    # - Variables on both sides
    # - Word problems requiring setup
    # - Multiple nested operations
    
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type 1: Fraction coefficients with distribution
        # Example: (2/3)(x + 6) - 4 = 10
        num = randint(2, 5)
        den = randint(2, 5)
        while gcd(num, den) != 1 or num == den:
            den = randint(2, 5)
        
        b_inside = nonzero(-8, 8)
        c_const = nonzero(-10, 10)
        target = nonzero(-15, 15)
        
        # Solve backwards: (num/den)(x + b_inside) + c_const = target
        # (num/den)x + (num/den)*b_inside + c_const = target
        # (num/den)x = target - c_const - (num/den)*b_inside
        # x = (target - c_const - (num/den)*b_inside) * (den/num)
        
        x_val = (target - c_const) * den / num - b_inside
        x_val = int(x_val) if x_val == int(x_val) else Rational(x_val).limit_denominator()
        
        frac_coeff = Rational(num, den)
        eq_lhs = frac_coeff * (x + b_inside) + c_const
        
        return problem(
            question=f"Solve for $x$: ${latex(eq_lhs)} = {target}$",
            answer=x_val,
            difficulty=(1600, 1750),
            topic="algebra1/two_step_equations",
            solution=steps(
                f"${latex(eq_lhs)} = {target}$",
                f"Subtract ${c_const}$ from both sides: ${latex(frac_coeff * (x + b_inside))} = {target - c_const}$",
                f"Multiply both sides by $\\frac{{{den}}}{{{num}}}$: $x + {b_inside} = {latex((target - c_const) * den / num)}$",
                f"Subtract ${b_inside}$ from both sides: $x = {latex(x_val)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Variables on both sides with distribution
        # Example: 3(x - 2) = 2x + 5
        coeff1 = nonzero(-5, 5)
        inside1 = nonzero(-8, 8)
        coeff2 = nonzero(-5, 5)
        while coeff1 == coeff2:
            coeff2 = nonzero(-5, 5)
        const2 = nonzero(-10, 10)
        
        # Solve: coeff1(x + inside1) = coeff2*x + const2
        # coeff1*x + coeff1*inside1 = coeff2*x + const2
        # (coeff1 - coeff2)*x = const2 - coeff1*inside1
        x_val = (const2 - coeff1 * inside1) / (coeff1 - coeff2)
        x_val = int(x_val) if x_val == int(x_val) else Rational(x_val).limit_denominator()
        
        lhs = coeff1 * (x + inside1)
        rhs = coeff2 * x + const2
        
        return problem(
            question=f"Solve for $x$: ${latex(lhs)} = {latex(rhs)}$",
            answer=x_val,
            difficulty=(1650, 1800),
            topic="algebra1/two_step_equations",
            solution=steps(
                f"${latex(lhs)} = {latex(rhs)}$",
                f"Expand: ${latex(expand(lhs))} = {latex(rhs)}$",
                f"Subtract ${latex(coeff2*x)}$ from both sides: ${latex((coeff1-coeff2)*x + coeff1*inside1)} = {const2}$",
                f"Subtract ${coeff1*inside1}$ from both sides: ${latex((coeff1-coeff2)*x)} = {const2 - coeff1*inside1}$",
                f"Divide by ${coeff1-coeff2}$: $x = {latex(x_val)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Distribution on both sides
        # Example: 2(x + 3) - 5 = 3(x - 1) + 2
        a1 = nonzero(-4, 4)
        b1 = nonzero(-6, 6)
        c1 = nonzero(-8, 8)
        a2 = nonzero(-4, 4)
        while a1 == a2:
            a2 = nonzero(-4, 4)
        b2 = nonzero(-6, 6)
        c2 = nonzero(-8, 8)
        
        # a1(x + b1) + c1 = a2(x + b2) + c2
        # a1*x + a1*b1 + c1 = a2*x + a2*b2 + c2
        # (a1 - a2)*x = a2*b2 + c2 - a1*b1 - c1
        x_val = (a2*b2 + c2 - a1*b1 - c1) / (a1 - a2)
        x_val = int(x_val) if x_val == int(x_val) else Rational(x_val).limit_denominator()
        
        lhs = a1 * (x + b1) + c1
        rhs = a2 * (x + b2) + c2
        
        return problem(
            question=f"Solve for $x$: ${latex(lhs)} = {latex(rhs)}$",
            answer=x_val,
            difficulty=(1700, 1850),
            topic="algebra1/two_step_equations",
            solution=steps(
                f"${latex(lhs)} = {latex(rhs)}$",
                f"Expand both sides: ${latex(expand(lhs))} = {latex(expand(rhs))}$",
                f"Collect $x$ terms on one side: ${latex((a1-a2)*x)} = {latex(a2*b2 + c2 - a1*b1 - c1)}$",
                f"Divide by ${a1-a2}$: $x = {latex(x_val)}$"
            ),
        )
    
    elif problem_type == 4:
        # Type 4: Word problem requiring equation setup
        # Example: "A number is tripled, then 5 is subtracted. The result is 16. Find the number."
        operation_type = randint(1, 3)
        
        if operation_type == 1:
            # "multiplied by a, then b is added/subtracted"
            mult = randint(2, 6)
            add_sub = choice(["added", "subtracted"])
            b_val = randint(3, 15)
            result = randint(10, 40)
            
            if add_sub == "added":
                x_val = (result - b_val) / mult
            else:
                x_val = (result + b_val) / mult
            
            x_val = int(x_val) if x_val == int(x_val) else Rational(x_val).limit_denominator()
            
            op_sign = "+" if add_sub == "added" else "-"
            
            return problem(
                question=f"A number is multiplied by ${mult}$, then ${b_val}$ is {add_sub}. The result is ${result}$. Find the number.",
                answer=x_val,
                difficulty=(1600, 1750),
                topic="algebra1/two_step_equations",
                solution=steps(
                    f"Let $x$ be the unknown number",
                    f"Set up equation: ${mult}x {op_sign} {b_val} = {result}$",
                    f"Subtract/add ${b_val}$: ${mult}x = {result - b_val if add_sub == 'added' else result + b_val}$",
                    f"Divide by ${mult}$: $x = {latex(x_val)}$"
                ),
            )
        else:
            # "divided by a, then b is added/subtracted"
            div = randint(2, 5)
            add_sub = choice(["added", "subtracted"])
            b_val = randint(3, 12)
            result = randint(5, 25)
            
            if add_sub == "added":
                x_val = (result - b_val) * div
            else:
                x_val = (result + b_val) * div
            
            x_val = int(x_val)
            op_sign = "+" if add_sub == "added" else "-"
            
            return problem(
                question=f"A number is divided by ${div}$, then ${b_val}$ is {add_sub}. The result is ${result}$. Find the number.",
                answer=x_val,
                difficulty=(1650, 1800),
                topic="algebra1/two_step_equations",
                solution=steps(
                    f"Let $x$ be the unknown number",
                    f"Set up equation: $\\frac{{x}}{{{div}}} {op_sign} {b_val} = {result}$",
                    f"Subtract/add ${b_val}$: $\\frac{{x}}{{{div}}} = {result - b_val if add_sub == 'added' else result + b_val}$",
                    f"Multiply by ${div}$: $x = {x_val}$"
                ),
            )
    
    else:
        # Type 5: Nested fractions/complex coefficients
        # Example: (x/2 + 3)/4 = 5
        inner_den = randint(2, 4)
        inner_add = nonzero(-6, 6)
        outer_den = randint(2, 5)
        result = nonzero(-10, 10)
        
        # (x/inner_den + inner_add)/outer_den = result
        # x/inner_den + inner_add = result * outer_den
        # x/inner_den = result * outer_den - inner_add
        # x = (result * outer_den - inner_add) * inner_den
        
        x_val = (result * outer_den - inner_add) * inner_den
        
        return problem(
            question=f"Solve for $x$: $\\frac{{\\frac{{x}}{{{inner_den}}} + {inner_add}}}{{{outer_den}}} = {result}$",
            answer=x_val,
            difficulty=(1750, 1900),
            topic="algebra1/two_step_equations",
            solution=steps(
                f"$\\frac{{\\frac{{x}}{{{inner_den}}} + {inner_add}}}{{{outer_den}}} = {result}$",
                f"Multiply both sides by ${outer_den}$: $\\frac{{x}}{{{inner_den}}} + {inner_add} = {result * outer_den}$",
                f"Subtract ${inner_add}$: $\\frac{{x}}{{{inner_den}}} = {result * outer_den - inner_add}$",
                f"Multiply by ${inner_den}$: $x = {x_val}$"
            ),
        )

emit(generate())