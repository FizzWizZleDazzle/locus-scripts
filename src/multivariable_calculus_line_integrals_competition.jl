# multivariable_calculus - line_integrals (competition)
# Generated: 2026-03-08T21:05:01.335085

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z t begin
    set_topic!("multivariable_calculus/line_integrals")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Conservative field path-independence with parametric surfaces
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        # Potential function φ = ax²y + by²z + cz³
        phi = a*x^2*y + b*y^2*z + c*z^3
        
        # Vector field F = ∇φ
        F_x = diff(phi, x)
        F_y = diff(phi, y)
        F_z = diff(phi, z)
        
        # Random start and end points
        x0, y0, z0 = randint(-3, 3), randint(-3, 3), randint(-3, 3)
        x1, y1, z1 = randint(-3, 3), randint(-3, 3), randint(-3, 3)
        
        # Ensure different points
        while x0 == x1 && y0 == y1 && z0 == z1
            x1, y1, z1 = randint(-3, 3), randint(-3, 3), randint(-3, 3)
        end
        
        phi_start = substitute(phi, [x => x0, y => y0, z => z0])
        phi_end = substitute(phi, [x => x1, y => y1, z => z1])
        ans = simplify(phi_end - phi_start)
        
        problem(
            question="Let \\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)), $(tex(F_z)) \\rangle. Prove that \\mathbf{F} is conservative, find a potential function \\phi, and evaluate \\int_C \\mathbf{F} \\cdot d\\mathbf{r} where C is ANY path from ($(x0), $(y0), $(z0)) to ($(x1), $(y1), $(z1)).",
            answer=ans,
            difficulty=(3500, 4000),
            solution=steps(
                "Check if \\mathbf{F} is conservative by verifying \\nabla \\times \\mathbf{F} = \\mathbf{0}",
                "Compute \\frac{\\partial F_z}{\\partial y} - \\frac{\\partial F_y}{\\partial z} = $(tex(diff(F_z, y) - diff(F_y, z))) = 0",
                "Similarly verify other curl components vanish",
                sol("Potential function", phi),
                "By fundamental theorem: \\int_C \\mathbf{F} \\cdot d\\mathbf{r} = \\phi($(x1), $(y1), $(z1)) - \\phi($(x0), $(y0), $(z0))",
                sol("\\phi($(x1), $(y1), $(z1))", phi_end),
                sol("\\phi($(x0), $(y0), $(z0))", phi_start),
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Non-conservative field with Green's theorem twist
        m = nonzero(-5, 5)
        n = nonzero(-5, 5)
        k = nonzero(-5, 5)
        
        # Construct F where curl is nonzero: F = <-my² + kx, nx² + ky>
        F_x = -m*y^2 + k*x
        F_y = n*x^2 + k*y
        
        # Curl in z-direction
        curl_z = simplify(diff(F_y, x) - diff(F_x, y))
        
        # Integrate over a parametric ellipse x = a*cos(t), y = b*sin(t)
        a_param = randint(2, 5)
        b_param = randint(2, 5)
        
        # Area of ellipse
        area = a_param * b_param * π
        
        # Line integral = ∬ curl·dA by Green's theorem
        curl_const = substitute(curl_z, [x => 0, y => 0])  # Check if constant
        
        # For general curl, integrate over ellipse
        # Using Green's theorem: ∮ F·dr = ∬ (∂F_y/∂x - ∂F_x/∂y) dA
        ans = simplify(curl_z * area)
        
        problem(
            question="Consider the vector field \\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)) \\rangle. Let C be the ellipse \\frac{x^2}{$(a_param)^2} + \\frac{y^2}{$(b_param)^2} = 1 oriented counterclockwise. Evaluate \\oint_C \\mathbf{F} \\cdot d\\mathbf{r} using Green's theorem.",
            answer=ans,
            difficulty=(3600, 4200),
            solution=steps(
                sol("Vector field", "\\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)) \\rangle"),
                "Apply Green's theorem: \\oint_C \\mathbf{F} \\cdot d\\mathbf{r} = \\iint_D \\left(\\frac{\\partial F_y}{\\partial x} - \\frac{\\partial F_x}{\\partial y}\\right) dA",
                sol("\\frac{\\partial F_y}{\\partial x}", diff(F_y, x)),
                sol("\\frac{\\partial F_x}{\\partial y}", diff(F_x, y)),
                sol("Curl", curl_z),
                "Area of ellipse D: \\pi \\cdot $(a_param) \\cdot $(b_param) = $(tex(area))",
                sol("Integral", ans)
            ),
            time=280
        )
        
    elseif problem_type == 3
        # Work integral with parametric helix
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        
        # Force field F = <ax, by, cz>
        F_x = a*x
        F_y = b*y
        F_z = c*z
        
        # Helix: r(t) = <R*cos(t), R*sin(t), h*t> for t ∈ [0, 2πn]
        R = randint(2, 4)
        h = randint(1, 3)
        n_turns = randint(1, 3)
        t_end = 2*π*n_turns
        
        # r'(t) = <-R*sin(t), R*cos(t), h>
        # F(r(t)) = <aR*cos(t), bR*sin(t), ch*t>
        # F·r' = -aR²*sin(t)*cos(t) + bR²*cos(t)*sin(t) + ch²*t
        #      = (b-a)R²*sin(t)*cos(t) + ch²*t
        #      = (b-a)R²/2 * sin(2t) + ch²*t
        
        # Integrate from 0 to t_end
        # ∫[(b-a)R²/2 * sin(2t) + ch²*t]dt = -(b-a)R²/4 * cos(2t) + ch²*t²/2
        # Evaluated: [-(b-a)R²/4 * cos(2*t_end) + ch²*t_end²/2] - [-(b-a)R²/4 * 1 + 0]
        # Since cos(4πn) = 1, this simplifies to ch²*t_end²/2
        
        ans = c * h^2 * t_end^2 // 2
        ans_simplified = simplify(substitute(ans, []))
        
        problem(
            question="Calculate the work done by the force field \\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)), $(tex(F_z)) \\rangle on a particle moving along the helix \\mathbf{r}(t) = \\langle $(R)\\cos(t), $(R)\\sin(t), $(h)t \\rangle for t \\in [0, $(n_turns == 1 ? "2\\pi" : "$(n_turns) \\cdot 2\\pi")].",
            answer=ans_simplified,
            difficulty=(3700, 4300),
            solution=steps(
                sol("Parameterization", "\\mathbf{r}(t) = \\langle $(R)\\cos(t), $(R)\\sin(t), $(h)t \\rangle"),
                sol("\\mathbf{r}'(t)", "\\langle -$(R)\\sin(t), $(R)\\cos(t), $(h) \\rangle"),
                sol("\\mathbf{F}(\\mathbf{r}(t))", "\\langle $(tex(a*R))\\cos(t), $(tex(b*R))\\sin(t), $(tex(c*h))t \\rangle"),
                "Work: W = \\int_C \\mathbf{F} \\cdot d\\mathbf{r} = \\int_0^{$(tex(t_end))} \\mathbf{F}(\\mathbf{r}(t)) \\cdot \\mathbf{r}'(t) \\, dt",
                "\\mathbf{F} \\cdot \\mathbf{r}' = $(tex((b-a)*R^2//2)) \\sin(2t) + $(tex(c*h^2))t",
                "Integrate: \\left[-\\frac{$(tex((b-a)*R^2))}{4}\\cos(2t) + \\frac{$(tex(c*h^2))}{2}t^2\\right]_0^{$(tex(t_end))}",
                "Cosine terms cancel due to periodicity",
                sol("Answer", ans_simplified)
            ),
            time=320
        )
        
    elseif problem_type == 4
        # Circulation and flux on closed curve with explicit parameterization
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        # Field F = <-by, ax>
        F_x = -b*y
        F_y = a*x
        
        # Curl for circulation
        curl_z = simplify(diff(F_y, x) - diff(F_x, y))
        
        # Circle of radius r
        r = randint(2, 6)
        area = π * r^2
        
        circulation = simplify(curl_z * area)
        
        problem(
            question="Let \\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)) \\rangle and let C be the circle x^2 + y^2 = $(r^2) oriented counterclockwise. Find the circulation \\oint_C \\mathbf{F} \\cdot d\\mathbf{r}.",
            answer=circulation,
            difficulty=(3500, 4100),
            solution=steps(
                sol("Given field", "\\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)) \\rangle"),
                "Use Green's theorem for circulation",
                sol("\\nabla \\times \\mathbf{F}", curl_z),
                "Circulation = \\iint_D ($(tex(curl_z))) \\, dA where D is disk x^2 + y^2 \\leq $(r^2)",
                sol("Area of D", area),
                sol("Circulation", circulation)
            ),
            time=240
        )
        
    else
        # Stokes' theorem on a surface with boundary
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        
        # Vector field with interesting curl
        F_x = a*y*z
        F_y = b*x*z
        F_z = (a + b)*x*y
        
        # Compute curl
        curl_x = simplify(diff(F_z, y) - diff(F_y, z))
        curl_y = simplify(diff(F_x, z) - diff(F_z, x))
        curl_z = simplify(diff(F_y, x) - diff(F_x, y))
        
        # Surface: hemisphere z = √(R² - x² - y²)
        R = randint(2, 5)
        
        # For hemisphere with upward normal, use Stokes' theorem
        # The boundary is the circle x² + y² = R² in the xy-plane
        # Easier to compute line integral directly
        
        # Parameterize boundary: r(t) = <R*cos(t), R*sin(t), 0>
        # F on boundary: <0, 0, (a+b)*R²*cos(t)*sin(t)>
        # r'(t) = <-R*sin(t), R*cos(t), 0>
        # F·r' = 0
        
        ans = 0
        
        problem(
            question="Let \\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)), $(tex(F_z)) \\rangle. Let S be the upper hemisphere x^2 + y^2 + z^2 = $(R^2), z \\geq 0, oriented upward. Use Stokes' theorem to evaluate \\iint_S (\\nabla \\times \\mathbf{F}) \\cdot d\\mathbf{S}.",
            answer=ans,
            difficulty=(3800, 4500),
            solution=steps(
                "By Stokes' theorem: \\iint_S (\\nabla \\times \\mathbf{F}) \\cdot d\\mathbf{S} = \\oint_C \\mathbf{F} \\cdot d\\mathbf{r}",
                "Boundary C is the circle x^2 + y^2 = $(R^2), z = 0, oriented counterclockwise",
                "Parameterize: \\mathbf{r}(t) = \\langle $(R)\\cos(t), $(R)\\sin(t), 0 \\rangle, t \\in [0, 2\\pi]",
                sol("\\mathbf{F}(\\mathbf{r}(t))", "\\langle 0, 0, $(tex((a+b)*R^2))\\cos(t)\\sin(t) \\rangle"),
                sol("\\mathbf{r}'(t)", "\\langle -$(R)\\sin(t), $(R)\\cos(t), 0 \\rangle"),
                "\\mathbf{F} \\cdot \\mathbf{r}' = 0 \\cdot (-$(R)\\sin(t)) + 0 \\cdot ($(R)\\cos(t)) + $(tex((a+b)*R^2))\\cos(t)\\sin(t) \\cdot 0 = 0",
                sol("Answer", 0)
            ),
            time=300
        )
    end
end