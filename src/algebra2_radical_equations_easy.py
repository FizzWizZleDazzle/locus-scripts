"""
algebra2 - radical_equations (easy)
Generated: 2026-02-22T04:26:46.270545
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: sqrt(x) = constant (1000-1150 ELO)
        # Start with answer, work backward
        ans_val = randint(2, 9)
        c = ans_val**2
        
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x}} = {ans_val}$",
            answer=c,
            difficulty=(1000, 1150),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: $(\\sqrt{{x}})^2 = {ans_val}^2$",
                f"$x = {c}$",
                f"Check: $\\sqrt{{{c}}} = {ans_val}$ ✓"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: sqrt(x + a) = b (1100-1250 ELO)
        ans_val = randint(3, 12)
        a = randint(1, 8)
        b = randint(2, 6)
        # We need sqrt(ans_val + a) = b
        # So ans_val + a = b^2
        ans_val = b**2 - a
        
        if ans_val < 1:
            # Adjust to make answer positive
            a = randint(1, 5)
            b = randint(3, 6)
            ans_val = b**2 - a
        
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x + {a}}} = {b}$",
            answer=ans_val,
            difficulty=(1100, 1250),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: $(\\sqrt{{x + {a}}})^2 = {b}^2$",
                f"$x + {a} = {b**2}$",
                f"$x = {b**2} - {a}$",
                f"$x = {ans_val}$",
                f"Check: $\\sqrt{{{ans_val} + {a}}} = \\sqrt{{{ans_val + a}}} = {b}$ ✓"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: sqrt(ax) = b (1050-1200 ELO)
        ans_val = randint(2, 10)
        coeff = randint(2, 5)
        b = randint(2, 6)
        # We need sqrt(coeff * ans_val) = b
        # So coeff * ans_val = b^2
        ans_val = b**2 // coeff
        if b**2 % coeff != 0:
            # Make it come out even
            ans_val = randint(1, 8)
            product = coeff * ans_val
            # Find a perfect square close to product
            b = 2
            while b**2 < product:
                b += 1
            ans_val = b**2 // coeff
        
        return problem(
            question=f"Solve for $x$: $\\sqrt{{{coeff}x}} = {b}$",
            answer=ans_val,
            difficulty=(1050, 1200),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: $(\\sqrt{{{coeff}x}})^2 = {b}^2$",
                f"${coeff}x = {b**2}$",
                f"$x = \\frac{{{b**2}}}{{{coeff}}}$",
                f"$x = {ans_val}$",
                f"Check: $\\sqrt{{{coeff} \\cdot {ans_val}}} = \\sqrt{{{coeff * ans_val}}} = {b}$ ✓"
            ),
        )
    
    else:
        # Type 4: sqrt(x) + a = b, where b > a (1150-1300 ELO)
        ans_val = randint(4, 16)
        # sqrt(ans_val) should be an integer
        sqrt_ans = int(ans_val**0.5)
        if sqrt_ans**2 != ans_val:
            # Force perfect square
            sqrt_ans = randint(2, 5)
            ans_val = sqrt_ans**2
        
        a = randint(1, 6)
        b = sqrt_ans + a
        
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x}} + {a} = {b}$",
            answer=ans_val,
            difficulty=(1150, 1300),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Isolate the radical: $\\sqrt{{x}} = {b} - {a}$",
                f"$\\sqrt{{x}} = {b - a}$",
                f"Square both sides: $(\\sqrt{{x}})^2 = {b - a}^2$",
                f"$x = {ans_val}$",
                f"Check: $\\sqrt{{{ans_val}}} + {a} = {sqrt_ans} + {a} = {b}$ ✓"
            ),
        )

emit(generate())