# multivariable_calculus - triple_integrals (very_easy)
# Generated: 2026-03-08T21:01:45.587887

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/triple_integrals")
    
    prob_type = rand(1:5)
    
    if prob_type == 1
        # ELO 150-300: Recognize a triple integral notation
        a = randint(0, 5)
        b = randint(a+1, 8)
        c = randint(0, 5)
        d = randint(c+1, 8)
        e = randint(0, 5)
        f = randint(e+1, 8)
        
        question = "How many integrations are performed in the expression \$\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} \\int_{$(e)}^{$(f)} 1 \\, dz \\, dy \\, dx\$?"
        answer = 3
        difficulty = (150, 300)
        solution = steps(
            "A triple integral has three integral signs",
            "Count the number of \$\\int\$ symbols",
            sol("Answer", 3)
        )
        
    elseif prob_type == 2
        # ELO 200-400: Identify order of integration
        orders = [("dz \\, dy \\, dx", "z, then y, then x"),
                  ("dy \\, dz \\, dx", "y, then z, then x"),
                  ("dx \\, dy \\, dz", "x, then y, then z"),
                  ("dz \\, dx \\, dy", "z, then x, then y")]
        order_choice = choice(orders)
        
        a = randint(0, 5)
        b = randint(a+1, 8)
        c = randint(0, 5)
        d = randint(c+1, 8)
        e = randint(0, 5)
        f = randint(e+1, 8)
        
        question = "In the triple integral \$\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} \\int_{$(e)}^{$(f)} f(x,y,z) \\, $(order_choice[1])\$, which variable is integrated first?"
        answer = split(order_choice[2], ",")[1]
        difficulty = (200, 400)
        solution = steps(
            "The order of integration is read from right to left",
            "The differential closest to the integrand is integrated first",
            sol("Answer", answer)
        )
        
    elseif prob_type == 3
        # ELO 300-500: Evaluate constant triple integral over box
        a = randint(0, 3)
        b = randint(a+1, 6)
        c = randint(0, 3)
        d = randint(c+1, 6)
        e = randint(0, 3)
        f = randint(e+1, 6)
        k = randint(1, 5)
        
        vol = (b - a) * (d - c) * (f - e)
        answer = k * vol
        
        question = "Evaluate \$\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} \\int_{$(e)}^{$(f)} $(k) \\, dz \\, dy \\, dx\$"
        difficulty = (300, 500)
        solution = steps(
            sol("Given", "\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} \\int_{$(e)}^{$(f)} $(k) \\, dz \\, dy \\, dx"),
            "Integrate with respect to z: \$\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} [$(k)z]_{$(e)}^{$(f)} \\, dy \\, dx = \\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} $(k*(f-e)) \\, dy \\, dx\$",
            "Integrate with respect to y: \$\\int_{$(a)}^{$(b)} [$(k*(f-e))y]_{$(c)}^{$(d)} \\, dx = \\int_{$(a)}^{$(b)} $(k*(f-e)*(d-c)) \\, dx\$",
            "Integrate with respect to x: \$[$(k*(f-e)*(d-c))x]_{$(a)}^{$(b)} = $(k*(f-e)*(d-c)*(b-a))\$",
            sol("Answer", answer)
        )
        
    elseif prob_type == 4
        # ELO 400-600: Evaluate linear function triple integral
        a = randint(0, 2)
        b = randint(a+1, 4)
        c = randint(0, 2)
        d = randint(c+1, 4)
        e = randint(0, 2)
        f = randint(e+1, 4)
        
        # Integrate x over box
        mid_x = (b^2 - a^2) // 2
        answer = mid_x * (d - c) * (f - e)
        
        question = "Evaluate \$\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} \\int_{$(e)}^{$(f)} x \\, dz \\, dy \\, dx\$"
        difficulty = (400, 600)
        solution = steps(
            sol("Given", "\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} \\int_{$(e)}^{$(f)} x \\, dz \\, dy \\, dx"),
            "Integrate with respect to z (treating x as constant): \$\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} [xz]_{$(e)}^{$(f)} \\, dy \\, dx = \\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} $(f-e)x \\, dy \\, dx\$",
            "Integrate with respect to y: \$\\int_{$(a)}^{$(b)} [$(f-e)xy]_{$(c)}^{$(d)} \\, dx = \\int_{$(a)}^{$(b)} $((f-e)*(d-c))x \\, dx\$",
            "Integrate with respect to x: \$[$((f-e)*(d-c))\\frac{x^2}{2}]_{$(a)}^{$(b)} = $((f-e)*(d-c)) \\cdot \\frac{$(b^2) - $(a^2)}{2} = $(answer)\$",
            sol("Answer", answer)
        )
        
    else
        # ELO 500-700: Evaluate simple polynomial triple integral
        a = randint(0, 2)
        b = randint(a+1, 3)
        c = randint(0, 1)
        d = randint(c+1, 2)
        e = randint(0, 1)
        f = randint(e+1, 2)
        
        # Integrate z over box
        mid_z = (f^2 - e^2) // 2
        answer = (b - a) * (d - c) * mid_z
        
        question = "Evaluate \$\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} \\int_{$(e)}^{$(f)} z \\, dz \\, dy \\, dx\$"
        difficulty = (500, 700)
        solution = steps(
            sol("Given", "\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} \\int_{$(e)}^{$(f)} z \\, dz \\, dy \\, dx"),
            "Integrate with respect to z: \$\\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} [\\frac{z^2}{2}]_{$(e)}^{$(f)} \\, dy \\, dx = \\int_{$(a)}^{$(b)} \\int_{$(c)}^{$(d)} \\frac{$(f^2) - $(e^2)}{2} \\, dy \\, dx\$",
            "Integrate with respect to y: \$\\int_{$(a)}^{$(b)} [\\frac{$(f^2 - e^2)}{2}y]_{$(c)}^{$(d)} \\, dx = \\int_{$(a)}^{$(b)} \\frac{$(f^2 - e^2)}{2} \\cdot $(d - c) \\, dx\$",
            "Integrate with respect to x: \$[\\frac{$((f^2 - e^2)*(d - c))}{2}x]_{$(a)}^{$(b)} = \\frac{$((f^2 - e^2)*(d - c))}{2} \\cdot $(b - a) = $(answer)\$",
            sol("Answer", answer)
        )
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        solution=solution,
        time=90
    )
end