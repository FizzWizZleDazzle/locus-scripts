# multivariable_calculus - stokes_divergence (very_easy)
# Generated: 2026-03-08T21:05:36.459831

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/stokes_divergence")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Recognize a vector field (foundational)
        a = randint(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        
        problem(
            question="What is the component of the vector field \\vec{F} = $(a)\\hat{i} + $(b)\\hat{j} + $(c)\\hat{k} in the y-direction?",
            answer=b,
            difficulty=(200, 300),
            solution=steps(
                "Given: \\vec{F} = $(a)\\hat{i} + $(b)\\hat{j} + $(c)\\hat{k}",
                "The component in the y-direction corresponds to the coefficient of \\hat{j}",
                sol("Answer", b)
            ),
            time=30
        )
        
    elseif problem_type == 2
        # Compute simple divergence (elementary)
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        
        div_val = a + b + c
        
        problem(
            question="Compute the divergence of \\vec{F} = $(a)x\\hat{i} + $(b)y\\hat{j} + $(c)z\\hat{k}",
            answer=div_val,
            difficulty=(500, 650),
            solution=steps(
                "Given: \\vec{F} = $(a)x\\hat{i} + $(b)y\\hat{j} + $(c)z\\hat{k}",
                "Divergence: \\nabla \\cdot \\vec{F} = \\frac{\\partial}{\\partial x}($(a)x) + \\frac{\\partial}{\\partial y}($(b)y) + \\frac{\\partial}{\\partial z}($(c)z)",
                "Calculate each partial: $(a) + $(b) + $(c)",
                sol("Answer", div_val)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Compute partial derivative for curl component (elementary)
        a = randint(-6, 6)
        b = randint(-6, 6)
        
        deriv = a
        
        problem(
            question="Compute \\frac{\\partial}{\\partial y}($(a)xy + $(b)z)",
            answer=a*x,
            difficulty=(400, 550),
            solution=steps(
                "Given: f(x,y,z) = $(a)xy + $(b)z",
                "Take partial derivative with respect to y, treating x and z as constants",
                "\\frac{\\partial}{\\partial y}($(a)xy) = $(a)x, and \\frac{\\partial}{\\partial y}($(b)z) = 0",
                sol("Answer", a*x)
            ),
            time=45
        )
        
    elseif problem_type == 4
        # Simple curl z-component (elementary)
        a = randint(-7, 7)
        b = randint(-7, 7)
        
        curl_z = b - a
        
        problem(
            question="The vector field \\vec{F} = $(a)y\\hat{i} + $(b)x\\hat{j} has curl \\nabla \\times \\vec{F} = C\\hat{k}. Find C.",
            answer=curl_z,
            difficulty=(550, 700),
            solution=steps(
                "Given: \\vec{F} = $(a)y\\hat{i} + $(b)x\\hat{j} + 0\\hat{k}",
                "The k-component of curl: (\\nabla \\times \\vec{F})_z = \\frac{\\partial F_y}{\\partial x} - \\frac{\\partial F_x}{\\partial y}",
                "Compute: \\frac{\\partial}{\\partial x}($(b)x) - \\frac{\\partial}{\\partial y}($(a)y) = $(b) - $(a)",
                sol("Answer", curl_z)
            ),
            time=75
        )
        
    elseif problem_type == 5
        # Divergence of constant field (foundational)
        a = randint(-9, 9)
        b = randint(-9, 9)
        c = randint(-9, 9)
        
        problem(
            question="What is the divergence of the constant vector field \\vec{F} = $(a)\\hat{i} + $(b)\\hat{j} + $(c)\\hat{k}?",
            answer=0,
            difficulty=(300, 450),
            solution=steps(
                "Given: \\vec{F} = $(a)\\hat{i} + $(b)\\hat{j} + $(c)\\hat{k} (constant)",
                "Divergence: \\nabla \\cdot \\vec{F} = \\frac{\\partial}{\\partial x}($(a)) + \\frac{\\partial}{\\partial y}($(b)) + \\frac{\\partial}{\\partial z}($(c))",
                "All partial derivatives of constants are zero",
                sol("Answer", 0)
            ),
            time=40
        )
        
    else
        # Evaluate vector field at a point (foundational)
        a = randint(-5, 5)
        b = randint(-5, 5)
        x_val = randint(-4, 4)
        y_val = randint(-4, 4)
        
        result = a * x_val + b * y_val
        
        problem(
            question="Evaluate the vector field \\vec{F} = ($(a)x + $(b)y)\\hat{i} at the point ($(x_val), $(y_val)). What is the coefficient of \\hat{i}?",
            answer=result,
            difficulty=(250, 400),
            solution=steps(
                "Given: \\vec{F} = ($(a)x + $(b)y)\\hat{i} at point ($(x_val), $(y_val))",
                "Substitute x = $(x_val) and y = $(y_val)",
                "Calculate: $(a)($(x_val)) + $(b)($(y_val)) = $(a * x_val) + $(b * y_val)",
                sol("Answer", result)
            ),
            time=45
        )
    end
end