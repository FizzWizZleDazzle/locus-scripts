# differential_equations - characteristic_equation (competition)
# Generated: 2026-03-08T20:54:26.129996

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/characteristic_equation")
    
    # Generate olympiad/research-level characteristic equation problem
    # These problems involve higher-order ODEs with challenging roots
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: Fourth-order with complex conjugate pairs requiring sophisticated analysis
        # Characteristic equation with two pairs of complex conjugates
        α = randint(1, 4)
        β = randint(2, 6)
        γ = randint(1, 3)
        δ = randint(3, 7)
        
        # r^4 + 2αr^3 + (α^2 + β^2 + 2γ)r^2 + 2γαr + γ^2 + δ^2
        # This factors as (r^2 + 2αr + α^2 + β^2)(r^2 + γ^2 + δ^2) but is hard to see
        
        a4 = 1
        a3 = 2α
        a2 = α^2 + β^2 + 2γ
        a1 = 2γ*α
        a0 = γ^2 + δ^2
        
        char_eq = x^4 + a3*x^3 + a2*x^2 + a1*x + a0
        
        # Roots are -α ± βi and ±√(γ^2 + δ^2) i
        r1_real = -α
        r1_imag = β
        r2_real = 0
        r2_imag = sqrt(γ^2 + δ^2)
        
        solution_text = steps(
            sol("Characteristic equation", char_eq ~ 0),
            "Group as \\((r^2 + $(2α)r + $(α^2 + β^2))(r^2 + $(γ^2 + δ^2)) = 0\\)",
            "First quadratic: \\(r^2 + $(2α)r + $(α^2 + β^2) = 0\\) gives \\(r = $(-α) \\pm $(β)i\\)",
            "Second quadratic: \\(r^2 + $(γ^2 + δ^2) = 0\\) gives \\(r = \\pm $(r2_imag)i\\)",
            "General solution: \\(y = e^{$(-α)x}(C_1\\cos($(β)x) + C_2\\sin($(β)x)) + C_3\\cos($(r2_imag)x) + C_4\\sin($(r2_imag)x)\\)"
        )
        
        answer_str = "e^{$(-α)x}(C_1*cos($(β)x) + C_2*sin($(β)x)) + C_3*cos($(r2_imag)x) + C_4*sin($(r2_imag)x)"
        
        problem(
            question = "Solve the differential equation \\(y^{(4)} + $(a3)y''' + $(a2)y'' + $(a1)y' + $(a0)y = 0\\) by finding the general solution using the characteristic equation method.",
            answer = answer_str,
            difficulty = (3500, 3800),
            solution = solution_text,
            time = 480
        )
        
    elseif problem_type == 2
        # Type 2: Fifth-order with mixed real and complex roots
        r1 = randint(-5, -1)
        r2 = randint(2, 6)
        α = randint(1, 3)
        β = randint(2, 5)
        
        # (x - r1)(x - r2)(x^2 + 2αx + α^2 + β^2) expanded
        factor1 = expand((x - r1) * (x - r2))
        factor2 = x^2 + 2α*x + (α^2 + β^2)
        char_eq = expand(factor1 * factor2)
        
        # Extract coefficients
        coeffs = [1]
        for i in 1:4
            push!(coeffs, substitute(diff(char_eq, x, i), x => 0) // factorial(i))
        end
        
        solution_text = steps(
            sol("Characteristic equation", char_eq ~ 0),
            "Factor as \\((r - $(r1))(r - $(r2))(r^2 + $(2α)r + $(α^2 + β^2)) = 0\\)",
            "Real roots: \\(r = $(r1), $(r2)\\)",
            "Complex roots from \\(r^2 + $(2α)r + $(α^2 + β^2) = 0\\): \\(r = $(-α) \\pm $(β)i\\)",
            "General solution: \\(y = C_1 e^{$(r1)x} + C_2 e^{$(r2)x} + e^{$(-α)x}(C_3\\cos($(β)x) + C_4\\sin($(β)x))\\)"
        )
        
        answer_str = "C_1*e^($(r1)x) + C_2*e^($(r2)x) + e^($(-α)x)(C_3*cos($(β)x) + C_4*sin($(β)x))"
        
        problem(
            question = "Find the general solution to \\($(tex(char_eq))y^{(4)} + \\cdots = 0\\) where the characteristic equation is \\($(tex(char_eq)) = 0\\).",
            answer = answer_str,
            difficulty = (3600, 3900),
            solution = solution_text,
            time = 420
        )
        
    elseif problem_type == 3
        # Type 3: Sixth-order with repeated complex roots (most challenging)
        α = randint(1, 3)
        β = randint(2, 5)
        γ = randint(1, 2)
        
        # (x^2 + 2αx + α^2 + β^2)^2 * (x - γ)^2
        base_quad = x^2 + 2α*x + (α^2 + β^2)
        char_eq = expand(base_quad^2 * (x - γ)^2)
        
        solution_text = steps(
            sol("Characteristic equation", char_eq ~ 0),
            "Recognize structure: \\((r^2 + $(2α)r + $(α^2 + β^2))^2(r - $(γ))^2 = 0\\)",
            "Double root \\(r = $(γ)\\) (multiplicity 2)",
            "Complex roots \\(r = $(-α) \\pm $(β)i\\) each with multiplicity 2",
            "General solution: \\(y = (C_1 + C_2 x)e^{$(γ)x} + e^{$(-α)x}[(C_3 + C_4 x)\\cos($(β)x) + (C_5 + C_6 x)\\sin($(β)x)]\\)"
        )
        
        answer_str = "(C_1 + C_2*x)*e^($(γ)x) + e^($(-α)x)*((C_3 + C_4*x)*cos($(β)x) + (C_5 + C_6*x)*sin($(β)x))"
        
        problem(
            question = "Determine the general solution of the sixth-order linear homogeneous ODE with characteristic equation \\($(tex(char_eq)) = 0\\).",
            answer = answer_str,
            difficulty = (3800, 4200),
            solution = solution_text,
            time = 540
        )
        
    else
        # Type 4: Advanced - characteristic equation requiring clever factorization
        # r^6 - 1 = 0 type (roots of unity variant)
        n = choice([3, 4, 5])
        k = randint(2, 4)
        
        # x^(2n) - k^2 = 0
        char_eq = x^(2n) - k^2
        
        root_pairs = []
        for j in 0:(n-1)
            angle = (2j + 1) * π / (2n)
            push!(root_pairs, (k * cos(angle), k * sin(angle)))
        end
        
        solution_text = steps(
            sol("Characteristic equation", char_eq ~ 0),
            "Rewrite as \\((r^{$(n)})^2 = $(k^2)\\), so \\(r^{$(n)} = \\pm $(k)\\)",
            "For \\(r^{$(n)} = $(k)\\): roots are \\($(k)e^{2\\pi i j/$(n)}\\) for \\(j = 0, 1, \\ldots, $(n-1)\\)",
            "For \\(r^{$(n)} = -$(k)\\): roots are \\($(k)e^{i\\pi(2j+1)/$(n)}\\) for \\(j = 0, 1, \\ldots, $(n-1)\\)",
            "Total of $(2n) distinct complex roots requiring careful handling of exponential and trigonometric forms"
        )
        
        answer_str = "General solution involves $(2n) exponential-trigonometric terms"
        
        problem(
            question = "Analyze the characteristic equation \\(r^{$(2n)} - $(k^2) = 0\\) and describe the structure of the general solution to the corresponding ODE \\(y^{($(2n))} - $(k^2)y = 0\\).",
            answer = answer_str,
            difficulty = (4000, 4500),
            solution = solution_text,
            time = 600
        )
    end
end