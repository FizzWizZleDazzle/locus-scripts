"""
calculus - volumes_of_revolution (easy)
Generated: 2026-02-22T05:17:11.456789
"""

from problem_utils import *

def generate():
    # For easier volumes of revolution (1000-1300 ELO), focus on:
    # - Simple functions (linear, quadratic)
    # - Disk method with axis of rotation
    # - Clean bounds that make integration straightforward
    
    problem_type = randint(1, 3)
    
    if problem_type == 1:
        # Disk method: revolve y = constant around x-axis
        # V = π∫[a,b] y² dx
        height = randint(1, 4)
        a_bound = 0
        b_bound = randint(2, 5)
        
        # Volume = π * height² * (b - a)
        volume = pi * height**2 * (b_bound - a_bound)
        
        question = f"Find the volume when the region bounded by $y = {height}$, $y = 0$, $x = {a_bound}$, and $x = {b_bound}$ is revolved around the $x$-axis."
        
        solution = steps(
            f"Using the disk method: $V = \\pi \\int_{{{a_bound}}}^{{{b_bound}}} y^2 \\, dx$",
            f"$V = \\pi \\int_{{{a_bound}}}^{{{b_bound}}} {height**2} \\, dx$",
            f"$V = \\pi \\cdot {height**2} \\cdot [{b_bound} - {a_bound}]$",
            f"$V = {latex(volume)}$"
        )
        
        return problem(
            question=question,
            answer=volume,
            difficulty=(1000, 1100),
            topic="calculus/volumes_of_revolution",
            solution=solution
        )
    
    elif problem_type == 2:
        # Disk method: revolve y = mx around x-axis from 0 to b
        # V = π∫[0,b] (mx)² dx = π∫[0,b] m²x² dx
        m_val = randint(1, 3)
        b_bound = randint(2, 4)
        
        # V = π * m² * b³/3
        volume = pi * m_val**2 * b_bound**3 / 3
        
        if m_val == 1:
            func_str = "y = x"
        else:
            func_str = f"y = {m_val}x"
        
        question = f"Find the volume when the region bounded by ${func_str}$, $y = 0$, and $x = {b_bound}$ is revolved around the $x$-axis."
        
        solution = steps(
            f"Using the disk method: $V = \\pi \\int_{{0}}^{{{b_bound}}} y^2 \\, dx$",
            f"$V = \\pi \\int_{{0}}^{{{b_bound}}} ({m_val}x)^2 \\, dx$",
            f"$V = \\pi \\int_{{0}}^{{{b_bound}}} {m_val**2}x^2 \\, dx$",
            f"$V = \\pi \\cdot {m_val**2} \\cdot \\left[\\frac{{x^3}}{{3}}\\right]_{{0}}^{{{b_bound}}}$",
            f"$V = \\pi \\cdot {m_val**2} \\cdot \\frac{{{b_bound**3}}}{{3}}$",
            f"$V = {latex(volume)}$"
        )
        
        return problem(
            question=question,
            answer=volume,
            difficulty=(1100, 1250),
            topic="calculus/volumes_of_revolution",
            solution=solution
        )
    
    else:
        # Disk method: revolve y = √x around x-axis
        # V = π∫[a,b] (√x)² dx = π∫[a,b] x dx
        a_bound = 0
        b_bound = randint(2, 6)
        
        # V = π * (b²/2 - a²/2) = π * b²/2
        volume = pi * b_bound**2 / 2
        
        question = f"Find the volume when the region bounded by $y = \\sqrt{{x}}$, $y = 0$, and $x = {b_bound}$ is revolved around the $x$-axis."
        
        solution = steps(
            f"Using the disk method: $V = \\pi \\int_{{0}}^{{{b_bound}}} y^2 \\, dx$",
            f"$V = \\pi \\int_{{0}}^{{{b_bound}}} (\\sqrt{{x}})^2 \\, dx$",
            f"$V = \\pi \\int_{{0}}^{{{b_bound}}} x \\, dx$",
            f"$V = \\pi \\left[\\frac{{x^2}}{{2}}\\right]_{{0}}^{{{b_bound}}}$",
            f"$V = \\pi \\cdot \\frac{{{b_bound**2}}}{{2}}$",
            f"$V = {latex(volume)}$"
        )
        
        return problem(
            question=question,
            answer=volume,
            difficulty=(1200, 1300),
            topic="calculus/volumes_of_revolution",
            solution=solution
        )

emit(generate())