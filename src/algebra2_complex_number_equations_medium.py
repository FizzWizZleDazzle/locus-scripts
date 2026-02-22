"""
algebra2 - complex_number_equations (medium)
Generated: 2026-02-22T04:22:14.511603
"""

from problem_utils import *

def generate():
    problem_type = choice(['solve_basic', 'solve_quadratic', 'operations', 'powers'])
    
    if problem_type == 'solve_basic':
        # Solve az + b = c + di where a, b, c, d are real
        # Target difficulty: 1300-1400
        a_coeff = nonzero(-5, 5)
        b_real = randint(-8, 8)
        c_real = randint(-8, 8)
        d_imag = nonzero(-8, 8)
        
        lhs = a_coeff * z + b_real
        rhs = c_real + d_imag * I
        
        solution_val = solve(Eq(lhs, rhs), z)[0]
        
        return problem(
            question=f"Solve for $z$: ${latex(lhs)} = {latex(rhs)}$",
            answer=solution_val,
            difficulty=(1300, 1400),
            topic="algebra2/complex_number_equations",
            solution=steps(
                f"${latex(lhs)} = {latex(rhs)}$",
                f"${latex(a_coeff * z)} = {latex(rhs - b_real)}$",
                f"$z = {latex(solution_val)}$"
            ),
        )
    
    elif problem_type == 'solve_quadratic':
        # Solve z^2 + bz + c = 0 where solutions are complex
        # Target difficulty: 1500-1600
        real_part = randint(-3, 3)
        imag_part = nonzero(-4, 4)
        
        # Roots are real_part ± imag_part*i
        root1 = real_part + imag_part * I
        root2 = real_part - imag_part * I
        
        # Expand (z - root1)(z - root2)
        b_coeff = -2 * real_part
        c_coeff = real_part**2 + imag_part**2
        
        equation = z**2 + b_coeff * z + c_coeff
        solutions = solve(equation, z)
        
        ans = FiniteSet(*solutions)
        
        return problem(
            question=f"Solve for $z$: ${latex(equation)} = 0$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="algebra2/complex_number_equations",
            solution=steps(
                f"Use quadratic formula: $z = \\frac{{-b \\pm \\sqrt{{b^2 - 4ac}}}}{{2a}}$",
                f"$z = \\frac{{-({b_coeff}) \\pm \\sqrt{{({b_coeff})^2 - 4(1)({c_coeff})}}}}{{2}}$",
                f"$z = \\frac{{{-b_coeff} \\pm \\sqrt{{{b_coeff**2 - 4*c_coeff}}}}}{{2}}$",
                f"$z = {latex(root1)}$ or $z = {latex(root2)}$"
            ),
        )
    
    elif problem_type == 'operations':
        # Simplify (a + bi)(c + di) or divide complex numbers
        # Target difficulty: 1300-1500
        if choice([True, False]):
            # Multiplication
            a_val = nonzero(-5, 5)
            b_val = nonzero(-5, 5)
            c_val = nonzero(-5, 5)
            d_val = nonzero(-5, 5)
            
            z1 = a_val + b_val * I
            z2 = c_val + d_val * I
            
            result = expand(z1 * z2)
            
            return problem(
                question=f"Simplify: $({latex(z1)})({latex(z2)})$",
                answer=result,
                difficulty=(1300, 1400),
                topic="algebra2/complex_number_equations",
                solution=steps(
                    f"$({a_val} + {b_val}i)({c_val} + {d_val}i)$",
                    f"$= {a_val*c_val} + {a_val*d_val}i + {b_val*c_val}i + {b_val*d_val}i^2$",
                    f"$= {a_val*c_val} + {a_val*d_val + b_val*c_val}i + {b_val*d_val}(-1)$",
                    f"$= {latex(result)}$"
                ),
            )
        else:
            # Division
            a_val = randint(-6, 6)
            b_val = nonzero(-6, 6)
            c_val = nonzero(-4, 4)
            d_val = nonzero(-4, 4)
            
            numerator = a_val + b_val * I
            denominator = c_val + d_val * I
            
            result = simplify(numerator / denominator)
            
            conjugate = c_val - d_val * I
            
            return problem(
                question=f"Simplify: $\\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
                answer=result,
                difficulty=(1400, 1500),
                topic="algebra2/complex_number_equations",
                solution=steps(
                    f"Multiply by conjugate: $\\frac{{{latex(numerator)}}}{{{latex(denominator)}}} \\cdot \\frac{{{latex(conjugate)}}}{{{latex(conjugate)}}}$",
                    f"$= \\frac{{{latex(expand(numerator * conjugate))}}}{{{latex(expand(denominator * conjugate))}}}$",
                    f"$= {latex(result)}$"
                ),
            )
    
    else:  # powers
        # Simplify i^n or solve equations with powers of i
        # Target difficulty: 1300-1400
        if choice([True, False]):
            # Simplify i^n
            n_val = randint(5, 20)
            result = I**n_val
            
            remainder = n_val % 4
            
            return problem(
                question=f"Simplify: $i^{{{n_val}}}$",
                answer=result,
                difficulty=(1300, 1400),
                topic="algebra2/complex_number_equations",
                solution=steps(
                    f"Since $i^4 = 1$, find ${n_val} \\bmod 4 = {remainder}$",
                    f"$i^{{{n_val}}} = i^{{{remainder}}} = {latex(result)}$"
                ),
            )
        else:
            # Solve z^2 = a + bi
            a_val = randint(-8, 8)
            b_val = nonzero(-8, 8)
            
            target = a_val + b_val * I
            solutions = solve(z**2 - target, z)
            ans = FiniteSet(*solutions)
            
            return problem(
                question=f"Solve for $z$: $z^2 = {latex(target)}$",
                answer=ans,
                difficulty=(1500, 1600),
                topic="algebra2/complex_number_equations",
                solution=steps(
                    f"$z^2 = {latex(target)}$",
                    f"$z = \\pm\\sqrt{{{latex(target)}}}$",
                    f"Solutions: $z = {latex(solutions[0])}$ or $z = {latex(solutions[1])}$"
                ),
            )

emit(generate())