# multivariable_calculus - triple_integrals (easy)
# Generated: 2026-03-08T21:02:15.102938

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/triple_integrals")
    
    problem_type = choice([
        :basic_rectangular,
        :constant_integrand,
        :polynomial_integrand,
        :order_of_integration,
        :volume_box
    ])
    
    if problem_type == :basic_rectangular
        # Simple triple integral with constant bounds
        a, b = sort([randint(-5, 5), randint(-5, 5)])
        c, d = sort([randint(-5, 5), randint(-5, 5)])
        e, f = sort([randint(-5, 5), randint(-5, 5)])
        
        # Ensure non-zero volume
        while a == b || c == d || e == f
            a, b = sort([randint(-5, 5), randint(-5, 5)])
            c, d = sort([randint(-5, 5), randint(-5, 5)])
            e, f = sort([randint(-5, 5), randint(-5, 5)])
        end
        
        k = nonzero(-8, 8)
        ans = k * (b - a) * (d - c) * (f - e)
        
        problem(
            question="Evaluate the triple integral: \$\\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} \\int_{$(a)}^{$(b)} $(k) \\, dx \\, dy \\, dz\$",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Integrate with respect to x: \$\\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} [$(k)x]_{$(a)}^{$(b)} \\, dy \\, dz = \\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} $(k*(b-a)) \\, dy \\, dz\$",
                "Integrate with respect to y: \$\\int_{$(e)}^{$(f)} [$(k*(b-a))y]_{$(c)}^{$(d)} \\, dz = \\int_{$(e)}^{$(f)} $(k*(b-a)*(d-c)) \\, dz\$",
                "Integrate with respect to z: \$[$(k*(b-a)*(d-c))z]_{$(e)}^{$(f)} = $(ans)\$"
            ),
            time=120
        )
        
    elseif problem_type == :constant_integrand
        # Triple integral of 1 to find volume
        a, b = sort([randint(0, 6), randint(0, 6)])
        c, d = sort([randint(0, 6), randint(0, 6)])
        e, f = sort([randint(0, 6), randint(0, 6)])
        
        while a == b || c == d || e == f
            a, b = sort([randint(0, 6), randint(0, 6)])
            c, d = sort([randint(0, 6), randint(0, 6)])
            e, f = sort([randint(0, 6), randint(0, 6)])
        end
        
        ans = (b - a) * (d - c) * (f - e)
        
        problem(
            question="Find the volume of the rectangular box defined by \$$(a) \\leq x \\leq $(b)\$, \$$(c) \\leq y \\leq $(d)\$, and \$$(e) \\leq z \\leq $(f)\$ using a triple integral.",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                "Set up the integral: \$V = \\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} \\int_{$(a)}^{$(b)} 1 \\, dx \\, dy \\, dz\$",
                "Integrate: \$\\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} ($(b) - $(a)) \\, dy \\, dz = \\int_{$(e)}^{$(f)} $(b-a) \\cdot ($(d) - $(c)) \\, dz\$",
                sol("Volume", ans)
            ),
            time=90
        )
        
    elseif problem_type == :polynomial_integrand
        # Simple polynomial integrand
        a, b = sort([randint(0, 4), randint(0, 4)])
        c, d = sort([randint(0, 4), randint(0, 4)])
        e, f = sort([randint(0, 4), randint(0, 4)])
        
        while a == b || c == d || e == f
            a, b = sort([randint(0, 4), randint(0, 4)])
            c, d = sort([randint(0, 4), randint(0, 4)])
            e, f = sort([randint(0, 4), randint(0, 4)])
        end
        
        k = nonzero(-6, 6)
        
        # Integrand is k*x
        integral_x = k * (b^2 - a^2) // 2
        ans = integral_x * (d - c) * (f - e)
        
        problem(
            question="Evaluate: \$\\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} \\int_{$(a)}^{$(b)} $(k)x \\, dx \\, dy \\, dz\$",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                "Integrate with respect to x: \$\\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} [$(k)x^2/2]_{$(a)}^{$(b)} \\, dy \\, dz = \\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} $(integral_x) \\, dy \\, dz\$",
                "Integrate with respect to y: \$\\int_{$(e)}^{$(f)} $(integral_x)($(d) - $(c)) \\, dz = \\int_{$(e)}^{$(f)} $(integral_x * (d-c)) \\, dz\$",
                sol("Final answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == :order_of_integration
        # xy integrand to practice order
        a, b = sort([randint(0, 3), randint(0, 3)])
        c, d = sort([randint(0, 3), randint(0, 3)])
        e, f = sort([randint(0, 3), randint(0, 3)])
        
        while a == b || c == d || e == f
            a, b = sort([randint(0, 3), randint(0, 3)])
            c, d = sort([randint(0, 3), randint(0, 3)])
            e, f = sort([randint(0, 3), randint(0, 3)])
        end
        
        int_x = (b^2 - a^2) // 2
        int_y = (d^2 - c^2) // 2
        ans = int_x * int_y * (f - e)
        
        problem(
            question="Evaluate: \$\\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} \\int_{$(a)}^{$(b)} xy \\, dx \\, dy \\, dz\$",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "Integrate with respect to x: \$\\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} y[x^2/2]_{$(a)}^{$(b)} \\, dy \\, dz = \\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} $(int_x)y \\, dy \\, dz\$",
                "Integrate with respect to y: \$\\int_{$(e)}^{$(f)} $(int_x)[y^2/2]_{$(c)}^{$(d)} \\, dz = \\int_{$(e)}^{$(f)} $(int_x * int_y) \\, dz\$",
                sol("Answer", ans)
            ),
            time=180
        )
        
    else  # :volume_box
        # Volume with xyz integrand
        a, b = sort([randint(1, 3), randint(1, 3)])
        c, d = sort([randint(1, 3), randint(1, 3)])
        e, f = sort([randint(1, 3), randint(1, 3)])
        
        while a == b || c == d || e == f
            a, b = sort([randint(1, 3), randint(1, 3)])
            c, d = sort([randint(1, 3), randint(1, 3)])
            e, f = sort([randint(1, 3), randint(1, 3)])
        end
        
        int_x = (b^2 - a^2) // 2
        int_y = (d^2 - c^2) // 2
        int_z = (f^2 - e^2) // 2
        ans = int_x * int_y * int_z
        
        problem(
            question="Evaluate: \$\\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} \\int_{$(a)}^{$(b)} xyz \\, dx \\, dy \\, dz\$",
            answer=ans,
            difficulty=(1000, 1200),
            solution=steps(
                "Integrate with respect to x: \$\\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} yz \\cdot \\frac{x^2}{2}\\Big|_{$(a)}^{$(b)} \\, dy \\, dz = \\int_{$(e)}^{$(f)} \\int_{$(c)}^{$(d)} $(int_x)yz \\, dy \\, dz\$",
                "Integrate with respect to y: \$\\int_{$(e)}^{$(f)} $(int_x)z \\cdot \\frac{y^2}{2}\\Big|_{$(c)}^{$(d)} \\, dz = \\int_{$(e)}^{$(f)} $(int_x * int_y)z \\, dz\$",
                "Integrate with respect to z: \$$(int_x * int_y) \\cdot \\frac{z^2}{2}\\Big|_{$(e)}^{$(f)} = $(ans)\$"
            ),
            time=180
        )
    end
end