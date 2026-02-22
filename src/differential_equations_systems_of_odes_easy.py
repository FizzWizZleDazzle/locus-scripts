"""
differential_equations - systems_of_odes (easy)
Generated: 2026-02-22T05:32:10.004489
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: 2x2 system with decoupled equations (easiest)
        # dy/dt = a*y, dz/dt = b*z
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        
        ans = FiniteSet(
            Eq(y, Symbol('C_1') * exp(a_val * t)),
            Eq(z, Symbol('C_2') * exp(b_val * t))
        )
        
        return problem(
            question=f"Solve the system of differential equations:\\n\\n$\\\\frac{{dy}}{{dt}} = {latex(a_val*y)}$\\n\\n$\\\\frac{{dz}}{{dt}} = {latex(b_val*z)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/systems_of_odes",
            solution=steps(
                "These equations are decoupled, so we can solve each separately.",
                f"For $\\\\frac{{dy}}{{dt}} = {latex(a_val*y)}$: Separating variables gives $\\\\frac{{dy}}{{y}} = {a_val} dt$",
                f"Integrating: $\\\\ln|y| = {a_val}t + C_1'$, so $y = C_1 e^{{{a_val}t}}$",
                f"For $\\\\frac{{dz}}{{dt}} = {latex(b_val*z)}$: Similarly, $z = C_2 e^{{{b_val}t}}$",
                f"Solution: $y = C_1 e^{{{a_val}t}}$, $z = C_2 e^{{{b_val}t}}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Simple 2x2 system with one equation depending on the other
        # dy/dt = z, dz/dt = a*z
        a_val = nonzero(-3, 3)
        
        ans = FiniteSet(
            Eq(z, Symbol('C_1') * exp(a_val * t)),
            Eq(y, Symbol('C_1') * exp(a_val * t) / a_val + Symbol('C_2'))
        )
        
        return problem(
            question=f"Solve the system of differential equations:\\n\\n$\\\\frac{{dy}}{{dt}} = z$\\n\\n$\\\\frac{{dz}}{{dt}} = {latex(a_val*z)}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="differential_equations/systems_of_odes",
            solution=steps(
                f"First solve $\\\\frac{{dz}}{{dt}} = {latex(a_val*z)}$",
                f"This gives $z = C_1 e^{{{a_val}t}}$",
                f"Now substitute into $\\\\frac{{dy}}{{dt}} = z$:",
                f"$\\\\frac{{dy}}{{dt}} = C_1 e^{{{a_val}t}}$",
                f"Integrating: $y = \\\\frac{{C_1}}{{{a_val}}} e^{{{a_val}t}} + C_2$",
                f"Solution: $z = C_1 e^{{{a_val}t}}$, $y = \\\\frac{{C_1}}{{{a_val}}} e^{{{a_val}t}} + C_2$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Find eigenvalues of coefficient matrix (simpler computational problem)
        a_val = randint(1, 4)
        b_val = randint(1, 4)
        
        # Diagonal matrix for easy eigenvalues
        A = Matrix([[a_val, 0], [0, -b_val]])
        eigenvals = [a_val, -b_val]
        ans = FiniteSet(*eigenvals)
        
        return problem(
            question=f"Find the eigenvalues of the coefficient matrix for the system $\\\\mathbf{{x}}' = A\\\\mathbf{{x}}$ where\\n\\n$A = {latex(A)}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="differential_equations/systems_of_odes",
            solution=steps(
                f"For a diagonal matrix, the eigenvalues are the diagonal entries",
                f"Eigenvalues: ${a_val}$ and ${-b_val}$"
            ),
        )
    
    else:
        # Type 4: Verify a solution to a simple system
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        
        # Check if y = e^(a*t), z = e^(b*t) satisfies the system
        # dy/dt = a*e^(a*t), dz/dt = b*e^(b*t)
        
        ans = True
        
        return problem(
            question=f"Does $y = e^{{{a_val}t}}$, $z = e^{{{b_val}t}}$ satisfy the system\\n\\n$\\\\frac{{dy}}{{dt}} = {latex(a_val*y)}$\\n\\n$\\\\frac{{dz}}{{dt}} = {latex(b_val*z)}$?",
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/systems_of_odes",
            solution=steps(
                f"Check first equation: $\\\\frac{{dy}}{{dt}} = \\\\frac{{d}}{{dt}}[e^{{{a_val}t}}] = {a_val}e^{{{a_val}t}} = {a_val}y$ ✓",
                f"Check second equation: $\\\\frac{{dz}}{{dt}} = \\\\frac{{d}}{{dt}}[e^{{{b_val}t}}] = {b_val}e^{{{b_val}t}} = {b_val}z$ ✓",
                "Both equations are satisfied, so the answer is True"
            ),
        )

emit(generate())