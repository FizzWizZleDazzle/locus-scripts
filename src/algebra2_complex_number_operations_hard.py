"""
algebra2 - complex_number_operations (hard)
Generated: 2026-02-22T04:21:29.596920
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Complex number powers and roots (1600-1800)
        # Find z^n where z is in a+bi form
        re_part = nonzero(-3, 3)
        im_part = nonzero(-3, 3)
        z = re_part + im_part * I
        power = randint(3, 4)
        
        ans = expand(z**power)
        ans = ans.rewrite(cos).rewrite(sin).simplify()
        
        return problem(
            question=f"Compute ${latex(z)}^{{{power}}}$ and express in the form $a + bi$.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"Let $z = {latex(z)}$",
                f"Expand $z^{{{power}}} = {latex(z)}^{{{power}}}$",
                f"After expansion and simplification: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Division of complex numbers with conjugates (1650-1800)
        # (a + bi) / (c + di)
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        c_val = nonzero(-4, 4)
        d_val = nonzero(-4, 4)
        
        numerator = a_val + b_val * I
        denominator = c_val + d_val * I
        
        # Compute answer by multiplying by conjugate
        conjugate = c_val - d_val * I
        top = expand(numerator * conjugate)
        bottom = c_val**2 + d_val**2
        
        ans = simplify(top / bottom)
        
        return problem(
            question=f"Simplify $\\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$ and express in the form $a + bi$.",
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"Multiply numerator and denominator by the conjugate ${latex(conjugate)}$",
                f"Numerator: ${latex(numerator)} \\cdot {latex(conjugate)} = {latex(top)}$",
                f"Denominator: ${latex(denominator)} \\cdot {latex(conjugate)} = {bottom}$",
                f"Result: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Find complex roots of quadratic with no real solutions (1600-1750)
        # x^2 + bx + c = 0 where discriminant < 0
        p = nonzero(-4, 4)
        q = nonzero(-4, 4)
        
        # Roots will be p ± qi (construct backward)
        # (x - (p + qi))(x - (p - qi)) = x^2 - 2px + (p^2 + q^2)
        b_coeff = -2 * p
        c_coeff = p**2 + q**2
        
        eq = Eq(x**2 + b_coeff * x + c_coeff, 0)
        roots = solve(eq, x)
        ans = FiniteSet(*roots)
        
        return problem(
            question=f"Find all complex solutions to ${latex(x**2 + b_coeff * x + c_coeff)} = 0$.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"Use quadratic formula: $x = \\frac{{-b \\pm \\sqrt{{b^2 - 4ac}}}}{{2a}}$",
                f"$a = 1, b = {b_coeff}, c = {c_coeff}$",
                f"Discriminant: $\\Delta = {b_coeff**2} - 4(1)({c_coeff}) = {b_coeff**2 - 4*c_coeff}$",
                f"Since $\\Delta < 0$, we have complex roots",
                f"$x = \\frac{{{-b_coeff} \\pm \\sqrt{{{b_coeff**2 - 4*c_coeff}}}}}{{2}} = \\frac{{{-b_coeff} \\pm {abs(b_coeff**2 - 4*c_coeff)}i}}{{2}}$",
                f"Solutions: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Complex number equation solving (1700-1850)
        # Solve for z in (a + bi)z + (c + di) = (e + fi)
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-4, 4)
        d_val = nonzero(-4, 4)
        e_val = nonzero(-4, 4)
        f_val = nonzero(-4, 4)
        
        coeff = a_val + b_val * I
        const = c_val + d_val * I
        rhs = e_val + f_val * I
        
        # z = (rhs - const) / coeff
        ans = simplify((rhs - const) / coeff)
        
        return problem(
            question=f"Solve for $z$ in the equation $({latex(coeff)})z + ({latex(const)}) = {latex(rhs)}$. Express in the form $a + bi$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"Isolate $z$: $({latex(coeff)})z = {latex(rhs)} - ({latex(const)}) = {latex(rhs - const)}$",
                f"Divide by ${latex(coeff)}$: $z = \\frac{{{latex(rhs - const)}}}{{{latex(coeff)}}}$",
                f"Multiply by conjugate ${latex(conjugate(coeff))}$ to rationalize",
                f"$z = {latex(ans)}$"
            ),
        )
    
    else:
        # Modulus and argument computation (1650-1800)
        # Find |z|^2 where z involves operations
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-3, 3)
        d_val = nonzero(-3, 3)
        
        z1 = a_val + b_val * I
        z2 = c_val + d_val * I
        
        operation = choice(['multiply', 'divide'])
        
        if operation == 'multiply':
            z = expand(z1 * z2)
            ans = abs(z)**2
            ans = simplify(ans)
            
            return problem(
                question=f"Find $|z|^2$ where $z = ({latex(z1)})({latex(z2)})$.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="algebra2/complex_number_operations",
                solution=steps(
                    f"First compute $z = ({latex(z1)})({latex(z2)}) = {latex(z)}$",
                    f"The modulus squared is $|z|^2 = z \\cdot \\overline{{z}}$",
                    f"For $z = {latex(z)}$, we have $|z|^2 = {latex(ans)}$"
                ),
            )
        else:
            z = simplify(z1 / z2)
            ans = abs(z)**2
            ans = simplify(ans)
            
            return problem(
                question=f"Find $|z|^2$ where $z = \\frac{{{latex(z1)}}}{{{latex(z2)}}}$.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="algebra2/complex_number_operations",
                solution=steps(
                    f"Use the property $\\left|\\frac{{z_1}}{{z_2}}\\right|^2 = \\frac{{|z_1|^2}}{{|z_2|^2}}$",
                    f"$|{latex(z1)}|^2 = {abs(z1)**2}$",
                    f"$|{latex(z2)}|^2 = {abs(z2)**2}$",
                    f"Therefore $|z|^2 = \\frac{{{abs(z1)**2}}}{{{abs(z2)**2}} = {latex(ans)}$"
                ),
            )

emit(generate())