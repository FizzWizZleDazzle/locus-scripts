"""
differential_equations - undetermined_coefficients (easy)
Generated: 2026-02-22T05:27:06.484604
"""

from problem_utils import *

def generate():
    # For undetermined coefficients at 1000-1300 ELO, we want the simplest cases:
    # - First-order ODEs: y' + ay = polynomial or exponential with simple right-hand side
    # - Second-order ODEs: y'' + ay' + by = polynomial (constant or linear)
    
    problem_type = choice(['first_order_poly', 'second_order_constant', 'second_order_linear'])
    
    if problem_type == 'first_order_poly':
        # y' + ay = c (constant right-hand side)
        # Particular solution: y_p = c/a
        a_val = nonzero(-3, 3)
        c_val = nonzero(-6, 6)
        
        # Make sure c_val is divisible by a_val for clean answer
        c_val = a_val * nonzero(-3, 3)
        
        y_p = Rational(c_val, a_val)
        
        if a_val == 1:
            ode_str = f"y' + y = {c_val}"
        elif a_val == -1:
            ode_str = f"y' - y = {c_val}"
        else:
            sign = "+" if a_val > 0 else "-"
            ode_str = f"y' {sign} {abs(a_val)}y = {c_val}"
        
        return problem(
            question=f"Find the particular solution $y_p$ using the method of undetermined coefficients for: ${ode_str}$",
            answer=y_p,
            difficulty=(1000, 1200),
            topic="differential_equations/undetermined_coefficients",
            solution=steps(
                f"The right-hand side is ${c_val}$ (a constant)",
                f"Assume particular solution of the form $y_p = A$ where $A$ is a constant",
                f"Then $y_p' = 0$",
                f"Substituting into the ODE: $0 + {a_val}A = {c_val}$",
                f"Solving: $A = {latex(y_p)}$",
                f"Therefore, $y_p = {latex(y_p)}$"
            ),
        )
    
    elif problem_type == 'second_order_constant':
        # y'' + ay' + by = c (constant right-hand side)
        # Particular solution: y_p = c/b (assuming b != 0)
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = b_val * nonzero(-3, 3)  # Make divisible
        
        y_p = Rational(c_val, b_val)
        
        # Build ODE string
        terms = []
        terms.append("y''")
        if a_val == 1:
            terms.append("+ y'")
        elif a_val == -1:
            terms.append("- y'")
        elif a_val > 0:
            terms.append(f"+ {a_val}y'")
        else:
            terms.append(f"- {abs(a_val)}y'")
        
        if b_val > 0:
            terms.append(f"+ {b_val}y")
        else:
            terms.append(f"- {abs(b_val)}y")
        
        ode_str = " ".join(terms) + f" = {c_val}"
        
        return problem(
            question=f"Find the particular solution $y_p$ using the method of undetermined coefficients for: ${ode_str}$",
            answer=y_p,
            difficulty=(1100, 1300),
            topic="differential_equations/undetermined_coefficients",
            solution=steps(
                f"The right-hand side is ${c_val}$ (a constant)",
                f"Assume particular solution of the form $y_p = A$ where $A$ is a constant",
                f"Then $y_p' = 0$ and $y_p'' = 0$",
                f"Substituting into the ODE: $0 + 0 + {b_val}A = {c_val}$",
                f"Solving: $A = {latex(y_p)}$",
                f"Therefore, $y_p = {latex(y_p)}$"
            ),
        )
    
    else:  # second_order_linear
        # y'' + by = mx (linear polynomial right-hand side, no y' term for simplicity)
        # Particular solution: y_p = (m/b)x
        b_val = nonzero(-3, 3)
        m_val = b_val * nonzero(-2, 2)  # Make divisible
        
        coeff = Rational(m_val, b_val)
        y_p = coeff * x
        
        if b_val > 0:
            ode_str = f"y'' + {b_val}y = {m_val}x"
        else:
            ode_str = f"y'' - {abs(b_val)}y = {m_val}x"
        
        return problem(
            question=f"Find the particular solution $y_p$ using the method of undetermined coefficients for: ${ode_str}$",
            answer=y_p,
            difficulty=(1200, 1300),
            topic="differential_equations/undetermined_coefficients",
            solution=steps(
                f"The right-hand side is ${m_val}x$ (a linear polynomial)",
                f"Assume particular solution of the form $y_p = Ax + B$",
                f"Then $y_p' = A$ and $y_p'' = 0$",
                f"Substituting into the ODE: $0 + {b_val}(Ax + B) = {m_val}x$",
                f"Expanding: ${b_val}Ax + {b_val}B = {m_val}x$",
                f"Comparing coefficients: ${b_val}A = {m_val}$ and ${b_val}B = 0$",
                f"Solving: $A = {latex(coeff)}$ and $B = 0$",
                f"Therefore, $y_p = {latex(y_p)}$"
            ),
        )

emit(generate())