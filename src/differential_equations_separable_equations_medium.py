"""
differential_equations - separable_equations (medium)
Generated: 2026-02-22T05:18:59.460572
"""

from problem_utils import *

def generate():
    # Choose problem type based on difficulty
    prob_type = choice(['basic_separable', 'with_coefficient', 'exponential', 'trig'])
    
    if prob_type == 'basic_separable':
        # dy/dx = g(x)h(y) type, 1300-1400 difficulty
        # Construct backward from clean antiderivatives
        
        # Pick simple functions
        x_power = randint(1, 3)
        y_power = randint(1, 2)
        
        # dy/dx = x^n * y^m
        question_text = f"\\frac{{dy}}{{dx}} = {latex(x**x_power * y**y_power)}"
        
        solution_steps = [
            f"Separate variables: $\\frac{{1}}{{y^{{{y_power}}}}} dy = x^{{{x_power}}} dx$",
            f"Rewrite: $y^{{-{y_power}}} dy = x^{{{x_power}}} dx$",
            f"Integrate both sides: $\\int y^{{-{y_power}}} dy = \\int x^{{{x_power}}} dx$"
        ]
        
        if y_power == 1:
            left_side = log(y)
            solution_steps.append(f"$\\ln|y| = \\frac{{x^{{{x_power+1}}}}}{{{x_power+1}}} + C$")
        else:
            left_side = y**(-y_power + 1) / (-y_power + 1)
            solution_steps.append(f"$\\frac{{y^{{{-y_power+1}}}}}{{{-y_power+1}}} = \\frac{{x^{{{x_power+1}}}}}{{{x_power+1}}} + C$")
        
        right_side = x**(x_power + 1) / (x_power + 1)
        ans = Eq(left_side, right_side + c)
        difficulty = (1300, 1400)
        
    elif prob_type == 'with_coefficient':
        # dy/dx = k*f(x)*g(y), 1400-1500 difficulty
        k = nonzero(-4, 4)
        
        # Simple case: dy/dx = k*x/y
        question_text = f"\\frac{{dy}}{{dx}} = {latex(k*x/y)}"
        
        solution_steps = [
            f"Separate variables: $y \\, dy = {k}x \\, dx$",
            f"Integrate both sides: $\\int y \\, dy = \\int {k}x \\, dx$",
            f"$\\frac{{y^2}}{{2}} = {k} \\cdot \\frac{{x^2}}{{2}} + C$",
            f"$\\frac{{y^2}}{{2}} = {latex(Rational(k,2)*x**2)} + C$",
            f"$y^2 = {latex(k*x**2)} + C$ (absorbing the constant)"
        ]
        
        ans = Eq(y**2, k*x**2 + c)
        difficulty = (1400, 1500)
        
    elif prob_type == 'exponential':
        # dy/dx = e^x * y or similar, 1450-1550 difficulty
        k = nonzero(-3, 3)
        
        if choice([True, False]):
            # dy/dx = k*e^x * y
            question_text = f"\\frac{{dy}}{{dx}} = {latex(k*exp(x)*y)}"
            
            solution_steps = [
                f"Separate variables: $\\frac{{1}}{{y}} dy = {k}e^x dx$",
                f"Integrate both sides: $\\int \\frac{{1}}{{y}} dy = \\int {k}e^x dx$",
                f"$\\ln|y| = {k}e^x + C$"
            ]
            
            ans = Eq(log(y), k*exp(x) + c)
        else:
            # dy/dx = e^x / y
            question_text = f"\\frac{{dy}}{{dx}} = {latex(exp(x)/y)}"
            
            solution_steps = [
                f"Separate variables: $y \\, dy = e^x dx$",
                f"Integrate both sides: $\\int y \\, dy = \\int e^x dx$",
                f"$\\frac{{y^2}}{{2}} = e^x + C$",
                f"$y^2 = 2e^x + C$ (absorbing the constant)"
            ]
            
            ans = Eq(y**2, 2*exp(x) + c)
        
        difficulty = (1450, 1550)
        
    else:  # trig
        # dy/dx with trig functions, 1500-1600 difficulty
        trig_choice = choice(['sin', 'cos'])
        
        if trig_choice == 'sin':
            # dy/dx = sin(x) * y
            question_text = f"\\frac{{dy}}{{dx}} = {latex(sin(x)*y)}"
            
            solution_steps = [
                f"Separate variables: $\\frac{{1}}{{y}} dy = \\sin(x) dx$",
                f"Integrate both sides: $\\int \\frac{{1}}{{y}} dy = \\int \\sin(x) dx$",
                f"$\\ln|y| = -\\cos(x) + C$"
            ]
            
            ans = Eq(log(y), -cos(x) + c)
        else:
            # dy/dx = cos(x)/y
            question_text = f"\\frac{{dy}}{{dx}} = {latex(cos(x)/y)}"
            
            solution_steps = [
                f"Separate variables: $y \\, dy = \\cos(x) dx$",
                f"Integrate both sides: $\\int y \\, dy = \\int \\cos(x) dx$",
                f"$\\frac{{y^2}}{{2}} = \\sin(x) + C$",
                f"$y^2 = 2\\sin(x) + C$ (absorbing the constant)"
            ]
            
            ans = Eq(y**2, 2*sin(x) + c)
        
        difficulty = (1500, 1600)
    
    return problem(
        question=f"Solve the differential equation: ${question_text}$",
        answer=ans,
        difficulty=difficulty,
        topic="differential_equations/separable_equations",
        solution=steps(*solution_steps),
        answer_type="equation",
        grading_mode="equivalent"
    )

emit(generate())