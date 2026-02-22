"""
linear_algebra - vector_spaces (hard)
Generated: 2026-02-22T05:54:38.126833
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Linear independence / dependence with parameters
        dim = randint(3, 4)
        num_vecs = dim
        
        # Create linearly dependent vectors with one being a linear combination
        base_vecs = []
        for i in range(num_vecs - 1):
            vec = [nonzero(-3, 3) for _ in range(dim)]
            base_vecs.append(vec)
        
        # Last vector is a linear combination
        coeff1 = nonzero(-2, 2)
        coeff2 = nonzero(-2, 2)
        last_vec = [coeff1 * base_vecs[0][i] + coeff2 * base_vecs[1][i] for i in range(dim)]
        
        all_vecs = base_vecs + [last_vec]
        
        # Create matrix with these vectors as columns
        mat = Matrix([all_vecs[j] for j in range(num_vecs)]).T
        
        question_vecs = ", ".join([f"\\mathbf{{v_{i+1}}} = {latex(Matrix(all_vecs[i]))}" for i in range(num_vecs)])
        
        ans = False
        
        return problem(
            question=f"Determine if the following vectors are linearly independent: ${question_vecs}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="linear_algebra/vector_spaces",
            solution=steps(
                f"Form matrix with vectors as columns: ${latex(mat)}$",
                f"Compute rank by row reduction",
                f"Rank is ${mat.rank()}$ which is less than ${num_vecs}$",
                f"Since rank < number of vectors, they are linearly dependent",
                f"Answer: No, they are not linearly independent"
            ),
            answer_type="boolean"
        )
    
    elif problem_type == 2:
        # Find basis for subspace defined by constraints
        # Subspace of R^4 where x1 + x2 = 0 and x3 - x4 = 0
        constraint_type = randint(1, 2)
        
        if constraint_type == 1:
            # Two constraints in R^4
            a1, a2 = nonzero(-2, 2), nonzero(-2, 2)
            b1, b2 = nonzero(-2, 2), nonzero(-2, 2)
            
            # Basis vectors satisfying constraints
            v1 = Matrix([1, -a1, 0, 0])
            v2 = Matrix([0, 0, 1, 1])
            
            dimension = 2
            
            basis_str = fmt_set([v1, v2])
            
            return problem(
                question=f"Find a basis for the subspace of $\\mathbb{{R}}^4$ defined by ${a1}x_1 + {a2}x_2 = 0$ and $x_3 - x_4 = 0$",
                answer=basis_str,
                difficulty=(1650, 1800),
                topic="linear_algebra/vector_spaces",
                solution=steps(
                    f"Express constraints: ${a1}x_1 + {a2}x_2 = 0$ means $x_2 = {latex(-a1*x/a2 if a2 != 0 else 0)}$",
                    f"And $x_3 = x_4$",
                    f"Let $x_1 = s$ and $x_3 = t$ be free variables",
                    f"General vector: $s{latex(v1)} + t{latex(v2)}$",
                    f"Basis: ${{{latex(v1)}, {latex(v2)}}}$"
                ),
                answer_type="set"
            )
        else:
            # Single constraint in R^3
            a1, a2, a3 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
            
            # Find two linearly independent vectors perpendicular to (a1, a2, a3)
            if a1 != 0:
                v1 = Matrix([a2, -a1, 0])
                v2 = Matrix([a3, 0, -a1])
            elif a2 != 0:
                v1 = Matrix([1, 0, 0])
                v2 = Matrix([0, a3, -a2])
            else:
                v1 = Matrix([1, 0, 0])
                v2 = Matrix([0, 1, 0])
            
            basis_str = fmt_set([v1, v2])
            
            return problem(
                question=f"Find a basis for the subspace of $\\mathbb{{R}}^3$ consisting of all vectors perpendicular to ${latex(Matrix([a1, a2, a3]))}$",
                answer=basis_str,
                difficulty=(1600, 1750),
                topic="linear_algebra/vector_spaces",
                solution=steps(
                    f"Vectors perpendicular to $\\mathbf{{n}} = {latex(Matrix([a1, a2, a3]))}$ satisfy ${a1}x_1 + {a2}x_2 + {a3}x_3 = 0$",
                    f"Find two linearly independent solutions",
                    f"Basis: ${{{latex(v1)}, {latex(v2)}}}$"
                ),
                answer_type="set"
            )
    
    elif problem_type == 3:
        # Dimension of intersection of two subspaces
        dim = 4
        
        # Create two subspaces via spanning sets
        # Use dimension formula: dim(U + V) = dim(U) + dim(V) - dim(U ∩ V)
        
        dim_U = 2
        dim_V = 2
        dim_intersection = 1
        
        # Build bases
        v_common = Matrix([1, 0, 1, 0])
        u1 = Matrix([1, 1, 0, 0])
        u2 = v_common
        v1 = Matrix([0, 1, 1, 1])
        v2 = v_common
        
        ans = dim_intersection
        
        return problem(
            question=f"Let $U = \\text{{span}}\\{{{latex(Matrix([1, 1, 0, 0]))}, {latex(Matrix([1, 0, 1, 0]))}\\}}$ and $V = \\text{{span}}\\{{{latex(Matrix([0, 1, 1, 1]))}, {latex(Matrix([1, 0, 1, 0]))}\\}}$ be subspaces of $\\mathbb{{R}}^4$. Find $\\dim(U \\cap V)$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="linear_algebra/vector_spaces",
            solution=steps(
                f"Notice that ${latex(v_common)}$ is in both $U$ and $V$",
                f"$\\dim(U) = 2$ and $\\dim(V) = 2$",
                f"The vector ${latex(v_common)}$ spans the intersection",
                f"Therefore $\\dim(U \\cap V) = 1$"
            ),
            answer_type="numeric"
        )
    
    elif problem_type == 4:
        # Coordinate vector with respect to a non-standard basis
        # Find [v]_B where B is a given basis
        
        # Create a basis for R^3
        b1 = Matrix([1, 1, 0])
        b2 = Matrix([1, 0, 1])
        b3 = Matrix([0, 1, 1])
        
        # Create target vector as linear combination
        c1, c2, c3 = randint(-3, 3), randint(-3, 3), nonzero(-3, 3)
        v = c1 * b1 + c2 * b2 + c3 * b3
        
        ans = Matrix([c1, c2, c3])
        
        return problem(
            question=f"Let $B = \\{{{latex(b1)}, {latex(b2)}, {latex(b3)}\\}}$ be a basis for $\\mathbb{{R}}^3$. Find the coordinate vector $[\\mathbf{{v}}]_B$ where $\\mathbf{{v}} = {latex(v)}$.",
            answer=ans,
            difficulty=(1650, 1800),
            topic="linear_algebra/vector_spaces",
            solution=steps(
                f"Need to find $c_1, c_2, c_3$ such that $\\mathbf{{v}} = c_1{latex(b1)} + c_2{latex(b2)} + c_3{latex(b3)}$",
                f"Set up system: ${latex(Matrix([b1, b2, b3]).T)} {latex(Matrix([c, d, k]))} = {latex(v)}$",
                f"Solving gives $c_1 = {c1}, c_2 = {c2}, c_3 = {c3}$",
                f"$[\\mathbf{{v}}]_B = {latex(ans)}$"
            ),
            answer_type="matrix"
        )
    
    else:
        # Prove/determine if a set is a subspace
        # Check if W = {(a, b, c) : a + 2b - c = 0} is a subspace
        
        coeff_a = nonzero(-2, 2)
        coeff_b = nonzero(-2, 2)
        
        ans = True
        
        return problem(
            question=f"Is $W = \\{{(a, b, c) \\in \\mathbb{{R}}^3 : {coeff_a}a + {coeff_b}b - c = 0\\}}$ a subspace of $\\mathbb{{R}}^3$?",
            answer=ans,
            difficulty=(1600, 1700),
            topic="linear_algebra/vector_spaces",
            solution=steps(
                "Check three conditions: (1) zero vector, (2) closed under addition, (3) closed under scalar multiplication",
                f"(1) Zero vector $(0,0,0)$ satisfies ${coeff_a}(0) + {coeff_b}(0) - 0 = 0$ ✓",
                f"(2) If $\\mathbf{{u}}, \\mathbf{{v}} \\in W$, then ${coeff_a}(u_1+v_1) + {coeff_b}(u_2+v_2) - (u_3+v_3) = 0$ ✓",
                f"(3) If $\\mathbf{{u}} \\in W$ and $k \\in \\mathbb{{R}}$, then ${coeff_a}(ku_1) + {coeff_b}(ku_2) - ku_3 = k({coeff_a}u_1 + {coeff_b}u_2 - u_3) = 0$ ✓",
                "All conditions satisfied, so $W$ is a subspace"
            ),
            answer_type="boolean"
        )

emit(generate())