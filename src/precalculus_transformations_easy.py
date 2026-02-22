"""
precalculus - transformations (easy)
Generated: 2026-02-22T04:40:16.434884
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Horizontal/Vertical shifts of basic functions
        func_choice = randint(1, 3)
        h = nonzero(-5, 5)
        k = nonzero(-5, 5)
        
        if func_choice == 1:
            base_func = "x^2"
            transformed = (x - h)**2 + k
            func_name = "f(x) = x^2"
        elif func_choice == 2:
            base_func = "|x|"
            transformed = abs(x - h) + k
            func_name = "f(x) = |x|"
        else:
            base_func = "\\sqrt{x}"
            transformed = sqrt(x - h) + k
            func_name = "f(x) = \\sqrt{x}"
        
        h_dir = "right" if h > 0 else "left"
        k_dir = "up" if k > 0 else "down"
        
        question = f"The function ${func_name}$ is shifted {abs(h)} units {h_dir} and {abs(k)} units {k_dir}. Write the equation of the transformed function."
        
        solution_steps = steps(
            f"Start with ${func_name}$",
            f"Horizontal shift: replace $x$ with $(x - {h})$ to shift {abs(h)} units {h_dir}",
            f"Vertical shift: add ${k}$ to shift {abs(k)} units {k_dir}",
            f"Result: $g(x) = {latex(transformed)}$"
        )
        
        return problem(
            question=question,
            answer=transformed,
            difficulty=(1000, 1200),
            topic="precalculus/transformations",
            solution=solution_steps
        )
    
    elif problem_type == 2:
        # Simple vertical stretch/compression
        base_choice = randint(1, 2)
        a = choice([2, 3, Rational(1, 2), Rational(1, 3)])
        
        if base_choice == 1:
            base_func = "x^2"
            transformed = a * x**2
            func_name = "f(x) = x^2"
        else:
            base_func = "|x|"
            transformed = a * abs(x)
            func_name = "f(x) = |x|"
        
        if a > 1:
            transform_type = "stretched vertically"
            factor = a
        else:
            transform_type = "compressed vertically"
            factor = a
        
        question = f"The function ${func_name}$ is {transform_type} by a factor of ${latex(factor)}$. Write the equation of the transformed function."
        
        solution_steps = steps(
            f"Start with ${func_name}$",
            f"Multiply the function by ${latex(a)}$",
            f"Result: $g(x) = {latex(transformed)}$"
        )
        
        return problem(
            question=question,
            answer=transformed,
            difficulty=(1100, 1250),
            topic="precalculus/transformations",
            solution=solution_steps
        )
    
    elif problem_type == 3:
        # Reflection across x-axis or y-axis
        func_choice = randint(1, 3)
        axis = choice(['x', 'y'])
        
        if func_choice == 1:
            if axis == 'x':
                transformed = -x**2
                explanation = "Multiply the function by $-1$"
            else:
                transformed = (-x)**2
                explanation = "Replace $x$ with $-x$"
            func_name = "f(x) = x^2"
        elif func_choice == 2:
            if axis == 'x':
                transformed = -abs(x)
                explanation = "Multiply the function by $-1$"
            else:
                transformed = abs(-x)
                explanation = "Replace $x$ with $-x$"
            func_name = "f(x) = |x|"
        else:
            if axis == 'x':
                transformed = -x**3
                explanation = "Multiply the function by $-1$"
            else:
                transformed = (-x)**3
                explanation = "Replace $x$ with $-x$"
            func_name = "f(x) = x^3"
        
        question = f"The function ${func_name}$ is reflected across the ${axis}$-axis. Write the equation of the transformed function."
        
        solution_steps = steps(
            f"Start with ${func_name}$",
            f"To reflect across the ${axis}$-axis: {explanation}",
            f"Result: $g(x) = {latex(transformed)}$"
        )
        
        return problem(
            question=question,
            answer=transformed,
            difficulty=(1050, 1200),
            topic="precalculus/transformations",
            solution=solution_steps
        )
    
    else:
        # Identify the transformation from equation
        h = nonzero(-4, 4)
        k = nonzero(-4, 4)
        
        transformed = (x - h)**2 + k
        
        h_dir = "right" if h > 0 else "left"
        k_dir = "up" if k > 0 else "down"
        
        question = f"The function $g(x) = {latex(transformed)}$ is a transformation of $f(x) = x^2$. Describe the horizontal shift."
        
        answer_val = abs(h)
        
        solution_steps = steps(
            f"Compare $g(x) = {latex(transformed)}$ with $f(x) = x^2$",
            f"The term $(x - {h})$ indicates a horizontal shift",
            f"The function is shifted ${abs(h)}$ units {h_dir}"
        )
        
        return problem(
            question=question,
            answer=answer_val,
            difficulty=(1200, 1300),
            topic="precalculus/transformations",
            solution=solution_steps
        )

emit(generate())