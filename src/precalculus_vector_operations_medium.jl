# precalculus - vector_operations (medium)
# Generated: 2026-03-08T20:34:51.282509

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/vector_operations")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Magnitude of a vector (1200-1400)
        x_comp = randint(-15, 15)
        y_comp = randint(-15, 15)
        z_comp = choice([0, randint(-15, 15)])
        
        if z_comp == 0
            mag = sqrt(x_comp^2 + y_comp^2)
            vec_str = "\\langle $x_comp, $y_comp \\rangle"
            calc_str = "\\sqrt{$(x_comp)^2 + $(y_comp)^2}"
        else
            mag = sqrt(x_comp^2 + y_comp^2 + z_comp^2)
            vec_str = "\\langle $x_comp, $y_comp, $z_comp \\rangle"
            calc_str = "\\sqrt{$(x_comp)^2 + $(y_comp)^2 + $(z_comp)^2}"
        end
        
        problem(
            question="Find the magnitude of the vector \$\\vec{v} = $vec_str\$.",
            answer=mag,
            difficulty=(1200, 1400),
            solution=steps(
                "Given: \$\\vec{v} = $vec_str\$",
                "Use the formula \$|\\vec{v}| = $calc_str\$",
                sol("Answer", mag)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Dot product (1200-1500)
        a1, a2 = randint(-12, 12), randint(-12, 12)
        b1, b2 = randint(-12, 12), randint(-12, 12)
        use_3d = choice([true, false])
        
        if use_3d
            a3, b3 = randint(-12, 12), randint(-12, 12)
            dot_prod = a1*b1 + a2*b2 + a3*b3
            vec_a = "\\langle $a1, $a2, $a3 \\rangle"
            vec_b = "\\langle $b1, $b2, $b3 \\rangle"
            calc = "$a1($b1) + $a2($b2) + $a3($b3)"
        else
            dot_prod = a1*b1 + a2*b2
            vec_a = "\\langle $a1, $a2 \\rangle"
            vec_b = "\\langle $b1, $b2 \\rangle"
            calc = "$a1($b1) + $a2($b2)"
        end
        
        problem(
            question="Calculate the dot product \$\\vec{a} \\cdot \\vec{b}\$ where \$\\vec{a} = $vec_a\$ and \$\\vec{b} = $vec_b\$.",
            answer=dot_prod,
            difficulty=(1200, 1500),
            solution=steps(
                "Given: \$\\vec{a} = $vec_a\$, \$\\vec{b} = $vec_b\$",
                "Compute: \$\\vec{a} \\cdot \\vec{b} = $calc\$",
                sol("Answer", dot_prod)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Unit vector (1300-1600)
        x_comp = nonzero(-10, 10)
        y_comp = nonzero(-10, 10)
        z_comp = choice([0, nonzero(-10, 10)])
        
        if z_comp == 0
            mag = sqrt(x_comp^2 + y_comp^2)
            vec_str = "\\langle $x_comp, $y_comp \\rangle"
            unit_x = x_comp // mag
            unit_y = y_comp // mag
            unit_str = "\\langle \\frac{$x_comp}{$mag}, \\frac{$y_comp}{$mag} \\rangle"
        else
            mag = sqrt(x_comp^2 + y_comp^2 + z_comp^2)
            vec_str = "\\langle $x_comp, $y_comp, $z_comp \\rangle"
            unit_x = x_comp // mag
            unit_y = y_comp // mag
            unit_z = z_comp // mag
            unit_str = "\\langle \\frac{$x_comp}{$mag}, \\frac{$y_comp}{$mag}, \\frac{$z_comp}{$mag} \\rangle"
        end
        
        problem(
            question="Find the unit vector in the direction of \$\\vec{v} = $vec_str\$.",
            answer=unit_str,
            difficulty=(1300, 1600),
            solution=steps(
                "Given: \$\\vec{v} = $vec_str\$",
                "Find magnitude: \$|\\vec{v}| = $mag\$",
                "Unit vector: \$\\hat{v} = \\frac{\\vec{v}}{|\\vec{v}|} = $unit_str\$"
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Angle between vectors using dot product (1400-1700)
        a1, a2 = nonzero(-8, 8), nonzero(-8, 8)
        b1, b2 = nonzero(-8, 8), nonzero(-8, 8)
        
        dot_prod = a1*b1 + a2*b2
        mag_a = sqrt(a1^2 + a2^2)
        mag_b = sqrt(b1^2 + b2^2)
        cos_theta = dot_prod / (mag_a * mag_b)
        theta_rad = acos(cos_theta)
        theta_deg = theta_rad * 180 / π
        
        vec_a = "\\langle $a1, $a2 \\rangle"
        vec_b = "\\langle $b1, $b2 \\rangle"
        
        problem(
            question="Find the angle (in degrees) between vectors \$\\vec{a} = $vec_a\$ and \$\\vec{b} = $vec_b\$. Round to the nearest tenth.",
            answer=round(theta_deg, digits=1),
            difficulty=(1400, 1700),
            solution=steps(
                "Given: \$\\vec{a} = $vec_a\$, \$\\vec{b} = $vec_b\$",
                "Use formula: \$\\cos(\\theta) = \\frac{\\vec{a} \\cdot \\vec{b}}{|\\vec{a}||\\vec{b}|}\$",
                "Compute: \$\\vec{a} \\cdot \\vec{b} = $dot_prod\$, \$|\\vec{a}| = $mag_a\$, \$|\\vec{b}| = $mag_b\$",
                "Thus \$\\theta = \\arccos($cos_theta) \\approx $(round(theta_deg, digits=1))°\$"
            ),
            time=180,
            calculator="scientific"
        )
        
    elseif problem_type == 5
        # Vector projection (1500-1800)
        a1, a2 = randint(-10, 10), randint(-10, 10)
        b1, b2 = nonzero(-10, 10), nonzero(-10, 10)
        
        dot_prod = a1*b1 + a2*b2
        mag_b_sq = b1^2 + b2^2
        scalar = dot_prod // mag_b_sq
        proj_x = scalar * b1
        proj_y = scalar * b2
        
        vec_a = "\\langle $a1, $a2 \\rangle"
        vec_b = "\\langle $b1, $b2 \\rangle"
        proj_str = "\\langle $(proj_x), $(proj_y) \\rangle"
        
        problem(
            question="Find the vector projection of \$\\vec{a} = $vec_a\$ onto \$\\vec{b} = $vec_b\$.",
            answer=proj_str,
            difficulty=(1500, 1800),
            solution=steps(
                "Given: \$\\vec{a} = $vec_a\$, \$\\vec{b} = $vec_b\$",
                "Use formula: \$\\text{proj}_{\\vec{b}}\\vec{a} = \\frac{\\vec{a} \\cdot \\vec{b}}{|\\vec{b}|^2}\\vec{b}\$",
                "Compute: \$\\vec{a} \\cdot \\vec{b} = $dot_prod\$, \$|\\vec{b}|^2 = $mag_b_sq\$",
                sol("Answer", proj_str)
            ),
            time=180
        )
        
    else
        # Linear combination (1300-1600)
        s = nonzero(-5, 5)
        t = nonzero(-5, 5)
        v1_x, v1_y = randint(-8, 8), randint(-8, 8)
        v2_x, v2_y = randint(-8, 8), randint(-8, 8)
        
        result_x = s * v1_x + t * v2_x
        result_y = s * v1_y + t * v2_y
        
        vec1 = "\\langle $v1_x, $v1_y \\rangle"
        vec2 = "\\langle $v2_x, $v2_y \\rangle"
        result = "\\langle $result_x, $result_y \\rangle"
        
        problem(
            question="Compute \$$s\\vec{v}_1 + $t\\vec{v}_2\$ where \$\\vec{v}_1 = $vec1\$ and \$\\vec{v}_2 = $vec2\$.",
            answer=result,
            difficulty=(1300, 1600),
            solution=steps(
                "Given: \$\\vec{v}_1 = $vec1\$, \$\\vec{v}_2 = $vec2\$",
                "Compute: \$$s$vec1 = \\langle $(s*v1_x), $(s*v1_y) \\rangle\$",
                "Compute: \$$t$vec2 = \\langle $(t*v2_x), $(t*v2_y) \\rangle\$",
                sol("Sum", result)
            ),
            time=120
        )
    end
end