"""
linear_algebra - vector_spaces (easy)
Generated: 2026-02-22T05:53:19.395428
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Check if a vector is in a given span (1000-1200)
        # Simple 2D case with obvious answer
        v1_vals = [nonzero(-3, 3), nonzero(-3, 3)]
        scalar = randint(2, 4)
        test_vec = [scalar * v1_vals[0], scalar * v1_vals[1]]
        
        v1 = Matrix(v1_vals)
        test = Matrix(test_vec)
        
        return problem(
            question=f"Is the vector ${latex(test)}$ in the span of ${latex(v1)}$?",
            answer=True,
            difficulty=(1000, 1150),
            topic="linear_algebra/vector_spaces",
            solution=steps(
                f"We need to check if there exists a scalar $c$ such that $c{latex(v1)} = {latex(test)}$",
                f"From the first component: $c \\cdot {v1_vals[0]} = {test_vec[0]}$, so $c = {scalar}$",
                f"Check second component: ${scalar} \\cdot {v1_vals[1]} = {scalar * v1_vals[1]} = {test_vec[1]}$ ✓",
                f"Therefore, the vector is in the span."
            ),
        )
    
    elif problem_type == 2:
        # Find a linear combination (1100-1250)
        c1 = randint(1, 3)
        c2 = randint(1, 3)
        v1_vals = [nonzero(-2, 2), nonzero(-2, 2)]
        v2_vals = [nonzero(-2, 2), nonzero(-2, 2)]
        
        result = [c1 * v1_vals[0] + c2 * v2_vals[0], c1 * v1_vals[1] + c2 * v2_vals[1]]
        
        v1 = Matrix(v1_vals)
        v2 = Matrix(v2_vals)
        result_vec = Matrix(result)
        
        return problem(
            question=f"Express ${latex(result_vec)}$ as a linear combination of ${latex(v1)}$ and ${latex(v2)}$. What is the coefficient of ${latex(v1)}$?",
            answer=c1,
            difficulty=(1100, 1250),
            topic="linear_algebra/vector_spaces",
            solution=steps(
                f"We want to find $a$ and $b$ such that $a{latex(v1)} + b{latex(v2)} = {latex(result_vec)}$",
                f"From the first component: $a \\cdot {v1_vals[0]} + b \\cdot {v2_vals[0]} = {result[0]}$",
                f"From the second component: $a \\cdot {v1_vals[1]} + b \\cdot {v2_vals[1]} = {result[1]}$",
                f"By inspection or solving: $a = {c1}$, $b = {c2}$",
                f"The coefficient of ${latex(v1)}$ is ${c1}$"
            ),
        )
    
    elif problem_type == 3:
        # Determine if vectors are linearly independent - simple 2D case (1150-1300)
        # Two parallel vectors (dependent)
        scalar = randint(2, 4)
        v1_vals = [nonzero(-3, 3), nonzero(-3, 3)]
        v2_vals = [scalar * v1_vals[0], scalar * v1_vals[1]]
        
        v1 = Matrix(v1_vals)
        v2 = Matrix(v2_vals)
        
        return problem(
            question=f"Are the vectors ${latex(v1)}$ and ${latex(v2)}$ linearly independent?",
            answer=False,
            difficulty=(1150, 1300),
            topic="linear_algebra/vector_spaces",
            solution=steps(
                f"Vectors are linearly independent if the only solution to $c_1{latex(v1)} + c_2{latex(v2)} = \\vec{{0}}$ is $c_1 = c_2 = 0$",
                f"Notice that ${latex(v2)} = {scalar}{latex(v1)}$",
                f"So ${scalar}{latex(v1)} - {latex(v2)} = \\vec{{0}}$ with non-zero coefficients",
                f"Therefore, the vectors are linearly dependent (not independent)."
            ),
        )
    
    elif problem_type == 4:
        # Add two vectors (1000-1100)
        v1_vals = [randint(-5, 5), randint(-5, 5)]
        v2_vals = [randint(-5, 5), randint(-5, 5)]
        
        v1 = Matrix(v1_vals)
        v2 = Matrix(v2_vals)
        result = v1 + v2
        
        return problem(
            question=f"Add the vectors ${latex(v1)} + {latex(v2)}$",
            answer=result,
            difficulty=(1000, 1100),
            topic="linear_algebra/vector_spaces",
            solution=steps(
                f"Add corresponding components:",
                f"First component: ${v1_vals[0]} + {v2_vals[0]} = {v1_vals[0] + v2_vals[0]}$",
                f"Second component: ${v1_vals[1]} + {v2_vals[1]} = {v1_vals[1] + v2_vals[1]}$",
                f"Result: ${latex(result)}$"
            ),
        )
    
    else:
        # Scalar multiplication (1000-1100)
        scalar = nonzero(-4, 4)
        v_vals = [randint(-4, 4), randint(-4, 4)]
        
        v = Matrix(v_vals)
        result = scalar * v
        
        return problem(
            question=f"Multiply the vector ${latex(v)}$ by the scalar ${scalar}$",
            answer=result,
            difficulty=(1000, 1100),
            topic="linear_algebra/vector_spaces",
            solution=steps(
                f"Multiply each component by ${scalar}$:",
                f"First component: ${scalar} \\cdot {v_vals[0]} = {scalar * v_vals[0]}$",
                f"Second component: ${scalar} \\cdot {v_vals[1]} = {scalar * v_vals[1]}$",
                f"Result: ${latex(result)}$"
            ),
        )

emit(generate())