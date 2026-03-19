# linear_algebra - subspaces (very_easy)
# Generated: 2026-03-08T21:11:11.855029

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/subspaces")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Is the zero vector in a subspace? (200-300 ELO)
        n = rand(2:4)
        zeros_vec = join(["0" for _ in 1:n], ", ")
        
        problem(
            question="Is the zero vector \\(\\mathbf{0} = ($(zeros_vec))\\) in every subspace of \\(\\mathbb{R}^$(n)\\)?",
            answer="Yes",
            difficulty=(200, 300),
            answer_type="multiple_choice",
            solution=steps(
                "By definition, every subspace must contain the zero vector.",
                "This is one of the three required properties of a subspace.",
                sol("Answer", "Yes, the zero vector is in every subspace")
            ),
            time=30
        )
        
    elseif problem_type == 2
        # Identify if set is closed under addition (400-600 ELO)
        case = rand(1:3)
        
        if case == 1
            # First quadrant - NOT a subspace
            problem(
                question="Is the set of all vectors \\((x, y)\\) where \\(x \\geq 0\\) and \\(y \\geq 0\\) (first quadrant) a subspace of \\(\\mathbb{R}^2\\)?",
                answer="No",
                difficulty=(400, 600),
                answer_type="multiple_choice",
                solution=steps(
                    "Check if the set contains the zero vector: \\((0,0)\\) has \\(x \\geq 0\\) and \\(y \\geq 0\\), so yes.",
                    "Check closure under scalar multiplication: If \\((x,y)\\) is in the set with \\(x,y \\geq 0\\), then \\((-1)(x,y) = (-x,-y)\\) has negative components.",
                    sol("Answer", "No, not closed under scalar multiplication, so not a subspace")
                ),
                time=60
            )
            
        elseif case == 2
            # Vectors with last component 0 - IS a subspace
            problem(
                question="Is the set of all vectors \\((x, y, 0)\\) in \\(\\mathbb{R}^3\\) a subspace?",
                answer="Yes",
                difficulty=(500, 650),
                answer_type="multiple_choice",
                solution=steps(
                    "Check zero vector: \\((0,0,0)\\) is in the set.",
                    "Check closure under addition: \\((x_1,y_1,0) + (x_2,y_2,0) = (x_1+x_2, y_1+y_2, 0)\\), still in the set.",
                    "Check closure under scalar multiplication: \\(c(x,y,0) = (cx,cy,0)\\), still in the set.",
                    sol("Answer", "Yes, this is a subspace (the xy-plane)")
                ),
                time=90
            )
            
        else
            # Vectors with sum of components = 1 - NOT a subspace
            problem(
                question="Is the set of all vectors \\((x, y)\\) where \\(x + y = 1\\) a subspace of \\(\\mathbb{R}^2\\)?",
                answer="No",
                difficulty=(450, 600),
                answer_type="multiple_choice",
                solution=steps(
                    "Check if the zero vector \\((0,0)\\) is in the set: \\(0 + 0 = 0 \\neq 1\\).",
                    "The zero vector is not in the set.",
                    sol("Answer", "No, does not contain the zero vector, so not a subspace")
                ),
                time=60
            )
        end
        
    elseif problem_type == 3
        # Count dimension of simple subspaces (300-500 ELO)
        case = rand(1:2)
        
        if case == 1
            n = rand(3:5)
            problem(
                question="What is the dimension of the zero subspace \\(\\{\\mathbf{0}\\}\\) in \\(\\mathbb{R}^$(n)\\)?",
                answer=0,
                difficulty=(300, 400),
                solution=steps(
                    "The zero subspace contains only the zero vector.",
                    "It has no basis vectors (the empty set is its basis).",
                    sol("Answer", "Dimension = 0")
                ),
                time=45
            )
        else
            n = rand(2:5)
            problem(
                question="What is the dimension of \\(\\mathbb{R}^$(n)\\) as a subspace of itself?",
                answer=n,
                difficulty=(250, 400),
                solution=steps(
                    "\\(\\mathbb{R}^$(n)\\) is spanned by the standard basis with $(n) vectors.",
                    "The standard basis is \\(\\{\\mathbf{e}_1, \\mathbf{e}_2, \\ldots, \\mathbf{e}_$(n)\\}\\).",
                    sol("Answer", "Dimension = $(n)")
                ),
                time=45
            )
        end
        
    elseif problem_type == 4
        # Identify which property fails (500-700 ELO)
        properties = ["contains the zero vector", "closed under addition", "closed under scalar multiplication"]
        prop_idx = rand(1:3)
        
        if prop_idx == 1
            a = randint(1, 5)
            problem(
                question="The set of all vectors \\((x, y)\\) where \\(x + y = $(a)\\) is NOT a subspace of \\(\\mathbb{R}^2\\). Which subspace property does it fail?",
                answer="contains the zero vector",
                difficulty=(500, 650),
                answer_type="multiple_choice",
                solution=steps(
                    "Check if \\((0,0)\\) satisfies \\(x + y = $(a)\\): \\(0 + 0 = 0 \\neq $(a)\\).",
                    "The zero vector is not in the set.",
                    sol("Answer", "Fails: contains the zero vector")
                ),
                time=75
            )
        elseif prop_idx == 2
            problem(
                question="The set of all vectors \\((x, y)\\) where \\(xy = 0\\) (points on the axes) is NOT a subspace of \\(\\mathbb{R}^2\\). Which subspace property does it fail?",
                answer="closed under addition",
                difficulty=(550, 700),
                answer_type="multiple_choice",
                solution=steps(
                    "The set contains \\((1,0)\\) and \\((0,1)\\) since \\(1 \\cdot 0 = 0\\) and \\(0 \\cdot 1 = 0\\).",
                    "But \\((1,0) + (0,1) = (1,1)\\), and \\(1 \\cdot 1 = 1 \\neq 0\\), so the sum is not in the set.",
                    sol("Answer", "Fails: closed under addition")
                ),
                time=90
            )
        else
            a = randint(2, 5)
            problem(
                question="The set of all vectors \\((x, y)\\) where \\(x^2 + y^2 = $(a)\\) (a circle) is NOT a subspace of \\(\\mathbb{R}^2\\). Which subspace property does it fail?",
                answer="contains the zero vector",
                difficulty=(500, 650),
                answer_type="multiple_choice",
                solution=steps(
                    "Check if \\((0,0)\\) satisfies \\(x^2 + y^2 = $(a)\\): \\(0^2 + 0^2 = 0 \\neq $(a)\\).",
                    "The zero vector is not in the set.",
                    sol("Answer", "Fails: contains the zero vector")
                ),
                time=75
            )
        end
        
    elseif problem_type == 5
        # Simple span recognition (400-600 ELO)
        case = rand(1:2)
        
        if case == 1
            problem(
                question="The span of the single vector \\((1, 0, 0)\\) in \\(\\mathbb{R}^3\\) forms a subspace. What geometric object is this subspace?",
                answer="line",
                difficulty=(400, 550),
                answer_type="multiple_choice",
                solution=steps(
                    "The span of \\((1,0,0)\\) is all scalar multiples: \\(\\{t(1,0,0) : t \\in \\mathbb{R}\\} = \\{(t,0,0) : t \\in \\mathbb{R}\\}\\).",
                    "This is the set of all points on the x-axis.",
                    sol("Answer", "A line through the origin")
                ),
                time=60
            )
        else
            problem(
                question="The span of the two vectors \\((1, 0, 0)\\) and \\((0, 1, 0)\\) in \\(\\mathbb{R}^3\\) forms a subspace. What geometric object is this subspace?",
                answer="plane",
                difficulty=(450, 600),
                answer_type="multiple_choice",
                solution=steps(
                    "The span is \\(\\{s(1,0,0) + t(0,1,0) : s,t \\in \\mathbb{R}\\} = \\{(s,t,0) : s,t \\in \\mathbb{R}\\}\\).",
                    "This is the set of all points with z-coordinate equal to 0.",
                    sol("Answer", "A plane through the origin (the xy-plane)")
                ),
                time=75
            )
        end
        
    else
        # Is a given set a subspace? (simple cases, 350-650 ELO)
        case = rand(1:3)
        
        if case == 1
            problem(
                question="Is the set of all vectors of the form \\((a, 2a)\\) where \\(a \\in \\mathbb{R}\\) a subspace of \\(\\mathbb{R}^2\\)?",
                answer="Yes",
                difficulty=(450, 600),
                answer_type="multiple_choice",
                solution=steps(
                    "Zero vector: \\((0, 0) = (0, 2 \\cdot 0)\\), so \\((0,0)\\) is in the set.",
                    "Addition: \\((a_1, 2a_1) + (a_2, 2a_2) = (a_1+a_2, 2(a_1+a_2))\\), which has the form \\((a, 2a)\\).",
                    "Scalar multiplication: \\(c(a, 2a) = (ca, 2ca)\\), which has the form \\((a, 2a)\\).",
                    sol("Answer", "Yes, this is a subspace")
                ),
                time=90
            )
        elseif case == 2
            b = randint(1, 5)
            problem(
                question="Is the set of all vectors of the form \\((a, b)\\) where \\(a \\in \\mathbb{R}\\) and \\(b = $(b)\\) a subspace of \\(\\mathbb{R}^2\\)?",
                answer="No",
                difficulty=(400, 550),
                answer_type="multiple_choice",
                solution=steps(
                    "Check zero vector: \\((0, 0)\\) requires the second component to be 0, but we need \\(b = $(b)\\).",
                    "The zero vector is not in the set.",
                    sol("Answer", "No, does not contain the zero vector")
                ),
                time=60
            )
        else
            problem(
                question="Is the set of all vectors \\((x, y, z)\\) where \\(z = 0\\) a subspace of \\(\\mathbb{R}^3\\)?",
                answer="Yes",
                difficulty=(350, 500),
                answer_type="multiple_choice",
                solution=steps(
                    "Zero vector: \\((0,0,0)\\) has \\(z=0\\), so it's in the set.",
                    "Addition: \\((x_1,y_1,0) + (x_2,y_2,0) = (x_1+x_2, y_1+y_2, 0)\\), still has \\(z=0\\).",
                    "Scalar multiplication: \\(c(x,y,0) = (cx,cy,0)\\), still has \\(z=0\\).",
                    sol("Answer", "Yes, this is a subspace")
                ),
                time=75
            )
        end
    end
end