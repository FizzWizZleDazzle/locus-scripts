"""
linear_algebra - subspaces (easy)
Generated: 2026-02-22T05:55:10.657769
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Check if a given vector is in a subspace (span of given vectors)
        # Easiest: 2D vectors, clearly in or not in span
        dim = 2
        
        # Create basis vector(s) for subspace
        if randint(0, 1) == 0:
            # Subspace is span of single vector
            v1_coords = [nonzero(-3, 3) for _ in range(dim)]
            v1 = Matrix(v1_coords)
            
            # Test vector - either scalar multiple or not
            if randint(0, 1) == 0:
                # In the span
                scalar = nonzero(-3, 3)
                test_vec = scalar * v1
                ans = True
            else:
                # Not in the span
                test_vec = Matrix([nonzero(-3, 3) for _ in range(dim)])
                # Make sure it's not accidentally a scalar multiple
                while v1_coords[1] * test_vec[0] == v1_coords[0] * test_vec[1]:
                    test_vec = Matrix([nonzero(-3, 3) for _ in range(dim)])
                ans = False
            
            question = f"Is the vector ${latex(test_vec)}$ in the subspace spanned by ${latex(v1)}$?"
            
            if ans:
                ratio = test_vec[0] / v1[0] if v1[0] != 0 else test_vec[1] / v1[1]
                solution = steps(
                    f"Check if ${latex(test_vec)} = c{latex(v1)}$ for some scalar $c$",
                    f"We need ${test_vec[0]} = c({v1[0]})$ and ${test_vec[1]} = c({v1[1]})$",
                    f"From first equation: $c = {latex(ratio)}$",
                    f"Check: ${latex(ratio)} \\cdot {latex(v1)} = {latex(test_vec)}$ ✓",
                    "Yes, the vector is in the subspace"
                )
            else:
                solution = steps(
                    f"Check if ${latex(test_vec)} = c{latex(v1)}$ for some scalar $c$",
                    f"From first component: $c = {latex(test_vec[0]/v1[0])}$" if v1[0] != 0 else f"From second component: $c = {latex(test_vec[1]/v1[1])}$",
                    f"But this doesn't satisfy both equations",
                    "No, the vector is not in the subspace"
                )
        else:
            # Subspace is span of two vectors in R^3
            dim = 3
            v1 = Matrix([nonzero(-2, 2), nonzero(-2, 2), 0])
            v2 = Matrix([0, nonzero(-2, 2), nonzero(-2, 2)])
            
            if randint(0, 1) == 0:
                # In the span
                c1, c2 = randint(-2, 2), randint(-2, 2)
                test_vec = c1 * v1 + c2 * v2
                ans = True
            else:
                # Not in the span (use a vector with specific pattern)
                test_vec = Matrix([nonzero(-3, 3), 0, 0])
                ans = False
            
            question = f"Is the vector ${latex(test_vec)}$ in the subspace spanned by ${latex(v1)}$ and ${latex(v2)}$?"
            
            if ans:
                solution = steps(
                    f"Check if ${latex(test_vec)} = c_1{latex(v1)} + c_2{latex(v2)}$ for some scalars",
                    f"Setting up the system of equations and solving",
                    f"We find $c_1 = {c1}, c_2 = {c2}$",
                    "Yes, the vector is in the subspace"
                )
            else:
                solution = steps(
                    f"Check if ${latex(test_vec)} = c_1{latex(v1)} + c_2{latex(v2)}$ for some scalars",
                    "Setting up equations from components",
                    "The system has no solution",
                    "No, the vector is not in the subspace"
                )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1200),
            topic="linear_algebra/subspaces",
            solution=solution
        )
    
    elif problem_type == 2:
        # Determine dimension of span
        # Easy: clearly dependent or independent vectors
        if randint(0, 1) == 0:
            # Two vectors in R^2, linearly independent
            v1 = Matrix([1, 0])
            v2 = Matrix([0, 1])
            ans = 2
            
            question = f"What is the dimension of the subspace spanned by ${latex(v1)}$ and ${latex(v2)}$?"
            solution = steps(
                "The vectors are linearly independent (not scalar multiples)",
                "Two linearly independent vectors in $\\mathbb{R}^2$ span a 2-dimensional subspace",
                f"Dimension = ${ans}$"
            )
        else:
            # Two vectors in R^2, linearly dependent
            v1_val = [nonzero(-3, 3), nonzero(-3, 3)]
            v1 = Matrix(v1_val)
            scalar = nonzero(-3, 3)
            v2 = scalar * v1
            ans = 1
            
            question = f"What is the dimension of the subspace spanned by ${latex(v1)}$ and ${latex(v2)}$?"
            solution = steps(
                f"Notice that ${latex(v2)} = {scalar} \\cdot {latex(v1)}$",
                "The vectors are linearly dependent (one is a scalar multiple of the other)",
                "They span a 1-dimensional subspace (a line through the origin)",
                f"Dimension = ${ans}$"
            )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1300),
            topic="linear_algebra/subspaces",
            solution=solution
        )
    
    elif problem_type == 3:
        # Find a basis for span of vectors
        # Easy version: already independent or obviously dependent
        v1 = Matrix([1, 0])
        v2 = Matrix([0, 1])
        ans = fmt_set(f"{{{latex(v1)}, {latex(v2)}}}")
        
        question = f"Find a basis for the subspace of $\\mathbb{{R}}^2$ spanned by ${latex(v1)}$ and ${latex(v2)}$"
        solution = steps(
            "Check if the vectors are linearly independent",
            "They are not scalar multiples of each other, so they are independent",
            f"Basis: ${{{latex(v1)}, {latex(v2)}}}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1200, 1300),
            topic="linear_algebra/subspaces",
            solution=solution,
            answer_type="set"
        )
    
    elif problem_type == 4:
        # Verify subspace axioms - zero vector
        # Is the zero vector in the span?
        v1 = Matrix([nonzero(-3, 3), nonzero(-3, 3)])
        ans = True
        
        question = f"Is the zero vector in the subspace spanned by ${latex(v1)}$?"
        solution = steps(
            "Every subspace must contain the zero vector",
            f"We can write $\\vec{{0}} = 0 \\cdot {latex(v1)}$",
            "Yes, the zero vector is in the subspace"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1100),
            topic="linear_algebra/subspaces",
            solution=solution
        )
    
    else:
        # Check if set is closed under addition (very simple case)
        # Span of a vector
        v1 = Matrix([randint(1, 3), randint(1, 3)])
        ans = True
        
        question = f"Is the span of ${latex(v1)}$ closed under vector addition?"
        solution = steps(
            "A span is always a subspace",
            "Subspaces are closed under addition by definition",
            f"If $\\vec{{u}} = c_1{latex(v1)}$ and $\\vec{{v}} = c_2{latex(v1)}$",
            f"Then $\\vec{{u}} + \\vec{{v}} = (c_1 + c_2){latex(v1)}$, which is also in the span",
            "Yes, it is closed under addition"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1200),
            topic="linear_algebra/subspaces",
            solution=solution
        )

emit(generate())