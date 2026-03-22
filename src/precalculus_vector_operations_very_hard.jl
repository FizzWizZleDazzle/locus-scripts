# precalculus - vector_operations (very_hard)
# Generated: 2026-03-08T20:35:38.898864

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/vector_operations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Projection and orthogonality (2500-2800)
        a1, a2, a3 = randint(-8, 8), randint(-8, 8), nonzero(-8, 8)
        b1, b2, b3 = randint(-8, 8), randint(-8, 8), nonzero(-8, 8)
        
        # Ensure vectors are not parallel
        while a1*b2 == a2*b1 && a1*b3 == a3*b1 && a2*b3 == a3*b2
            b1, b2, b3 = randint(-8, 8), randint(-8, 8), nonzero(-8, 8)
        end
        
        dot_ab = a1*b1 + a2*b2 + a3*b3
        dot_bb = b1^2 + b2^2 + b3^2
        
        proj_b1 = dot_ab * b1 // dot_bb
        proj_b2 = dot_ab * b2 // dot_bb
        proj_b3 = dot_ab * b3 // dot_bb
        
        perp1 = a1 - proj_b1
        perp2 = a2 - proj_b2
        perp3 = a3 - proj_b3
        
        ans_squared = perp1^2 + perp2^2 + perp3^2
        
        problem(
            question="Let \\(\\vec{a} = \\langle $(a1), $(a2), $(a3) \\rangle\\) and \\(\\vec{b} = \\langle $(b1), $(b2), $(b3) \\rangle\\). Find the square of the magnitude of the component of \\(\\vec{a}\\) that is orthogonal to \\(\\vec{b}\\). Express your answer as a simplified fraction.",
            answer=ans_squared,
            difficulty=(2500, 2800),
            solution=steps(
                "Find the projection of \\(\\vec{a}\\) onto \\(\\vec{b}\\): \\(\\text{proj}_{\\vec{b}}\\vec{a} = \\frac{\\vec{a} \\cdot \\vec{b}}{\\vec{b} \\cdot \\vec{b}} \\vec{b}\\)",
                "Compute \\(\\vec{a} \\cdot \\vec{b} = $(a1)($(b1)) + $(a2)($(b2)) + $(a3)($(b3)) = $(dot_ab)\\)",
                "Compute \\(\\vec{b} \\cdot \\vec{b} = $(b1)^2 + $(b2)^2 + $(b3)^2 = $(dot_bb)\\)",
                "So \\(\\text{proj}_{\\vec{b}}\\vec{a} = \\frac{$(dot_ab)}{$(dot_bb)} \\langle $(b1), $(b2), $(b3) \\rangle = \\langle $(proj_b1), $(proj_b2), $(proj_b3) \\rangle\\)",
                "The orthogonal component is \\(\\vec{a} - \\text{proj}_{\\vec{b}}\\vec{a} = \\langle $(perp1), $(perp2), $(perp3) \\rangle\\)",
                "The square of its magnitude is \\(($(perp1))^2 + ($(perp2))^2 + ($(perp3))^2 = $(ans_squared)\\)"
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Vector equation with parameter (2600-3000)
        a1, a2 = nonzero(-10, 10), nonzero(-10, 10)
        b1, b2 = randint(-10, 10), randint(-10, 10)
        c1, c2 = randint(-10, 10), randint(-10, 10)

        # Ensure b and c are not parallel (and not zero vectors)
        while b1*c2 == b2*c1
            b1, b2 = randint(-10, 10), randint(-10, 10)
            c1, c2 = randint(-10, 10), randint(-10, 10)
        end
        
        # We want |sa + tb| = |sa + tc| for some specific s, t values
        # This means (sa+tb)·(sa+tb) = (sa+tc)·(sa+tc)
        # s²|a|² + 2st(a·b) + t²|b|² = s²|a|² + 2st(a·c) + t²|c|²
        # 2st(a·b) + t²|b|² = 2st(a·c) + t²|c|²
        # 2s(a·b - a·c) = t(|c|² - |b|²)
        
        dot_ab = a1*b1 + a2*b2
        dot_ac = a1*c1 + a2*c2
        mag_b_sq = b1^2 + b2^2
        mag_c_sq = c1^2 + c2^2
        
        if 2*(dot_ab - dot_ac) != 0
            s_over_t = (mag_c_sq - mag_b_sq) // (2*(dot_ab - dot_ac))
            
            problem(
                question="Let \\(\\vec{a} = \\langle $(a1), $(a2) \\rangle\\), \\(\\vec{b} = \\langle $(b1), $(b2) \\rangle\\), and \\(\\vec{c} = \\langle $(c1), $(c2) \\rangle\\). Find the value of \\(\\frac{s}{t}\\) such that \\(\\|s\\vec{a} + t\\vec{b}\\| = \\|s\\vec{a} + t\\vec{c}\\|\\) for all such \\(s\\) and \\(t\\) satisfying this ratio. Express your answer as a simplified fraction.",
                answer=s_over_t,
                difficulty=(2600, 3000),
                solution=steps(
                    "Since \\(\\|s\\vec{a} + t\\vec{b}\\| = \\|s\\vec{a} + t\\vec{c}\\|\\), we have \\(\\|s\\vec{a} + t\\vec{b}\\|^2 = \\|s\\vec{a} + t\\vec{c}\\|^2\\)",
                    "Expand: \\(s^2\\|\\vec{a}\\|^2 + 2st(\\vec{a} \\cdot \\vec{b}) + t^2\\|\\vec{b}\\|^2 = s^2\\|\\vec{a}\\|^2 + 2st(\\vec{a} \\cdot \\vec{c}) + t^2\\|\\vec{c}\\|^2\\)",
                    "Simplify: \\(2st(\\vec{a} \\cdot \\vec{b}) + t^2\\|\\vec{b}\\|^2 = 2st(\\vec{a} \\cdot \\vec{c}) + t^2\\|\\vec{c}\\|^2\\)",
                    "Compute \\(\\vec{a} \\cdot \\vec{b} = $(dot_ab)\\), \\(\\vec{a} \\cdot \\vec{c} = $(dot_ac)\\), \\(\\|\\vec{b}\\|^2 = $(mag_b_sq)\\), \\(\\|\\vec{c}\\|^2 = $(mag_c_sq)\\)",
                    "Substitute: \\(2st($(dot_ab)) + t^2($(mag_b_sq)) = 2st($(dot_ac)) + t^2($(mag_c_sq))\\)",
                    "Rearrange: \\(2st($(dot_ab - dot_ac)) = t^2($(mag_c_sq - mag_b_sq))\\)",
                    "Solve: \\(\\frac{s}{t} = \\frac{$(mag_c_sq - mag_b_sq)}{$(2*(dot_ab - dot_ac))} = $(s_over_t)\\)"
                ),
                time=300
            )
        else
            # Fallback to simpler problem
            k = nonzero(-5, 5)
            d1, d2 = randint(-8, 8), randint(-8, 8)
            
            ans1 = k*a1 + d1
            ans2 = k*a2 + d2
            
            problem(
                question="If \\(\\vec{v} = $(k)\\langle $(a1), $(a2) \\rangle + \\langle $(d1), $(d2) \\rangle\\), find the sum of the components of \\(\\vec{v}\\).",
                answer=ans1 + ans2,
                difficulty=(2400, 2600),
                solution=steps(
                    "Compute \\(\\vec{v} = \\langle $(k*a1), $(k*a2) \\rangle + \\langle $(d1), $(d2) \\rangle\\)",
                    "Add components: \\(\\vec{v} = \\langle $(ans1), $(ans2) \\rangle\\)",
                    "Sum of components: \\($(ans1) + $(ans2) = $(ans1 + ans2)\\)"
                ),
                time=180
            )
        end
        
    elseif problem_type == 3
        # Geometric interpretation - angle between vectors (2700-3200)
        # Find angle θ such that certain condition holds
        u1, u2 = nonzero(-6, 6), nonzero(-6, 6)
        v1, v2 = nonzero(-6, 6), nonzero(-6, 6)

        dot_uv = u1*v1 + u2*v2
        while dot_uv == 0
            v1, v2 = nonzero(-6, 6), nonzero(-6, 6)
            dot_uv = u1*v1 + u2*v2
        end

        # Construct problem: find when u·v equals some multiple of magnitudes
        k = randint(2, 4)
        target = k * dot_uv
        
        problem(
            question="Let \\(\\vec{u} = \\langle $(u1), $(u2) \\rangle\\) and \\(\\vec{v} = \\langle $(v1), $(v2) \\rangle\\). A vector \\(\\vec{w}\\) satisfies \\(\\vec{w} \\cdot \\vec{u} = $(target)\\) and \\(\\vec{w}\\) is parallel to \\(\\vec{v}\\). If \\(\\vec{w} = \\lambda \\vec{v}\\) for some scalar \\(\\lambda\\), find \\(\\lambda\\). Express as a simplified fraction.",
            answer=target // dot_uv,
            difficulty=(2700, 3200),
            solution=steps(
                "Since \\(\\vec{w}\\) is parallel to \\(\\vec{v}\\), we can write \\(\\vec{w} = \\lambda \\vec{v} = \\lambda \\langle $(v1), $(v2) \\rangle\\)",
                "Then \\(\\vec{w} \\cdot \\vec{u} = \\lambda (\\vec{v} \\cdot \\vec{u})\\)",
                "Compute \\(\\vec{v} \\cdot \\vec{u} = $(v1)($(u1)) + $(v2)($(u2)) = $(dot_uv)\\)",
                "We need \\(\\lambda ($(dot_uv)) = $(target)\\)",
                "Therefore \\(\\lambda = \\frac{$(target)}{$(dot_uv)} = $(target // dot_uv)\\)"
            ),
            time=240
        )
        
    elseif problem_type == 4
        # Triple scalar product and volume (3000-3400)
        a = [randint(-5, 5), randint(-5, 5), nonzero(-5, 5)]
        b = [randint(-5, 5), randint(-5, 5), nonzero(-5, 5)]
        c = [randint(-5, 5), randint(-5, 5), nonzero(-5, 5)]
        
        # Compute cross product b × c
        cross_bc = [
            b[2]*c[3] - b[3]*c[2],
            b[3]*c[1] - b[1]*c[3],
            b[1]*c[2] - b[2]*c[1]
        ]
        
        # Triple scalar product a · (b × c)
        triple_product = a[1]*cross_bc[1] + a[2]*cross_bc[2] + a[3]*cross_bc[3]
        volume = abs(triple_product)
        
        problem(
            question="Find the volume of the parallelepiped determined by vectors \\(\\vec{a} = \\langle $(a[1]), $(a[2]), $(a[3]) \\rangle\\), \\(\\vec{b} = \\langle $(b[1]), $(b[2]), $(b[3]) \\rangle\\), and \\(\\vec{c} = \\langle $(c[1]), $(c[2]), $(c[3]) \\rangle\\).",
            answer=volume,
            difficulty=(3000, 3400),
            solution=steps(
                "Volume = \\(|\\vec{a} \\cdot (\\vec{b} \\times \\vec{c})|\\)",
                "Compute \\(\\vec{b} \\times \\vec{c} = \\langle $(cross_bc[1]), $(cross_bc[2]), $(cross_bc[3]) \\rangle\\)",
                "Using the determinant formula for cross product",
                "Then \\(\\vec{a} \\cdot (\\vec{b} \\times \\vec{c}) = $(a[1])($(cross_bc[1])) + $(a[2])($(cross_bc[2])) + $(a[3])($(cross_bc[3])) = $(triple_product)\\)",
                "Volume = \\(|$(triple_product)| = $(volume)\\)"
            ),
            time=300
        )
        
    else
        # Vector inequality optimization (3200-3500)
        # Find max/min of expression involving vectors
        # Use Pythagorean pairs so |q| is an integer
        pythagorean_pairs = [(3,4), (4,3), (5,12), (12,5), (6,8), (8,6)]
        pair = choice(pythagorean_pairs)
        q1 = choice([-1, 1]) * pair[1]
        q2 = choice([-1, 1]) * pair[2]
        mag_q = isqrt(q1^2 + q2^2)

        p1, p2 = randint(-8, 8), randint(-8, 8)
        t_val = randint(3, 10)
        dot_pq = p1*q1 + p2*q2

        ans = dot_pq + t_val * mag_q

        problem(
            question="Let \\(\\vec{p} = \\langle $(p1), $(p2) \\rangle\\) and \\(\\vec{q} = \\langle $(q1), $(q2) \\rangle\\). Find the maximum value of \\((\\vec{p} + $(t_val)\\vec{v}) \\cdot \\vec{q}\\) where \\(\\vec{v}\\) is a unit vector.",
            answer=ans,
            difficulty=(3200, 3500),
            solution=steps(
                "The maximum occurs when \\(\\vec{v}\\) is parallel to \\(\\vec{q}\\)",
                "\\(\\vec{p} \\cdot \\vec{q} = $(dot_pq)\\), \\(|\\vec{q}| = $(mag_q)\\)",
                "Maximum = \\(\\vec{p} \\cdot \\vec{q} + $(t_val)|\\vec{q}| = $(dot_pq) + $(t_val) \\cdot $(mag_q) = $(ans)\\)"
            ),
            time=240
        )
    end
end
