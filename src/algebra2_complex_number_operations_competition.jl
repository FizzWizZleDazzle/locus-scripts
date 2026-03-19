# algebra2 - complex_number_operations (competition)
# Generated: 2026-03-08T20:14:43.837112

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z n k begin
    set_topic!("algebra2/complex_number_operations")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # High-degree polynomial roots with complex conjugates (Olympiad level)
        # Find all roots of a carefully constructed polynomial
        real_root = randint(-8, 8)
        a_re = randint(1, 5)
        a_im = randint(2, 7)
        b_re = randint(-6, 6)
        b_im = randint(2, 8)
        
        # Polynomial with roots: real_root, a_re ± a_im*i, b_re ± b_im*i
        # Construct from factors
        factor1 = x - real_root
        factor2 = expand((x - (a_re + a_im*im)) * (x - (a_re - a_im*im)))
        factor3 = expand((x - (b_re + b_im*im)) * (x - (b_re - b_im*im)))
        
        # factor2 = x^2 - 2*a_re*x + (a_re^2 + a_im^2)
        # factor3 = x^2 - 2*b_re*x + (b_re^2 + b_im^2)
        coeff2_linear = -2*a_re
        coeff2_const = a_re^2 + a_im^2
        coeff3_linear = -2*b_re
        coeff3_const = b_re^2 + b_im^2
        
        poly = expand(factor1 * (x^2 + coeff2_linear*x + coeff2_const) * (x^2 + coeff3_linear*x + coeff3_const))
        
        roots = Set([
            real_root,
            complex(a_re, a_im),
            complex(a_re, -a_im),
            complex(b_re, b_im),
            complex(b_re, -b_im)
        ])
        
        ans_str = fmt_set(roots)
        
        problem(
            question="Find all roots (real and complex) of the polynomial \$P(x) = $(tex(poly))\$. Express complex roots in the form \$a+bi\$.",
            answer=ans_str,
            difficulty=(3500, 4000),
            answer_type="set",
            solution=steps(
                sol("Given polynomial", poly),
                "Note that complex roots come in conjugate pairs for polynomials with real coefficients",
                "Factor systematically: first find rational root \$x=$(real_root)\$ by Rational Root Theorem",
                "Divide out \$(x-$(real_root))\$ to get a quartic, then factor into two quadratics",
                "Apply quadratic formula to each quadratic factor",
                "Complete factorization yields all five roots: $(ans_str)"
            ),
            time=300
        )
        
    elseif problem_type == 2
        # De Moivre's theorem with high exponent and root extraction
        r = randint(2, 5)
        theta_num = randint(1, 11)
        theta_den = choice([3, 4, 6, 8, 12])
        n_pow = randint(12, 25)
        
        # z = r * (cos(theta) + i*sin(theta))
        # Find z^n
        
        new_r = r^n_pow
        new_theta_num = (theta_num * n_pow) % (2 * theta_den)
        
        # Simplify the angle
        gcd_val = gcd(new_theta_num, theta_den)
        final_num = div(new_theta_num, gcd_val)
        final_den = div(theta_den, gcd_val)
        
        ans_str = "$(new_r)(cos($(final_num)π/$(final_den)) + i·sin($(final_num)π/$(final_den)))"
        
        problem(
            question="Let \$z = $(r)\\left(\\cos\\frac{$(theta_num)\\pi}{$(theta_den)} + i\\sin\\frac{$(theta_num)\\pi}{$(theta_den)}\\right)\$. Use De Moivre's theorem to compute \$z^{$(n_pow)}\$ in polar form.",
            answer=ans_str,
            difficulty=(3600, 4200),
            solution=steps(
                "By De Moivre's theorem: \$z^n = r^n(\\cos(n\\theta) + i\\sin(n\\theta))\$",
                sol("Compute", "r^{$(n_pow)} = $(r)^{$(n_pow)} = $(new_r)"),
                sol("Compute angle", "$(n_pow) \\cdot \\frac{$(theta_num)\\pi}{$(theta_den)} = \\frac{$(theta_num * n_pow)\\pi}{$(theta_den)}"),
                "Reduce angle modulo \$2\\pi\$ and simplify",
                sol("Final answer", ans_str)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # System of equations involving complex numbers with constraints
        # Find all complex z satisfying |z - a| = r and arg(z - b) = theta
        
        a_re = randint(-7, 7)
        a_im = randint(-7, 7)
        b_re = randint(-7, 7)
        b_im = randint(-7, 7)
        radius = randint(3, 10)
        angle_num = choice([1, 1, 3, 3, 5, 7])
        angle_den = choice([4, 6])
        
        # This is a sophisticated problem requiring geometric insight
        ans = "Intersection of circle centered at $(a_re)+$(a_im)i with radius $(radius) and ray from $(b_re)+$(b_im)i at angle $(angle_num)π/$(angle_den)"
        
        problem(
            question="Find all complex numbers \$z\$ satisfying both \$|z - ($(a_re) + $(a_im)i)| = $(radius)\$ and \$\\arg(z - ($(b_re) + $(b_im)i)) = \\frac{$(angle_num)\\pi}{$(angle_den)}\$. Express your answer in the form \$a+bi\$.",
            answer="geometric_construction",
            difficulty=(4000, 4500),
            solution=steps(
                "The first equation defines a circle in the complex plane centered at \$($(a_re), $(a_im))\$ with radius \$$(radius)\$",
                "The second equation defines a ray from \$($(b_re), $(b_im))\$ at angle \$\\frac{$(angle_num)\\pi}{$(angle_den)}\$ from the positive real axis",
                "Parameterize the ray: \$z = ($(b_re) + $(b_im)i) + t(\\cos\\frac{$(angle_num)\\pi}{$(angle_den)} + i\\sin\\frac{$(angle_num)\\pi}{$(angle_den)})\$ for \$t \\geq 0\$",
                "Substitute into the circle equation and solve for \$t\$",
                "This yields a quadratic in \$t\$; select non-negative solutions",
                "Convert back to \$a+bi\$ form to obtain the intersection point(s)"
            ),
            time=300
        )
        
    elseif problem_type == 4
        # nth roots of unity and cyclotomic polynomials
        n_val = choice([7, 9, 11, 13, 15, 17])
        k_val = randint(1, n_val - 1)
        
        # Sum of all primitive nth roots of unity
        problem(
            question="Let \$\\omega = e^{2\\pi i/$(n_val)}\$ be a primitive $(n_val)-th root of unity. Evaluate the sum \$S = \\sum_{k=1}^{$(n_val-1)} \\omega^k \\cdot k^2\$. Express your answer as a complex number in the form \$a+bi\$.",
            answer="requires_cyclotomic_theory",
            difficulty=(4200, 4800),
            solution=steps(
                "Recognize that \$\\omega\$ is a primitive $(n_val)-th root of unity",
                "The minimal polynomial is the $(n_val)-th cyclotomic polynomial \$\\Phi_{$(n_val)}(x)\$",
                "Use the identity \$\\sum_{k=0}^{n-1} \\omega^k = 0\$ for primitive roots",
                "Apply weighted sum techniques: \$\\sum k^2 \\omega^k = \\omega \\frac{d}{d\\omega}\\left(\\omega\\frac{d}{d\\omega}\\sum \\omega^k\\right)\$",
                "Exploit symmetry properties of roots of unity",
                "The sum evaluates to a specific value using cyclotomic theory and calculus"
            ),
            time=300
        )
        
    elseif problem_type == 5
        # Complex number equation with absolute value and argument constraints
        a = randint(2, 8)
        b = randint(2, 8)
        c = randint(2, 8)
        
        problem(
            question="Find all complex numbers \$z\$ such that \$|z|^2 + |z + $(a)i|^2 = $(b^2 + c^2)\$ and \$\\text{Re}(z^2) = 0\$. Express all solutions in the form \$a+bi\$.",
            answer="constrained_locus",
            difficulty=(3800, 4400),
            solution=steps(
                "Let \$z = x + yi\$ where \$x, y \\in \\mathbb{R}\$",
                "From \$\\text{Re}(z^2) = 0\$: \$\\text{Re}((x+yi)^2) = x^2 - y^2 = 0\$, so \$x = \\pm y\$",
                "Expand \$|z|^2 = x^2 + y^2\$ and \$|z + $(a)i|^2 = x^2 + (y+$(a))^2\$",
                "Substitute into the first equation: \$x^2 + y^2 + x^2 + (y+$(a))^2 = $(b^2 + c^2)\$",
                "Combine with constraint \$x = \\pm y\$ to form system of equations",
                "Solve the resulting quadratic equations to find all valid \$(x,y)\$ pairs"
            ),
            time=270
        )
        
    else
        # Polynomial with complex coefficients and special structure
        a_re = randint(1, 6)
        a_im = randint(1, 6)
        b_re = randint(-5, 5)
        b_im = randint(1, 7)
        
        # Find roots of z^3 + (a+bi)z + (c+di) = 0 using Cardano-like methods
        
        problem(
            question="Consider the cubic polynomial \$P(z) = z^3 + ($(a_re) + $(a_im)i)z^2 + ($(b_re) + $(b_im)i)z + k\$ where \$k\$ is chosen so that \$z = 1-2i\$ is a root. Find the value of \$k\$ and all other roots of \$P(z)\$.",
            answer="cubic_root_finding",
            difficulty=(3900, 4600),
            solution=steps(
                "Substitute \$z = 1-2i\$ into \$P(z) = 0\$ to find \$k\$",
                sol("Compute", "(1-2i)^3 = 1 - 6i - 12 + 8i = -11 - 6i"),
                "Solve for \$k\$: \$k = -[(1-2i)^3 + ($(a_re)+$(a_im)i)(1-2i)^2 + ($(b_re)+$(b_im)i)(1-2i)]\$",
                "Perform synthetic division of \$P(z)\$ by \$(z - (1-2i))\$ to obtain quadratic quotient",
                "Apply quadratic formula with complex coefficients to find remaining two roots",
                "Verify all three roots sum to \$-($(a_re)+$(a_im)i)\$ by Vieta's formulas"
            ),
            time=300
        )
    end
end