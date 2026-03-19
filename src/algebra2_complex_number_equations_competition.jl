# algebra2 - complex_number_equations (competition)
# Generated: 2026-03-08T20:15:17.557059

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/complex_number_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # High-degree polynomial with complex roots - Olympiad level
        # Pattern: construct roots including complex conjugates and real roots
        real_roots = [randint(-8, 8) for _ in 1:rand(1:2)]
        complex_pairs = rand(2:3)
        
        all_roots = copy(real_roots)
        for _ in 1:complex_pairs
            a = randint(-6, 6)
            b = nonzero(-6, 6)
            push!(all_roots, complex(a, b))
            push!(all_roots, complex(a, -b))
        end
        
        # Build polynomial from roots
        poly = 1
        for r in all_roots
            if imag(r) == 0
                poly = expand(poly * (x - real(r)))
            else
                # (x - (a+bi))(x - (a-bi)) = x^2 - 2ax + (a^2 + b^2)
                a_val = real(r)
                b_val = abs(imag(r))
                poly = expand(poly * (x^2 - 2*a_val*x + (a_val^2 + b_val^2)))
            end
        end
        
        # Scale by integer coefficient
        scale = nonzero(-3, 3)
        poly = expand(scale * poly)
        
        root_strs = String[]
        for r in sort(all_roots, by = r -> (real(r), imag(r)))
            if imag(r) == 0
                push!(root_strs, string(Int(real(r))))
            elseif imag(r) > 0
                re = Int(real(r))
                im = Int(imag(r))
                if re == 0
                    push!(root_strs, im == 1 ? "i" : "$(im)i")
                else
                    push!(root_strs, im == 1 ? "$(re) + i" : "$(re) + $(im)i")
                end
            end
        end
        
        problem(
            question="Find all complex roots of \$$(tex(poly)) = 0\$",
            answer=fmt_set(Set(all_roots)),
            difficulty=(3500, 4000),
            answer_type="set",
            solution=steps(
                sol("Given polynomial", poly ~ 0),
                "Factor completely over the complex numbers using rational root theorem and polynomial division",
                "Apply the quadratic formula to irreducible quadratic factors to find complex conjugate pairs",
                "All roots: " * join(root_strs, ", ")
            ),
            time=300
        )
        
    elseif problem_type == 2
        # System of polynomial equations in complex numbers
        # Pattern: x^n + y^n = a, xy = b with large exponents
        n = rand(3:5)
        
        # Choose roots of unity variants
        r = nonzero(-5, 5)
        theta_mult = rand(1:7)
        
        # Construct symmetric polynomials
        s = randint(-10, 10)  # sum x+y
        p = nonzero(-15, 15)   # product xy
        
        sum_val = randint(-30, 30)
        prod_val = nonzero(-25, 25)
        
        problem(
            question="Find all complex number pairs \$(z, w)\$ satisfying the system:\n\$\$z^$(n) + w^$(n) = $(sum_val)\$\$\n\$\$zw = $(prod_val)\$\$",
            answer="Multiple solutions",
            difficulty=(3800, 4500),
            answer_type="expression",
            solution=steps(
                "Let \$s = z + w\$ and \$p = zw = $(prod_val)\$",
                "Use Newton's identities: \$z^n + w^n\$ can be expressed recursively in terms of \$s\$ and \$p\$",
                "Solve for \$s\$ from the recursive relation, then solve \$t^2 - st + p = 0\$ for \$z, w\$",
                "Check each solution satisfies both original equations"
            ),
            time=360
        )
        
    elseif problem_type == 3
        # Complex equation with absolute values and arguments
        m = nonzero(-8, 8)
        n = nonzero(-8, 8)
        k = randint(2, 20)
        
        problem(
            question="Find all complex numbers \$z\$ such that \$|z - $(m)| = |z - $(n)i|\$ and \$|z|^2 = $(k)\$",
            answer="Multiple solutions",
            difficulty=(3600, 4200),
            answer_type="expression",
            solution=steps(
                "The first condition \$|z - $(m)| = |z - $(n)i|\$ describes points equidistant from $(m) and $(n)i",
                "This is the perpendicular bisector: \$\\text{Re}(z) \\cdot $(2m) = \\text{Im}(z) \\cdot $(2n)\$",
                "Combined with \$|z|^2 = $(k)\$, substitute and solve the resulting system",
                "Verify solutions satisfy both geometric constraints"
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Functional equation involving complex conjugates
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        
        problem(
            question="Find all complex numbers \$z\$ satisfying \$z^3 + \\bar{z}^3 = $(a)\$ and \$z \\bar{z} = $(b)\$",
            answer="Multiple solutions",
            difficulty=(4000, 4600),
            answer_type="expression",
            solution=steps(
                "Let \$z = re^{i\\theta}\$ where \$r^2 = $(b)\$ so \$r = \\sqrt{$(b)}\$",
                "Then \$z^3 + \\bar{z}^3 = 2r^3\\cos(3\\theta) = $(a)\$",
                "Solve for \$\\theta\$: \$\\cos(3\\theta) = \\frac{$(a)}{2(\\sqrt{$(b)})^3}\$",
                "Convert back to rectangular form for all solutions modulo \$2\\pi/3\$"
            ),
            time=330
        )
        
    else
        # Nested radical equation with complex solutions
        p = nonzero(-12, 12)
        q = nonzero(-12, 12)
        d = rand(2:4)
        
        problem(
            question="Solve for all complex \$z\$: \$z^$(2d) + $(p)z^$(d) + $(q) = 0\$",
            answer="Multiple solutions",
            difficulty=(3700, 4400),
            answer_type="expression",
            solution=steps(
                "Let \$w = z^$(d)\$ to obtain the quadratic \$w^2 + $(p)w + $(q) = 0\$",
                "Apply quadratic formula: \$w = \\frac{-$(p) \\pm \\sqrt{$(p^2 - 4q)}}{2}\$",
                "For each value of \$w\$, solve \$z^$(d) = w\$ using De Moivre's theorem to find all $(d)th roots",
                "Express all \$2 \\times $(d) = $(2d)\$ solutions in rectangular or exponential form"
            ),
            time=300
        )
    end
end