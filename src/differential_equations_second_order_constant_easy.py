"""
differential_equations - second_order_constant (easy)
Generated: 2026-02-22T05:24:31.296042
"""

from problem_utils import *

def generate():
    # For EASIER problems (1000-1300), we focus on:
    # - Simple characteristic equations with real, distinct roots
    # - Basic initial value problems
    # - Direct application of solution formulas
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Find general solution with distinct real roots (1000-1100)
        # y'' + by' + cy = 0 where roots are simple integers
        r1 = randint(1, 4)
        r2 = randint(1, 4)
        if r1 == r2:
            r2 += 1
        
        # Characteristic equation: (r - r1)(r - r2) = r^2 - (r1+r2)r + r1*r2
        b_coef = -(r1 + r2)
        c_coef = r1 * r2
        
        # General solution: y = C1*e^(r1*t) + C2*e^(r2*t)
        ans = symbols('C_1') * exp(r1*t) + symbols('C_2') * exp(r2*t)
        
        if b_coef >= 0:
            b_str = f"+{b_coef}y'"
        else:
            b_str = f"{b_coef}y'"
            
        if c_coef >= 0:
            c_str = f"+{c_coef}y"
        else:
            c_str = f"{c_coef}y"
        
        return problem(
            question=f"Find the general solution to $y''{b_str}{c_str}=0$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Characteristic equation: $r^2{b_coef:+d}r{c_coef:+d}=0$",
                f"Factor: $(r-{r1})(r-{r2})=0$",
                f"Roots: $r_1={r1}, r_2={r2}$",
                f"General solution: $y=C_1e^{{{r1}t}}+C_2e^{{{r2}t}}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Simple IVP with distinct real roots (1100-1200)
        r1 = randint(1, 3)
        r2 = randint(1, 3)
        if r1 == r2:
            r2 += 1
        
        # Pick simple initial conditions
        y0 = randint(1, 5)
        yp0 = randint(1, 8)
        
        # Solve for C1 and C2
        # y(0) = C1 + C2 = y0
        # y'(0) = r1*C1 + r2*C2 = yp0
        # From first: C2 = y0 - C1
        # Substitute: r1*C1 + r2*(y0 - C1) = yp0
        # r1*C1 + r2*y0 - r2*C1 = yp0
        # C1*(r1 - r2) = yp0 - r2*y0
        C1_val = Rational(yp0 - r2*y0, r1 - r2)
        C2_val = y0 - C1_val
        
        ans = C1_val * exp(r1*t) + C2_val * exp(r2*t)
        
        b_coef = -(r1 + r2)
        c_coef = r1 * r2
        
        return problem(
            question=f"Solve the IVP: $y''{b_coef:+d}y'{c_coef:+d}y=0$, $y(0)={y0}$, $y'(0)={yp0}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Characteristic equation: $r^2{b_coef:+d}r{c_coef:+d}=0$",
                f"Roots: $r={r1},{r2}$",
                f"General solution: $y=C_1e^{{{r1}t}}+C_2e^{{{r2}t}}$",
                f"Apply $y(0)={y0}$: $C_1+C_2={y0}$",
                f"Apply $y'(0)={yp0}$: ${r1}C_1+{r2}C_2={yp0}$",
                f"Solve system: $C_1={latex(C1_val)}$, $C_2={latex(C2_val)}$",
                f"Solution: $y={latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Verify solution (1000-1100)
        r1 = randint(1, 3)
        r2 = randint(1, 3)
        if r1 == r2:
            r2 += 1
        
        y_proposed = exp(r1*t) + exp(r2*t)
        
        b_coef = -(r1 + r2)
        c_coef = r1 * r2
        
        # Check if it's a solution by substituting
        yp = diff(y_proposed, t)
        ypp = diff(yp, t)
        check = simplify(ypp + b_coef*yp + c_coef*y_proposed)
        
        ans = check == 0  # True
        
        return problem(
            question=f"Is $y=e^{{{r1}t}}+e^{{{r2}t}}$ a solution to $y''{b_coef:+d}y'{c_coef:+d}y=0$?",
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"$y=e^{{{r1}t}}+e^{{{r2}t}}$",
                f"$y'={r1}e^{{{r1}t}}+{r2}e^{{{r2}t}}$",
                f"$y''={r1**2}e^{{{r1}t}}+{r2**2}e^{{{r2}t}}$",
                f"Substitute into equation and verify it equals 0",
                f"Yes, it is a solution"
            ),
        )
    
    else:
        # Type 4: Find characteristic equation roots (1200-1300)
        r1 = randint(-3, 3)
        r2 = randint(-3, 3)
        if r1 == 0:
            r1 = 1
        if r2 == 0:
            r2 = 2
        if r1 == r2:
            r2 += 1
        
        b_coef = -(r1 + r2)
        c_coef = r1 * r2
        
        ans = FiniteSet(r1, r2)
        
        return problem(
            question=f"Find the roots of the characteristic equation for $y''{b_coef:+d}y'{c_coef:+d}y=0$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Characteristic equation: $r^2{b_coef:+d}r{c_coef:+d}=0$",
                f"Factor or use quadratic formula",
                f"$(r-{r1})(r-{r2})=0$",
                f"Roots: $r={r1},{r2}$"
            ),
        )

emit(generate())