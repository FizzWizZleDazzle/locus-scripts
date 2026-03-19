# precalculus - vector_operations (competition)
# Generated: 2026-03-08T20:35:29.220239

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("precalculus/vector_operations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Orthogonal projection with complex coefficients
        a1, a2, a3 = nonzero(-15, 15), nonzero(-15, 15), nonzero(-15, 15)
        b1, b2, b3 = nonzero(-12, 12), nonzero(-12, 12), nonzero(-12, 12)
        
        dot_ab = a1*b1 + a2*b2 + a3*b3
        dot_bb = b1^2 + b2^2 + b3^2
        
        proj_coeff = dot_ab // dot_bb
        proj1 = proj_coeff * b1
        proj2 = proj_coeff * b2
        proj3 = proj_coeff * b3
        
        orth1 = a1 - proj1
        orth2 = a2 - proj2
        orth3 = a3 - proj3
        
        ans = fmt_tuple([orth1, orth2, orth3])
        
        problem(
            question="Let \\vec{a} = $(fmt_tuple([a1, a2, a3])) and \\vec{b} = $(fmt_tuple([b1, b2, b3])). Find the component of \\vec{a} orthogonal to \\vec{b}. Express your answer as an ordered triple of rational numbers in lowest terms.",
            answer=ans,
            difficulty=(3500, 3800),
            answer_type="tuple",
            solution=steps(
                "Given: \\vec{a} = $(fmt_tuple([a1, a2, a3])), \\vec{b} = $(fmt_tuple([b1, b2, b3]))",
                sol("\\text{proj}_{\\vec{b}} \\vec{a}", "\\frac{\\vec{a} \\cdot \\vec{b}}{\\vec{b} \\cdot \\vec{b}} \\vec{b}"),
                sol("\\vec{a} \\cdot \\vec{b}", dot_ab),
                sol("\\vec{b} \\cdot \\vec{b}", dot_bb),
                sol("\\text{proj}_{\\vec{b}} \\vec{a}", fmt_tuple([proj1, proj2, proj3])),
                "Orthogonal component: \\vec{a} - \\text{proj}_{\\vec{b}} \\vec{a}",
                sol("\\text{Answer}", ans)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Vector triple product identity
        a1, a2, a3 = nonzero(-10, 10), nonzero(-10, 10), nonzero(-10, 10)
        b1, b2, b3 = nonzero(-10, 10), nonzero(-10, 10), nonzero(-10, 10)
        c1, c2, c3 = nonzero(-10, 10), nonzero(-10, 10), nonzero(-10, 10)
        
        # Compute (a × b) × c using BAC-CAB rule: b(a·c) - a(b·c)
        dot_ac = a1*c1 + a2*c2 + a3*c3
        dot_bc = b1*c1 + b2*c2 + b3*c3
        
        res1 = b1*dot_ac - a1*dot_bc
        res2 = b2*dot_ac - a2*dot_bc
        res3 = b3*dot_ac - a3*dot_bc
        
        ans = fmt_tuple([res1, res2, res3])
        
        problem(
            question="Let \\vec{a} = $(fmt_tuple([a1, a2, a3])), \\vec{b} = $(fmt_tuple([b1, b2, b3])), and \\vec{c} = $(fmt_tuple([c1, c2, c3])). Compute (\\vec{a} \\times \\vec{b}) \\times \\vec{c} using the BAC-CAB identity: (\\vec{a} \\times \\vec{b}) \\times \\vec{c} = \\vec{b}(\\vec{a} \\cdot \\vec{c}) - \\vec{a}(\\vec{b} \\cdot \\vec{c}).",
            answer=ans,
            difficulty=(3800, 4200),
            answer_type="tuple",
            solution=steps(
                "Use BAC-CAB identity: (\\vec{a} \\times \\vec{b}) \\times \\vec{c} = \\vec{b}(\\vec{a} \\cdot \\vec{c}) - \\vec{a}(\\vec{b} \\cdot \\vec{c})",
                sol("\\vec{a} \\cdot \\vec{c}", dot_ac),
                sol("\\vec{b} \\cdot \\vec{c}", dot_bc),
                sol("\\vec{b}(\\vec{a} \\cdot \\vec{c})", fmt_tuple([b1*dot_ac, b2*dot_ac, b3*dot_ac])),
                sol("\\vec{a}(\\vec{b} \\cdot \\vec{c})", fmt_tuple([a1*dot_bc, a2*dot_bc, a3*dot_bc])),
                "Subtract to get final answer",
                sol("\\text{Answer}", ans)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Minimize distance from point to parametric line
        p1, p2, p3 = randint(-20, 20), randint(-20, 20), randint(-20, 20)
        l1, l2, l3 = randint(-15, 15), randint(-15, 15), randint(-15, 15)
        d1, d2, d3 = nonzero(-8, 8), nonzero(-8, 8), nonzero(-8, 8)
        
        # Point P, line L(t) = L0 + t*d
        # Minimize |P - L(t)|^2, derivative gives: (P - L0)·d = t(d·d)
        diff1, diff2, diff3 = p1 - l1, p2 - l2, p3 - l3
        dot_pd = diff1*d1 + diff2*d2 + diff3*d3
        dot_dd = d1^2 + d2^2 + d3^2
        
        t_min = dot_pd // dot_dd
        
        closest1 = l1 + t_min * d1
        closest2 = l2 + t_min * d2
        closest3 = l3 + t_min * d3
        
        ans = fmt_tuple([closest1, closest2, closest3])
        
        problem(
            question="Find the point on the line \\vec{r}(t) = $(fmt_tuple([l1, l2, l3])) + t$(fmt_tuple([d1, d2, d3])) that is closest to the point P = $(fmt_tuple([p1, p2, p3])). Express coordinates as rational numbers in lowest terms.",
            answer=ans,
            difficulty=(3600, 4000),
            answer_type="tuple",
            solution=steps(
                "Minimize distance from P to line by finding t where (P - \\vec{r}(t)) \\perp \\vec{d}",
                sol("\\text{Condition}", "(P - \\vec{r}(t)) \\cdot \\vec{d} = 0"),
                "Expand: (P - \\vec{L}_0 - t\\vec{d}) \\cdot \\vec{d} = 0",
                sol("(P - \\vec{L}_0) \\cdot \\vec{d}", dot_pd),
                sol("\\vec{d} \\cdot \\vec{d}", dot_dd),
                sol("t", t_min),
                "Substitute t back into line equation",
                sol("\\text{Closest point}", ans)
            ),
            time=270
        )
        
    elseif problem_type == 4
        # Scalar triple product and volume
        a1, a2, a3 = nonzero(-12, 12), nonzero(-12, 12), nonzero(-12, 12)
        b1, b2, b3 = nonzero(-12, 12), nonzero(-12, 12), nonzero(-12, 12)
        c1, c2, c3 = nonzero(-12, 12), nonzero(-12, 12), nonzero(-12, 12)
        
        # Cross product b × c
        cross1 = b2*c3 - b3*c2
        cross2 = b3*c1 - b1*c3
        cross3 = b1*c2 - b2*c1
        
        # Scalar triple product a · (b × c)
        triple = a1*cross1 + a2*cross2 + a3*cross3
        volume = abs(triple)
        
        problem(
            question="Find the volume of the parallelepiped determined by vectors \\vec{a} = $(fmt_tuple([a1, a2, a3])), \\vec{b} = $(fmt_tuple([b1, b2, b3])), and \\vec{c} = $(fmt_tuple([c1, c2, c3])).",
            answer=volume,
            difficulty=(3700, 4100),
            solution=steps(
                "Volume = |\\vec{a} \\cdot (\\vec{b} \\times \\vec{c})|",
                sol("\\vec{b} \\times \\vec{c}", fmt_tuple([cross1, cross2, cross3])),
                sol("\\vec{a} \\cdot (\\vec{b} \\times \\vec{c})", triple),
                "Take absolute value",
                sol("\\text{Volume}", volume)
            ),
            time=240
        )
        
    else
        # Angle between two planes via normal vectors
        # Plane 1: a1*x + a2*y + a3*z = d1
        # Plane 2: b1*x + b2*y + b3*z = d2
        a1, a2, a3 = nonzero(-15, 15), nonzero(-15, 15), nonzero(-15, 15)
        b1, b2, b3 = nonzero(-15, 15), nonzero(-15, 15), nonzero(-15, 15)
        d1, d2 = randint(-30, 30), randint(-30, 30)
        
        dot_ab = a1*b1 + a2*b2 + a3*b3
        norm_a = sqrt(a1^2 + a2^2 + a3^2)
        norm_b = sqrt(b1^2 + b2^2 + b3^2)
        
        cos_theta = abs(dot_ab) / (norm_a * norm_b)
        
        # Simplify if possible
        num = abs(dot_ab)
        den = norm_a * norm_b
        
        ans_str = "\\arccos\\left(\\frac{$(num)}{$(den)}\\right)"
        
        problem(
            question="Find the acute angle between the planes $(a1)x + $(a2)y + $(a3)z = $(d1) and $(b1)x + $(b2)y + $(b3)z = $(d2). Express your answer as \\arccos\\left(\\frac{p}{q}\\right) where p and q are positive integers with \\gcd(p,q)=1.",
            answer=ans_str,
            difficulty=(4000, 4500),
            answer_type="math",
            solution=steps(
                "Normal vectors: \\vec{n}_1 = $(fmt_tuple([a1, a2, a3])), \\vec{n}_2 = $(fmt_tuple([b1, b2, b3]))",
                sol("\\vec{n}_1 \\cdot \\vec{n}_2", dot_ab),
                sol("|\\vec{n}_1|", norm_a),
                sol("|\\vec{n}_2|", norm_b),
                "Acute angle: \\theta = \\arccos\\left(\\frac{|\\vec{n}_1 \\cdot \\vec{n}_2|}{|\\vec{n}_1||\\vec{n}_2|}\\right)",
                sol("\\theta", ans_str)
            ),
            time=300
        )
    end
end