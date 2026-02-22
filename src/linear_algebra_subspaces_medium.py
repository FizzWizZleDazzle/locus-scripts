"""
linear_algebra - subspaces (medium)
Generated: 2026-02-22T05:55:46.325040
"""

from problem_utils import *

def generate():
    problem_type = choice(['verify_subspace', 'basis_dimension', 'span_check', 'intersection'])
    
    if problem_type == 'verify_subspace':
        # Generate a subspace of R^3 defined by linear constraints
        constraint_type = choice(['plane', 'line', 'parametric'])
        
        if constraint_type == 'plane':
            # Plane through origin: ax + by + cz = 0
            a_val = nonzero(-3, 3)
            b_val = nonzero(-3, 3)
            c_val = nonzero(-3, 3)
            
            question = f"Is $W = \\{{(x, y, z) \\in \\mathbb{{R}}^3 : {a_val}x "
            if b_val > 0:
                question += f"+ {b_val}y "
            else:
                question += f"{b_val}y "
            if c_val > 0:
                question += f"+ {c_val}z = 0\\}}$ a subspace of $\\mathbb{{R}}^3$?"
            else:
                question += f"{c_val}z = 0\\}}$ a subspace of $\\mathbb{{R}}^3$?"
            
            ans = True
            solution = steps(
                "Check the three subspace criteria:",
                "1. Zero vector: $(0,0,0)$ satisfies the equation since $0 = 0$. ✓",
                "2. Closure under addition: If $(x_1,y_1,z_1), (x_2,y_2,z_2) \\in W$, then their sum satisfies the equation by linearity. ✓",
                "3. Closure under scalar multiplication: If $(x,y,z) \\in W$ and $c \\in \\mathbb{R}$, then $c(x,y,z)$ satisfies the equation. ✓",
                "Therefore, $W$ is a subspace of $\\mathbb{R}^3$."
            )
            
            return problem(
                question=question,
                answer=ans,
                difficulty=(1300, 1400),
                topic="linear_algebra/subspaces",
                solution=solution
            )
        
        else:  # parametric
            # Give parametric form and ask if it's a subspace
            a1, a2 = nonzero(-3, 3), nonzero(-3, 3)
            b1, b2 = nonzero(-3, 3), nonzero(-3, 3)
            
            question = f"Is $W = \\{{t\\begin{{pmatrix}} {a1} \\\\ {a2} \\end{{pmatrix}} : t \\in \\mathbb{{R}}\\}}$ a subspace of $\\mathbb{{R}}^2$?"
            
            ans = True
            solution = steps(
                "This is the span of a single vector, which forms a line through the origin.",
                "1. Zero vector: Setting $t=0$ gives $(0,0)$. ✓",
                "2. Closure under addition: $t_1\\mathbf{v} + t_2\\mathbf{v} = (t_1+t_2)\\mathbf{v} \\in W$. ✓",
                "3. Closure under scalar multiplication: $c(t\\mathbf{v}) = (ct)\\mathbf{v} \\in W$. ✓",
                "Therefore, $W$ is a subspace."
            )
            
            return problem(
                question=question,
                answer=ans,
                difficulty=(1300, 1400),
                topic="linear_algebra/subspaces",
                solution=solution
            )
    
    elif problem_type == 'basis_dimension':
        # Find basis and dimension of a subspace
        dim_choice = choice([1, 2])
        
        if dim_choice == 1:
            # Line in R^3
            a_val = nonzero(-3, 3)
            b_val = nonzero(-3, 3)
            c_val = nonzero(-3, 3)
            
            question = f"Find the dimension of the subspace $W = \\text{{span}}\\left\\{{\\begin{{pmatrix}} {a_val} \\\\ {b_val} \\\\ {c_val} \\end{{pmatrix}}\\right\\}}$."
            
            ans = 1
            solution = steps(
                f"The subspace is spanned by one vector $\\mathbf{{v}} = \\begin{{pmatrix}} {a_val} \\\\ {b_val} \\\\ {c_val} \\end{{pmatrix}}$.",
                "Since this vector is nonzero, it forms a linearly independent set.",
                "Therefore, $\\dim(W) = 1$."
            )
            
            return problem(
                question=question,
                answer=ans,
                difficulty=(1400, 1500),
                topic="linear_algebra/subspaces",
                solution=solution
            )
        
        else:  # dim 2
            # Plane in R^3 given by constraint
            a_val = nonzero(-2, 2)
            b_val = nonzero(-2, 2)
            c_val = nonzero(-2, 2)
            
            question = f"Find the dimension of the subspace $W = \\{{(x, y, z) \\in \\mathbb{{R}}^3 : {a_val}x "
            if b_val > 0:
                question += f"+ {b_val}y "
            else:
                question += f"{b_val}y "
            if c_val > 0:
                question += f"+ {c_val}z = 0\\}}$."
            else:
                question += f"{c_val}z = 0\\}}$."
            
            ans = 2
            solution = steps(
                "This is a plane through the origin in $\\mathbb{R}^3$.",
                "A plane through the origin in $\\mathbb{R}^3$ has dimension 2.",
                "Alternatively: We have 1 constraint equation on 3 variables,",
                "so $\\dim(W) = 3 - 1 = 2$ (by rank-nullity theorem)."
            )
            
            return problem(
                question=question,
                answer=ans,
                difficulty=(1400, 1500),
                topic="linear_algebra/subspaces",
                solution=solution
            )
    
    elif problem_type == 'span_check':
        # Check if a vector is in the span of given vectors
        # Keep it simple: R^2, check if (a,b) is in span of (c,d)
        
        c_val = nonzero(-3, 3)
        d_val = nonzero(-3, 3)
        
        in_span = choice([True, False])
        
        if in_span:
            scalar = nonzero(-2, 2)
            a_val = scalar * c_val
            b_val = scalar * d_val
        else:
            # Pick random that's not a multiple
            a_val = nonzero(-5, 5)
            b_val = nonzero(-5, 5)
            # Make sure it's not accidentally in span
            if c_val * b_val == d_val * a_val:
                b_val += 1
        
        question = f"Is the vector $\\begin{{pmatrix}} {a_val} \\\\ {b_val} \\end{{pmatrix}}$ in the subspace $W = \\text{{span}}\\left\\{{\\begin{{pmatrix}} {c_val} \\\\ {d_val} \\end{{pmatrix}}\\right\\}}$?"
        
        ans = in_span
        
        if in_span:
            solution = steps(
                f"We need to check if $\\begin{{pmatrix}} {a_val} \\\\ {b_val} \\end{{pmatrix}} = t\\begin{{pmatrix}} {c_val} \\\\ {d_val} \\end{{pmatrix}}$ for some scalar $t$.",
                f"From the first component: $t = {a_val}/{c_val} = {Rational(a_val, c_val)}$.",
                f"Checking second component: ${Rational(a_val, c_val)} \\cdot {d_val} = {Rational(a_val * d_val, c_val)} = {b_val}$. ✓",
                "Yes, the vector is in $W$."
            )
        else:
            solution = steps(
                f"We check if $\\begin{{pmatrix}} {a_val} \\\\ {b_val} \\end{{pmatrix}} = t\\begin{{pmatrix}} {c_val} \\\\ {d_val} \\end{{pmatrix}}$ for some scalar $t$.",
                f"From first component: $t = {Rational(a_val, c_val)}$.",
                f"From second component: $t = {Rational(b_val, d_val)}$.",
                f"Since ${latex(Rational(a_val, c_val))} \\neq {latex(Rational(b_val, d_val))}$, no such $t$ exists.",
                "No, the vector is not in $W$."
            )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1500, 1600),
            topic="linear_algebra/subspaces",
            solution=solution
        )
    
    else:  # intersection
        # Intersection of two subspaces
        # Two lines in R^2: find dimension of intersection
        
        a1 = nonzero(-3, 3)
        b1 = nonzero(-3, 3)
        a2 = nonzero(-3, 3)
        b2 = nonzero(-3, 3)
        
        # Make sure vectors are not parallel
        if a1 * b2 == a2 * b1:
            b2 += 1
        
        question = f"Find the dimension of $W_1 \\cap W_2$ where $W_1 = \\text{{span}}\\left\\{{\\begin{{pmatrix}} {a1} \\\\ {b1} \\end{{pmatrix}}\\right\\}}$ and $W_2 = \\text{{span}}\\left\\{{\\begin{{pmatrix}} {a2} \\\\ {b2} \\end{{pmatrix}}\\right\\}}$."
        
        ans = 0
        solution = steps(
            "$W_1$ and $W_2$ are distinct lines through the origin in $\\mathbb{R}^2$.",
            "The only vector in both lines is the zero vector.",
            "Therefore, $W_1 \\cap W_2 = \\{\\mathbf{0}\\}$, which has dimension $0$."
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1500, 1600),
            topic="linear_algebra/subspaces",
            solution=solution
        )

emit(generate())