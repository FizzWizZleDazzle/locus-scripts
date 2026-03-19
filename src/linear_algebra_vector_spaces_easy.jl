# linear_algebra - vector_spaces (easy)
# Generated: 2026-03-08T21:10:21.834522

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/vector_spaces")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Linear independence check for 2D vectors
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        
        # Make them linearly independent or dependent
        if rand(Bool)
            # Independent: det ≠ 0
            while a*d - b*c == 0
                d = nonzero(-8, 8)
            end
            ans = "linearly independent"
            explanation = "The determinant is $(a*d - b*c) ≠ 0"
        else
            # Dependent: make second vector a multiple of first
            k = nonzero(-3, 3)
            c = k * a
            d = k * b
            ans = "linearly dependent"
            explanation = "\\vec{v}_2 = $(k)\\vec{v}_1"
        end
        
        problem(
            question="Determine if the vectors \\vec{v}_1 = \\begin{pmatrix} $(a) \\\\ $(b) \\end{pmatrix} and \\vec{v}_2 = \\begin{pmatrix} $(c) \\\\ $(d) \\end{pmatrix} are linearly independent or linearly dependent.",
            answer=ans,
            difficulty=(700, 950),
            answer_type="text",
            solution=steps(
                "Check if one vector is a scalar multiple of the other",
                "Calculate determinant: $(a)($(d)) - $(b)($(c)) = $(a*d - b*c)",
                explanation,
                "Answer: $(ans)"
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Span of vectors in R^2
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = randint(-8, 8)
        d = randint(-8, 8)
        
        # Check if (c,d) is in span
        if a*d - b*c == 0 && !(a == 0 && b == 0)
            # In span
            ans = "yes"
            if a != 0
                k = c // a
            else
                k = d // b
            end
            explanation = "We can write \\begin{pmatrix} $(c) \\\\ $(d) \\end{pmatrix} = $(k)\\begin{pmatrix} $(a) \\\\ $(b) \\end{pmatrix}"
        else
            ans = "no"
            explanation = "No scalar k exists such that k\\begin{pmatrix} $(a) \\\\ $(b) \\end{pmatrix} = \\begin{pmatrix} $(c) \\\\ $(d) \\end{pmatrix}"
        end
        
        problem(
            question="Is the vector \\begin{pmatrix} $(c) \\\\ $(d) \\end{pmatrix} in the span of \\begin{pmatrix} $(a) \\\\ $(b) \\end{pmatrix}? Answer 'yes' or 'no'.",
            answer=ans,
            difficulty=(750, 1000),
            answer_type="text",
            solution=steps(
                "A vector \\vec{w} is in span(\\vec{v}) if \\vec{w} = k\\vec{v} for some scalar k",
                "Check if $(c) = k($(a)) and $(d) = k($(b)) have a consistent solution",
                explanation,
                "Answer: $(ans)"
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Dimension of span
        n_vectors = rand(2:3)
        
        if n_vectors == 2
            a1, b1 = nonzero(-7, 7), nonzero(-7, 7)
            
            if rand(Bool)
                # Make second independent
                a2, b2 = nonzero(-7, 7), nonzero(-7, 7)
                while a1*b2 - b1*a2 == 0
                    b2 = nonzero(-7, 7)
                end
                dim = 2
                explanation = "The vectors are linearly independent (determinant = $(a1*b2 - b1*a2) ≠ 0)"
            else
                # Make second dependent
                k = nonzero(-3, 3)
                a2, b2 = k*a1, k*b1
                dim = 1
                explanation = "The second vector is $(k) times the first, so they are linearly dependent"
            end
            
            problem(
                question="What is the dimension of the span of the vectors \\begin{pmatrix} $(a1) \\\\ $(b1) \\end{pmatrix} and \\begin{pmatrix} $(a2) \\\\ $(b2) \\end{pmatrix}?",
                answer=dim,
                difficulty=(800, 1100),
                solution=steps(
                    "The dimension equals the number of linearly independent vectors",
                    explanation,
                    "Answer: $(dim)"
                ),
                time=120
            )
        else
            # 3 vectors in R^3
            a1, b1, c1 = nonzero(-5, 5), randint(-5, 5), randint(-5, 5)
            a2, b2, c2 = randint(-5, 5), nonzero(-5, 5), randint(-5, 5)
            a3, b3, c3 = randint(-5, 5), randint(-5, 5), nonzero(-5, 5)
            
            # Make third a combination of first two sometimes
            if rand(Bool)
                k1, k2 = randint(-2, 2), randint(-2, 2)
                a3, b3, c3 = k1*a1 + k2*a2, k1*b1 + k2*b2, k1*c1 + k2*c2
                dim = 2
                explanation = "The third vector is a linear combination of the first two"
            else
                dim = 3
                explanation = "The three vectors are linearly independent"
            end
            
            problem(
                question="What is the dimension of the span of \\begin{pmatrix} $(a1) \\\\ $(b1) \\\\ $(c1) \\end{pmatrix}, \\begin{pmatrix} $(a2) \\\\ $(b2) \\\\ $(c2) \\end{pmatrix}, and \\begin{pmatrix} $(a3) \\\\ $(b3) \\\\ $(c3) \\end{pmatrix}?",
                answer=dim,
                difficulty=(900, 1200),
                solution=steps(
                    "Find the number of linearly independent vectors",
                    explanation,
                    "Answer: $(dim)"
                ),
                time=180
            )
        end
        
    elseif problem_type == 4
        # Subspace verification
        property = choice(["closed under addition", "closed under scalar multiplication", "contains zero vector"])
        
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        
        if property == "contains zero vector"
            ans = "yes"
            explanation = "The zero vector \\begin{pmatrix} 0 \\\\ 0 \\end{pmatrix} satisfies $(a)(0) + $(b)(0) = 0"
            question_text = "Does the set \\{\\begin{pmatrix} x \\\\ y \\end{pmatrix} : $(a)x + $(b)y = 0\\} contain the zero vector? Answer 'yes' or 'no'."
        elseif property == "closed under addition"
            ans = "yes"
            explanation = "If $(a)x_1 + $(b)y_1 = 0 and $(a)x_2 + $(b)y_2 = 0, then $(a)(x_1+x_2) + $(b)(y_1+y_2) = 0"
            question_text = "Is the set \\{\\begin{pmatrix} x \\\\ y \\end{pmatrix} : $(a)x + $(b)y = 0\\} closed under addition? Answer 'yes' or 'no'."
        else
            ans = "yes"
            explanation = "If $(a)x + $(b)y = 0, then $(a)(kx) + $(b)(ky) = k($(a)x + $(b)y) = 0 for any scalar k"
            question_text = "Is the set \\{\\begin{pmatrix} x \\\\ y \\end{pmatrix} : $(a)x + $(b)y = 0\\} closed under scalar multiplication? Answer 'yes' or 'no'."
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(850, 1150),
            answer_type="text",
            solution=steps(
                "Check the subspace property: $(property)",
                explanation,
                "Answer: $(ans)"
            ),
            time=150
        )
        
    else
        # Find a vector in the span
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        k = randint(-4, 4)
        
        ans_x = k * a
        ans_y = k * b
        
        problem(
            question="Give an example of a vector in the span of \\begin{pmatrix} $(a) \\\\ $(b) \\end{pmatrix}. Write your answer as an ordered pair (x, y).",
            answer=fmt_tuple([ans_x, ans_y]),
            difficulty=(700, 900),
            answer_type="tuple",
            solution=steps(
                "A vector is in the span if it's a scalar multiple of the given vector",
                "Choose k = $(k)",
                "Answer: $(k) \\cdot \\begin{pmatrix} $(a) \\\\ $(b) \\end{pmatrix} = \\begin{pmatrix} $(ans_x) \\\\ $(ans_y) \\end{pmatrix}"
            ),
            time=90
        )
    end
end