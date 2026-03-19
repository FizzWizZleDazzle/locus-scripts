# linear_algebra - linear_transformations (very_easy)
# Generated: 2026-03-08T21:14:57.510113

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("linear_algebra/linear_transformations")
    
    problem_type = rand(1:8)
    
    if problem_type == 1
        # Recognize if a function is linear (100-300 ELO)
        is_linear = rand(Bool)
        if is_linear
            a = nonzero(-5, 5)
            b = nonzero(-5, 5)
            func_expr = "T(x, y) = ($(a)x + $(b)y, $(randint(-5,5))x + $(randint(-5,5))y)"
            ans = "Yes"
        else
            choice_type = rand(1:3)
            if choice_type == 1
                func_expr = "T(x, y) = (x^2, y)"
                ans = "No"
            elseif choice_type == 2
                func_expr = "T(x, y) = (x + y + 1, 2y)"
                ans = "No"
            else
                func_expr = "T(x, y) = (xy, x - y)"
                ans = "No"
            end
        end
        
        problem(
            question="Is the transformation $(func_expr) a linear transformation?",
            answer=ans,
            difficulty=(100, 300),
            answer_type="text",
            solution=steps(
                "A transformation T is linear if T(u+v) = T(u) + T(v) and T(cu) = cT(u) for all vectors u, v and scalar c",
                "Check if the transformation satisfies these properties",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Find image of a vector under matrix transformation (200-400 ELO)
        a = randint(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        d = randint(-5, 5)
        
        x_val = randint(-8, 8)
        y_val = randint(-8, 8)
        
        result_x = a * x_val + b * y_val
        result_y = c * x_val + d * y_val
        
        ans = fmt_tuple([result_x, result_y])
        
        problem(
            question="Let T be the linear transformation represented by the matrix \\(\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\\). Find T\\(\\begin{bmatrix} $(x_val) \\\\ $(y_val) \\end{bmatrix}\\).",
            answer=ans,
            difficulty=(200, 400),
            answer_type="tuple",
            solution=steps(
                "Multiply the matrix by the vector",
                sol("\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix} \\begin{bmatrix} $(x_val) \\\\ $(y_val) \\end{bmatrix}"),
                sol("= \\begin{bmatrix} $(a)($(x_val)) + $(b)($(y_val)) \\\\ $(c)($(x_val)) + $(d)($(y_val)) \\end{bmatrix}"),
                sol("Answer", "\\begin{bmatrix} $(result_x) \\\\ $(result_y) \\end{bmatrix}")
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Identify the matrix of a simple transformation (300-500 ELO)
        transform_type = rand(1:4)
        
        if transform_type == 1
            # Scaling
            k = nonzero(-6, 6)
            matrix_str = "\\begin{bmatrix} $(k) & 0 \\\\ 0 & $(k) \\end{bmatrix}"
            desc = "scales all vectors by a factor of $(k)"
        elseif transform_type == 2
            # Reflection over x-axis
            matrix_str = "\\begin{bmatrix} 1 & 0 \\\\ 0 & -1 \\end{bmatrix}"
            desc = "reflects vectors over the x-axis"
        elseif transform_type == 3
            # Reflection over y-axis
            matrix_str = "\\begin{bmatrix} -1 & 0 \\\\ 0 & 1 \\end{bmatrix}"
            desc = "reflects vectors over the y-axis"
        else
            # Projection onto x-axis
            matrix_str = "\\begin{bmatrix} 1 & 0 \\\\ 0 & 0 \\end{bmatrix}"
            desc = "projects vectors onto the x-axis"
        end
        
        ans = matrix_str
        
        problem(
            question="What is the standard matrix for the linear transformation that $(desc)?",
            answer=ans,
            difficulty=(300, 500),
            answer_type="text",
            solution=steps(
                "Consider how the transformation acts on the standard basis vectors",
                "The columns of the matrix are the images of the standard basis vectors",
                sol("Answer", matrix_str)
            ),
            time=75
        )
        
    elseif problem_type == 4
        # Apply transformation to standard basis vector (150-350 ELO)
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-8, 8)
        
        basis_choice = rand(1:2)
        if basis_choice == 1
            # e1 = (1, 0)
            result_x = a
            result_y = c
            basis_vec = "\\begin{bmatrix} 1 \\\\ 0 \\end{bmatrix}"
        else
            # e2 = (0, 1)
            result_x = b
            result_y = d
            basis_vec = "\\begin{bmatrix} 0 \\\\ 1 \\end{bmatrix}"
        end
        
        ans = fmt_tuple([result_x, result_y])
        
        problem(
            question="Let T be the linear transformation with matrix \\(\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\\). Find T$(basis_vec).",
            answer=ans,
            difficulty=(150, 350),
            answer_type="tuple",
            solution=steps(
                "Multiply the matrix by the basis vector",
                sol("\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix} $(basis_vec)"),
                sol("Answer", "\\begin{bmatrix} $(result_x) \\\\ $(result_y) \\end{bmatrix}")
            ),
            time=60
        )
        
    elseif problem_type == 5
        # Zero transformation recognition (100-250 ELO)
        x_val = randint(-10, 10)
        y_val = randint(-10, 10)
        
        ans = fmt_tuple([0, 0])
        
        problem(
            question="The zero transformation T maps every vector to the zero vector. Find T\\(\\begin{bmatrix} $(x_val) \\\\ $(y_val) \\end{bmatrix}\\).",
            answer=ans,
            difficulty=(100, 250),
            answer_type="tuple",
            solution=steps(
                "The zero transformation maps every vector to the zero vector",
                "This is true regardless of the input vector",
                sol("Answer", "\\begin{bmatrix} 0 \\\\ 0 \\end{bmatrix}")
            ),
            time=45
        )
        
    elseif problem_type == 6
        # Identity transformation (100-250 ELO)
        x_val = randint(-12, 12)
        y_val = randint(-12, 12)
        
        ans = fmt_tuple([x_val, y_val])
        
        problem(
            question="The identity transformation T maps every vector to itself. Find T\\(\\begin{bmatrix} $(x_val) \\\\ $(y_val) \\end{bmatrix}\\).",
            answer=ans,
            difficulty=(100, 250),
            answer_type="tuple",
            solution=steps(
                "The identity transformation T(v) = v for all vectors v",
                "The vector is mapped to itself",
                sol("Answer", "\\begin{bmatrix} $(x_val) \\\\ $(y_val) \\end{bmatrix}")
            ),
            time=45
        )
        
    elseif problem_type == 7
        # Find one component of image (400-600 ELO)
        a = randint(-6, 6)
        b = randint(-6, 6)
        c = randint(-6, 6)
        d = randint(-6, 6)
        
        x_val = randint(-8, 8)
        y_val = randint(-8, 8)
        
        component_choice = rand(1:2)
        if component_choice == 1
            ans = a * x_val + b * y_val
            component_name = "first"
        else
            ans = c * x_val + d * y_val
            component_name = "second"
        end
        
        problem(
            question="Let T be given by \\(T\\begin{bmatrix} x \\\\ y \\end{bmatrix} = \\begin{bmatrix} $(a)x + $(b)y \\\\ $(c)x + $(d)y \\end{bmatrix}\\). Find the $(component_name) component of T\\(\\begin{bmatrix} $(x_val) \\\\ $(y_val) \\end{bmatrix}\\).",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Substitute x = $(x_val) and y = $(y_val) into the transformation",
                component_choice == 1 ? sol("First component", "$(a)($(x_val)) + $(b)($(y_val))") : sol("Second component", "$(c)($(x_val)) + $(d)($(y_val))"),
                sol("Answer", ans)
            ),
            time=75
        )
        
    else
        # Simple composition concept (500-700 ELO)
        k1 = nonzero(-4, 4)
        k2 = nonzero(-4, 4)
        
        x_val = randint(-6, 6)
        y_val = randint(-6, 6)
        
        # First scale by k1, then by k2
        result_x = k1 * k2 * x_val
        result_y = k1 * k2 * y_val
        
        ans = fmt_tuple([result_x, result_y])
        
        problem(
            question="Let S scale vectors by $(k1) and let T scale vectors by $(k2). Find (T ∘ S)\\(\\begin{bmatrix} $(x_val) \\\\ $(y_val) \\end{bmatrix}\\).",
            answer=ans,
            difficulty=(500, 700),
            answer_type="tuple",
            solution=steps(
                "First apply S: scale by $(k1)",
                sol("S\\begin{bmatrix} $(x_val) \\\\ $(y_val) \\end{bmatrix} = \\begin{bmatrix} $(k1 * x_val) \\\\ $(k1 * y_val) \\end{bmatrix}"),
                "Then apply T: scale by $(k2)",
                sol("T\\begin{bmatrix} $(k1 * x_val) \\\\ $(k1 * y_val) \\end{bmatrix} = \\begin{bmatrix} $(result_x) \\\\ $(result_y) \\end{bmatrix}")
            ),
            time=120
        )
    end
end