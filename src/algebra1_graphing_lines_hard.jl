# algebra1 - graphing_lines (hard)
# Generated: 2026-03-08T19:56:55.671908

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/graphing_lines")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Find equation of line through two points (medium complexity)
        x1, y1 = randint(-12, 12), randint(-12, 12)
        x2, y2 = randint(-12, 12), randint(-12, 12)
        while x1 == x2 || (x1 == x2 && y1 == y2)
            x2, y2 = randint(-12, 12), randint(-12, 12)
        end
        
        m = (y2 - y1) // (x2 - x1)
        b = y1 - m * x1
        
        ans_expr = m*x + b
        
        problem(
            question="Find the equation of the line passing through the points \$($(x1), $(y1))\$ and \$($(x2), $(y2))\$ in slope-intercept form \$y = mx + b\$.",
            answer=ans_expr,
            difficulty=(1800, 2000),
            solution=steps(
                "Points: \$($(x1), $(y1))\$ and \$($(x2), $(y2))\$",
                sol("Slope", "m = \\frac{$(y2) - $(y1)}{$(x2) - $(x1)} = $(tex(m))"),
                "Using point-slope form: \$y - $(y1) = $(tex(m))(x - $(x1))\$",
                sol("Simplify to slope-intercept", ans_expr)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Find intersection of two lines with challenging coefficients
        a1 = nonzero(-8, 8)
        b1 = nonzero(-8, 8)
        c1 = randint(-25, 25)
        
        a2 = nonzero(-8, 8)
        b2 = nonzero(-8, 8)
        c2 = randint(-25, 25)
        
        # Ensure lines aren't parallel
        while a1*b2 == a2*b1
            a2 = nonzero(-8, 8)
            b2 = nonzero(-8, 8)
        end
        
        # Solve system
        det = a1*b2 - a2*b1
        x_sol = (c1*b2 - c2*b1) // det
        y_sol = (a1*c2 - a2*c1) // det
        
        ans = fmt_tuple([x_sol, y_sol])
        
        problem(
            question="Find the intersection point of the lines \$$(tex(a1*x + b1*y)) = $(c1)\$ and \$$(tex(a2*x + b2*y)) = $(c2)\$. Express your answer as an ordered pair.",
            answer=ans,
            difficulty=(1900, 2100),
            answer_type="tuple",
            solution=steps(
                sol("System", "$(tex(a1*x + b1*y ~ c1)), \\quad $(tex(a2*x + b2*y ~ c2))"),
                "Multiply first equation by $(b2), second by $(b1) and subtract to eliminate \$y\$",
                sol("Solve for x", "x = $(tex(x_sol))"),
                "Substitute back to find \$y\$",
                sol("Solution", ans)
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Find equation perpendicular to given line through a point
        m_given = nonzero(-9, 9) // nonzero(1, 5)
        b_given = randint(-15, 15)
        
        px, py = randint(-10, 10), randint(-10, 10)
        
        m_perp = -1 // m_given
        b_perp = py - m_perp * px
        
        ans_expr = m_perp*x + b_perp
        
        problem(
            question="Find the equation of the line perpendicular to \$y = $(tex(m_given*x + b_given))\$ that passes through the point \$($(px), $(py))\$.",
            answer=ans_expr,
            difficulty=(1850, 2050),
            solution=steps(
                sol("Given line slope", "m = $(tex(m_given))"),
                sol("Perpendicular slope", "m_{\\perp} = -\\frac{1}{m} = $(tex(m_perp))"),
                "Use point-slope form with \$($(px), $(py))\$: \$y - $(py) = $(tex(m_perp))(x - $(px))\$",
                sol("Simplify", ans_expr)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Distance between parallel lines in form ax + by = c
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        c1 = randint(-20, 20)
        c2 = randint(-20, 20)
        while c1 == c2
            c2 = randint(-20, 20)
        end
        
        # Distance formula: |c2 - c1| / sqrt(a^2 + b^2)
        numerator = abs(c2 - c1)
        denominator_sq = a^2 + b^2
        
        # Simplify the radical if possible
        ans_num = numerator
        ans_den_sq = denominator_sq
        
        # Try to simplify
        gcd_val = gcd(ans_num, ans_den_sq)
        ans_num = ans_num ÷ gcd_val
        ans_den_sq = ans_den_sq ÷ gcd_val
        
        if ans_den_sq == 1
            ans = string(ans_num)
        else
            ans = "\\frac{$(ans_num)}{\\sqrt{$(ans_den_sq)}}"
        end
        
        problem(
            question="Find the distance between the parallel lines \$$(tex(a*x + b*y)) = $(c1)\$ and \$$(tex(a*x + b*y)) = $(c2)\$. Express your answer in simplest radical form.",
            answer=ans,
            difficulty=(2100, 2300),
            answer_type="expression",
            solution=steps(
                "The lines are parallel since they have the same coefficients for \$x\$ and \$y\$",
                sol("Distance formula", "d = \\frac{|c_2 - c_1|}{\\sqrt{a^2 + b^2}}"),
                sol("Substitute", "d = \\frac{|$(c2) - $(c1)|}{\\sqrt{$(a)^2 + $(b)^2}} = \\frac{$(numerator)}{\\sqrt{$(denominator_sq)}}"),
                sol("Simplify", ans)
            ),
            time=180
        )
        
    elseif problem_type == 5
        # Area of triangle formed by three lines (requires finding vertices)
        # Two non-parallel lines and x-axis
        m1 = nonzero(-6, 6)
        b1 = nonzero(-15, 15)
        
        m2 = nonzero(-6, 6)
        b2 = nonzero(-15, 15)
        while m1 == m2 || abs(b1) == abs(b2)
            m2 = nonzero(-6, 6)
            b2 = nonzero(-15, 15)
        end
        
        # Intersection of the two lines
        x_int = (b2 - b1) // (m1 - m2)
        y_int = m1 * x_int + b1
        
        # x-intercepts
        x1_axis = -b1 // m1
        x2_axis = -b2 // m2
        
        # Area = (1/2) * base * height
        base = abs(x2_axis - x1_axis)
        height = abs(y_int)
        area = base * height // 2
        
        problem(
            question="Find the area of the triangle formed by the lines \$y = $(tex(m1*x + b1))\$, \$y = $(tex(m2*x + b2))\$, and the \$x\$-axis.",
            answer=area,
            difficulty=(2200, 2400),
            solution=steps(
                "Find the intersection of \$y = $(tex(m1*x + b1))\$ and \$y = $(tex(m2*x + b2))\$",
                sol("Intersection point", "($(tex(x_int)), $(tex(y_int)))"),
                "Find \$x\$-intercepts: set \$y = 0\$ for each line",
                sol("x-intercepts", "($(tex(x1_axis)), 0), ($(tex(x2_axis)), 0)"),
                sol("Area", "A = \\frac{1}{2} \\cdot |$(tex(x2_axis - x1_axis))| \\cdot |$(tex(y_int))| = $(tex(area))")
            ),
            time=240
        )
        
    else
        # Reflection of a line across another line (challenging)
        # Reflect y = mx + b across y = x
        m = nonzero(-5, 5) // nonzero(1, 3)
        b = randint(-12, 12)
        
        # When reflecting y = mx + b across y = x, swap x and y: x = my + b, so y = (x - b)/m
        m_reflected = 1 // m
        b_reflected = -b // m
        
        ans_expr = m_reflected * x + b_reflected
        
        problem(
            question="Find the equation of the line obtained by reflecting \$y = $(tex(m*x + b))\$ across the line \$y = x\$.",
            answer=ans_expr,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Original line", "y = $(tex(m*x + b))"),
                "Reflecting across \$y = x\$ swaps \$x\$ and \$y\$: \$x = $(tex(m*y + b))\$",
                "Solve for \$y\$: \$$(tex(m*y)) = x - $(b)\$",
                sol("Reflected line", ans_expr)
            ),
            time=180
        )
    end
end