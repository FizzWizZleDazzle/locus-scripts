# precalculus - transformations (competition)
# Generated: 2026-03-08T20:26:43.486118

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z t begin
    set_topic!("precalculus/transformations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad: Functional equation with transformation composition
        a = nonzero(-3, 3)
        b = nonzero(-5, 5)
        c = nonzero(-3, 3)
        d = nonzero(-5, 5)
        
        # f(x) = ax + b, g(x) = cx + d
        # Find all x such that f(g(f(x))) = g(f(g(x)))
        
        # f(g(f(x))) = a(c(ax+b)+d)+b = a²cx + abc + ad + b
        # g(f(g(x))) = c(a(cx+d)+b)+d = ac²x + acd + bc + d
        
        # a²c = ac² => ac(a-c) = 0
        # Since a,c nonzero: a = c
        
        # If a = c: abc + ad + b = acd + bc + d
        # ab² + ad + b = a²d + ab + d
        # ab² - ab + ad - a²d + b - d = 0
        # ab(b-1) + ad(1-a) + (b-d) = 0
        
        lhs_coeff = a^2 * c
        lhs_const = a*b*c + a*d + b
        rhs_coeff = a * c^2
        rhs_const = a*c*d + b*c + d
        
        if a == c
            if lhs_const == rhs_const
                answer = fmt_interval(-Inf, Inf, true, true)
                sol_text = "All real numbers satisfy the equation"
            else
                answer = fmt_set(Set([]))
                sol_text = "No solution exists"
            end
        else
            x_val = (rhs_const - lhs_const) // (lhs_coeff - rhs_coeff)
            answer = x_val
            sol_text = "Unique solution"
        end
        
        problem(
            question="Let \\(f(x) = $(a)x + $(b)\\) and \\(g(x) = $(c)x + $(d)\\). Find all real numbers \\(x\\) such that \\(f(g(f(x))) = g(f(g(x)))\\).",
            answer=answer,
            difficulty=(3500, 3800),
            solution=steps(
                "Compute \\(f(g(f(x)))\\): First \\(f(x) = $(a)x + $(b)\\), then \\(g(f(x)) = $(c)($(a)x + $(b)) + $(d) = $(a*c)x + $(b*c + d)\\), finally \\(f(g(f(x))) = $(a)($(a*c)x + $(b*c + d)) + $(b) = $(lhs_coeff)x + $(lhs_const)\\)",
                "Compute \\(g(f(g(x)))\\): First \\(g(x) = $(c)x + $(d)\\), then \\(f(g(x)) = $(a)($(c)x + $(d)) + $(b) = $(a*c)x + $(a*d + b)\\), finally \\(g(f(g(x))) = $(c)($(a*c)x + $(a*d + b)) + $(d) = $(rhs_coeff)x + $(rhs_const)\\)",
                "Set equal: \\($(lhs_coeff)x + $(lhs_const) = $(rhs_coeff)x + $(rhs_const)\\)",
                "$(sol_text)",
                sol("Answer", answer)
            ),
            time=300,
        )
        
    elseif problem_type == 2
        # Olympiad: Invariant point under composition of transformations
        a = nonzero(-4, 4)
        b = randint(-8, 8)
        k = nonzero(2, 5)
        
        # f(x) = kx, g(x) = ax + b
        # Find fixed point of f∘g∘f: f(g(f(x))) = x
        # f(g(f(x))) = f(g(kx)) = f(akx + b) = k(akx + b) = ak²x + kb
        # ak²x + kb = x => x(ak² - 1) = -kb => x = -kb/(ak² - 1)
        
        if a * k^2 == 1
            answer = fmt_set(Set([]))
            denom = 0
        else
            denom = a * k^2 - 1
            x_fixed = (-k * b) // denom
            answer = x_fixed
        end
        
        problem(
            question="Let \\(f(x) = $(k)x\\) and \\(g(x) = $(a)x + $(b)\\). Find all fixed points of the composition \\(f \\circ g \\circ f\\), i.e., all \\(x\\) such that \\((f \\circ g \\circ f)(x) = x\\).",
            answer=answer,
            difficulty=(3600, 3900),
            solution=steps(
                sol("Compute composition", "f(g(f(x))) = f(g($(k)x)) = f($(a) \\cdot $(k)x + $(b)) = $(k)($(a*k)x + $(b)) = $(a*k^2)x + $(k*b)"),
                "Set equal to \\(x\\): \\($(a*k^2)x + $(k*b) = x\\)",
                "Rearrange: \\($(a*k^2 - 1)x = $(-(k*b))\\)",
                denom == 0 ? "No solution (contradiction)" : sol("Solve for x", x_fixed),
                sol("Answer", answer)
            ),
            time=280,
        )
        
    elseif problem_type == 3
        # Research-adjacent: Transformation group theory
        n = rand(3:5)
        
        # Rotation by 2π/n about origin
        # R^n = identity, find order of composition with reflection
        
        problem(
            question="Consider the transformation \\(R\\) that rotates the plane by \\(\\frac{2\\pi}{$(n)}\\) counterclockwise about the origin, and \\(S\\) that reflects across the \\(x\\)-axis. What is the smallest positive integer \\(k\\) such that \\((R \\circ S)^k\\) is the identity transformation?",
            answer=2n,
            difficulty=(4200, 4600),
            solution=steps(
                "\\(R\\) has order \\($(n)\\) (rotation by \\(\\frac{2\\pi}{$(n)}\\) applied \\($(n)\\) times gives full rotation)",
                "\\(S\\) has order 2 (reflection applied twice is identity)",
                "\\(R \\circ S\\) is a glide reflection. For dihedral group \\(D_{$(n)}\\), the product of rotation and reflection has order \\(2n\\)",
                "Verify: \\((R \\circ S)^{2n} = R^{2n} \\circ (S \\circ R)^{n-1} \\circ S = I\\) using group relations",
                sol("Answer", 2n)
            ),
            time=300,
        )
        
    elseif problem_type == 4
        # Olympiad: Conjugacy and similarity
        a = nonzero(-3, 3)
        b = nonzero(-5, 5)
        c = nonzero(-3, 3)
        
        # T(x) = ax + b, S(x) = cx
        # Find h such that T∘h∘S = h
        # T(h(S(x))) = h(x)
        # Let h(x) = mx + n
        # T(h(cx)) = T(mcx + n) = a(mcx + n) + b = amcx + an + b
        # h(x) = mx + n
        # amcx + an + b = mx + n
        # amc = m => m(ac - 1) = 0
        # an + b = n => n(a - 1) = -b
        
        if a == 1 && b != 0
            answer = "No solution"
        elseif a * c == 1
            if a == 1
                answer = "Infinitely many solutions"
            else
                n_val = (-b) // (a - 1)
                answer = "h(x) = $(n_val)"
            end
        else
            n_val = (-b) // (a - 1)
            answer = "h(x) = $(n_val)"
        end
        
        target_n = (a != 1) ? ((-b) // (a - 1)) : 0
        
        problem(
            question="Find all linear functions \\(h(x) = mx + n\\) such that \\(T(h(S(x))) = h(x)\\), where \\(T(x) = $(a)x + $(b)\\) and \\(S(x) = $(c)x\\).",
            answer=answer,
            difficulty=(3800, 4100),
            solution=steps(
                "Let \\(h(x) = mx + n\\). Compute \\(T(h(S(x))) = T(h($(c)x)) = T($(c)mx + n) = $(a)($(c)mx + n) + $(b) = $(a*c)mx + $(a)n + $(b)\\)",
                "Set equal to \\(h(x) = mx + n\\): \\($(a*c)mx + $(a)n + $(b) = mx + n\\)",
                "Match coefficients: \\($(a*c)m = m\\) and \\($(a)n + $(b) = n\\)",
                "From first: \\(m($(a*c) - 1) = 0\\), so \\(m = 0\\) or \\($(a*c) = 1\\)",
                "From second: \\(n($(a) - 1) = $(-(b))\\)" * (a != 1 ? ", so \\(n = $(target_n)\\)" : ""),
                sol("Answer", answer)
            ),
            time=300,
        )
        
    else
        # Research-adjacent: Transformation commutator
        p = nonzero(2, 4)
        q = nonzero(2, 4)
        
        # f(x) = x^p, g(x) = qx
        # [f,g] = f∘g∘f⁻¹∘g⁻¹
        # Find fixed points
        
        problem(
            question="Let \\(f(x) = x^{$(p)}\\) (defined for \\(x > 0\\)) and \\(g(x) = $(q)x\\). The commutator is defined as \\([f,g](x) = f(g(f^{-1}(g^{-1}(x))))\\). Find the unique positive fixed point of \\([f,g]\\), i.e., solve \\([f,g](x) = x\\).",
            answer=1,
            difficulty=(4500, 4900),
            solution=steps(
                "\\(g^{-1}(x) = \\frac{x}{$(q)}\\), \\(f^{-1}(x) = x^{1/$(p)}\\)",
                "\\(f(g(f^{-1}(g^{-1}(x)))) = f(g(f^{-1}(\\frac{x}{$(q)}))) = f(g((\\frac{x}{$(q)})^{1/$(p)}))\\)",
                "\\(= f($(q) \\cdot (\\frac{x}{$(q)})^{1/$(p)}) = ($(q) \\cdot (\\frac{x}{$(q)})^{1/$(p)})^{$(p)} = $(q)^{$(p)} \\cdot \\frac{x}{$(q)}\\)",
                "Set equal to \\(x\\): \\($(q)^{$(p)} \\cdot \\frac{x}{$(q)} = x\\), so \\($(q)^{$(p-1)} x = x\\)",
                "For \\(x > 0\\): \\(x = 1\\) when \\($(q)^{$(p-1)} \\neq 1\\), or all \\(x\\) if \\($(q) = 1\\)",
                sol("Answer", 1)
            ),
            time=300,
        )
    end
end