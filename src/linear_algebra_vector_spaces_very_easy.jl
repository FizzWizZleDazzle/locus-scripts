# linear_algebra - vector_spaces (very_easy)
# Generated: 2026-03-08T21:09:47.848733

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/vector_spaces")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Vector identification (ELO 200-400)
        v = [randint(-5, 5), randint(-5, 5)]
        ans = choice(["yes", "no"])
        if ans == "yes"
            question_text = "Is \\($(fmt_tuple(v))\\) a vector in \\(\\mathbb{R}^2\\)?"
        else
            v_text = "\\(($(v[1]), $(v[2]), $(randint(-5,5)))\\)"
            question_text = "Is $(v_text) a vector in \\(\\mathbb{R}^2\\)?"
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(200, 400),
            answer_type="text",
            solution=steps(
                "A vector in \\(\\mathbb{R}^2\\) has exactly 2 components",
                ans == "yes" ? "This vector has 2 components" : "This vector has 3 components",
                "Answer: $(ans)"
            ),
            time=30
        )
        
    elseif problem_type == 2
        # Vector addition (ELO 300-500)
        v1 = [randint(-8, 8), randint(-8, 8)]
        v2 = [randint(-8, 8), randint(-8, 8)]
        ans = v1 .+ v2
        
        problem(
            question="Compute $(fmt_tuple(v1)) + $(fmt_tuple(v2))",
            answer=fmt_tuple(ans),
            difficulty=(300, 500),
            answer_type="tuple",
            solution=steps(
                "Add corresponding components",
                "First component: $(v1[1]) + $(v2[1]) = $(ans[1])",
                "Second component: $(v1[2]) + $(v2[2]) = $(ans[2])",
                sol("Answer", fmt_tuple(ans))
            ),
            time=45
        )
        
    elseif problem_type == 3
        # Scalar multiplication (ELO 350-550)
        k = randint(-6, 6)
        v = [randint(-7, 7), randint(-7, 7)]
        ans = k .* v
        
        problem(
            question="Compute \\($(k) \\cdot $(fmt_tuple(v))\\)",
            answer=fmt_tuple(ans),
            difficulty=(350, 550),
            answer_type="tuple",
            solution=steps(
                "Multiply each component by the scalar",
                "First component: $(k) × $(v[1]) = $(ans[1])",
                "Second component: $(k) × $(v[2]) = $(ans[2])",
                sol("Answer", fmt_tuple(ans))
            ),
            time=50
        )
        
    elseif problem_type == 4
        # Zero vector identification (ELO 250-450)
        is_zero = choice([true, false])
        if is_zero
            v = [0, 0]
        else
            v = [randint(-5, 5), randint(-5, 5)]
            while v == [0, 0]
                v = [randint(-5, 5), randint(-5, 5)]
            end
        end
        ans = is_zero ? "yes" : "no"
        
        problem(
            question="Is $(fmt_tuple(v)) the zero vector in \\(\\mathbb{R}^2\\)?",
            answer=ans,
            difficulty=(250, 450),
            answer_type="text",
            solution=steps(
                "The zero vector in \\(\\mathbb{R}^2\\) is \\((0, 0)\\)",
                is_zero ? "All components are zero" : "Not all components are zero",
                "Answer: $(ans)"
            ),
            time=35
        )
        
    elseif problem_type == 5
        # Vector subtraction (ELO 400-600)
        v1 = [randint(-9, 9), randint(-9, 9)]
        v2 = [randint(-9, 9), randint(-9, 9)]
        ans = v1 .- v2
        
        problem(
            question="Compute $(fmt_tuple(v1)) - $(fmt_tuple(v2))",
            answer=fmt_tuple(ans),
            difficulty=(400, 600),
            answer_type="tuple",
            solution=steps(
                "Subtract corresponding components",
                "First component: $(v1[1]) - $(v2[1]) = $(ans[1])",
                "Second component: $(v1[2]) - $(v2[2]) = $(ans[2])",
                sol("Answer", fmt_tuple(ans))
            ),
            time=50
        )
        
    else
        # Combined operations (ELO 500-700)
        k1 = randint(-4, 4)
        k2 = randint(-4, 4)
        v1 = [randint(-5, 5), randint(-5, 5)]
        v2 = [randint(-5, 5), randint(-5, 5)]
        ans = k1 .* v1 .+ k2 .* v2
        
        problem(
            question="Compute \\($(k1) $(fmt_tuple(v1)) + $(k2) $(fmt_tuple(v2))\\)",
            answer=fmt_tuple(ans),
            difficulty=(500, 700),
            answer_type="tuple",
            solution=steps(
                "First compute scalar multiplications",
                "\\($(k1) $(fmt_tuple(v1)) = $(fmt_tuple(k1 .* v1))\\)",
                "\\($(k2) $(fmt_tuple(v2)) = $(fmt_tuple(k2 .* v2))\\)",
                "Add the results: $(fmt_tuple(k1 .* v1)) + $(fmt_tuple(k2 .* v2)) = $(fmt_tuple(ans))"
            ),
            time=75
        )
    end
end