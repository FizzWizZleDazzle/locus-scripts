"""
differential_equations - systems_of_odes (medium)
Generated: 2026-02-22T05:32:38.272872
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: 2x2 linear system with constant coefficients (1300-1400)
        # Backward engineer: pick solution first
        x_sol = nonzero(-5, 5)
        y_sol = nonzero(-5, 5)
        
        # Create coefficients
        a11, a12 = nonzero(-4, 4), nonzero(-4, 4)
        a21, a22 = nonzero(-4, 4), nonzero(-4, 4)
        
        # Ensure system is not degenerate
        while a11 * a22 == a12 * a21:
            a22 = nonzero(-4, 4)
        
        # Compute right-hand sides
        b1 = a11 * x_sol + a12 * y_sol
        b2 = a21 * x_sol + a22 * y_sol
        
        # Format the system
        eq1_str = f"{latex(a11)}x + {latex(a12)}y = {latex(b1)}"
        eq2_str = f"{latex(a21)}x + {latex(a22)}y = {latex(b2)}"
        
        question = f"Solve the system of differential equations (find equilibrium point):<br>$\\frac{{dx}}{{dt}} = {eq1_str}$<br>$\\frac{{dy}}{{dt}} = {eq2_str}$"
        
        ans = fmt_tuple([x_sol, y_sol])
        
        solution = steps(
            f"Set $\\frac{{dx}}{{dt}} = 0$ and $\\frac{{dy}}{{dt}} = 0$ to find equilibrium",
            f"This gives us: ${eq1_str}$ and ${eq2_str}$",
            f"Using substitution or elimination methods",
            f"Solution: $(x, y) = ({x_sol}, {y_sol})$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1400),
            topic="differential_equations/systems_of_odes",
            solution=solution,
            answer_type="tuple"
        )
    
    elif problem_type == 2:
        # Type 2: Solve dx/dt = ax, dy/dt = by (uncoupled system) (1300-1400)
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        
        x0 = nonzero(-5, 5)
        y0 = nonzero(-5, 5)
        
        # Solutions are x(t) = x0*e^(a*t), y(t) = y0*e^(b*t)
        x_sol = x0 * exp(a_val * t)
        y_sol = y0 * exp(b_val * t)
        
        question = f"Solve the system with initial conditions $x(0) = {x0}$, $y(0) = {y0}$:<br>$\\frac{{dx}}{{dt}} = {latex(a_val)}x$<br>$\\frac{{dy}}{{dt}} = {latex(b_val)}y$"
        
        ans = fmt_tuple([x_sol, y_sol])
        
        solution = steps(
            f"These are uncoupled first-order linear ODEs",
            f"For $\\frac{{dx}}{{dt}} = {latex(a_val)}x$ with $x(0) = {x0}$: $x(t) = {latex(x_sol)}$",
            f"For $\\frac{{dy}}{{dt}} = {latex(b_val)}y$ with $y(0) = {y0}$: $y(t) = {latex(y_sol)}$",
            f"Solution: $(x(t), y(t)) = ({latex(x_sol)}, {latex(y_sol)})$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1400),
            topic="differential_equations/systems_of_odes",
            solution=solution,
            answer_type="tuple"
        )
    
    elif problem_type == 3:
        # Type 3: Find eigenvalues of 2x2 system matrix (1400-1500)
        # Backward engineer: pick eigenvalues first
        lambda1 = nonzero(-4, 4)
        lambda2 = nonzero(-4, 4)
        
        # Create a matrix with these eigenvalues (diagonal or simple form)
        if randint(0, 1) == 0:
            # Diagonal matrix
            A = Matrix([[lambda1, 0], [0, lambda2]])
        else:
            # Upper triangular
            off_diag = nonzero(-3, 3)
            A = Matrix([[lambda1, off_diag], [0, lambda2]])
        
        question = f"Find the eigenvalues of the coefficient matrix for the system $\\frac{{d\\mathbf{{x}}}}{{dt}} = A\\mathbf{{x}}$ where $A = {latex(A)}$"
        
        ans = fmt_set([lambda1, lambda2])
        
        solution = steps(
            f"Find eigenvalues by solving $\\det(A - \\lambda I) = 0$",
            f"For $A = {latex(A)}$",
            f"Characteristic equation: $(\\lambda - {lambda1})(\\lambda - {lambda2}) = 0$",
            f"Eigenvalues: $\\lambda = {{{lambda1}, {lambda2}}}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1500),
            topic="differential_equations/systems_of_odes",
            solution=solution,
            answer_type="set"
        )
    
    else:
        # Type 4: Coupled 2x2 system - solve for one variable (1500-1600)
        # dx/dt = ax + by, dy/dt = cx + dy
        # Pick simpler values
        a_val = choice([-2, -1, 1, 2])
        b_val = choice([-2, -1, 1, 2])
        c_val = choice([-2, -1, 1, 2])
        d_val = choice([-2, -1, 1, 2])
        
        # Ensure trace^2 >= 4*det for real eigenvalues
        trace = a_val + d_val
        det = a_val * d_val - b_val * c_val
        
        if trace**2 < 4*det:
            d_val = -a_val
        
        A = Matrix([[a_val, b_val], [c_val, d_val]])
        eigenvals = list(A.eigenvals().keys())
        
        question = f"For the system $\\frac{{dx}}{{dt}} = {latex(a_val)}x + {latex(b_val)}y$, $\\frac{{dy}}{{dt}} = {latex(c_val)}x + {latex(d_val)}y$, classify the equilibrium at the origin based on eigenvalues."
        
        # Determine stability
        real_parts = [complex(e.evalf()).real for e in eigenvals]
        
        if all(r < 0 for r in real_parts):
            ans = "stable"
        elif all(r > 0 for r in real_parts):
            ans = "unstable"
        else:
            ans = "saddle"
        
        solution = steps(
            f"Find eigenvalues of $A = {latex(A)}$",
            f"Eigenvalues: ${latex(eigenvals[0])}, {latex(eigenvals[1])}$",
            f"Based on signs of real parts, the origin is {ans}"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1500, 1600),
            topic="differential_equations/systems_of_odes",
            solution=solution,
            answer_type="expression"
        )

emit(generate())