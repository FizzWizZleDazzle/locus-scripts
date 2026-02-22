"""
algebra1 - factoring_gcf (easy)
Generated: 2026-02-22T03:59:50.090435
"""

from problem_utils import *

def generate():
    difficulty_choice = randint(1, 3)
    
    if difficulty_choice == 1:
        # 1000-1100: Simple GCF extraction from two terms with obvious common factor
        gcf = choice([2, 3, 4, 5])
        coeff1 = gcf * randint(1, 4)
        coeff2 = gcf * randint(1, 4)
        
        expr = coeff1 * x + coeff2
        ans = factor(expr)
        
        return problem(
            question=f"Factor out the greatest common factor: ${latex(expr)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra1/factoring_gcf",
            grading_mode="factor",
            solution=steps(
                f"The GCF of ${coeff1}$ and ${coeff2}$ is ${gcf}$",
                f"Factor out ${gcf}$: ${latex(ans)}$"
            )
        )
    
    elif difficulty_choice == 2:
        # 1100-1200: GCF with variable factor included
        gcf_num = choice([2, 3, 4, 5])
        coeff1 = gcf_num * randint(1, 3)
        coeff2 = gcf_num * randint(1, 3)
        power = randint(1, 2)
        
        expr = coeff1 * x**(power + 1) + coeff2 * x**power
        ans = factor(expr)
        
        return problem(
            question=f"Factor out the greatest common factor: ${latex(expr)}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra1/factoring_gcf",
            grading_mode="factor",
            solution=steps(
                f"The GCF of the coefficients ${coeff1}$ and ${coeff2}$ is ${gcf_num}$",
                f"The GCF of ${latex(x**(power+1))}$ and ${latex(x**power)}$ is ${latex(x**power)}$",
                f"Factor out ${gcf_num}{latex(x**power)}$: ${latex(ans)}$"
            )
        )
    
    else:
        # 1200-1300: Three terms with both numeric and variable GCF
        gcf_num = choice([2, 3, 4])
        coeff1 = gcf_num * randint(1, 3)
        coeff2 = gcf_num * randint(1, 3)
        coeff3 = gcf_num * randint(1, 3)
        power = randint(1, 2)
        
        expr = coeff1 * x**(power + 2) + coeff2 * x**(power + 1) + coeff3 * x**power
        ans = factor(expr)
        
        return problem(
            question=f"Factor out the greatest common factor: ${latex(expr)}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra1/factoring_gcf",
            grading_mode="factor",
            solution=steps(
                f"The GCF of the coefficients ${coeff1}$, ${coeff2}$, and ${coeff3}$ is ${gcf_num}$",
                f"The lowest power of $x$ is ${latex(x**power)}$",
                f"Factor out ${gcf_num}{latex(x**power)}$: ${latex(ans)}$"
            )
        )

emit(generate())