"""
algebra1 - factoring_gcf (medium)
Generated: 2026-02-22T04:00:06.234293
"""

from problem_utils import *

def generate():
    # Generate GCF factoring problems at 1300-1600 difficulty
    # Standard level: 2-3 terms with clear GCF
    
    problem_type = randint(1, 3)
    
    if problem_type == 1:
        # Two-term factoring with monomial GCF (1300-1400)
        gcf_coeff = randint(2, 6)
        gcf_power = randint(1, 3)
        
        term1_extra_coeff = randint(2, 8)
        term1_extra_power = randint(0, 2)
        
        term2_extra_coeff = randint(2, 8)
        term2_extra_power = randint(0, 2)
        
        # Build terms
        term1 = gcf_coeff * term1_extra_coeff * x**(gcf_power + term1_extra_power)
        term2 = gcf_coeff * term2_extra_coeff * x**(gcf_power + term2_extra_power)
        
        expr = term1 + term2
        ans = factor(expr)
        
        difficulty_val = (1300, 1400)
        sol = steps(
            f"Identify the GCF of ${latex(term1)}$ and ${latex(term2)}$",
            f"GCF = ${latex(gcf_coeff * x**gcf_power)}$",
            f"Factor out the GCF: ${latex(ans)}$"
        )
        
    elif problem_type == 2:
        # Three-term factoring with monomial GCF (1400-1500)
        gcf_coeff = randint(2, 5)
        gcf_power = randint(1, 2)
        
        term1_extra_coeff = randint(1, 6)
        term1_extra_power = randint(1, 3)
        
        term2_extra_coeff = randint(1, 6)
        term2_extra_power = randint(0, 2)
        
        term3_extra_coeff = randint(1, 6)
        
        # Build terms
        term1 = gcf_coeff * term1_extra_coeff * x**(gcf_power + term1_extra_power)
        term2 = gcf_coeff * term2_extra_coeff * x**(gcf_power + term2_extra_power)
        term3 = gcf_coeff * term3_extra_coeff * x**gcf_power
        
        expr = term1 + term2 + term3
        ans = factor(expr)
        
        difficulty_val = (1400, 1500)
        sol = steps(
            f"Identify the GCF of all terms in ${latex(expr)}$",
            f"GCF = ${latex(gcf_coeff * x**gcf_power)}$",
            f"Factor out the GCF: ${latex(ans)}$"
        )
        
    else:
        # Three-term with negative coefficient and higher powers (1500-1600)
        gcf_coeff = randint(2, 4)
        gcf_power = randint(1, 2)
        
        # Make first coefficient negative for added complexity
        sign = -1
        
        term1_extra_coeff = randint(2, 5)
        term1_extra_power = randint(2, 3)
        
        term2_extra_coeff = randint(2, 5)
        term2_extra_power = randint(1, 2)
        
        term3_extra_coeff = randint(1, 4)
        
        # Build terms
        term1 = sign * gcf_coeff * term1_extra_coeff * x**(gcf_power + term1_extra_power)
        term2 = sign * gcf_coeff * term2_extra_coeff * x**(gcf_power + term2_extra_power)
        term3 = sign * gcf_coeff * term3_extra_coeff * x**gcf_power
        
        expr = term1 + term2 + term3
        ans = factor(expr)
        
        difficulty_val = (1500, 1600)
        sol = steps(
            f"Identify the GCF of all terms in ${latex(expr)}$",
            f"Note: Factor out the negative to simplify",
            f"GCF = ${latex(sign * gcf_coeff * x**gcf_power)}$",
            f"Factor out the GCF: ${latex(ans)}$"
        )
    
    return problem(
        question=f"Factor out the greatest common factor (GCF): ${latex(expr)}$",
        answer=ans,
        difficulty=difficulty_val,
        topic="algebra1/factoring_gcf",
        grading_mode="factor",
        solution=sol
    )

emit(generate())