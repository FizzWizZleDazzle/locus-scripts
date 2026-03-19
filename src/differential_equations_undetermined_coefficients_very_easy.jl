# differential_equations - undetermined_coefficients (very_easy)
# Generated: 2026-03-08T20:54:24.995909

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("differential_equations/undetermined_coefficients")
    
    # For FOUNDATIONAL/ELEMENTARY (100-700), we focus on:
    # - Recognizing the form of a differential equation
    # - Identifying which method to use
    # - Simple pattern matching for particular solutions
    # - Very basic undetermined coefficients (guessing form)
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # ELO 200-400: Recognize the form of g(x) for undetermined coefficients
        forms = [
            ("polynomial", "5x^2 + 3x - 7", "Ax^2 + Bx + C"),
            ("exponential", "4e^{3x}", "Ae^{3x}"),
            ("sine", "\\sin(2x)", "A\\cos(2x) + B\\sin(2x)"),
            ("cosine", "3\\cos(x)", "A\\cos(x) + B\\sin(x)"),
            ("constant", "12", "A"),
        ]
        
        form_data = choice(forms)
        form_name, g_expr, y_p_form = form_data
        
        question = "For the differential equation \$y'' + y' - y = $(g_expr)\$, what form should the particular solution \$y_p\$ take when using the method of undetermined coefficients?"
        answer = y_p_form
        
        problem(
            question=question,
            answer=answer,
            difficulty=(200, 400),
            answer_type="text",
            solution=steps(
                "The right-hand side is a $(form_name) function: \$$(g_expr)\$",
                "For undetermined coefficients, we guess a particular solution of the same form",
                sol("Particular solution form", y_p_form)
            ),
            time=45
        )
        
    elseif problem_type == 2
        # ELO 300-500: Identify if a solution form needs modification (Rule for Duplication)
        root = randint(-3, 3)
        r_val = nonzero(-4, 4)
        
        if rand(Bool)
            # Characteristic root matches exponential on RHS
            question = "Consider \$y'' - $(2*root)y' + $(root^2)y = e^{$(root)x}\$. The characteristic equation has root \$r = $(root)\$ with multiplicity 2. Should the particular solution be \$y_p = Ae^{$(root)x}\$ or \$y_p = Ax^2e^{$(root)x}\$?"
            answer = "Ax^2e^{$(root)x}"
            
            problem(
                question=question,
                answer=answer,
                difficulty=(400, 600),
                answer_type="text",
                solution=steps(
                    "The right-hand side is \$e^{$(root)x}\$",
                    "The characteristic root \$r = $(root)\$ has multiplicity 2",
                    "We must multiply by \$x^2\$ to avoid duplication",
                    sol("Particular solution", "y_p = Ax^2e^{$(root)x}")
                ),
                time=60
            )
        else
            # No duplication case
            g_exp = nonzero(-4, 4)
            while g_exp == root
                g_exp = nonzero(-4, 4)
            end
            
            question = "Consider \$y'' - $(2*root)y' + $(root^2)y = e^{$(g_exp)x}\$. The characteristic equation has root \$r = $(root)\$ with multiplicity 2. Should the particular solution be \$y_p = Ae^{$(g_exp)x}\$ or \$y_p = Axe^{$(g_exp)x}\$?"
            answer = "Ae^{$(g_exp)x}"
            
            problem(
                question=question,
                answer=answer,
                difficulty=(400, 600),
                answer_type="text",
                solution=steps(
                    "The right-hand side is \$e^{$(g_exp)x}\$",
                    "The characteristic root is \$r = $(root)\$, which is different from $(g_exp)",
                    "No modification needed since there is no duplication",
                    sol("Particular solution", "y_p = Ae^{$(g_exp)x}")
                ),
                time=60
            )
        end
        
    elseif problem_type == 3
        # ELO 500-700: Simple computation - find A in y_p = A (constant)
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        g = nonzero(-20, 20)
        
        # For y'' + ay' + by = g, particular solution y_p = A (constant)
        # Then y_p' = 0, y_p'' = 0, so bA = g, thus A = g/b
        
        A_val = g // c
        
        question = "For the differential equation \$y'' + $(a)y' + $(c)y = $(g)\$, find the value of \$A\$ in the particular solution \$y_p = A\$ (a constant)."
        answer = A_val
        
        problem(
            question=question,
            answer=answer,
            difficulty=(500, 700),
            solution=steps(
                "Assume particular solution \$y_p = A\$ (constant)",
                "Then \$y_p' = 0\$ and \$y_p'' = 0\$",
                "Substituting: \$0 + $(a)(0) + $(c)A = $(g)\$",
                "Solving: \$$(c)A = $(g)\$",
                sol("A", A_val)
            ),
            time=90
        )
        
    else
        # ELO 400-600: Match the correct form for combinations
        combo_type = rand(1:3)
        
        if combo_type == 1
            # Polynomial + exponential
            k = nonzero(-3, 3)
            question = "For \$y'' - y = 3x + e^{$(k)x}\$, what form should \$y_p\$ take?"
            answer = "Ax + B + Ce^{$(k)x}"
            
            problem(
                question=question,
                answer=answer,
                difficulty=(400, 600),
                answer_type="text",
                solution=steps(
                    "The right-hand side is a sum: polynomial \$3x\$ plus exponential \$e^{$(k)x}\$",
                    "For the polynomial part, use \$Ax + B\$",
                    "For the exponential part, use \$Ce^{$(k)x}\$",
                    sol("Particular solution", "y_p = Ax + B + Ce^{$(k)x}")
                ),
                time=75
            )
        elseif combo_type == 2
            # Exponential + sine/cosine
            k = nonzero(-3, 3)
            question = "For \$y'' + 4y = e^{$(k)x} + \\sin(x)\$, what form should \$y_p\$ take?"
            answer = "Ae^{$(k)x} + B\\cos(x) + C\\sin(x)"
            
            problem(
                question=question,
                answer=answer,
                difficulty=(500, 650),
                answer_type="text",
                solution=steps(
                    "The right-hand side has exponential \$e^{$(k)x}\$ and trigonometric \$\\sin(x)\$",
                    "For exponential: use \$Ae^{$(k)x}\$",
                    "For sine: use both \$B\\cos(x) + C\\sin(x)\$",
                    sol("Particular solution", "y_p = Ae^{$(k)x} + B\\cos(x) + C\\sin(x)")
                ),
                time=90
            )
        else
            # Just recognizing a trigonometric form
            omega = choice([1, 2, 3])
            question = "For \$y'' + y' + y = \\cos($(omega)x)\$, what form should \$y_p\$ take?"
            answer = "A\\cos($(omega)x) + B\\sin($(omega)x)"
            
            problem(
                question=question,
                answer=answer,
                difficulty=(300, 500),
                answer_type="text",
                solution=steps(
                    "The right-hand side is \$\\cos($(omega)x)\$",
                    "For cosine functions, we need both sine and cosine terms",
                    sol("Particular solution", "y_p = A\\cos($(omega)x) + B\\sin($(omega)x)")
                ),
                time=60
            )
        end
    end
end