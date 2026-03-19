# algebra2 - complex_number_equations (very_hard)
# Generated: 2026-03-08T20:15:17.674041

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/complex_number_equations")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # High-degree polynomial with complex roots (2500-2800)
        # Generate conjugate pairs for cleaner problem
        a_real = randint(2, 5)
        b_imag = randint(2, 6)
        c_real = randint(-4, 4)
        d_imag = randint(2, 5)
        
        # Roots: a±bi and c±di
        root1 = complex(a_real, b_imag)
        root2 = complex(a_real, -b_imag)
        root3 = complex(c_real, d_imag)
        root4 = complex(c_real, -d_imag)
        
        # Build polynomial from roots
        poly1 = expand((x - a_real - b_imag*im) * (x - a_real + b_imag*im))
        poly2 = expand((x - c_real - d_imag*im) * (x - c_real + d_imag*im))
        poly_expr = expand(poly1 * poly2)
        
        roots_set = Set([root1, root2, root3, root4])
        
        problem(
            question="Find all complex solutions to \$$(tex(poly_expr)) = 0\$",
            answer=fmt_set(roots_set),
            difficulty=(2500, 2800),
            answer_type="set",
            solution=steps(
                sol("Given", poly_expr ~ 0),
                "Factor as product of quadratics with conjugate pairs",
                sol("First pair", (x - a_real)^2 + b_imag^2 ~ 0),
                sol("Second pair", (x - c_real)^2 + d_imag^2 ~ 0),
                "Solve each quadratic to find all four complex roots",
                "Solution set: \$\\{$(a_real)+$(b_imag)i, $(a_real)-$(b_imag)i, $(c_real)+$(d_imag)i, $(c_real)-$(d_imag)i\\}\$"
            ),
            time=240
        )
        
    elseif problem_type == 2
        # System with complex coefficients (2600-3000)
        a = randint(2, 5)
        b_re = randint(-3, 3)
        b_im = nonzero(2, 5)
        c = randint(-8, 8)
        
        d_re = nonzero(-4, 4)
        d_im = nonzero(2, 5)
        e = randint(2, 6)
        f = randint(-10, 10)
        
        # Solution: solve backward
        x_val = complex(randint(-5, 5), randint(2, 6))
        y_val = complex(randint(-4, 4), randint(2, 5))
        
        # Build system
        rhs1 = a * x_val + complex(b_re, b_im) * y_val + c
        rhs2 = complex(d_re, d_im) * x_val + e * y_val + f
        
        problem(
            question="Solve the system over the complex numbers:<br>\$$(a)x + ($(b_re)+$(b_im)i)y = $(real(rhs1))+$(imag(rhs1))i\$<br>\$$(d_re > 0 ? "+" : "")$(d_re)$(d_im > 0 ? "+" : "")$(d_im)i)x + $(e)y = $(real(rhs2))+$(imag(rhs2))i\$",
            answer=fmt_tuple([x_val, y_val]),
            difficulty=(2600, 3000),
            answer_type="tuple",
            solution=steps(
                "Use elimination or substitution with complex arithmetic",
                "Multiply equations to eliminate variables",
                "Simplify complex coefficient products",
                "Solve for x, then substitute to find y",
                sol("Solution", (x_val, y_val))
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Equation involving powers of complex numbers (2700-3200)
        n = rand([3, 4, 5, 6])
        k = randint(2, 8)
        
        # Find nth roots of k*e^(iπ/m)
        m = rand([2, 3, 4, 6])
        
        # z^n = k
        roots = Set()
        for j in 0:(n-1)
            angle = 2 * π * j / n
            root = k^(1/n) * (cos(angle) + im*sin(angle))
            push!(roots, root)
        end
        
        problem(
            question="Find all complex solutions to \$z^$(n) = $(k)\$ in rectangular form \$a+bi\$",
            answer=fmt_set(roots),
            difficulty=(2700, 3200),
            answer_type="set",
            solution=steps(
                sol("Given", "z^$(n) = $(k)"),
                "Express $(k) in polar form: \$$(k) = $(k)e^{i\\cdot 0}\$",
                "Apply De Moivre's theorem: \$z_k = \\sqrt[$(n)]{$(k)} e^{i(0 + 2\\pi k)/$(n)}\$ for k=0,1,...,$(n-1)",
                "Convert each root to rectangular form",
                "The $(n) distinct roots form vertices of a regular $(n)-gon"
            ),
            time=270
        )
        
    elseif problem_type == 4
        # Polynomial with specific symmetry (2800-3300)
        # Build palindromic polynomial
        a = nonzero(1, 3)
        b = randint(-5, 5)
        c = nonzero(2, 6)
        
        # x^4 + bx^3 + cx^2 + bx + a = 0 (palindromic)
        poly = a*x^4 + b*x^3 + c*x^2 + b*x + a
        
        # Divide by x^2 and substitute y = x + 1/x
        # This is complex and requires advanced technique
        
        problem(
            question="Solve the palindromic equation \$$(tex(poly)) = 0\$ for all complex roots",
            answer=tex(solve(poly ~ 0, x)),
            difficulty=(2800, 3300),
            answer_type="set",
            solution=steps(
                sol("Given", poly ~ 0),
                "Note this is palindromic: coefficients read same forward and backward",
                "Divide by \$x^2\$: \$$(a)x^2 + $(b)x + $(c) + \\frac{$(b)}{x} + \\frac{$(a)}{x^2} = 0\$",
                "Substitute \$y = x + \\frac{1}{x}\$, then \$y^2 = x^2 + 2 + \\frac{1}{x^2}\$",
                "Reduce to quadratic in y, solve for y, then solve \$x + \\frac{1}{x} = y\$ for each y",
                "This gives four complex roots"
            ),
            time=300
        )
        
    elseif problem_type == 5
        # Exponential equation with complex solutions (2600-3100)
        a = nonzero(2, 8)
        b = nonzero(-10, 10)
        
        # e^(2πi/n) type solutions
        n = rand([3, 4, 5, 6])
        
        problem(
            question="Find all complex solutions to \$z^$(n) + $(a) = 0\$ where \$z \\in \\mathbb{C}\$",
            answer="set of $(n) complex numbers",
            difficulty=(2600, 3100),
            answer_type="set",
            solution=steps(
                sol("Given", "z^$(n) = -$(a)"),
                "Express \$-$(a)\$ in polar form: \$$(a)e^{i\\pi}\$",
                "Apply nth root formula: \$z_k = \\sqrt[$(n)]{$(a)} e^{i(\\pi + 2\\pi k)/$(n)}\$ for k=0,1,...,$(n-1)",
                "Calculate magnitude: \$r = \\sqrt[$(n)]{$(a)}\$",
                "Calculate arguments: \$\\theta_k = \\frac{\\pi + 2\\pi k}{$(n)}\$",
                "Convert to rectangular form for each root"
            ),
            time=240
        )
        
    else
        # Rational equation with complex coefficients (3000-3400)
        p = randint(2, 5)
        q_re = randint(-4, 4)
        q_im = nonzero(2, 5)
        
        r_re = nonzero(-5, 5)
        r_im = nonzero(2, 6)
        s = randint(-8, 8)
        
        problem(
            question="Solve for z: \$\\frac{$(p)z + ($(q_re)+$(q_im)i)}{z - ($(r_re)+$(r_im)i)} = $(s)\$",
            answer="complex number",
            difficulty=(3000, 3400),
            answer_type="expression",
            solution=steps(
                "Cross multiply: \$$(p)z + ($(q_re)+$(q_im)i) = $(s)(z - ($(r_re)+$(r_im)i))\$",
                "Expand right side with complex multiplication",
                "Collect all z terms on one side",
                "Isolate z: factor and divide by complex coefficient",
                "Rationalize denominator by multiplying by conjugate",
                "Simplify to form \$a+bi\$"
            ),
            time=270
        )
    end
end