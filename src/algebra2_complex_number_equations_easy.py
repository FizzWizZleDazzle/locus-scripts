"""
algebra2 - complex_number_equations (easy)
Generated: 2026-02-22T04:21:49.636464
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Solve simple equations like (x + ai) = bi (1000-1150)
        real_coeff = nonzero(-5, 5)
        imag_coeff = nonzero(-5, 5)
        result_imag = nonzero(-8, 8)
        
        # Answer is x = result_imag*I - real_coeff
        ans = result_imag * I - real_coeff
        
        question = f"Solve for $x$: $x + {real_coeff} = {result_imag}i$"
        
        solution = steps(
            f"Subtract ${real_coeff}$ from both sides",
            f"$x = {result_imag}i - {real_coeff}$",
            f"$x = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1150),
            topic="algebra2/complex_number_equations",
            solution=solution
        )
    
    elif problem_type == 2:
        # Type 2: Solve ax = b where a and b are complex (1100-1250)
        a_real = nonzero(-4, 4)
        a_imag = nonzero(-4, 4)
        b_real = nonzero(-6, 6)
        b_imag = nonzero(-6, 6)
        
        a_complex = a_real + a_imag * I
        b_complex = b_real + b_imag * I
        
        # x = b/a
        ans = simplify(b_complex / a_complex)
        
        question = f"Solve for $x$: ${latex(a_complex)} \\cdot x = {latex(b_complex)}$"
        
        solution = steps(
            f"Divide both sides by ${latex(a_complex)}$",
            f"$x = \\frac{{{latex(b_complex)}}}{{{latex(a_complex)}}}$",
            f"Multiply numerator and denominator by the conjugate ${latex(a_real - a_imag*I)}$",
            f"$x = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1250),
            topic="algebra2/complex_number_equations",
            solution=solution
        )
    
    elif problem_type == 3:
        # Type 3: x + (a + bi) = (c + di), solve for x (1000-1100)
        a_val = nonzero(-6, 6)
        b_val = nonzero(-6, 6)
        c_val = nonzero(-6, 6)
        d_val = nonzero(-6, 6)
        
        lhs_const = a_val + b_val * I
        rhs = c_val + d_val * I
        
        # x = rhs - lhs_const
        ans = rhs - lhs_const
        
        question = f"Solve for $x$: $x + ({latex(lhs_const)}) = {latex(rhs)}$"
        
        solution = steps(
            f"Subtract ${latex(lhs_const)}$ from both sides",
            f"$x = {latex(rhs)} - ({latex(lhs_const)})$",
            f"$x = ({c_val} - {a_val}) + ({d_val} - {b_val})i$",
            f"$x = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/complex_number_equations",
            solution=solution
        )
    
    else:
        # Type 4: Simple equation (a + bi)x = ci (1150-1300)
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-5, 5)
        
        lhs_coeff = a_val + b_val * I
        rhs = c_val * I
        
        ans = simplify(rhs / lhs_coeff)
        
        question = f"Solve for $x$: $({latex(lhs_coeff)})x = {latex(rhs)}$"
        
        solution = steps(
            f"Divide both sides by ${latex(lhs_coeff)}$",
            f"$x = \\frac{{{latex(rhs)}}}{{{latex(lhs_coeff)}}}$",
            f"Multiply by conjugate ${latex(a_val - b_val*I)}$",
            f"$x = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1150, 1300),
            topic="algebra2/complex_number_equations",
            solution=solution
        )

emit(generate())