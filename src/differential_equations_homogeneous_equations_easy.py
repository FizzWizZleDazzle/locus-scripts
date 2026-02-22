"""
differential_equations - homogeneous_equations (easy)
Generated: 2026-02-22T05:23:01.669773
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: dy/dx = f(x)/f(y) - simplest separable form
        # Example: dy/dx = x/y
        coeff = choice([1, 2, 3])
        power_x = choice([1, 2])
        power_y = choice([1, 2])
        
        if coeff == 1:
            coeff_str = ""
        else:
            coeff_str = str(coeff)
        
        if power_x == 1:
            x_str = "x"
        else:
            x_str = f"x^{power_x}"
            
        if power_y == 1:
            y_str = "y"
        else:
            y_str = f"y^{power_y}"
        
        question = f"\\frac{{dy}}{{dx}} = \\frac{{{coeff_str}{x_str}}}{{{y_str}}}"
        
        # Solve by separation: y dy = coeff * x^power_x dx
        # Integrate both sides
        left_power = power_y + 1
        right_power = power_x + 1
        
        if left_power == 2:
            left_side = y**2 / 2
        else:
            left_side = y**left_power / left_power
            
        if right_power == 2:
            right_side = coeff * x**2 / 2
        else:
            right_side = coeff * x**right_power / right_power
        
        ans = Eq(left_side, right_side + c)
        
        solution_steps = steps(
            f"Separate variables: ${y_str} \\, dy = {coeff_str}{x_str} \\, dx$",
            f"Integrate both sides: $\\int {y_str} \\, dy = \\int {coeff_str}{x_str} \\, dx$",
            f"${latex(left_side)} = {latex(right_side)} + C$"
        )
        
        return problem(
            question=f"Solve the differential equation: ${question}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/homogeneous_equations",
            solution=solution_steps,
            grading_mode="equivalent"
        )
    
    elif problem_type == 2:
        # Type 2: dy/dx = g(y/x) - homogeneous equation in simplest form
        # Example: dy/dx = y/x
        numerator_coeff = choice([1, 2])
        
        if numerator_coeff == 1:
            question = "\\frac{dy}{dx} = \\frac{y}{x}"
            ans_expr = c * x
        else:
            question = f"\\frac{{dy}}{{dx}} = \\frac{{{numerator_coeff}y}}{{x}}"
            ans_expr = c * x**numerator_coeff
        
        ans = Eq(y, ans_expr)
        
        solution_steps = steps(
            f"This is a homogeneous equation. Use substitution $v = \\frac{{y}}{{x}}$, so $y = vx$",
            f"Then $\\frac{{dy}}{{dx}} = v + x\\frac{{dv}}{{dx}}$",
            f"Substitute and separate variables to get $\\frac{{dv}}{{v}} = 0$ (after simplification)",
            f"Integrating: $\\ln|v| = \\ln|C|$, so $v = C$",
            f"Therefore $y = Cx{'' if numerator_coeff == 1 else f'^{{{numerator_coeff}}}}$"
        )
        
        return problem(
            question=f"Solve the homogeneous differential equation: ${question}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="differential_equations/homogeneous_equations",
            solution=solution_steps,
            grading_mode="equivalent"
        )
    
    elif problem_type == 3:
        # Type 3: Simple separable DE (easier than homogeneous)
        # dy/dx = ky where k is a constant
        k_val = nonzero(-3, 3)
        
        if k_val == 1:
            k_str = ""
            sign_str = ""
        elif k_val == -1:
            k_str = ""
            sign_str = "-"
        elif k_val > 0:
            k_str = str(k_val)
            sign_str = ""
        else:
            k_str = str(abs(k_val))
            sign_str = "-"
        
        question = f"\\frac{{dy}}{{dx}} = {sign_str}{k_str}y"
        
        ans = Eq(y, c * exp(k_val * x))
        
        solution_steps = steps(
            f"Separate variables: $\\frac{{dy}}{{y}} = {sign_str}{k_str} \\, dx$",
            f"Integrate both sides: $\\ln|y| = {sign_str}{k_str}x + C_1$",
            f"Exponentiate: $y = Ce^{{{sign_str}{k_str}x}}$"
        )
        
        return problem(
            question=f"Solve the differential equation: ${question}$",
            answer=ans,
            difficulty=(1000, 1150),
            topic="differential_equations/homogeneous_equations",
            solution=solution_steps,
            grading_mode="equivalent"
        )
    
    else:
        # Type 4: dy/dx = x + y (simple first-order linear)
        # Actually separable after substitution
        
        question = "\\frac{dy}{dx} = \\frac{x + y}{x}"
        
        ans = Eq(y, c * x - x)
        
        solution_steps = steps(
            f"Rewrite as $\\frac{{dy}}{{dx}} = 1 + \\frac{{y}}{{x}}$",
            f"This is homogeneous. Let $v = \\frac{{y}}{{x}}$, so $y = vx$ and $\\frac{{dy}}{{dx}} = v + x\\frac{{dv}}{{dx}}$",
            f"Substitute: $v + x\\frac{{dv}}{{dx}} = 1 + v$",
            f"Simplify: $x\\frac{{dv}}{{dx}} = 1$",
            f"Separate and integrate: $dv = \\frac{{dx}}{{x}}$, giving $v = \\ln|x| + C$",
            f"Since $y = vx$: $y = x(\\ln|x| + C) = x\\ln|x| + Cx$"
        )
        
        return problem(
            question=f"Solve the homogeneous differential equation: ${question}$",
            answer=Eq(y, x*log(abs(x)) + c*x),
            difficulty=(1200, 1300),
            topic="differential_equations/homogeneous_equations",
            solution=solution_steps,
            grading_mode="equivalent"
        )

emit(generate())