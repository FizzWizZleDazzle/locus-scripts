# multivariable_calculus - change_of_variables (very_easy)
# Generated: 2026-03-08T21:03:05.019194

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/change_of_variables")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simple Jacobian determinant for linear transformation
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        det_val = a * d - b * c
        
        problem(
            question = "Find the Jacobian determinant for the transformation \$u = $(a)x + $(b)y\$, \$v = $(c)x + $(d)y\$.",
            answer = det_val,
            difficulty = (400, 600),
            solution = steps(
                "The Jacobian matrix is \$\\begin{pmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{pmatrix}\$",
                sol("Determinant", "\\det(J) = $(a) \\cdot $(d) - $(b) \\cdot $(c)"),
                sol("Answer", det_val)
            ),
            time = 60
        )
        
    elseif problem_type == 2
        # Identify which variable transformation is given
        coef = nonzero(-4, 4)
        
        choices = [
            "u = x + y, v = x - y",
            "u = $(coef)x, v = $(coef)y",
            "u = x/y, v = xy",
            "u = x^2, v = y^2"
        ]
        
        correct = choice(1:length(choices))
        
        problem(
            question = "Which of the following represents a linear change of variables?\n" * 
                      join(["($i) $(choices[i])" for i in 1:length(choices)], "\n"),
            answer = correct,
            difficulty = (300, 500),
            solution = steps(
                "A linear change of variables has the form \$u = ax + by\$, \$v = cx + dy\$",
                "Check each option for linearity",
                sol("Answer", "Option $(correct) is linear")
            ),
            time = 45
        )
        
    elseif problem_type == 3
        # Simple scaling transformation Jacobian
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        
        det_val = a * b
        
        problem(
            question = "Find the Jacobian determinant for the transformation \$u = $(a)x\$, \$v = $(b)y\$.",
            answer = det_val,
            difficulty = (200, 400),
            solution = steps(
                "For \$u = $(a)x\$ and \$v = $(b)y\$, we have \$\\frac{\\partial u}{\\partial x} = $(a)\$, \$\\frac{\\partial v}{\\partial y} = $(b)\$",
                "The Jacobian is \$\\begin{pmatrix} $(a) & 0 \\\\ 0 & $(b) \\end{pmatrix}\$",
                sol("Answer", det_val)
            ),
            time = 45
        )
        
    elseif problem_type == 4
        # Recognize polar coordinate Jacobian element
        
        problem(
            question = "In polar coordinates, what is \$\\frac{\\partial x}{\\partial r}\$ where \$x = r\\cos\\theta\$?",
            answer = "cos(θ)",
            difficulty = (500, 700),
            solution = steps(
                sol("Given", "x = r\\cos\\theta"),
                "Differentiate with respect to \$r\$, treating \$\\theta\$ as constant",
                sol("Answer", "\\cos\\theta")
            ),
            time = 60
        )
        
    else
        # Simple area scaling factor
        k = nonzero(2, 8)
        
        area_factor = k^2
        
        problem(
            question = "If the transformation \$u = $(k)x\$, \$v = $(k)y\$ maps a region \$R\$ to region \$S\$, by what factor does the area change?",
            answer = area_factor,
            difficulty = (400, 600),
            solution = steps(
                "The Jacobian determinant is \$J = $(k) \\cdot $(k) = $(area_factor)\$",
                "Area scaling factor equals the absolute value of the Jacobian",
                sol("Answer", area_factor)
            ),
            time = 60
        )
    end
end