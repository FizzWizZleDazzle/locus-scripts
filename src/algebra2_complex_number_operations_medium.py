"""
algebra2 - complex_number_operations (medium)
Generated: 2026-02-22T04:20:59.168860
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Addition/Subtraction of complex numbers (1300-1400)
        a_real = nonzero(-8, 8)
        a_imag = nonzero(-8, 8)
        b_real = nonzero(-8, 8)
        b_imag = nonzero(-8, 8)
        
        z1 = a_real + a_imag * I
        z2 = b_real + b_imag * I
        
        if randint(0, 1) == 0:
            # Addition
            ans = z1 + z2
            operation = "+"
            ans_real = a_real + b_real
            ans_imag = a_imag + b_imag
        else:
            # Subtraction
            ans = z1 - z2
            operation = "-"
            ans_real = a_real - b_real
            ans_imag = a_imag - b_imag
        
        return problem(
            question=f"Simplify: $({latex(z1)}) {operation} ({latex(z2)})$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"Combine real parts: ${a_real} {operation} {b_real} = {ans_real}$",
                f"Combine imaginary parts: ${a_imag}i {operation} {b_imag}i = {ans_imag}i$",
                f"Result: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Multiplication of complex numbers (1400-1500)
        a_real = nonzero(-5, 5)
        a_imag = nonzero(-5, 5)
        b_real = nonzero(-5, 5)
        b_imag = nonzero(-5, 5)
        
        z1 = a_real + a_imag * I
        z2 = b_real + b_imag * I
        ans = expand(z1 * z2)
        
        return problem(
            question=f"Multiply: $({latex(z1)})({latex(z2)})$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"Use FOIL: $({a_real})({b_real}) + ({a_real})({b_imag}i) + ({a_imag}i)({b_real}) + ({a_imag}i)({b_imag}i)$",
                f"Simplify: ${a_real*b_real} + {a_real*b_imag}i + {a_imag*b_real}i + {a_imag*b_imag}i^2$",
                f"Since $i^2 = -1$: ${a_real*b_real} + {a_real*b_imag}i + {a_imag*b_real}i - {a_imag*b_imag}$",
                f"Combine like terms: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Division of complex numbers (1500-1600)
        # Choose denominator first for cleaner answers
        denom_real = nonzero(-4, 4)
        denom_imag = nonzero(-4, 4)
        
        # Multiply by a simple complex number to get numerator
        mult_real = nonzero(-3, 3)
        mult_imag = nonzero(-3, 3)
        
        z_denom = denom_real + denom_imag * I
        z_mult = mult_real + mult_imag * I
        z_num = expand(z_mult * z_denom)
        
        ans = z_mult
        conjugate = denom_real - denom_imag * I
        
        return problem(
            question=f"Divide: $\\frac{{{latex(z_num)}}}{{{latex(z_denom)}}}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"Multiply numerator and denominator by conjugate ${latex(conjugate)}$",
                f"Numerator: $({latex(z_num)})({latex(conjugate)})$",
                f"Denominator: $({latex(z_denom)})({latex(conjugate)}) = {denom_real**2} - ({denom_imag}i)^2 = {denom_real**2 + denom_imag**2}$",
                f"Simplify to get: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Conjugate and modulus (1300-1400)
        a_real = nonzero(-8, 8)
        a_imag = nonzero(-8, 8)
        z = a_real + a_imag * I
        
        if randint(0, 1) == 0:
            # Find conjugate
            ans = conjugate(z)
            return problem(
                question=f"Find the complex conjugate of ${latex(z)}$",
                answer=ans,
                difficulty=(1300, 1400),
                topic="algebra2/complex_number_operations",
                solution=steps(
                    f"The complex conjugate of $a + bi$ is $a - bi$",
                    f"Conjugate of ${latex(z)}$ is ${latex(ans)}$"
                )
            )
        else:
            # Find modulus
            ans = sqrt(a_real**2 + a_imag**2)
            return problem(
                question=f"Find the modulus (absolute value) of ${latex(z)}$",
                answer=ans,
                difficulty=(1300, 1400),
                topic="algebra2/complex_number_operations",
                solution=steps(
                    f"For $z = a + bi$, the modulus is $|z| = \\sqrt{{a^2 + b^2}}$",
                    f"$|z| = \\sqrt{{({a_real})^2 + ({a_imag})^2}}$",
                    f"$|z| = \\sqrt{{{a_real**2 + a_imag**2}}} = {latex(ans)}$"
                )
            )
    
    else:
        # Powers of i (1300-1400)
        exponent = randint(3, 20)
        
        # i^n cycles: i^1=i, i^2=-1, i^3=-i, i^4=1
        remainder = exponent % 4
        if remainder == 0:
            ans = 1
        elif remainder == 1:
            ans = I
        elif remainder == 2:
            ans = -1
        else:
            ans = -I
        
        return problem(
            question=f"Simplify: $i^{{{exponent}}}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/complex_number_operations",
            solution=steps(
                f"Powers of $i$ cycle every 4: $i^1=i$, $i^2=-1$, $i^3=-i$, $i^4=1$",
                f"Divide exponent by 4: ${exponent} = 4 \\cdot {exponent//4} + {remainder}$",
                f"So $i^{{{exponent}}} = i^{{{remainder}}} = {latex(ans)}$"
            )
        )

emit(generate())