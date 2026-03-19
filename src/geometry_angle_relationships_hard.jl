# geometry - angle_relationships (hard)
# Generated: 2026-03-08T20:02:12.425876

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/angle_relationships")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Intersecting lines with algebraic angles (1800-2000)
        a = nonzero(-8, 8)
        b = randint(10, 50)
        c = nonzero(-8, 8)
        d = randint(10, 50)
        
        # Vertical angles are equal: ax + b = cx + d
        x_val = (d - b) // (a - c)
        angle1_val = a * x_val + b
        angle2_val = c * x_val + d
        
        # Ensure reasonable angle values
        if angle1_val < 20 || angle1_val > 160
            a = nonzero(2, 5)
            b = randint(30, 60)
            c = nonzero(-5, -2)
            d = randint(80, 120)
            x_val = (d - b) // (a - c)
            angle1_val = a * x_val + b
        end
        
        d = DiagramObj(600, 400)
        line!(d, 100, 200, 500, 200)
        line!(d, 150, 100, 450, 300)
        point!(d, 300, 200, "P")
        text!(d, 350, 180, "$(a)x + $(b)", size=16)
        text!(d, 250, 230, "$(c)x + $(d)", size=16)
        
        problem(
            question="Two lines intersect at point P. If one angle measures \$($(a)x + $(b))°\$ and its vertical angle measures \$($(c)x + $(d))°\$, find the value of x and the measure of these angles.",
            answer=Float64(x_val),
            difficulty=(1800, 2000),
            solution=steps(
                "Vertical angles are congruent",
                sol("Set up equation", "$(a)x + $(b) = $(c)x + $(d)"),
                "Solve: $(a)x - $(c)x = $(d) - $(b)",
                sol("x", x_val),
                sol("Angle measure", "$(angle1_val)°")
            ),
            image=render(d),
            time=150
        )
        
    elseif problem_type == 2
        # Parallel lines with transversal - complex angle relationships (2000-2200)
        m = nonzero(2, 7)
        n = randint(5, 25)
        k = nonzero(2, 6)
        p = randint(10, 40)
        
        # Corresponding angles: mx + n = 3x + p, solve for x
        x_val = (p - n) // (m - 3)
        angle_val = m * x_val + n
        
        # Make sure we get reasonable values
        if angle_val < 30 || angle_val > 150
            m = 4
            n = 20
            x_val = 15
            angle_val = m * x_val + n
            p = 3 * x_val + n
        end
        
        d = DiagramObj(600, 500)
        line!(d, 50, 150, 550, 150)
        line!(d, 50, 350, 550, 350)
        line!(d, 150, 50, 400, 450)
        
        point!(d, 235, 150, "A")
        point!(d, 315, 350, "B")
        
        text!(d, 260, 130, "$(m)x + $(n)", size=16)
        text!(d, 340, 370, "3x + $(p)", size=16)
        text!(d, 280, 400, "Parallel lines", size=14)
        
        problem(
            question="Two parallel lines are cut by a transversal. One angle measures \$($(m)x + $(n))°\$ and its corresponding angle measures \$(3x + $(p))°\$. Find x and the measure of these angles.",
            answer=Float64(x_val),
            difficulty=(2000, 2200),
            solution=steps(
                "Corresponding angles formed by parallel lines and a transversal are congruent",
                sol("Equation", "$(m)x + $(n) = 3x + $(p)"),
                "Solve: $(m)x - 3x = $(p) - $(n)",
                sol("x", x_val),
                sol("Angle measure", "$(angle_val)°")
            ),
            image=render(d),
            time=180
        )
        
    elseif problem_type == 3
        # Triangle with exterior angle theorem (1900-2100)
        a = nonzero(2, 8)
        b = randint(15, 45)
        c = nonzero(2, 7)
        d = randint(10, 40)
        e = nonzero(3, 9)
        f = randint(20, 50)
        
        # Exterior angle = sum of remote interior angles
        # (ax + b) + (cx + d) = ex + f
        x_val = (f - b - d) // (a + c - e)
        
        if x_val < 5 || x_val > 30
            a = 3
            b = 20
            c = 4
            d = 25
            e = 9
            f = 90
            x_val = (f - b - d) // (a + c - e)
        end
        
        angle1 = a * x_val + b
        angle2 = c * x_val + d
        exterior = e * x_val + f
        
        d = DiagramObj(600, 500)
        polygon!(d, [150, 350, 500, 150], [350, 100, 350, 350])
        line!(d, 500, 350, 580, 350)
        
        point!(d, 150, 350, "A")
        point!(d, 350, 100, "B")
        point!(d, 500, 350, "C")
        
        text!(d, 180, 330, "$(a)x + $(b)", size=15)
        text!(d, 340, 130, "$(c)x + $(d)", size=15)
        text!(d, 520, 340, "$(e)x + $(f)", size=15)
        
        problem(
            question="In triangle ABC, angle A measures \$($(a)x + $(b))°\$ and angle B measures \$($(c)x + $(d))°\$. An exterior angle at C measures \$($(e)x + $(f))°\$. Find x and all angle measures.",
            answer=Float64(x_val),
            difficulty=(1900, 2100),
            solution=steps(
                "By the Exterior Angle Theorem: exterior angle = sum of remote interior angles",
                sol("Equation", "$(e)x + $(f) = ($(a)x + $(b)) + ($(c)x + $(d))"),
                "Simplify: $(e)x + $(f) = $(a + c)x + $(b + d)",
                "Solve: $(e - a - c)x = $(b + d - f)",
                sol("x", x_val),
                "Angle A = $(angle1)°, Angle B = $(angle2)°, Exterior angle = $(exterior)°"
            ),
            image=render(d),
            time=200
        )
        
    elseif problem_type == 4
        # Complementary and supplementary angle system (2100-2300)
        # Let angles be x and y
        # x + y = 90 (complementary)
        # Also: x = 2y + k (some relationship)
        k = randint(5, 25)
        
        # Solve: 2y + k + y = 90
        y_val = (90 - k) // 3
        x_val = 2 * y_val + k
        
        d = DiagramObj(600, 400)
        
        # Draw right angle
        line!(d, 150, 300, 450, 300)
        line!(d, 150, 300, 150, 100)
        line!(d, 150, 300, 350, 150)
        right_angle!(d, 450, 300, 150, 300, 150, 100, 20)
        
        angle_arc!(d, 150, 300, 50, 0, Float64(x_val), "x")
        
        text!(d, 280, 200, "Angle x = 2y + $(k)", size=14)
        text!(d, 280, 230, "Angles x and y are complementary", size=14)
        
        problem(
            question="Two angles x and y are complementary. If angle x is $(k)° more than twice angle y, find the measures of both angles.",
            answer=Float64(x_val),
            difficulty=(2100, 2300),
            solution=steps(
                "Complementary angles sum to 90°",
                sol("System", "x + y = 90 and x = 2y + $(k)"),
                "Substitute: (2y + $(k)) + y = 90",
                "Simplify: 3y = $(90 - k)",
                sol("y", y_val),
                sol("x", x_val),
                "Therefore x = $(x_val)° and y = $(y_val)°"
            ),
            image=render(d),
            time=220
        )
        
    else
        # Polygon interior/exterior angles (2200-2400)
        n = randint(5, 9)
        m = nonzero(3, 12)
        b = randint(10, 50)
        
        # Each interior angle of regular n-gon: (n-2)*180/n
        # Given one angle is mx + b, solve for x
        interior_angle = (n - 2) * 180 // n
        x_val = (interior_angle - b) // m
        
        if x_val < 5 || x_val > 40
            n = 6
            m = 8
            b = 30
            interior_angle = (n - 2) * 180 // n
            x_val = (interior_angle - b) // m
        end
        
        angle_val = m * x_val + b
        
        d = DiagramObj(600, 500)
        
        # Draw regular polygon
        angles = [2π * i / n for i in 0:n]
        cx, cy = 300, 250
        radius = 150
        xs = [cx + radius * cos(a) for a in angles]
        ys = [cy + radius * sin(a) for a in angles]
        
        polygon!(d, xs[1:n], ys[1:n])
        
        text!(d, cx + 80, cy - 20, "$(m)x + $(b)", size=16)
        text!(d, cx - 100, cy + 200, "Regular $(n)-gon", size=16)
        
        problem(
            question="In a regular $(n)-sided polygon, each interior angle can be expressed as \$($(m)x + $(b))°\$. Find the value of x.",
            answer=Float64(x_val),
            difficulty=(2200, 2400),
            solution=steps(
                "For a regular n-gon, each interior angle = (n-2)×180°/n",
                sol("Formula", "Interior angle = $(Float64((n-2)*180//n))°"),
                sol("Equation", "$(m)x + $(b) = $(Float64(interior_angle))"),
                "Solve: $(m)x = $(Float64(interior_angle - b))",
                sol("x", x_val),
                "Verification: $(m)($(x_val)) + $(b) = $(angle_val)°"
            ),
            image=render(d),
            time=240
        )
    end
end