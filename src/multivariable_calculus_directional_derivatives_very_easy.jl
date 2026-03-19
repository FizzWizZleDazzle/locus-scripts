# multivariable_calculus - directional_derivatives (very_easy)
# Generated: 2026-03-08T20:59:10.282509

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/directional_derivatives")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # ELO 200-400: Recognize directional derivative notation
        a = randint(1, 5)
        b = randint(1, 5)
        c = randint(1, 5)
        d = randint(1, 5)
        
        u_vec = "[$(a), $(b)]"
        grad_vec = "[$(c), $(d)]"
        
        ans = a * c + b * d
        
        problem(
            question="If the gradient of f at point P is ∇f = $(grad_vec) and the unit vector is u = $(u_vec), what is the directional derivative D_u f (the dot product ∇f · u)?",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                "Given: ∇f = $(grad_vec) and u = $(u_vec)",
                "The directional derivative is D_u f = ∇f · u = $(c)($(a)) + $(d)($(b))",
                sol("Answer", ans)
            ),
            time=45
        )
        
    elseif problem_type == 2
        # ELO 300-500: Compute gradient at a point (single variable partial derivatives)
        a = randint(2, 6)
        b = randint(1, 5)
        x0 = randint(1, 4)
        y0 = randint(1, 4)
        
        # f(x,y) = ax + by
        fx_val = a
        fy_val = b
        
        problem(
            question="Find the gradient ∇f at the point ($(x0), $(y0)) if f(x,y) = $(a)x + $(b)y. Enter your answer as [∂f/∂x, ∂f/∂y].",
            answer="[$(fx_val), $(fy_val)]",
            answer_type="vector",
            difficulty=(300, 500),
            solution=steps(
                "Given: f(x,y) = $(a)x + $(b)y",
                "∂f/∂x = $(a), ∂f/∂y = $(b)",
                "The gradient is constant everywhere: ∇f = [$(fx_val), $(fy_val)]"
            ),
            time=60
        )
        
    elseif problem_type == 3
        # ELO 400-600: Compute partial derivatives of quadratic function
        a = randint(1, 4)
        b = randint(1, 4)
        x0 = randint(1, 3)
        y0 = randint(1, 3)
        
        # f(x,y) = ax² + by²
        fx_val = 2 * a * x0
        fy_val = 2 * b * y0
        
        problem(
            question="Find the gradient ∇f at point ($(x0), $(y0)) if f(x,y) = $(a)x² + $(b)y². Enter as [∂f/∂x, ∂f/∂y].",
            answer="[$(fx_val), $(fy_val)]",
            answer_type="vector",
            difficulty=(400, 600),
            solution=steps(
                "Given: f(x,y) = $(a)x² + $(b)y²",
                "∂f/∂x = $(2*a)x, so at ($(x0), $(y0)): ∂f/∂x = $(2*a)($(x0)) = $(fx_val)",
                "∂f/∂y = $(2*b)y, so at ($(x0), $(y0)): ∂f/∂y = $(2*b)($(y0)) = $(fy_val)",
                "∇f($(x0), $(y0)) = [$(fx_val), $(fy_val)]"
            ),
            time=90
        )
        
    else
        # ELO 500-700: Directional derivative in direction of vector (not necessarily unit)
        a = randint(2, 5)
        b = randint(2, 5)
        vx = randint(1, 4)
        vy = randint(1, 4)
        
        # f(x,y) = ax + by, so gradient is [a, b]
        # Direction vector v = [vx, vy]
        # Directional derivative = ∇f · v = a*vx + b*vy
        
        ans = a * vx + b * vy
        
        problem(
            question="Find the directional derivative of f(x,y) = $(a)x + $(b)y in the direction of vector v = [$(vx), $(vy)]. (Note: v is not necessarily a unit vector, but compute ∇f · v.)",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Given: f(x,y) = $(a)x + $(b)y",
                "The gradient is ∇f = [$(a), $(b)]",
                "Directional derivative: ∇f · v = [$(a), $(b)] · [$(vx), $(vy)] = $(a)($(vx)) + $(b)($(vy)) = $(ans)"
            ),
            time=75
        )
    end
end