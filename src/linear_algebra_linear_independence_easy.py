"""
linear_algebra - linear_independence (easy)
Generated: 2026-02-22T05:57:01.464546
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Check if 2 vectors in R^2 are linearly independent (visual/simple)
        # ELO ~1000-1150: Direct check with 2 vectors
        a1, a2 = nonzero(-5, 5), nonzero(-5, 5)
        b1, b2 = nonzero(-5, 5), nonzero(-5, 5)
        
        # Make sure they're not scalar multiples
        if a1 * b2 != a2 * b1:
            # Linearly independent
            ans = True
            det_val = a1 * b2 - a2 * b1
            return problem(
                question=f"Are the vectors $\\begin{{pmatrix}} {a1} \\\\ {a2} \\end{{pmatrix}}$ and $\\begin{{pmatrix}} {b1} \\\\ {b2} \\end{{pmatrix}}$ linearly independent?",
                answer=ans,
                difficulty=(1000, 1150),
                topic="linear_algebra/linear_independence",
                solution=steps(
                    f"Two vectors in $\\mathbb{{R}}^2$ are linearly independent if one is not a scalar multiple of the other.",
                    f"Check if $\\begin{{vmatrix}} {a1} & {b1} \\\\ {a2} & {b2} \\end{{vmatrix}} \\neq 0$",
                    f"Determinant = ${a1} \\cdot {b2} - {a2} \\cdot {b1} = {det_val} \\neq 0$",
                    f"Therefore, the vectors are linearly independent.",
                ),
            )
        else:
            # Make them dependent
            k = a1 // b1 if b1 != 0 else a2 // b2
            b1, b2 = a1 // k if k != 0 else a1, a2 // k if k != 0 else a2
            ans = False
            return problem(
                question=f"Are the vectors $\\begin{{pmatrix}} {a1} \\\\ {a2} \\end{{pmatrix}}$ and $\\begin{{pmatrix}} {b1} \\\\ {b2} \\end{{pmatrix}}$ linearly independent?",
                answer=ans,
                difficulty=(1000, 1150),
                topic="linear_algebra/linear_independence",
                solution=steps(
                    f"Two vectors in $\\mathbb{{R}}^2$ are linearly independent if one is not a scalar multiple of the other.",
                    f"Notice that $\\begin{{pmatrix}} {a1} \\\\ {a2} \\end{{pmatrix}} = {k} \\begin{{pmatrix}} {b1} \\\\ {b2} \\end{{pmatrix}}$",
                    f"Therefore, the vectors are linearly dependent (not independent).",
                ),
            )
    
    elif problem_type == 2:
        # Type 2: Check if a single vector is linearly independent (trivial case)
        # ELO ~1000-1100: Understanding that one nonzero vector is always LI
        a1, a2 = nonzero(-5, 5), nonzero(-5, 5)
        ans = True
        return problem(
            question=f"Is the set containing only the vector $\\begin{{pmatrix}} {a1} \\\\ {a2} \\end{{pmatrix}}$ linearly independent?",
            answer=ans,
            difficulty=(1000, 1100),
            topic="linear_algebra/linear_independence",
            solution=steps(
                f"A set containing a single nonzero vector is always linearly independent.",
                f"Since $\\begin{{pmatrix}} {a1} \\\\ {a2} \\end{{pmatrix}} \\neq \\begin{{pmatrix}} 0 \\\\ 0 \\end{{pmatrix}}$, the set is linearly independent.",
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Check if set containing zero vector is LI
        # ELO ~1100-1200: Recognize zero vector makes set dependent
        a1, a2 = nonzero(-5, 5), nonzero(-5, 5)
        ans = False
        return problem(
            question=f"Is the set $\\left\\{{\\begin{{pmatrix}} {a1} \\\\ {a2} \\end{{pmatrix}}, \\begin{{pmatrix}} 0 \\\\ 0 \\end{{pmatrix}}\\right\\}}$ linearly independent?",
            answer=ans,
            difficulty=(1100, 1200),
            topic="linear_algebra/linear_independence",
            solution=steps(
                f"A set of vectors is linearly dependent if it contains the zero vector.",
                f"Since $\\begin{{pmatrix}} 0 \\\\ 0 \\end{{pmatrix}}$ is in the set, we can write:",
                f"$0 \\cdot \\begin{{pmatrix}} {a1} \\\\ {a2} \\end{{pmatrix}} + 1 \\cdot \\begin{{pmatrix}} 0 \\\\ 0 \\end{{pmatrix}} = \\begin{{pmatrix}} 0 \\\\ 0 \\end{{pmatrix}}$ (nontrivial linear combination)",
                f"Therefore, the set is linearly dependent (not independent).",
            ),
        )
    
    else:
        # Type 4: Simple 2x2 determinant check with nice numbers
        # ELO ~1150-1300: Computing determinant to check independence
        a1, a2 = randint(1, 4), randint(1, 4)
        b1, b2 = randint(1, 4), randint(1, 4)
        
        det_val = a1 * b2 - a2 * b1
        
        if det_val != 0:
            ans = True
            return problem(
                question=f"Determine whether the vectors $\\mathbf{{v}}_1 = \\begin{{pmatrix}} {a1} \\\\ {a2} \\end{{pmatrix}}$ and $\\mathbf{{v}}_2 = \\begin{{pmatrix}} {b1} \\\\ {b2} \\end{{pmatrix}}$ are linearly independent.",
                answer=ans,
                difficulty=(1150, 1300),
                topic="linear_algebra/linear_independence",
                solution=steps(
                    f"Form the matrix $A = \\begin{{pmatrix}} {a1} & {b1} \\\\ {a2} & {b2} \\end{{pmatrix}}$ with the vectors as columns.",
                    f"Compute $\\det(A) = {a1} \\cdot {b2} - {a2} \\cdot {b1} = {a1 * b2} - {a2 * b1} = {det_val}$",
                    f"Since $\\det(A) \\neq 0$, the vectors are linearly independent.",
                ),
            )
        else:
            ans = False
            return problem(
                question=f"Determine whether the vectors $\\mathbf{{v}}_1 = \\begin{{pmatrix}} {a1} \\\\ {a2} \\end{{pmatrix}}$ and $\\mathbf{{v}}_2 = \\begin{{pmatrix}} {b1} \\\\ {b2} \\end{{pmatrix}}$ are linearly independent.",
                answer=ans,
                difficulty=(1150, 1300),
                topic="linear_algebra/linear_independence",
                solution=steps(
                    f"Form the matrix $A = \\begin{{pmatrix}} {a1} & {b1} \\\\ {a2} & {b2} \\end{{pmatrix}}$ with the vectors as columns.",
                    f"Compute $\\det(A) = {a1} \\cdot {b2} - {a2} \\cdot {b1} = {a1 * b2} - {a2 * b1} = {det_val}$",
                    f"Since $\\det(A) = 0$, the vectors are linearly dependent (not independent).",
                ),
            )

emit(generate())