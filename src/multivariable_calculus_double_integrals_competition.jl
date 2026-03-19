# multivariable_calculus - double_integrals (competition)
# Generated: 2026-03-08T21:02:49.070434

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/double_integrals")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Order of integration reversal with challenging region (3500-4000)
        a = randint(2, 5)
        b = randint(2, 4)
        c = randint(1, 3)
        
        # Region: 0 ≤ x ≤ a, x^b/c ≤ y ≤ a^b
        outer_limit = a^b
        
        # Reversed: integrate from y^(1/b)*c to a, then 0 to a^b
        integrand_expr = x^randint(2, 4) * y^randint(1, 3)
        
        inner_old = "x^{$b}/$c \\leq y \\leq $outer_limit"
        outer_old = "0 \\leq x \\leq $a"
        
        inner_new = "y^{1/$b} \\cdot $c \\leq x \\leq $a"
        outer_new = "0 \\leq y \\leq $outer_limit"
        
        question = "Reverse the order of integration for \\\$\\int_0^{$a} \\int_{x^{$b}/$c}^{$outer_limit} $(tex(integrand_expr)) \\, dy \\, dx\\\$. Express in the form \\\$\\int_c^d \\int_{g_1(y)}^{g_2(y)} f(x,y) \\, dx \\, dy\\\$ and identify the new limits. What is the outer integral's upper limit?"
        
        answer = outer_limit
        
        solution = steps(
            "Original region: \\\$$inner_old\\\$, \\\$$outer_old\\\$",
            "To reverse, solve \\\$y = x^{$b}/$c\\\$ for \\\$x\\\$: \\\$x = (y \\cdot $c)^{1/$b}\\\$",
            "New bounds: \\\$$inner_new\\\$, \\\$$outer_new\\\$",
            sol("Outer upper limit", outer_limit)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 3900),
            solution=solution,
            time=240
        )
        
    elseif problem_type == 2
        # Polar conversion with non-standard region (3800-4300)
        r_val = randint(3, 8)
        angle_mult = choice([2, 3, 4])
        
        # Region in polar: r = θ^angle_mult, 0 ≤ θ ≤ π/angle_mult
        # Challenging Jacobian problem
        
        theta_max_num = 1
        theta_max_denom = angle_mult
        
        question = "Convert \\\$\\iint_R (x^2 + y^2)^{3/2} \\, dA\\\$ to polar coordinates where \\\$R\\\$ is the region bounded by \\\$r = \\theta^{$angle_mult}\\\$ for \\\$0 \\leq \\theta \\leq \\pi/$angle_mult\\\$. What is the power of \\\$r\\\$ in the integrand (after including the Jacobian)?"
        
        # In polar: (x^2 + y^2)^(3/2) = r^3, Jacobian r gives r^4
        answer = 4
        
        solution = steps(
            "In polar coordinates: \\\$x^2 + y^2 = r^2\\\$, so \\\$(x^2+y^2)^{3/2} = r^3\\\$",
            "Jacobian for polar: \\\$dA = r \\, dr \\, d\\theta\\\$",
            "Integrand becomes: \\\$r^3 \\cdot r = r^4\\\$",
            sol("Power of r", 4)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3800, 4300),
            solution=solution,
            time=270
        )
        
    elseif problem_type == 3
        # Change of variables with non-linear transformation (4000-4600)
        a = randint(2, 5)
        b = randint(2, 4)
        
        # Transformation: u = x^a, v = y^b
        # Jacobian calculation required
        
        question = "Consider the transformation \\\$u = x^{$a}\\\$, \\\$v = y^{$b}\\\$ where \\\$x, y > 0\\\$. Compute the absolute value of the Jacobian \\\$\\left|\\frac{\\partial(x,y)}{\\partial(u,v)}\\right|\\\$. Express your answer as a simplified expression in \\\$u\\\$ and \\\$v\\\$. What is the exponent of \\\$u\\\$ in the numerator?"
        
        # x = u^(1/a), y = v^(1/b)
        # ∂x/∂u = (1/a)u^(1/a - 1), ∂x/∂v = 0
        # ∂y/∂u = 0, ∂y/∂v = (1/b)v^(1/b - 1)
        # Jacobian = (1/a)(1/b)u^(1/a - 1)v^(1/b - 1)
        
        u_exp_num = 1 - a
        u_exp_denom = a
        
        answer_exp = u_exp_num // u_exp_denom
        
        question_alt = "Consider the transformation \\\$u = x^{$a}\\\$, \\\$v = y^{$b}\\\$ where \\\$x, y > 0\\\$. The Jacobian \\\$\\left|\\frac{\\partial(x,y)}{\\partial(u,v)}\\right|\\\$ equals \\\$\\frac{1}{$a \\cdot $b} u^p v^q\\\$. What is \\\$p + q\\\$?"
        
        p_val = (1 - a) // a
        q_val = (1 - b) // b
        answer_sum = p_val + q_val
        
        solution = steps(
            "Inverse transformation: \\\$x = u^{1/$a}\\\$, \\\$y = v^{1/$b}\\\$",
            "Compute partial derivatives: \\\$\\frac{\\partial x}{\\partial u} = \\frac{1}{$a}u^{(1-$a)/$a}\\\$, \\\$\\frac{\\partial y}{\\partial v} = \\frac{1}{$b}v^{(1-$b)/$b}\\\$",
            "Jacobian matrix is diagonal, determinant: \\\$\\frac{1}{$(a*b)} u^{(1-$a)/$a} v^{(1-$b)/$b}\\\$",
            sol("Sum of exponents", answer_sum)
        )
        
        problem(
            question=question_alt,
            answer=answer_sum,
            difficulty=(4000, 4600),
            solution=solution,
            time=300
        )
        
    else
        # Surface integral with parametric surface (4200-4800)
        radius = randint(3, 7)
        height = randint(4, 9)
        
        # Cylinder: x = r cos(θ), y = r sin(θ), z = z
        # 0 ≤ θ ≤ 2π, 0 ≤ z ≤ height, r = radius
        
        question = "Compute \\\$\\iint_S z \\, dS\\\$ where \\\$S\\\$ is the lateral surface of the cylinder \\\$x^2 + y^2 = $radius^2\\\$, \\\$0 \\leq z \\leq $height\\\$. What is the final answer?"
        
        # Parametrization: r(θ, z) = (radius cos θ, radius sin θ, z)
        # |r_θ × r_z| = radius
        # Integral: ∫∫ z · radius dθ dz = radius · (2π) · (height^2/2)
        
        answer = radius * 2 * height^2 // 2
        answer_val = radius * height^2
        
        solution = steps(
            "Parametrize surface: \\\$\\mathbf{r}(\\theta, z) = ($radius \\cos\\theta, $radius \\sin\\theta, z)\\\$",
            "Compute \\\$|\\mathbf{r}_\\theta \\times \\mathbf{r}_z| = $radius\\\$",
            "Set up integral: \\\$\\int_0^{2\\pi} \\int_0^{$height} z \\cdot $radius \\, dz \\, d\\theta\\\$",
            "Evaluate: \\\$$radius \\cdot 2\\pi \\cdot \\frac{$height^2}{2} = $(radius * height^2)\\pi\\\$",
            sol("Answer", "$(radius * height^2)\\pi")
        )
        
        problem(
            question=question,
            answer="$(answer_val)pi",
            difficulty=(4200, 4800),
            solution=solution,
            time=300
        )
    end
end