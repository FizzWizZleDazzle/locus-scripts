# multivariable_calculus - greens_theorem (hard)
# Generated: 2026-03-08T21:05:38.833993

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/greens_theorem")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: Direct application of Green's theorem - compute line integral by converting to double integral
        # Pick a vector field F = (P, Q) where ∂Q/∂x - ∂P/∂y is simple
        # Use a simple closed curve (rectangle or circle)
        
        curve_type = choice([:rectangle, :circle])
        
        if curve_type == :rectangle
            a = randint(1, 5)
            b = randint(1, 5)
            
            # Create F = (P, Q) where curl is constant
            k = randint(2, 8)
            # Let P = -ky/2, Q = kx/2, then ∂Q/∂x - ∂P/∂y = k
            P_expr = -k*y//2
            Q_expr = k*x//2
            
            curl_val = k
            area = 4*a*b
            ans = curl_val * area
            
            question = "Use Green's theorem to evaluate the line integral \\(\\oint_C $(tex(P_expr))\\,dx + $(tex(Q_expr))\\,dy\\), where \\(C\\) is the rectangle with vertices \\((\\pm $a, \\pm $b)\\) oriented counterclockwise."
            
            solution = steps(
                "Apply Green's theorem: \\(\\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right)\\,dA\\)",
                sol("\\frac{\\partial Q}{\\partial x}", k//2),
                sol("\\frac{\\partial P}{\\partial y}", -k//2),
                sol("Curl", k),
                "Area of rectangle: \\((2 \\cdot $a)(2 \\cdot $b) = $area\\)",
                sol("Line integral", ans)
            )
            
        else  # circle
            r = randint(2, 6)
            
            # F = (-y, x) gives curl = 2
            P_expr = -y
            Q_expr = x
            
            curl_val = 2
            area = π * r^2
            ans_expr = 2 * π * r^2
            
            question = "Use Green's theorem to evaluate \\(\\oint_C $(tex(P_expr))\\,dx + $(tex(Q_expr))\\,dy\\), where \\(C\\) is the circle \\(x^2 + y^2 = $(r^2)\\) oriented counterclockwise."
            
            solution = steps(
                "Apply Green's theorem: \\(\\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right)\\,dA\\)",
                sol("\\frac{\\partial Q}{\\partial x}", 1),
                sol("\\frac{\\partial P}{\\partial y}", -1),
                sol("Curl", curl_val),
                "Area of circle: \\(\\pi r^2 = $(r^2)\\pi\\)",
                sol("Line integral", "$(ans_expr)\\pi")
            )
            ans = ans_expr
        end
        
        problem(
            question=question,
            answer=ans,
            difficulty=(1800, 2000),
            solution=solution,
            time=180
        )
        
    elseif problem_type == 2
        # Type 2: Compute area using Green's theorem
        # Area = (1/2) ∮_C (x dy - y dx)
        
        curve = choice([:ellipse, :triangle])
        
        if curve == :ellipse
            a = randint(2, 6)
            b = randint(2, 6)
            
            area = π * a * b
            
            question = "Use Green's theorem to find the area enclosed by the ellipse \\(\\frac{x^2}{$(a^2)} + \\frac{y^2}{$(b^2)} = 1\\)."
            
            solution = steps(
                "Area formula using Green's theorem: \\(A = \\frac{1}{2}\\oint_C (x\\,dy - y\\,dx)\\)",
                "Parametrize ellipse: \\(x = $a\\cos t\\), \\(y = $b\\sin t\\), \\(0 \\leq t \\leq 2\\pi\\)",
                "Compute \\(dx = -$a\\sin t\\,dt\\), \\(dy = $b\\cos t\\,dt\\)",
                "\\(A = \\frac{1}{2}\\int_0^{2\\pi} ($a\\cos t \\cdot $b\\cos t - $b\\sin t \\cdot (-$a\\sin t))\\,dt\\)",
                "\\(= \\frac{1}{2}\\int_0^{2\\pi} $(a*b)(\\cos^2 t + \\sin^2 t)\\,dt = \\frac{$(a*b)}{2} \\cdot 2\\pi\\)",
                sol("Area", "$(a*b)\\pi")
            )
            ans = area
            
        else  # triangle
            x1, y1 = randint(0, 4), randint(0, 4)
            x2, y2 = randint(5, 8), randint(0, 3)
            x3, y3 = randint(1, 4), randint(5, 8)
            
            # Area using cross product formula
            area = abs((x2 - x1)*(y3 - y1) - (x3 - x1)*(y2 - y1)) // 2
            
            question = "Use Green's theorem to find the area of the triangle with vertices \\(($x1, $y1)\\), \\(($x2, $y2)\\), and \\(($x3, $y3)\\)."
            
            solution = steps(
                "Area formula: \\(A = \\frac{1}{2}\\oint_C (x\\,dy - y\\,dx)\\)",
                "Integrate along each edge of the triangle",
                "By the shoelace formula: \\(A = \\frac{1}{2}|x_1(y_2 - y_3) + x_2(y_3 - y_1) + x_3(y_1 - y_2)|\\)",
                "\\(= \\frac{1}{2}|$x1($y2 - $y3) + $x2($y3 - $y1) + $x3($y1 - $y2)|\\)",
                sol("Area", area)
            )
            ans = area
        end
        
        problem(
            question=question,
            answer=ans,
            difficulty=(1900, 2100),
            solution=solution,
            time=240
        )
        
    elseif problem_type == 3
        # Type 3: Verify Green's theorem on a specific path
        # Choose a vector field and simple region where both integrals can be computed
        
        # Use triangular region and linear field
        a = randint(2, 5)
        
        # Field F = (y, x) on triangle with vertices (0,0), (a,0), (0,a)
        P_expr = y
        Q_expr = x
        
        # ∂Q/∂x - ∂P/∂y = 1 - 1 = 0
        curl = 0
        ans = 0
        
        question = "Verify Green's theorem for \\(\\oint_C y\\,dx + x\\,dy\\) where \\(C\\) is the boundary of the triangle with vertices \\((0,0)\\), \\(($a, 0)\\), \\((0, $a)\\), oriented counterclockwise. Find the value of the line integral."
        
        solution = steps(
            "Compute \\(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y} = 1 - 1 = 0\\)",
            "By Green's theorem: \\(\\oint_C P\\,dx + Q\\,dy = \\iint_D 0\\,dA = 0\\)",
            "Can verify directly: integrate along three edges",
            "Edge 1: \\((0,0)\\) to \\(($a,0)\\): \\(y=0, dy=0\\), integral = 0",
            "Edge 2: \\(($a,0)\\) to \\((0,$a)\\): parametric integration gives \\($a^2/2\\)",
            "Edge 3: \\((0,$a)\\) to \\((0,0)\\): \\(x=0, dx=0\\), integral = \\(-$a^2/2\\)",
            sol("Total", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(2000, 2200),
            solution=solution,
            time=300
        )
        
    else  # problem_type == 4
        # Type 4: Use Green's theorem to evaluate a more complex field
        # Polynomial field on a simple region
        
        n = randint(2, 4)
        m = randint(2, 4)
        k = randint(1, 3)
        
        # F = (x^n*y, x*y^m)
        # ∂Q/∂x = y^m, ∂P/∂y = x^n
        # Curl = y^m - x^n
        
        # On unit disk
        P_expr = x^n * y
        Q_expr = k * x * y^m
        
        question = "Use Green's theorem to evaluate \\(\\oint_C $(tex(P_expr))\\,dx + $(tex(Q_expr))\\,dy\\) where \\(C\\) is the unit circle \\(x^2 + y^2 = 1\\) oriented counterclockwise."
        
        solution = steps(
            "Apply Green's theorem: \\(\\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{\\partial Q}{\\partial x} - \\frac{\\partial P}{\\partial y}\\right)\\,dA\\)",
            sol("\\frac{\\partial Q}{\\partial x}", k*y^m),
            sol("\\frac{\\partial P}{\\partial y}", x^n),
            "Convert to polar: \\(x = r\\cos\\theta\\), \\(y = r\\sin\\theta\\)",
            "Integrate \\(\\iint_D ($(k)y^$m - x^$n)\\,dA\\) over unit disk",
            "By symmetry of odd powers over symmetric domain, both integrals vanish",
            sol("Line integral", 0)
        )
        ans = 0
        
        problem(
            question=question,
            answer=ans,
            difficulty=(2100, 2400),
            solution=solution,
            time=240
        )
    end
end