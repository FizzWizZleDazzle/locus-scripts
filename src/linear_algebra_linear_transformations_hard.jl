# linear_algebra - linear_transformations (hard)
# Generated: 2026-03-08T21:15:06.094168

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/linear_transformations")
    
    problem_type = choice([
        :matrix_transformation,
        :kernel_dimension,
        :image_basis,
        :composition,
        :inverse_exists,
        :eigenspace,
        :matrix_from_basis
    ])
    
    if problem_type == :matrix_transformation
        # Find the matrix of a linear transformation given by its action on basis vectors
        dim = choice([2, 3])
        if dim == 2
            # T: R^2 -> R^2
            a11, a12 = randint(-8, 8), randint(-8, 8)
            a21, a22 = randint(-8, 8), randint(-8, 8)
            
            v1_img = [a11, a21]
            v2_img = [a12, a22]
            
            answer_matrix = fmt_matrix([v1_img v2_img])
            
            problem(
                question="Let T: \\mathbb{R}^2 \\to \\mathbb{R}^2 be a linear transformation such that T$(fmt_tuple([1, 0])) = $(fmt_tuple(v1_img)) and T$(fmt_tuple([0, 1])) = $(fmt_tuple(v2_img)). Find the standard matrix of T.",
                answer=answer_matrix,
                difficulty=(1800, 2000),
                answer_type="matrix",
                solution=steps(
                    "The standard matrix [T] has columns equal to the images of the standard basis vectors",
                    "Column 1: T(e₁) = $(fmt_tuple(v1_img))",
                    "Column 2: T(e₂) = $(fmt_tuple(v2_img))",
                    sol("Standard matrix", answer_matrix)
                ),
                time=120
            )
        else
            # T: R^3 -> R^2
            a11, a12, a13 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
            a21, a22, a23 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
            
            v1_img = [a11, a21]
            v2_img = [a12, a22]
            v3_img = [a13, a23]
            
            answer_matrix = fmt_matrix([v1_img v2_img v3_img])
            
            problem(
                question="Let T: \\mathbb{R}^3 \\to \\mathbb{R}^2 be a linear transformation with T$(fmt_tuple([1, 0, 0])) = $(fmt_tuple(v1_img)), T$(fmt_tuple([0, 1, 0])) = $(fmt_tuple(v2_img)), and T$(fmt_tuple([0, 0, 1])) = $(fmt_tuple(v3_img)). Find the matrix representation of T.",
                answer=answer_matrix,
                difficulty=(1850, 2050),
                answer_type="matrix",
                solution=steps(
                    "Matrix columns are images of standard basis vectors",
                    "Columns: $(fmt_tuple(v1_img)), $(fmt_tuple(v2_img)), $(fmt_tuple(v3_img))",
                    sol("Matrix [T]", answer_matrix)
                ),
                time=150
            )
        end
        
    elseif problem_type == :kernel_dimension
        # Find dimension of kernel given rank
        n = randint(3, 6)
        m = randint(2, n-1)
        rank_val = randint(max(1, m-1), min(m, n-1))
        ker_dim = n - rank_val
        
        problem(
            question="Let T: \\mathbb{R}^$(n) \\to \\mathbb{R}^$(m) be a linear transformation with rank(T) = $(rank_val). What is the dimension of ker(T)?",
            answer=ker_dim,
            difficulty=(1900, 2100),
            solution=steps(
                "Apply the Rank-Nullity Theorem: dim(domain) = rank(T) + nullity(T)",
                "$(n) = $(rank_val) + dim(ker(T))",
                sol("dim(ker(T))", ker_dim)
            ),
            time=90
        )
        
    elseif problem_type == :image_basis
        # Find dimension of image
        m = randint(3, 5)
        n = randint(2, m)
        rank_val = randint(1, n)
        
        problem(
            question="Let T: \\mathbb{R}^$(n) \\to \\mathbb{R}^$(m) be a linear transformation with nullity(T) = $(n - rank_val). What is the dimension of Im(T)?",
            answer=rank_val,
            difficulty=(1850, 2050),
            solution=steps(
                "Use Rank-Nullity: dim(domain) = rank(T) + nullity(T)",
                "$(n) = rank(T) + $(n - rank_val)",
                sol("dim(Im(T)) = rank(T)", rank_val)
            ),
            time=90
        )
        
    elseif problem_type == :composition
        # Composition of transformations
        # T: R^n -> R^m, S: R^m -> R^k
        n = choice([2, 3])
        m = choice([2, 3])
        k = choice([2, 3])
        
        if n == 2 && m == 2 && k == 2
            # Simple 2x2 case
            t11, t12 = randint(-5, 5), randint(-5, 5)
            t21, t22 = randint(-5, 5), randint(-5, 5)
            
            s11, s12 = randint(-5, 5), randint(-5, 5)
            s21, s22 = randint(-5, 5), randint(-5, 5)
            
            T_mat = [t11 t12; t21 t22]
            S_mat = [s11 s12; s21 s22]
            comp_mat = S_mat * T_mat
            
            answer_matrix = fmt_matrix(comp_mat)
            
            problem(
                question="Let T: \\mathbb{R}^2 \\to \\mathbb{R}^2 have matrix $(fmt_matrix(T_mat)) and S: \\mathbb{R}^2 \\to \\mathbb{R}^2 have matrix $(fmt_matrix(S_mat)). Find the matrix of S ∘ T.",
                answer=answer_matrix,
                difficulty=(1900, 2150),
                answer_type="matrix",
                solution=steps(
                    "The composition S ∘ T has matrix [S][T]",
                    "Multiply: $(fmt_matrix(S_mat)) × $(fmt_matrix(T_mat))",
                    sol("[S ∘ T]", answer_matrix)
                ),
                time=180
            )
        else
            # Simpler: ask about dimensions
            problem(
                question="If T: \\mathbb{R}^$(n) \\to \\mathbb{R}^$(m) and S: \\mathbb{R}^$(m) \\to \\mathbb{R}^$(k) are linear transformations, what is the dimension of the domain of S ∘ T?",
                answer=n,
                difficulty=(1800, 1950),
                solution=steps(
                    "S ∘ T means apply T first, then S",
                    "Domain of S ∘ T = domain of T = \\mathbb{R}^$(n)",
                    sol("Dimension", n)
                ),
                time=60
            )
        end
        
    elseif problem_type == :inverse_exists
        # When does inverse exist?
        n = randint(3, 6)
        det_val = nonzero(-15, 15)
        
        problem(
            question="Let T: \\mathbb{R}^$(n) \\to \\mathbb{R}^$(n) be a linear transformation with det([T]) = $(det_val). Is T invertible? Answer 'yes' or 'no'.",
            answer="yes",
            difficulty=(1850, 2000),
            solution=steps(
                "A linear transformation T: \\mathbb{R}^n \\to \\mathbb{R}^n is invertible if and only if det([T]) ≠ 0",
                "Here det([T]) = $(det_val) ≠ 0",
                sol("T is invertible", "yes")
            ),
            time=75
        )
        
    elseif problem_type == :eigenspace
        # Dimension of eigenspace
        n = randint(4, 7)
        lambda = nonzero(-8, 8)
        geo_mult = randint(1, n-1)
        
        problem(
            question="Let T: \\mathbb{R}^$(n) \\to \\mathbb{R}^$(n) be a linear transformation. If $(lambda) is an eigenvalue of T and the nullity of (T - $(lambda)I) is $(geo_mult), what is the dimension of the eigenspace E_{$(lambda)}?",
            answer=geo_mult,
            difficulty=(2000, 2250),
            solution=steps(
                "The eigenspace E_λ is defined as ker(T - λI)",
                "dim(E_{$(lambda)}) = nullity(T - $(lambda)I)",
                sol("dim(E_{$(lambda)})", geo_mult)
            ),
            time=100
        )
        
    else # :matrix_from_basis
        # Find matrix with respect to non-standard basis
        # T(e1) = a*v1 + b*v2, find [T]_B
        a1, a2 = randint(-6, 6), randint(-6, 6)
        b1, b2 = randint(-6, 6), randint(-6, 6)
        
        answer_matrix = fmt_matrix([a1 a2; b1 b2])
        
        problem(
            question="Let T: \\mathbb{R}^2 \\to \\mathbb{R}^2 be a linear transformation and B = {v₁, v₂} be a basis for \\mathbb{R}^2. If T(v₁) = $(a1)v₁ + $(b1)v₂ and T(v₂) = $(a2)v₁ + $(b2)v₂, find [T]_B, the matrix of T with respect to basis B.",
            answer=answer_matrix,
            difficulty=(2100, 2350),
            answer_type="matrix",
            solution=steps(
                "The matrix [T]_B has columns equal to coordinate vectors of T(vᵢ) with respect to B",
                "Column 1: [T(v₁)]_B = $(fmt_tuple([a1, b1]))",
                "Column 2: [T(v₂)]_B = $(fmt_tuple([a2, b2]))",
                sol("[T]_B", answer_matrix)
            ),
            time=150
        )
    end
end