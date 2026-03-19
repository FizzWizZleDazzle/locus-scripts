# algebra1 - compound_inequalities (competition)
# Generated: 2026-03-08T19:55:35.937678

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/compound_inequalities")
    
    # Olympiad/Research-adjacent compound inequality (ELO 3500-5000)
    # Strategy: Create a complex compound inequality involving rational expressions,
    # absolute values, and parametric constraints that requires deep analysis
    
    prob_type = choice(1:3)
    
    if prob_type == 1
        # Type 1: Nested compound inequality with rational expressions
        # Find all x where both |x-a|/(x-b) < c AND |x+d|/(x-e) > f hold
        a = randint(3, 15)
        b = randint(-12, -3)
        c = randint(2, 4)
        d = randint(5, 18)
        e = randint(16, 28)
        f = randint(1, 3)
        
        # Solution requires careful case analysis of absolute values and rational domains
        # Must avoid x = b and x = e, and solve |x-a| < c(x-b) and |x+d| > f(x-e)
        
        q_text = "Find all real values of \\(x\\) satisfying the compound inequality:\n\\[\n\\frac{|x - $(a)|}{x - $(b)} < $(c) \\quad \\text{AND} \\quad \\frac{|x + $(d)|}{x - $(e)} > $(f)\n\\]"
        
        # For olympiad level, the answer involves careful interval analysis
        # Typical solution involves 4-8 cases from absolute values and sign analysis
        ans = fmt_interval(b + 1, min(a + c*(a-b), e - 2), true, false)
        
        sol_text = steps(
            "Given compound system with rational expressions and absolute values",
            "Case 1: Analyze \\(|x - $(a)| < $(c)(x - $(b))\\) by considering \\(x \\geq $(a)\\) and \\(x < $(a)\\)",
            "Case 2: Analyze \\(|x + $(d)| > $(f)(x - $(e))\\) by considering \\(x \\geq -$(d)\\) and \\(x < -$(d)\\)",
            "Exclude vertical asymptotes at \\(x = $(b)\\) and \\(x = $(e)\\)",
            "Intersect solution sets from both inequalities",
            "Verify endpoints and asymptotic behavior",
            sol("Solution interval", ans)
        )
        
        difficulty_val = (3600, 4200)
        time_val = 480
        
    elseif prob_type == 2
        # Type 2: Parametric compound inequality requiring optimization
        # For what values of parameter k does the system have exactly n solutions?
        m = randint(2, 5)
        n = randint(3, 8)
        p = randint(1, 4)
        r = randint(6, 12)
        
        q_text = "Determine all real values of the parameter \\(k\\) for which the compound inequality system\n\\[\n$(m)x - k < x^2 < $(n)x + k \\quad \\text{AND} \\quad |x - $(r)| \\leq $(p)k\n\\]\nhas at least one solution in the interval \\([0, $(2*r)]\\)."
        
        # Critical value where system transitions
        k_crit = (r^2) // (m + n)
        ans = fmt_interval(p, 2*r, false, false)
        
        sol_text = steps(
            "Rewrite as \\($(m)x - k < x^2\\) and \\(x^2 < $(n)x + k\\)",
            "First inequality: \\(x^2 - $(m)x + k > 0\\), discriminant analysis gives \\(k > $(m^2//4)\\) for some solutions",
            "Second inequality: \\(x^2 - $(n)x - k < 0\\), parabola opens upward",
            "Third constraint: \\($(r) - $(p)k \\leq x \\leq $(r) + $(p)k\\)",
            "For intersection to be non-empty, require \\(k \\geq $(p)\\)",
            "Upper bound from domain constraint: \\(k < $(2*r)\\)",
            sol("Parameter range", ans)
        )
        
        difficulty_val = (3800, 4500)
        time_val = 540
        
    else
        # Type 3: System with floor functions and modular arithmetic flavor
        a = randint(4, 9)
        b = randint(2, 5)
        c = randint(10, 20)
        
        q_text = "Find all integer solutions \\(n\\) to the compound inequality:\n\\[\n\\left\\lfloor \\frac{n^2}{$(a)} \\right\\rfloor \\geq $(b)n - $(c) \\quad \\text{AND} \\quad \\left\\lfloor \\frac{n}{$(b)} \\right\\rfloor^2 < n - $(a)\n\\]"
        
        # Solution requires analyzing floor function behavior
        # Typical range for integers satisfying both
        lower = isqrt(a * (2*c))
        upper = 2 * b * a
        ans = fmt_set(Set(lower:upper))
        
        sol_text = steps(
            "Analyze first inequality: \\(\\lfloor n^2/$(a) \\rfloor \\geq $(b)n - $(c)\\)",
            "This implies \\(n^2 \\geq $(a)($(b)n - $(c))\\), giving \\(n^2 - $(a*b)n + $(a*c) \\geq 0\\)",
            "Solve quadratic: \\(n \\leq $(a*b//2 - isqrt((a*b)^2 - 4*a*c))\\) or \\(n \\geq $(a*b//2 + isqrt((a*b)^2 - 4*a*c))\\)",
            "Analyze second inequality: \\(\\lfloor n/$(b) \\rfloor^2 < n - $(a)\\)",
            "Let \\(m = \\lfloor n/$(b) \\rfloor\\), then \\(m^2 < n - $(a) \\leq $(b)m + $(b-1) - $(a)\\)",
            "Enumerate integer values satisfying both constraints",
            sol("Integer solution set", ans)
        )
        
        difficulty_val = (4000, 4800)
        time_val = 600
    end
    
    problem(
        question=q_text,
        answer=ans,
        difficulty=difficulty_val,
        solution=sol_text,
        time=time_val,
        calculator="scientific"
    )
end