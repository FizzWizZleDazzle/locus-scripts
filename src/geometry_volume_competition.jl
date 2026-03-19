# geometry - volume (competition)
# Generated: 2026-03-08T20:13:38.802613

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/volume")
    
    problem_type = choice([
        :tetrahedron_inscribed_sphere,
        :pyramid_sphere_cap,
        :rotating_region_constraint,
        :polyhedron_extremal,
        :optimization_solid
    ])
    
    if problem_type == :tetrahedron_inscribed_sphere
        # Regular tetrahedron with edge length a, find volume of inscribed sphere
        a = randint(8, 24)
        
        # For regular tetrahedron with edge a:
        # Inradius r = a/(2*sqrt(6))
        # Volume of sphere = (4/3)*pi*r^3
        
        r_num = a
        r_denom = 2 * sqrt(6)
        
        # V = (4/3)*pi*(a/(2*sqrt(6)))^3 = (4/3)*pi*a^3/(8*6*sqrt(6))
        # = pi*a^3/(36*sqrt(6)) = pi*a^3*sqrt(6)/216
        
        vol_coefficient = a^3 / 216
        
        # Create diagram
        d = DiagramObj(400, 400)
        # Draw tetrahedron wireframe
        polygon!(d, [100, 200, 300, 200], [300, 100, 300, 100], :none, :black, 2)
        line!(d, 200, 50, 100, 300, :black, 2)
        line!(d, 200, 50, 300, 300, :black, 2)
        line!(d, 200, 50, 200, 100, :black, 2, :dashed)
        # Draw inscribed sphere
        circle!(d, 200, 220, 40, :none, :blue, 2)
        point!(d, 200, 220, :blue, 5, "O")
        text!(d, 320, 310, "a = $a", 14, :black)
        
        answer = "\\frac{$(a^3)\\sqrt{6}\\pi}{216}"
        
        problem(
            question="A regular tetrahedron has edge length \$a = $a\$. Find the exact volume of the inscribed sphere (the largest sphere that fits inside the tetrahedron). Express your answer in the form \$\\frac{k\\sqrt{6}\\pi}{216}\$ where \$k\$ is an integer.",
            answer=answer,
            difficulty=(3600, 3900),
            solution=steps(
                "For a regular tetrahedron with edge length \$a = $a\$, we first find the inradius.",
                "The inradius of a regular tetrahedron is \$r = \\frac{a}{2\\sqrt{6}} = \\frac{$a}{2\\sqrt{6}}\$",
                "The volume of the inscribed sphere is \$V = \\frac{4}{3}\\pi r^3 = \\frac{4}{3}\\pi\\left(\\frac{$a}{2\\sqrt{6}}\\right)^3\$",
                "Simplifying: \$V = \\frac{4\\pi \\cdot $(a^3)}{3 \\cdot 8 \\cdot 6\\sqrt{6}} = \\frac{4\\pi \\cdot $(a^3)}{144\\sqrt{6}} = \\frac{\\pi \\cdot $(a^3)}{36\\sqrt{6}}\$",
                "Rationalizing: \$V = \\frac{$(a^3)\\pi\\sqrt{6}}{216}\$",
                sol("Answer", answer)
            ),
            image=render(d),
            time=300
        )
        
    elseif problem_type == :pyramid_sphere_cap
        # Square pyramid with inscribed sphere touching all 5 faces
        # Find ratio of volume of spherical cap cut off by base to sphere volume
        
        h = randint(12, 30)
        s = randint(10, 24)
        
        # For pyramid with square base s×s and height h
        # Inradius r relates to surface area and volume
        # This is a complex olympiad-level calculation
        
        slant_height = sqrt(h^2 + (s/2)^2)
        
        d = DiagramObj(400, 400)
        # Draw pyramid
        polygon!(d, [100, 300, 300, 100], [300, 300, 300, 300], :lightgray, :black, 2)
        line!(d, 100, 300, 200, 100, :black, 2)
        line!(d, 300, 300, 200, 100, :black, 2)
        line!(d, 100, 300, 200, 100, :black, 2)
        line!(d, 300, 300, 200, 100, :black, 2)
        circle!(d, 200, 240, 50, :none, :blue, 2)
        text!(d, 210, 320, "s = $s", 14, :black)
        text!(d, 320, 200, "h = $h", 14, :black)
        
        # This requires finding inradius and complex geometry
        answer_num = h^2 * s^2
        answer_den = 3 * (s^2 + 2*h^2)^2
        
        problem(
            question="A square pyramid has a square base with side length \$s = $s\$ and height \$h = $h\$. A sphere is inscribed in the pyramid so that it touches all five faces. Prove that the ratio of the sphere's volume to the pyramid's volume equals \$\\frac{3r}{h}\$, where \$r\$ is the inradius. Find \$r\$ in simplest radical form.",
            answer="\\frac{$s $h}{$(s^2 + 4*h^2)}",
            difficulty=(3800, 4200),
            solution=steps(
                "The volume of the pyramid is \$V_{pyr} = \\frac{1}{3}s^2 h = \\frac{1}{3} \\cdot $(s^2) \\cdot $h = \\frac{$(s^2 * h)}{3}\$",
                "For an inscribed sphere touching all faces, use the formula \$V_{pyr} = \\frac{1}{3} \\cdot A_{surface} \\cdot r\$",
                "Surface area: base \$s^2 = $(s^2)\$ plus 4 triangular faces each with area \$\\frac{1}{2}s\\ell\$ where \$\\ell = \\sqrt{h^2 + (s/2)^2}\$",
                "Slant height: \$\\ell = \\sqrt{$(h^2) + $(s^2/4)} = \\sqrt{$((4*h^2 + s^2)/4)}\$",
                "Solving \$\\frac{1}{3}(s^2 + 2s\\ell) r = \\frac{1}{3}s^2 h\$ gives \$r = \\frac{s h}{s + 2\\ell}\$",
                sol("Answer", "\\frac{$s $h}{$(s^2 + 4*h^2)}")
            ),
            image=render(d),
            time=360
        )
        
    elseif problem_type == :rotating_region_constraint
        # Region bounded by curves rotated around axis
        # Find volume with olympiad-level constraint
        
        a = randint(3, 8)
        b = randint(2, 6)
        
        d = DiagramObj(450, 400)
        g = GraphObj(d, -1, a+1, -1, (a^2 + 2), 50, 50, 350, 300)
        plot!(g, x -> x^2, -1, a+0.5, :blue)
        plot!(g, x -> a^2, -1, a+0.5, :red)
        fill_between!(g, x -> x^2, x -> a^2, 0, a, (100, 200, 255, 100))
        text!(d, 300, 80, "y = x²", 12, :blue)
        text!(d, 300, 100, "y = $a²", 12, :red)
        
        # Volume = π∫[0 to a] (a² - x²)² dx rotated around x-axis
        # But using shell method around y-axis gives different problem
        
        vol_expr = "\\frac{$(a^5)\\pi}{2}"
        
        problem(
            question="Find the volume of the solid obtained by rotating the region bounded by \$y = x^2\$, \$y = $(a^2)\$, and \$x = 0\$ around the \$y\$-axis. Express your answer as a rational multiple of \$\\pi\$.",
            answer=vol_expr,
            difficulty=(3500, 3800),
            solution=steps(
                "Using the shell method: \$V = 2\\pi \\int_0^{$a} x($(a^2) - x^2)\\,dx\$",
                "Expanding: \$V = 2\\pi \\int_0^{$a} ($(a^2)x - x^3)\\,dx\$",
                "Integrating: \$V = 2\\pi\\left[\\frac{$(a^2)x^2}{2} - \\frac{x^4}{4}\\right]_0^{$a}\$",
                "Evaluating: \$V = 2\\pi\\left(\\frac{$(a^4)}{2} - \\frac{$(a^4)}{4}\\right) = 2\\pi \\cdot \\frac{$(a^4)}{4} = \\frac{$(a^4)\\pi}{2}\$",
                sol("Answer", vol_expr)
            ),
            image=render(d),
            time=300
        )
        
    elseif problem_type == :polyhedron_extremal
        # Extremal volume problem for inscribed polyhedron
        
        R = randint(6, 15)
        n = choice([6, 8, 12])
        
        d = DiagramObj(400, 400)
        circle!(d, 200, 200, 120, :none, :black, 2)
        
        if n == 6
            # Regular octahedron
            for i in 1:6
                angle = (i-1) * 60
                x1 = 200 + 100 * cosd(angle)
                y1 = 200 + 100 * sind(angle)
                x2 = 200 + 100 * cosd(angle + 60)
                y2 = 200 + 100 * sind(angle + 60)
                line!(d, x1, y1, x2, y2, :blue, 2)
            end
            polyhedron_name = "regular octahedron"
            answer = "\\frac{$(4*R^3)\\sqrt{2}}{3}"
        elseif n == 8
            polyhedron_name = "cube"
            answer = "\\frac{$(8*R^3)\\sqrt{3}}{9}"
        else
            polyhedron_name = "icosahedron"
            answer = "\\frac{$(5*R^3)(3+\\sqrt{5})}{12}"
        end
        
        text!(d, 200, 350, "R = $R", 14, :black)
        
        problem(
            question="A sphere of radius \$R = $R\$ circumscribes a $polyhedron_name. Find the exact volume of the polyhedron in simplest radical form.",
            answer=answer,
            difficulty=(3700, 4100),
            solution=steps(
                "For a $polyhedron_name inscribed in a sphere of radius \$R = $R\$:",
                "The vertices lie on the sphere, and we use the known relationship between \$R\$ and edge length \$a\$",
                "For this polyhedron, the volume formula in terms of \$R\$ involves computing vertex positions",
                "Using symmetry and geometric relationships specific to the $polyhedron_name",
                sol("Answer", answer)
            ),
            image=render(d),
            time=360
        )
        
    else # :optimization_solid
        # Optimization: maximize volume of inscribed solid
        
        R = randint(8, 18)
        
        d = DiagramObj(400, 400)
        circle!(d, 200, 200, 100, :none, :black, 2)
        # Draw inscribed cylinder
        polygon!(d, [150, 250, 250, 150], [150, 150, 280, 280], :lightblue, :blue, 2)
        line!(d, 150, 150, 250, 150, :blue, 2)
        point!(d, 200, 200, :red, 5, "O")
        text!(d, 320, 210, "R = $R", 14, :black)
        
        # Maximum volume of cylinder inscribed in sphere: h = 2R/√3, r = R√(2/3)
        # V = πr²h = π(2R²/3)(2R/√3) = 4πR³/(3√3) = 4πR³√3/9
        
        max_vol_coef = 4 * R^3
        answer = "\\frac{$(max_vol_coef)\\sqrt{3}\\pi}{9}"
        
        problem(
            question="Find the maximum volume of a right circular cylinder that can be inscribed in a sphere of radius \$R = $R\$. Express your answer in the form \$\\frac{k\\sqrt{3}\\pi}{9}\$ where \$k\$ is an integer.",
            answer=answer,
            difficulty=(3600, 3900),
            solution=steps(
                "Let the cylinder have radius \$r\$ and height \$h = 2y\$ where \$y\$ is the distance from center to top base.",
                "By the sphere equation: \$r^2 + y^2 = R^2 = $(R^2)\$, so \$r^2 = $(R^2) - y^2\$",
                "Volume: \$V = \\pi r^2 h = 2\\pi y($(R^2) - y^2)\$",
                "Taking derivative: \$\\frac{dV}{dy} = 2\\pi($(R^2) - 3y^2) = 0\$ gives \$y = \\frac{$R}{\\sqrt{3}}\$",
                "Maximum volume: \$V = 2\\pi \\cdot \\frac{$R}{\\sqrt{3}} \\cdot \\frac{2 \\cdot $(R^2)}{3} = \\frac{4\\pi \\cdot $(R^3)}{3\\sqrt{3}} = \\frac{$(4*R^3)\\sqrt{3}\\pi}{9}\$",
                sol("Answer", answer)
            ),
            image=render(d),
            time=300
        )
    end
end