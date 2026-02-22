"""
differential_equations - homogeneous_equations (medium)
Generated: 2026-02-22T05:23:38.334901
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: dy/dx = f(x)/g(x) where f and g are homogeneous of same degree
        # Example: dy/dx = (x + y) / x
        coeff1 = choice([1, 2, 3])
        coeff2 = choice([1, 2, 3])
        
        # dy/dx = (coeff1*x + coeff2*y) / x
        # Substitute v = y/x, so y = vx, dy/dx = v + x*dv/dx
        # v + x*dv/dx = coeff1 + coeff2*v
        # x*dv/dx = coeff1 + (coeff2-1)*v
        # Separable: dv/(coeff1 + (coeff2-1)*v) = dx/x
        
        if coeff2 == 1:
            # dv/coeff1 = dx/x
            # v = coeff1*ln|x| + C
            # y/x = coeff1*ln|x| + C
            # y = coeff1*x*ln|x| + Cx
            ans_expr = f"y = {coeff1}x\\ln|x| + Cx" if coeff1 > 1 else "y = x\\ln|x| + Cx"
            
            solution_steps = steps(
                f"This is a homogeneous equation. Let $v = \\frac{{y}}{{x}}$, so $y = vx$ and $\\frac{{dy}}{{dx}} = v + x\\frac{{dv}}{{dx}}$",
                f"Substitute: $v + x\\frac{{dv}}{{dx}} = {coeff1} + {coeff2}v = {coeff1} + v$",
                f"Simplify: $x\\frac{{dv}}{{dx}} = {coeff1}$",
                f"Separate variables: $dv = \\frac{{{coeff1}dx}}{{x}}$",
                f"Integrate: $v = {coeff1}\\ln|x| + C$",
                f"Substitute back $v = \\frac{{y}}{{x}}$: ${ans_expr}$"
            )
        else:
            # General case
            k = coeff2 - 1
            if k == 0:
                ans_expr = f"y = {coeff1}x\\ln|x| + Cx" if coeff1 > 1 else "y = x\\ln|x| + Cx"
            else:
                # ln|coeff1 + k*v| = ln|x| + C
                # coeff1 + k*v = Cx
                # v = (Cx - coeff1)/k
                # y/x = (Cx - coeff1)/k
                if k > 0:
                    ans_expr = f"{coeff1} + {k}\\frac{{y}}{{x}} = Cx"
                else:
                    ans_expr = f"{coeff1} - {abs(k)}\\frac{{y}}{{x}} = Cx"
            
            solution_steps = steps(
                f"This is a homogeneous equation. Let $v = \\frac{{y}}{{x}}$, so $y = vx$ and $\\frac{{dy}}{{dx}} = v + x\\frac{{dv}}{{dx}}$",
                f"Substitute: $v + x\\frac{{dv}}{{dx}} = {coeff1} + {coeff2}v$",
                f"Simplify: $x\\frac{{dv}}{{dx}} = {coeff1} + {k}v$",
                f"Separate variables: $\\frac{{dv}}{{{coeff1} + {k}v}} = \\frac{{dx}}{{x}}$",
                f"Integrate both sides to get the general solution",
                f"Substitute back $v = \\frac{{y}}{{x}}$: ${ans_expr}$"
            )
        
        numerator = f"{coeff1}x + {coeff2}y" if coeff1 > 1 and coeff2 > 1 else (f"x + {coeff2}y" if coeff1 == 1 and coeff2 > 1 else (f"{coeff1}x + y" if coeff1 > 1 else "x + y"))
        
        return problem(
            question=f"Solve the homogeneous differential equation: $\\frac{{dy}}{{dx}} = \\frac{{{numerator}}}{{x}}$",
            answer=ans_expr,
            difficulty=(1300, 1500),
            topic="differential_equations/homogeneous_equations",
            solution=solution_steps,
            answer_type="expression"
        )
    
    elif problem_type == 2:
        # Type 2: dy/dx = f(y/x) form
        # Example: dy/dx = (y/x)^2 + y/x
        
        a = randint(1, 3)
        
        # dy/dx = v^2 + a*v where v = y/x
        # v + x*dv/dx = v^2 + a*v
        # x*dv/dx = v^2 + (a-1)*v
        # dv/(v^2 + (a-1)*v) = dx/x
        
        b = a - 1
        
        if b == 0:
            # dv/v^2 = dx/x
            # -1/v = ln|x| + C
            ans_expr = "y = -\\frac{x}{\\ln|x| + C}"
        else:
            ans_expr = f"\\frac{{1}}{{v}} - \\frac{{1}}{{v+{b}}} = {b}\\ln|x| + C \\text{{ where }} v = \\frac{{y}}{{x}}"
        
        if a == 1:
            main_eq = "\\left(\\frac{y}{x}\\right)^2 + \\frac{y}{x}"
        else:
            main_eq = f"\\left(\\frac{{y}}{{x}}\\right)^2 + {a}\\frac{{y}}{{x}}"
        
        return problem(
            question=f"Solve the homogeneous differential equation: $\\frac{{dy}}{{dx}} = {main_eq}$",
            answer=ans_expr,
            difficulty=(1400, 1600),
            topic="differential_equations/homogeneous_equations",
            solution=steps(
                f"Let $v = \\frac{{y}}{{x}}$, so $y = vx$ and $\\frac{{dy}}{{dx}} = v + x\\frac{{dv}}{{dx}}$",
                f"Substitute: $v + x\\frac{{dv}}{{dx}} = v^2 + {a}v$",
                f"Simplify: $x\\frac{{dv}}{{dx}} = v^2 + {b}v$",
                f"Separate variables and integrate",
                f"${ans_expr}$"
            ),
            answer_type="expression"
        )
    
    elif problem_type == 3:
        # Type 3: Standard form (x^2 + y^2)dx + something*dy = 0
        
        coeff = choice([2, -2, 3, -3])
        
        # (x^2 + y^2)dx + coeff*xy*dy = 0
        # dy/dx = -(x^2 + y^2)/(coeff*xy)
        
        ans_expr = f"x^2 + y^2 = Cx^{{{coeff}}}"
        
        if coeff > 0:
            question_str = f"(x^2 + y^2)dx + {coeff}xydy = 0"
        else:
            question_str = f"(x^2 + y^2)dx {coeff}xydy = 0"
        
        return problem(
            question=f"Solve the homogeneous differential equation: ${question_str}$",
            answer=ans_expr,
            difficulty=(1300, 1500),
            topic="differential_equations/homogeneous_equations",
            solution=steps(
                f"Rewrite as $\\frac{{dy}}{{dx}} = -\\frac{{x^2 + y^2}}{{{coeff}xy}}$",
                f"This is homogeneous. Let $v = \\frac{{y}}{{x}}$",
                f"Substitute and separate variables",
                f"After integration: ${ans_expr}$"
            ),
            answer_type="expression"
        )
    
    else:
        # Type 4: Simple homogeneous with substitution
        # dy/dx = (x + y)/x = 1 + y/x
        
        sign = choice([1, -1])
        
        if sign == 1:
            # dy/dx = 1 + y/x
            # v + x*dv/dx = 1 + v
            # x*dv/dx = 1
            # dv = dx/x
            # v = ln|x| + C
            # y = x*ln|x| + Cx
            ans_expr = "y = x\\ln|x| + Cx"
            eq_str = "1 + \\frac{y}{x}"
        else:
            # dy/dx = 1 - y/x
            # v + x*dv/dx = 1 - v
            # x*dv/dx = 1 - 2v
            # dv/(1-2v) = dx/x
            # -ln|1-2v|/2 = ln|x| + C
            ans_expr = "1 - 2\\frac{y}{x} = \\frac{C}{x^2}"
            eq_str = "1 - \\frac{y}{x}"
        
        return problem(
            question=f"Solve the homogeneous differential equation: $\\frac{{dy}}{{dx}} = {eq_str}$",
            answer=ans_expr,
            difficulty=(1300, 1400),
            topic="differential_equations/homogeneous_equations",
            solution=steps(
                f"Let $v = \\frac{{y}}{{x}}$, so $y = vx$ and $\\frac{{dy}}{{dx}} = v + x\\frac{{dv}}{{dx}}$",
                f"Substitute into the equation",
                f"Separate variables and integrate",
                f"${ans_expr}$"
            ),
            answer_type="expression"
        )

emit(generate())