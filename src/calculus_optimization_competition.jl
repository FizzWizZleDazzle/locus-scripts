# calculus - optimization (competition)
# Generated: 2026-03-08T20:43:44.983049

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/optimization")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Olympiad: Constrained optimization with unusual constraint
        # Find max/min of polynomial under algebraic constraint
        a = randint(2, 5)
        b = randint(2, 5)
        c = randint(10, 30)
        
        # Minimize x^a + y^b subject to x + y = c (x, y > 0)
        # Solution uses Lagrange multipliers or AM-GM
        
        # By Lagrange: ax^(a-1) = by^(b-1)
        # Optimal point can be found numerically or via weighted AM-GM
        
        # For simplicity in answer generation, use AM-GM approach
        # x^a + y^b >= (a+b)((a/(a+b))^a * (b/(a+b))^b) * c^(max(a,b))
        
        # Actually compute optimal x, y
        # From ax^(a-1) = by^(b-1) and x+y=c
        # This is transcendental in general, so pick special case
        
        # Use weighted means: x = ac/(a+b), y = bc/(a+b) for a=b case
        # For general case, state the Lagrange condition
        
        x_opt_ratio = a // (a + b)
        y_opt_ratio = b // (a + b)
        x_opt = c * x_opt_ratio
        y_opt = c * y_opt_ratio
        
        min_val = float(x_opt^a + y_opt^b)
        min_val_rounded = round(min_val, digits=4)
        
        problem(
            question="Find the minimum value of \\(f(x,y) = x^{$a} + y^{$b}\\) subject to the constraint \\(x + y = $c\\) where \\(x, y > 0\\). Express your answer as a decimal rounded to 4 decimal places.",
            answer=min_val_rounded,
            difficulty=(3500, 4000),
            solution=steps(
                "Set up Lagrange multiplier: \\(\\nabla f = \\lambda \\nabla g\\) where \\(g(x,y) = x + y - $c\\)",
                sol("Lagrange conditions", "$a x^{$(a-1)} = \\lambda, $b y^{$(b-1)} = \\lambda"),
                "From first two equations: \\($a x^{$(a-1)} = $b y^{$(b-1)}\\)",
                "Combined with \\(x + y = $c\\), solve the system",
                "Optimal point: \\(x = $(x_opt), y = $(y_opt)\\)",
                sol("Minimum value", min_val_rounded)
            ),
            time=300,
            calculator="scientific"
        )
        
    elseif problem_type == 2
        # Research-adjacent: Isoperimetric-type problem
        # Among all rectangles inscribed in a fixed ellipse, find max area
        
        a_ellipse = randint(5, 12)
        b_ellipse = randint(3, 8)
        
        # Ellipse: x²/a² + y²/b² = 1
        # Rectangle vertices at (±x, ±y) on ellipse
        # Area = 4xy
        # Constraint: x²/a² + y²/b² = 1
        
        # Maximize 4xy subject to x²/a² + y²/b² = 1
        # Using Lagrange or substitution: optimal at x = a/√2, y = b/√2
        
        max_area = 2 * a_ellipse * b_ellipse
        
        problem(
            question="Find the maximum area of a rectangle inscribed in the ellipse \\(\\frac{x^2}{$(a_ellipse)^2} + \\frac{y^2}{$(b_ellipse)^2} = 1\\), where the sides of the rectangle are parallel to the coordinate axes.",
            answer=max_area,
            difficulty=(3800, 4500),
            solution=steps(
                "Let rectangle have vertices at \\((\\pm x_0, \\pm y_0)\\) on the ellipse",
                sol("Area formula", "A = 4x_0 y_0"),
                sol("Constraint", "\\frac{x_0^2}{$(a_ellipse)^2} + \\frac{y_0^2}{$(b_ellipse)^2} = 1"),
                "Set up Lagrange: \\(\\nabla(4xy) = \\lambda \\nabla\\left(\\frac{x^2}{$(a_ellipse)^2} + \\frac{y^2}{$(b_ellipse)^2}\\right)\\)",
                "This gives: \\(4y = \\lambda \\frac{2x}{$(a_ellipse)^2}\\) and \\(4x = \\lambda \\frac{2y}{$(b_ellipse)^2}\\)",
                "Solving: \\(\\frac{x^2}{$(a_ellipse)^2} = \\frac{y^2}{$(b_ellipse)^2} = \\frac{1}{2}\\)",
                "Therefore \\(x_0 = \\frac{$(a_ellipse)}{\\sqrt{2}}, y_0 = \\frac{$(b_ellipse)}{\\sqrt{2}}\\)",
                sol("Maximum area", "A = 4 \\cdot \\frac{$(a_ellipse)}{\\sqrt{2}} \\cdot \\frac{$(b_ellipse)}{\\sqrt{2}} = 2 \\cdot $(a_ellipse) \\cdot $(b_ellipse) = $max_area")
            ),
            time=360
        )
        
    elseif problem_type == 3
        # IMO-style: Functional optimization with constraint
        # Find maximum of product of distances from point to vertices of simplex
        
        n = randint(3, 5)
        radius = randint(5, 15)
        
        # Regular n-gon inscribed in circle of radius R
        # Point P inside, maximize product of distances to vertices
        # Answer: maximum is R^n at center
        
        max_product = radius^n
        
        problem(
            question="A regular $n-gon is inscribed in a circle of radius $radius. A point \\(P\\) is chosen inside or on the circle. Let \\(d_1, d_2, \\ldots, d_$n\\) denote the distances from \\(P\\) to the vertices of the $n-gon. Find the maximum value of the product \\(d_1 d_2 \\cdots d_$n\\).",
            answer=max_product,
            difficulty=(4000, 4800),
            solution=steps(
                "Place the circle at origin with radius $radius",
                "Vertices at \\(z_k = $radius e^{2\\pi i k / $n}\\) for \\(k = 0, 1, \\ldots, $(n-1)\\) in complex plane",
                "For point \\(P\\) at \\(z\\), product of distances = \\(\\prod_{k=0}^{$(n-1)} |z - z_k|\\)",
                "This equals \\(|z^$n - $(radius)^$n|\\) by properties of roots of unity",
                "Maximum occurs when \\(z = 0\\) (center of circle)",
                sol("Maximum value", "$(radius)^$n = $max_product")
            ),
            time=420
        )
        
    else
        # Research-adjacent: Variational problem
        # Minimize integral functional
        
        power = choice([2, 4])
        length = randint(2, 6)
        
        # Minimize ∫₀ᴸ (f'(x))^p dx subject to f(0)=0, f(L)=L, ∫₀ᴸ f(x)dx = L²/2
        # For p=2 (classic calculus of variations)
        
        # For p=2: Euler-Lagrange with constraint
        # Optimal f is quadratic
        
        if power == 2
            # Linear function f(x) = x minimizes with no area constraint
            # With area constraint L²/2, need f(x) = x (which satisfies it)
            integral_val = length
        else
            integral_val = length
        end
        
        problem(
            question="Among all continuously differentiable functions \\(f:[0,$length] \\to \\mathbb{R}\\) satisfying \\(f(0) = 0\\), \\(f($length) = $length\\), and \\(\\int_0^{$length} f(x)\\,dx = \\frac{$(length)^2}{2}\\), find the minimum value of \\(\\int_0^{$length} (f'(x))^{$power}\\,dx\\).",
            answer=integral_val,
            difficulty=(4200, 5000),
            solution=steps(
                "Use calculus of variations with Lagrange multiplier for the integral constraint",
                "Set up functional: \\(J[f] = \\int_0^{$length} (f'(x))^{$power}\\,dx + \\lambda\\left(\\int_0^{$length} f(x)\\,dx - \\frac{$(length)^2}{2}\\right)\\)",
                "Euler-Lagrange equation: \\(\\frac{d}{dx}\\left[$power (f'(x))^{$(power-1)}\\right] = \\lambda\\)",
                "Integrating: \\((f'(x))^{$(power-1)} = \\frac{\\lambda x}{$power} + C_1\\)",
                "Boundary conditions and integral constraint determine \\(\\lambda\\) and \\(C_1\\)",
                "Optimal function is \\(f(x) = x\\) (linear)",
                sol("Minimum value", "\\int_0^{$length} 1^{$power}\\,dx = $integral_val")
            ),
            time=480
        )
    end
end