"""
precalculus - transformations (medium)
Generated: 2026-02-22T04:40:38.562899
"""

from problem_utils import *

def generate():
    problem_type = choice(['horizontal_shift', 'vertical_shift', 'reflection', 'stretch_compress', 'combined'])
    
    if problem_type == 'horizontal_shift':
        # f(x-h) horizontal shift
        base_func = choice([sin(x), cos(x), sqrt(x), x**2, abs(x)])
        h = nonzero(-5, 5)
        
        if h > 0:
            direction = "right"
            shift_text = f"{h}"
        else:
            direction = "left"
            shift_text = f"{-h}"
        
        transformed = base_func.subs(x, x - h)
        
        question = f"The graph of $f(x) = {latex(base_func)}$ is shifted {shift_text} units to the {direction}. What is the equation of the transformed function?"
        
        ans = transformed
        
        solution = steps(
            f"A horizontal shift of {shift_text} units to the {direction} replaces $x$ with $x - ({h})$",
            f"$g(x) = f(x - ({h})) = {latex(transformed)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/transformations",
            solution=solution
        )
    
    elif problem_type == 'vertical_shift':
        # f(x) + k vertical shift
        base_func = choice([sin(x), cos(x), x**2, abs(x), sqrt(x)])
        k = nonzero(-5, 5)
        
        if k > 0:
            direction = "up"
            shift_text = f"{k}"
        else:
            direction = "down"
            shift_text = f"{-k}"
        
        transformed = base_func + k
        
        question = f"The graph of $f(x) = {latex(base_func)}$ is shifted {shift_text} units {direction}. What is the equation of the transformed function?"
        
        ans = transformed
        
        solution = steps(
            f"A vertical shift of {shift_text} units {direction} adds ${k}$ to the function",
            f"$g(x) = f(x) + ({k}) = {latex(transformed)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/transformations",
            solution=solution
        )
    
    elif problem_type == 'reflection':
        # Reflection over x-axis or y-axis
        base_func = choice([sin(x), cos(x), x**2, x**3, sqrt(x)])
        axis = choice(['x-axis', 'y-axis'])
        
        if axis == 'x-axis':
            transformed = -base_func
            explanation = "Reflection over the $x$-axis multiplies the function by $-1$"
            formula = "$g(x) = -f(x)$"
        else:
            transformed = base_func.subs(x, -x)
            explanation = "Reflection over the $y$-axis replaces $x$ with $-x$"
            formula = "$g(x) = f(-x)$"
        
        question = f"The graph of $f(x) = {latex(base_func)}$ is reflected over the {axis}. What is the equation of the transformed function?"
        
        ans = transformed
        
        solution = steps(
            explanation,
            f"{formula} = {latex(transformed)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1500),
            topic="precalculus/transformations",
            solution=solution
        )
    
    elif problem_type == 'stretch_compress':
        # Vertical stretch/compression
        base_func = choice([sin(x), cos(x), x**2, abs(x)])
        a = choice([Rational(1, 2), Rational(1, 3), 2, 3, 4])
        
        if a > 1:
            transform_type = "stretched"
            factor_text = f"{a}"
        else:
            transform_type = "compressed"
            factor_text = f"{a}"
        
        transformed = a * base_func
        
        question = f"The graph of $f(x) = {latex(base_func)}$ is vertically {transform_type} by a factor of ${latex(a)}$. What is the equation of the transformed function?"
        
        ans = transformed
        
        solution = steps(
            f"A vertical stretch/compression by factor ${latex(a)}$ multiplies the function by ${latex(a)}$",
            f"$g(x) = {latex(a)} \\cdot f(x) = {latex(transformed)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1500),
            topic="precalculus/transformations",
            solution=solution
        )
    
    else:  # combined transformations
        base_func = choice([sin(x), cos(x), x**2, abs(x)])
        h = nonzero(-4, 4)
        k = nonzero(-4, 4)
        a = choice([2, 3, Rational(1, 2), -1, -2])
        
        transformed = a * base_func.subs(x, x - h) + k
        
        transformations = []
        if a < 0:
            transformations.append(f"reflected over the $x$-axis")
        if abs(a) != 1:
            transformations.append(f"vertically {'stretched' if abs(a) > 1 else 'compressed'} by factor ${latex(abs(a))}$")
        if h != 0:
            transformations.append(f"shifted ${abs(h)}$ units {'right' if h > 0 else 'left'}")
        if k != 0:
            transformations.append(f"shifted ${abs(k)}$ units {'up' if k > 0 else 'down'}")
        
        transform_desc = ", ".join(transformations)
        
        question = f"The graph of $f(x) = {latex(base_func)}$ is {transform_desc}. What is the equation of the transformed function?"
        
        ans = transformed
        
        solution_steps = [f"Start with $f(x) = {latex(base_func)}$"]
        solution_steps.append(f"Apply transformations: $g(x) = {latex(a)}f(x - ({h})) + ({k})$")
        solution_steps.append(f"$g(x) = {latex(transformed)}$")
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1500, 1600),
            topic="precalculus/transformations",
            solution=steps(*solution_steps)
        )

emit(generate())