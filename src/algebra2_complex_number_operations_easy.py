"""
algebra2 - complex_number_operations (easy)
Generated: 2026-02-22T04:20:34.811352
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Adding/subtracting complex numbers (ELO 1000-1100)
        a_real = nonzero(-8, 8)
        a_imag = nonzero(-8, 8)
        b_real = nonzero(-8, 8)
        b_imag = nonzero(-8, 8)
        
        z1 = a_real + a_imag * I
        z2 = b_real + b_imag * I
        
        if randint(0, 1) == 0:
            # Addition
            ans = z1 + z2
            op = "+"
            result_real = a_real + b_real
            result_imag = a_imag + b_imag
            solution_text = steps(
                f"Add real parts: ${a_real} + {b_real} = {result_real}$",
                f"Add imaginary parts: ${a_imag}i + {b_imag}i = {result_imag}i$",
                f"Answer: ${latex(ans)}$"
            )
        else:
            # Subtraction
            ans = z1 - z2
            op = "-"
            result_real = a_real - b_real
            result_imag = a_imag - b_imag
            solution_text = steps(
                f"Subtract real parts: ${a_real} - ({b_real}) = {result_real}$",
                f"Subtract imaginary parts: ${a_imag}i - ({b_imag}i) = {result_imag}i$",
                f"Answer: ${latex(ans)}$"
            )
        
        return problem(
            question=f"Simplify: $({latex(z1)}) {op} ({latex(z2)})$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/complex_number_operations",
            solution=solution_text
        )
    
    elif problem_type == 2:
        # Multiplying a complex number by a real number (ELO 1050-1150)
        scalar = nonzero(-5, 5)
        c_real = nonzero(-6, 6)
        c_imag = nonzero(-6, 6)
        z = c_real + c_imag * I
        ans = scalar * z
        
        return problem(
            question=f"Simplify: ${scalar} \\cdot ({latex(z)})$",
            answer=ans,
            difficulty=(1050, 1150),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"Distribute ${scalar}$ to both terms",
                f"${scalar} \\cdot {c_real} + {scalar} \\cdot {c_imag}i$",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Simple multiplication (ELO 1100-1200)
        a_real = randint(-4, 4)
        a_imag = nonzero(-4, 4)
        b_real = randint(-4, 4)
        b_imag = nonzero(-4, 4)
        
        z1 = a_real + a_imag * I
        z2 = b_real + b_imag * I
        ans = expand(z1 * z2)
        
        # Calculate intermediate steps
        ac = a_real * b_real
        ad = a_real * b_imag
        bc = a_imag * b_real
        bd = a_imag * b_imag
        
        return problem(
            question=f"Multiply: $({latex(z1)})({latex(z2)})$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"Use FOIL method",
                f"$= {a_real} \\cdot {b_real} + {a_real} \\cdot {b_imag}i + {a_imag}i \\cdot {b_real} + {a_imag}i \\cdot {b_imag}i$",
                f"$= {ac} + {ad}i + {bc}i + {bd}i^2$",
                f"Since $i^2 = -1$: $= {ac} + {ad}i + {bc}i - {bd}$",
                f"$= {latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Powers of i (ELO 1050-1150)
        exponent = randint(2, 8)
        ans = I**exponent
        
        # Determine the pattern
        remainder = exponent % 4
        if remainder == 0:
            cycle_ans = 1
        elif remainder == 1:
            cycle_ans = I
        elif remainder == 2:
            cycle_ans = -1
        else:
            cycle_ans = -I
        
        return problem(
            question=f"Simplify: $i^{{{exponent}}}$",
            answer=ans,
            difficulty=(1050, 1150),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"Use the pattern: $i^1 = i, i^2 = -1, i^3 = -i, i^4 = 1$",
                f"Divide exponent by 4: ${exponent} = 4 \\cdot {exponent // 4} + {remainder}$",
                f"Therefore $i^{{{exponent}}} = i^{{{remainder}}} = {latex(ans)}$"
            )
        )
    
    else:
        # Finding the conjugate (ELO 1000-1100)
        c_real = nonzero(-8, 8)
        c_imag = nonzero(-8, 8)
        z = c_real + c_imag * I
        ans = conjugate(z)
        
        return problem(
            question=f"Find the complex conjugate of ${latex(z)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"The complex conjugate changes the sign of the imaginary part",
                f"Conjugate of ${latex(z)}$ is ${latex(ans)}$"
            )
        )

emit(generate())