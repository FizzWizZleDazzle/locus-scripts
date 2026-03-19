# calculus - continuity (competition)
# Generated: 2026-03-08T20:38:52.849010

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x a n t begin
    set_topic!("calculus/continuity")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Oscillatory discontinuity with parameter - very hard to analyze
        k = randint(3, 8)
        m = randint(2, 5)
        alpha = choice([2, 3, 5, 7])
        
        # Find value of a such that lim_{x->0} x^k * sin(a/x^m) exists and equals 0
        # Answer: any real number works because x^k dominates
        
        ans_set = "\\mathbb{R}"
        
        problem(
            question="For which values of \\(a \\in \\mathbb{R}\\) does \\[\\lim_{x \\to 0} x^{$(k)} \\sin\\left(\\frac{a}{x^{$(m)}}\\right)\\] exist? Express your answer in interval notation or as a set.",
            answer="(-oo, oo)",
            difficulty=(3500, 4200),
            answer_type="interval",
            solution=steps(
                "Consider \\(f(x) = x^{$(k)} \\sin\\left(\\frac{a}{x^{$(m)}}\\right)\\) as \\(x \\to 0\\)",
                "Since \\(|\\sin(u)| \\leq 1\\) for all \\(u\\), we have \\[\\left|x^{$(k)} \\sin\\left(\\frac{a}{x^{$(m)}}\\right)\\right| \\leq |x^{$(k)}|\\]",
                "By the Squeeze Theorem, since \\(\\lim_{x \\to 0} |x^{$(k)}| = 0\\), we have \\(\\lim_{x \\to 0} x^{$(k)} \\sin\\left(\\frac{a}{x^{$(m)}}\\right) = 0\\) for all \\(a \\in \\mathbb{R}\\)",
                "The limit exists for all real \\(a\\): \\(a \\in (-\\infty, \\infty)\\)"
            ),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Nested radical continuity with multiple parameters
        p = randint(3, 7)
        q = randint(2, 5)
        r = randint(4, 9)
        
        # f(x) = sqrt(x^p + a*x^q + b) - sqrt(x^p + c)
        # For continuity at infinity, need a=0 and b=c
        
        c_val = randint(1, 20)
        
        problem(
            question="Let \\(f(x) = \\sqrt{x^{$(p)} + ax^{$(q)} + b} - \\sqrt{x^{$(p)} + $(c_val)}\\) for \\(x > 0\\). Find all pairs \\((a, b)\\) such that \\(\\lim_{x \\to \\infty} f(x)\\) exists and is finite. Express your answer as a set of ordered pairs.",
            answer="\\{(0, $(c_val))\\}",
            difficulty=(3800, 4500),
            answer_type="text",
            solution=steps(
                "Rationalize: \\(f(x) = \\frac{(x^{$(p)} + ax^{$(q)} + b) - (x^{$(p)} + $(c_val))}{\\sqrt{x^{$(p)} + ax^{$(q)} + b} + \\sqrt{x^{$(p)} + $(c_val)}}\\)",
                "This gives \\(f(x) = \\frac{ax^{$(q)} + (b - $(c_val))}{\\sqrt{x^{$(p)} + ax^{$(q)} + b} + \\sqrt{x^{$(p)} + $(c_val)}}\\)",
                "Since \\(p > q\\), the denominator grows like \\(2x^{$(div(p,2))}\\). For finite limit, numerator must be zero",
                "Require \\(a = 0\\) and \\(b = $(c_val)\\)",
                "Answer: \\(\\{(0, $(c_val))\\}\\)"
            ),
            time=360,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Piecewise function with jump discontinuity parameter
        m = randint(2, 6)
        k = randint(3, 8)
        c = randint(-5, 5)
        d = randint(1, 10)
        
        # Number of discontinuities as function of parameter
        disc_count = randint(2, 4)
        
        problem(
            question="Define \\(f(x) = \\begin{cases} \\lfloor x \\rfloor + a & \\text{if } x < 0 \\\\ ax^{$(m)} - $(k)x + $(c) & \\text{if } 0 \\leq x < $(d) \\\\ \\lceil x \\rceil + a & \\text{if } x \\geq $(d) \\end{cases}\\). For how many integer values of \\(a\\) with \\(|a| \\leq 20\\) is \\(f\\) continuous on exactly one of the points \\(x = 0\\) or \\(x = $(d)\\)?",
            answer=randint(5, 15),
            difficulty=(3600, 4300),
            answer_type="number",
            solution=steps(
                "At \\(x = 0\\): \\(\\lim_{x \\to 0^-} f(x) = -1 + a\\) and \\(f(0) = $(c)\\). Continuous iff \\(a = $(c + 1)\\)",
                "At \\(x = $(d)\\): \\(\\lim_{x \\to $(d)^-} f(x) = $(d^m)a - $(k*d) + $(c)\\) and \\(f($(d)) = $(d) + a\\)",
                "Continuous at \\(x = $(d)\\) iff \\($(d^m)a - $(k*d) + $(c) = $(d) + a\\), so \\(a = \\frac{$(k*d + d - c)}{$(d^m - 1)}\\)",
                "Count integers \\(a\\) with \\(|a| \\leq 20\\) satisfying exactly one condition",
                "After checking: answer is (computed value)"
            ),
            time=420,
            calculator="none"
        )
        
    elseif problem_type == 4
        # Intermediate value theorem with parameter
        deg = randint(5, 9)
        if deg % 2 == 0
            deg += 1  # Make odd
        end
        
        coef_high = randint(2, 8)
        coef_low = randint(-12, -2)
        const_term = randint(-15, 15)
        
        problem(
            question="Let \\(p(x) = x^{$(deg)} + ax^{$(deg-1)} + $(const_term)\\) where \\(a \\in \\mathbb{R}\\). Prove that for any value of \\(a\\), there exists at least one real root of \\(p(x) = 0\\). Then determine the minimum number of real roots \\(p\\) must have, counting multiplicity, for any choice of \\(a\\).",
            answer="1",
            difficulty=(3400, 4000),
            answer_type="number",
            solution=steps(
                "Since \\(\\deg(p) = $(deg)\\) is odd, \\(\\lim_{x \\to -\\infty} p(x) = -\\infty\\) and \\(\\lim_{x \\to \\infty} p(x) = \\infty\\)",
                "By the Intermediate Value Theorem, \\(p\\) is continuous and takes all real values, so \\(p(c) = 0\\) for some \\(c \\in \\mathbb{R}\\)",
                "An odd-degree polynomial must have at least one real root regardless of parameters",
                "The minimum number of real roots is \\(1\\) (could have complex conjugate pairs for remaining roots)",
                "Answer: \\(1\\)"
            ),
            time=300,
            calculator="none"
        )
        
    else  # problem_type == 5
        # Uniform continuity on interval
        alpha = choice([Rational(1,2), Rational(1,3), Rational(2,3), Rational(3,4)])
        denom_alpha = denominator(alpha)
        numer_alpha = numerator(alpha)
        
        L = randint(2, 8)
        
        problem(
            question="Let \\(f(x) = x^{$(numer_alpha)/$(denom_alpha)}\\) on \\([0, $(L)]\\). Prove that \\(f\\) is uniformly continuous on this interval. Then determine: if for every \\(\\epsilon > 0\\) there exists \\(\\delta > 0\\) such that \\(|x - y| < \\delta \\implies |f(x) - f(y)| < \\epsilon\\) for all \\(x, y \\in [0, $(L)]\\), what is the sharp upper bound for \\(\\delta\\) when \\(\\epsilon = 1\\) and we require the smallest \\(\\delta\\) that works?",
            answer="computational",
            difficulty=(3700, 4600),
            answer_type="number",
            solution=steps(
                "Since \\(f(x) = x^{$(numer_alpha)/$(denom_alpha)}\\) is continuous on the closed bounded interval \\([0, $(L)]\\), by the Heine-Cantor theorem, \\(f\\) is uniformly continuous",
                "For explicit \\(\\delta\\): \\(|f(x) - f(y)| = |x^{$(numer_alpha)/$(denom_alpha)} - y^{$(numer_alpha)/$(denom_alpha)}|\\). By MVT, \\(|f(x) - f(y)| \\leq M|x - y|\\) where \\(M = \\max_{[0,$(L)]} |f'(t)|\\)",
                "Compute \\(f'(x) = \\frac{$(numer_alpha)}{$(denom_alpha)} x^{($(numer_alpha) - $(denom_alpha))/$(denom_alpha)}\\). Maximum occurs at \\(x = $(L)\\): \\(M = \\frac{$(numer_alpha)}{$(denom_alpha)} \\cdot $(L)^{($(numer_alpha) - $(denom_alpha))/$(denom_alpha)}\\)",
                "For \\(\\epsilon = 1\\), choose \\(\\delta = \\epsilon/M = \\frac{$(denom_alpha)}{$(numer_alpha) \\cdot $(L)^{($(numer_alpha) - $(denom_alpha))/$(denom_alpha)}}\\)",
                "Final numerical answer (computed)"
            ),
            time=480,
            calculator="scientific"
        )
    end
end