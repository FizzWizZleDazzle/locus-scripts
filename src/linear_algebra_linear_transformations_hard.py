"""
linear_algebra - linear_transformations (hard)
Generated: 2026-02-22T06:01:53.235730
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Matrix of linear transformation with kernel and image computation
        # Difficulty: 1600-1750
        rows = 3
        cols = 3
        rank = choice([1, 2])
        
        # Build matrix with specific rank
        if rank == 1:
            v = Matrix([nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)])
            A = v * Matrix([[nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)]])
        else:  # rank 2
            v1 = Matrix([nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)])
            v2 = Matrix([nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)])
            A = v1 * Matrix([[1, 0, nonzero(-1, 1)]]) + v2 * Matrix([[0, 1, nonzero(-1, 1)]])
        
        nullity = cols - rank
        
        return problem(
            question=f"Let $T: \\mathbb{{R}}^3 \\to \\mathbb{{R}}^3$ be the linear transformation with matrix ${latex(A)}$. Find the dimension of the kernel (null space) of $T$.",
            answer=nullity,
            difficulty=(1600, 1750),
            topic="linear_algebra/linear_transformations",
            solution=steps(
                f"By the rank-nullity theorem: $\\dim(\\ker(T)) + \\dim(\\text{{im}}(T)) = \\dim(\\mathbb{{R}}^3) = 3$",
                f"Compute the rank of $A$ by row reduction",
                f"The rank of $A$ is ${rank}$",
                f"Therefore $\\dim(\\ker(T)) = 3 - {rank} = {nullity}$"
            ),
        )
    
    elif problem_type == 2:
        # Composition of linear transformations
        # Difficulty: 1650-1800
        A = Matrix([[randint(1, 3), nonzero(-2, 2)], [nonzero(-2, 2), randint(1, 3)]])
        B = Matrix([[nonzero(-2, 2), randint(1, 2)], [randint(1, 2), nonzero(-2, 2)]])
        
        v = Matrix([nonzero(-3, 3), nonzero(-3, 3)])
        
        result = A * (B * v)
        
        return problem(
            question=f"Let $S: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ be given by $S(\\mathbf{{v}}) = {latex(B)}\\mathbf{{v}}$ and $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ be given by $T(\\mathbf{{v}}) = {latex(A)}\\mathbf{{v}}$. Find $(T \\circ S){latex(v)}$.",
            answer=result,
            difficulty=(1650, 1800),
            topic="linear_algebra/linear_transformations",
            solution=steps(
                f"$(T \\circ S)(\\mathbf{{v}}) = T(S(\\mathbf{{v}}))$",
                f"First compute $S{latex(v)} = {latex(B)}{latex(v)} = {latex(B*v)}$",
                f"Then compute $T({latex(B*v)}) = {latex(A)}{latex(B*v)} = {latex(result)}$",
                f"Answer: ${latex(result)}$"
            ),
        )
    
    elif problem_type == 3:
        # Finding matrix representation given transformation of basis vectors
        # Difficulty: 1700-1850
        e1 = Matrix([1, 0])
        e2 = Matrix([0, 1])
        
        a11, a12 = nonzero(-3, 3), nonzero(-3, 3)
        a21, a22 = nonzero(-3, 3), nonzero(-3, 3)
        
        T_e1 = Matrix([a11, a21])
        T_e2 = Matrix([a12, a22])
        
        A = Matrix([[a11, a12], [a21, a22]])
        
        return problem(
            question=f"A linear transformation $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ satisfies $T{latex(e1)} = {latex(T_e1)}$ and $T{latex(e2)} = {latex(T_e2)}$. Find the matrix $[T]$ representing $T$ with respect to the standard basis.",
            answer=A,
            difficulty=(1700, 1850),
            topic="linear_algebra/linear_transformations",
            solution=steps(
                f"The matrix of $T$ has columns given by the images of the standard basis vectors",
                f"First column: $T{latex(e1)} = {latex(T_e1)}$",
                f"Second column: $T{latex(e2)} = {latex(T_e2)}$",
                f"Therefore $[T] = {latex(A)}$"
            ),
        )
    
    elif problem_type == 4:
        # Determine if transformation is injective/surjective
        # Difficulty: 1650-1800
        is_injective = choice([True, False])
        
        if is_injective:
            # Full rank 2x3 matrix (injective but not surjective)
            A = Matrix([[1, 0, nonzero(-2, 2)], [0, 1, nonzero(-2, 2)]])
            rank_val = 2
            answer_str = "injective but not surjective"
        else:
            # Rank 1 matrix 3x2 (neither injective nor surjective)
            v = Matrix([nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)])
            w = Matrix([[1, nonzero(-1, 1)]])
            A = v * w
            rank_val = 1
            answer_str = "neither injective nor surjective"
        
        return problem(
            question=f"Let $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^3$ be the linear transformation with matrix ${latex(A)}$. Is $T$ injective, surjective, both, or neither?",
            answer=answer_str,
            difficulty=(1650, 1800),
            topic="linear_algebra/linear_transformations",
            solution=steps(
                f"The matrix $A$ has rank ${rank_val}$",
                f"$T$ is injective if and only if $\\dim(\\ker(T)) = 0$, i.e., rank is $2$",
                f"$T$ is surjective if and only if $\\dim(\\text{{im}}(T)) = 3$, i.e., rank is $3$",
                f"Since rank is ${rank_val}$, $T$ is {answer_str}"
            ),
        )
    
    else:  # problem_type == 5
        # Image of a specific vector under linear transformation
        # Difficulty: 1600-1750
        a11, a12, a13 = nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)
        a21, a22, a23 = nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)
        a31, a32, a33 = nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)
        
        A = Matrix([[a11, a12, a13], [a21, a22, a23], [a31, a32, a33]])
        v = Matrix([nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)])
        
        result = A * v
        
        return problem(
            question=f"Let $T: \\mathbb{{R}}^3 \\to \\mathbb{{R}}^3$ be the linear transformation defined by $T(\\mathbf{{x}}) = {latex(A)}\\mathbf{{x}}$. Find $T{latex(v)}$.",
            answer=result,
            difficulty=(1600, 1750),
            topic="linear_algebra/linear_transformations",
            solution=steps(
                f"Apply the matrix multiplication $T{latex(v)} = {latex(A)}{latex(v)}$",
                f"${latex(result)}$"
            ),
        )

emit(generate())