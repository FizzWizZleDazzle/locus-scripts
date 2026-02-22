"""
algebra1 - factoring_gcf (hard)
Generated: 2026-02-22T04:00:28.057243
"""

from problem_utils import *

def generate():
    difficulty_choice = randint(1, 4)
    
    if difficulty_choice == 1:
        # Level 1600-1700: GCF with 3 terms, including negatives and higher powers
        gcf = choice([2, 3, 4, 5, 6])
        power1 = randint(3, 5)
        power2 = randint(2, power1 - 1)
        power3 = randint(1, power2 - 1)
        
        coeff1 = gcf * nonzero(-4, 4)
        coeff2 = gcf * nonzero(-4, 4)
        coeff3 = gcf * nonzero(-4, 4)
        
        expr = coeff1 * x**power1 + coeff2 * x**power2 + coeff3 * x**power3
        ans = factor(expr)
        
        return problem(
            question=f"Factor completely: ${latex(expr)}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/factoring_gcf",
            grading_mode="factor",
            solution=steps(
                f"Identify the GCF of the coefficients: ${gcf}$",
                f"Identify the lowest power of $x$: $x^{{{power3}}}$",
                f"The GCF is ${gcf}x^{{{power3}}}$",
                f"Factor out: ${latex(ans)}$"
            )
        )
    
    elif difficulty_choice == 2:
        # Level 1650-1750: GCF with two variables
        gcf = choice([2, 3, 4, 5])
        x_power1 = randint(3, 5)
        x_power2 = randint(2, x_power1 - 1)
        x_power3 = randint(1, x_power2 - 1)
        
        y_power1 = randint(2, 4)
        y_power2 = randint(1, y_power1 - 1)
        y_power3 = randint(1, y_power2)
        
        coeff1 = gcf * nonzero(-3, 3)
        coeff2 = gcf * nonzero(-3, 3)
        coeff3 = gcf * nonzero(-3, 3)
        
        expr = coeff1 * x**x_power1 * y**y_power1 + coeff2 * x**x_power2 * y**y_power2 + coeff3 * x**x_power3 * y**y_power3
        ans = factor(expr)
        
        return problem(
            question=f"Factor completely: ${latex(expr)}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra1/factoring_gcf",
            grading_mode="factor",
            solution=steps(
                f"Identify the GCF of the coefficients: ${gcf}$",
                f"Identify the lowest power of $x$: $x^{{{x_power3}}}$",
                f"Identify the lowest power of $y$: $y^{{{y_power3}}}$",
                f"The GCF is ${gcf}x^{{{x_power3}}}y^{{{y_power3}}}$",
                f"Factor out: ${latex(ans)}$"
            )
        )
    
    elif difficulty_choice == 3:
        # Level 1700-1800: GCF with 4 terms and two variables
        gcf = choice([2, 3, 4, 6])
        x_power = randint(2, 4)
        y_power = randint(2, 3)
        
        coeff1 = gcf * nonzero(-5, 5)
        coeff2 = gcf * nonzero(-5, 5)
        coeff3 = gcf * nonzero(-5, 5)
        coeff4 = gcf * nonzero(-5, 5)
        
        expr = (coeff1 * x**(x_power + 2) * y**(y_power + 1) + 
                coeff2 * x**(x_power + 1) * y**(y_power + 2) + 
                coeff3 * x**(x_power + 1) * y**y_power + 
                coeff4 * x**x_power * y**y_power)
        ans = factor(expr)
        
        return problem(
            question=f"Factor completely: ${latex(expr)}$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra1/factoring_gcf",
            grading_mode="factor",
            solution=steps(
                f"Identify the GCF of the coefficients: ${gcf}$",
                f"Identify the lowest power of $x$: $x^{{{x_power}}}$",
                f"Identify the lowest power of $y$: $y^{{{y_power}}}$",
                f"The GCF is ${gcf}x^{{{x_power}}}y^{{{y_power}}}$",
                f"Factor out: ${latex(ans)}$"
            )
        )
    
    else:
        # Level 1750-1900: GCF with three variables and negative leading coefficient
        gcf = choice([2, 3, 4, 6])
        x_power = randint(2, 3)
        y_power = randint(1, 3)
        z_power = randint(1, 2)
        
        coeff1 = -gcf * randint(2, 4)
        coeff2 = gcf * nonzero(-4, 4)
        coeff3 = gcf * nonzero(-4, 4)
        coeff4 = gcf * nonzero(-4, 4)
        
        expr = (coeff1 * x**(x_power + 2) * y**(y_power + 1) * z**(z_power + 1) + 
                coeff2 * x**(x_power + 1) * y**(y_power + 1) * z**z_power + 
                coeff3 * x**(x_power + 1) * y**y_power * z**(z_power + 1) + 
                coeff4 * x**x_power * y**y_power * z**z_power)
        ans = factor(expr)
        
        return problem(
            question=f"Factor completely: ${latex(expr)}$",
            answer=ans,
            difficulty=(1750, 1900),
            topic="algebra1/factoring_gcf",
            grading_mode="factor",
            solution=steps(
                f"Note the negative leading coefficient suggests factoring out a negative GCF",
                f"Identify the GCF of the absolute values of coefficients: ${gcf}$",
                f"Identify the lowest power of $x$: $x^{{{x_power}}}$",
                f"Identify the lowest power of $y$: $y^{{{y_power}}}$",
                f"Identify the lowest power of $z$: $z^{{{z_power}}}$",
                f"The GCF is ${-gcf if coeff1 < 0 else gcf}x^{{{x_power}}}y^{{{y_power}}}z^{{{z_power}}}$",
                f"Factor out: ${latex(ans)}$"
            )
        )

emit(generate())