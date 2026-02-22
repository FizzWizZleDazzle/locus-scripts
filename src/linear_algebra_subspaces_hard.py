"""
linear_algebra - subspaces (hard)
Generated: 2026-02-22T05:56:36.628011
"""

from problem_utils import *

def generate():
    problem_type = choice(['basis_check', 'dimension', 'sum_intersection', 'complement', 'span_check'])
    
    if problem_type == 'basis_check':
        # Generate vectors and ask if they form a basis for a subspace
        dim = choice([2, 3])
        num_vectors = randint(2, 4)
        
        if dim == 2:
            # Create vectors in R^3 that lie in a plane
            normal = Matrix([nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)])
            
            # Generate independent vectors perpendicular to normal
            v1 = Matrix([1, 0, -normal[0]/normal[2]]) if normal[2] != 0 else Matrix([1, 1, 0])
            v1 = v1 / gcd(v1)
            
            # Create another independent vector
            v2_temp = Matrix([0, 1, -normal[1]/normal[2]]) if normal[2] != 0 else Matrix([1, -1, 0])
            v2 = v2_temp - (v2_temp.dot(v1) / v1.dot(v1)) * v1
            v2 = v2 / gcd(v2)
            
            vectors = [v1, v2]
            
            if num_vectors == 3:
                # Add dependent vector
                c1, c2 = nonzero(-2, 2), nonzero(-2, 2)
                v3 = c1 * v1 + c2 * v2
                vectors.append(v3)
                is_basis = False
            else:
                is_basis = True
                
            question = "Let $W$ be the subspace of $\\mathbb{R}^3$ consisting of all vectors perpendicular to $" + latex(normal.T) + "$. "
            question += "Do the vectors $" + ", ".join([latex(v.T) for v in vectors]) + "$ form a basis for $W$?"
            
            answer = is_basis
            
            solution_steps = [
                f"The subspace $W$ has dimension 2 (the orthogonal complement of a line in $\\mathbb{{R}}^3$)."
            ]
            
            if num_vectors == 3:
                solution_steps.append(f"We have 3 vectors, but $\\dim(W) = 2$, so they cannot be linearly independent.")
                solution_steps.append(f"Therefore, they do not form a basis for $W$.")
            else:
                solution_steps.append(f"Check linear independence by row reducing the matrix with these vectors as columns.")
                M = Matrix.hstack(*vectors)
                solution_steps.append(f"The vectors are linearly independent and $\\dim(W) = 2$.")
                solution_steps.append(f"Therefore, they form a basis for $W$.")
            
        else:  # dim == 3
            # Generate independent or dependent vectors in R^4
            v1 = Matrix([nonzero(-2, 2), nonzero(-2, 2), 0, 0])
            v2 = Matrix([0, 0, nonzero(-2, 2), nonzero(-2, 2)])
            v3 = Matrix([nonzero(-2, 2), 0, nonzero(-2, 2), 0])
            
            vectors = [v1, v2, v3]
            is_basis = True
            
            question = "Let $W$ be the subspace of $\\mathbb{R}^4$ spanned by $" + latex(v1.T) + ", " + latex(v2.T) + ", " + latex(v3.T) + "$. "
            question += "Is this set of vectors a basis for $W$?"
            
            answer = is_basis
            
            M = Matrix.hstack(*vectors)
            rank = M.rank()
            
            solution_steps = [
                f"Form the matrix $A = {latex(M)}$",
                f"Row reduce to check linear independence.",
                f"The rank is {rank}, so the vectors are linearly independent.",
                f"Since they span $W$ by definition and are linearly independent, they form a basis for $W$."
            ]
        
        return problem(
            question=question,
            answer=answer,
            difficulty=(1650, 1850),
            topic="linear_algebra/subspaces",
            solution=steps(*solution_steps),
            answer_type="boolean"
        )
    
    elif problem_type == 'dimension':
        # Find dimension of intersection or sum of subspaces
        operation = choice(['intersection', 'sum'])
        
        # Create two subspaces in R^4
        # U spanned by 2 vectors
        u1 = Matrix([1, 0, nonzero(-2, 2), 0])
        u2 = Matrix([0, 1, 0, nonzero(-2, 2)])
        
        # V spanned by 2 vectors
        v1 = Matrix([1, nonzero(-2, 2), 0, 0])
        v2 = Matrix([0, 0, 1, nonzero(-2, 2)])
        
        if operation == 'intersection':
            question = f"Let $U = \\text{{span}}\\{{{latex(u1.T)}, {latex(u2.T)}\\}}$ and $V = \\text{{span}}\\{{{latex(v1.T)}, {latex(v2.T)}\\}}$ "
            question += f"be subspaces of $\\mathbb{{R}}^4$. Find $\\dim(U \\cap V)$."
            
            # Find intersection by solving system
            # Vector in intersection: c1*u1 + c2*u2 = d1*v1 + d2*v2
            M_u = Matrix.hstack(u1, u2)
            M_v = Matrix.hstack(v1, v2)
            M_combined = Matrix.hstack(M_u, -M_v)
            
            rank_combined = M_combined.rank()
            dim_u = 2
            dim_v = 2
            
            # Use dimension formula: dim(U) + dim(V) = dim(U+V) + dim(U∩V)
            # For this construction, intersection is typically 1-dimensional
            dim_intersection = dim_u + dim_v - rank_combined
            
            answer = dim_intersection
            
            solution_steps = [
                f"$\\dim(U) = 2$ and $\\dim(V) = 2$.",
                f"To find $\\dim(U \\cap V)$, we solve for vectors in both subspaces.",
                f"Form the augmented system $[U | -V]$ and find its rank: {rank_combined}.",
                f"By the dimension formula, $\\dim(U \\cap V) = \\dim(U) + \\dim(V) - \\dim(U + V) = 2 + 2 - {rank_combined} = {dim_intersection}$."
            ]
        else:  # sum
            question = f"Let $U = \\text{{span}}\\{{{latex(u1.T)}, {latex(u2.T)}\\}}$ and $V = \\text{{span}}\\{{{latex(v1.T)}, {latex(v2.T)}\\}}$ "
            question += f"be subspaces of $\\mathbb{{R}}^4$. Find $\\dim(U + V)$."
            
            M_combined = Matrix.hstack(u1, u2, v1, v2)
            dim_sum = M_combined.rank()
            
            answer = dim_sum
            
            solution_steps = [
                f"$U + V$ is spanned by all four vectors: ${latex(u1.T)}, {latex(u2.T)}, {latex(v1.T)}, {latex(v2.T)}$.",
                f"Form matrix $A = {latex(M_combined)}$.",
                f"The dimension of $U + V$ equals the rank of $A$.",
                f"$\\dim(U + V) = {dim_sum}$."
            ]
        
        return problem(
            question=question,
            answer=answer,
            difficulty=(1700, 1900),
            topic="linear_algebra/subspaces",
            solution=steps(*solution_steps),
            answer_type="numeric"
        )
    
    elif problem_type == 'sum_intersection':
        # Given dimensions, use dimension formula
        n = choice([4, 5])
        dim_u = randint(2, n-1)
        dim_v = randint(2, n-1)
        dim_intersection = randint(1, min(dim_u, dim_v))
        dim_sum = min(n, dim_u + dim_v - dim_intersection)
        
        find = choice(['sum', 'intersection'])
        
        if find == 'sum':
            question = f"Let $U$ and $V$ be subspaces of $\\mathbb{{R}}^{n}$ with $\\dim(U) = {dim_u}$, $\\dim(V) = {dim_v}$, "
            question += f"and $\\dim(U \\cap V) = {dim_intersection}$. Find $\\dim(U + V)$."
            
            answer = dim_sum
            
            solution_steps = [
                f"Use the dimension formula: $\\dim(U + V) = \\dim(U) + \\dim(V) - \\dim(U \\cap V)$.",
                f"$\\dim(U + V) = {dim_u} + {dim_v} - {dim_intersection} = {dim_sum}$."
            ]
        else:
            question = f"Let $U$ and $V$ be subspaces of $\\mathbb{{R}}^{n}$ with $\\dim(U) = {dim_u}$, $\\dim(V) = {dim_v}$, "
            question += f"and $\\dim(U + V) = {dim_sum}$. Find $\\dim(U \\cap V)$."
            
            answer = dim_intersection
            
            solution_steps = [
                f"Use the dimension formula: $\\dim(U + V) = \\dim(U) + \\dim(V) - \\dim(U \\cap V)$.",
                f"${dim_sum} = {dim_u} + {dim_v} - \\dim(U \\cap V)$.",
                f"$\\dim(U \\cap V) = {dim_u} + {dim_v} - {dim_sum} = {dim_intersection}$."
            ]
        
        return problem(
            question=question,
            answer=answer,
            difficulty=(1600, 1750),
            topic="linear_algebra/subspaces",
            solution=steps(*solution_steps),
            answer_type="numeric"
        )
    
    elif problem_type == 'complement':
        # Find dimension of orthogonal complement
        n = choice([4, 5])
        num_vectors = randint(2, n-1)
        
        vectors = []
        for i in range(num_vectors):
            v = Matrix([nonzero(-2, 2) if j < num_vectors else 0 for j in range(n)])
            vectors.append(v)
        
        M = Matrix.hstack(*vectors)
        rank = M.rank()
        dim_perp = n - rank
        
        question = f"Let $W$ be the subspace of $\\mathbb{{R}}^{n}$ spanned by the vectors "
        question += ", ".join([latex(v.T) for v in vectors]) + ". "
        question += f"Find $\\dim(W^\\perp)$, the dimension of the orthogonal complement of $W$."
        
        answer = dim_perp
        
        solution_steps = [
            f"First find $\\dim(W)$ by determining the rank of the matrix with these vectors as columns.",
            f"$\\dim(W) = {rank}$.",
            f"For any subspace $W$ of $\\mathbb{{R}}^{n}$, we have $\\dim(W) + \\dim(W^\\perp) = {n}$.",
            f"Therefore, $\\dim(W^\\perp) = {n} - {rank} = {dim_perp}$."
        ]
        
        return problem(
            question=question,
            answer=answer,
            difficulty=(1650, 1800),
            topic="linear_algebra/subspaces",
            solution=steps(*solution_steps),
            answer_type="numeric"
        )
    
    else:  # span_check
        # Check if a vector is in the span of given vectors
        n = 3
        v1 = Matrix([1, nonzero(-2, 2), 0])
        v2 = Matrix([0, 1, nonzero(-2, 2)])
        
        is_in_span = choice([True, False])
        
        if is_in_span:
            c1, c2 = nonzero(-3, 3), nonzero(-3, 3)
            w = c1 * v1 + c2 * v2
        else:
            w = Matrix([nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)])
            # Make sure it's not in span by adjusting
            M_aug = Matrix.hstack(v1, v2, w)
            if M_aug.rank() == 2:
                w = Matrix([1, 1, 1])
        
        question = f"Is the vector ${latex(w.T)}$ in the subspace $W = \\text{{span}}\\{{{latex(v1.T)}, {latex(v2.T)}\\}}$ of $\\mathbb{{R}}^3$?"
        
        answer = is_in_span
        
        M_check = Matrix.hstack(v1, v2, w)
        rank_check = M_check.rank()
        
        solution_steps = [
            f"Form the augmented matrix $[{latex(v1.T)} | {latex(v2.T)} | {latex(w.T)}]^T$ and row reduce.",
            f"The rank of $[v_1 | v_2]$ is 2."
        ]
        
        if is_in_span:
            solution_steps.append(f"The rank of $[v_1 | v_2 | w]$ is also 2, so $w$ is in $W$.")
        else:
            solution_steps.append(f"The rank of $[v_1 | v_2 | w]$ is {rank_check}, so $w$ is not in $W$.")
        
        return problem(
            question=question,
            answer=answer,
            difficulty=(1600, 1750),
            topic="linear_algebra/subspaces",
            solution=steps(*solution_steps),
            answer_type="boolean"
        )

emit(generate())