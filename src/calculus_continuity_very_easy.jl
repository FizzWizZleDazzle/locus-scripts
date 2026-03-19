# calculus - continuity (very_easy)
# Generated: 2026-03-08T20:37:54.728800

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/continuity")
    
    prob_type = rand(1:5)
    
    if prob_type == 1
        # ELO 150-300: Identify if a simple function is continuous at a point
        funcs = [
            ("x^2", x^2, "polynomial"),
            ("x + 3", x + 3, "linear"),
            ("2x - 5", 2*x - 5, "linear"),
            ("x^3", x^3, "polynomial"),
            ("-x^2 + 1", -x^2 + 1, "polynomial"),
        ]
        func_tex, func_expr, func_type = choice(funcs)
        pt = randint(-5, 5)
        
        problem(
            question="Is the function \\(f(x) = $func_tex\\) continuous at \\(x = $pt\\)?",
            answer="Yes",
            difficulty=(150, 300),
            answer_type="multiple_choice",
            solution=steps(
                "Given: \\(f(x) = $func_tex\\)",
                "This is a $func_type function",
                "Polynomial and linear functions are continuous everywhere",
                sol("Answer", "Yes, the function is continuous at \\(x = $pt\\)")
            ),
            time=45
        )
        
    elseif prob_type == 2
        # ELO 300-500: Evaluate a limit for a continuous function
        q = rand_quadratic(x; a=(-3,3), b=(-8,8), c=(-10,10))
        pt = randint(-6, 6)
        ans = substitute(q.expr, x => pt)
        
        problem(
            question="Find \\(\\lim_{x \\to $pt} $(tex(q.expr))\\)",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", "\\lim_{x \\to $pt} $(tex(q.expr))"),
                "Since this is a polynomial, it is continuous everywhere",
                "For continuous functions, \\(\\lim_{x \\to a} f(x) = f(a)\\)",
                sol("Substitute \\(x = $pt\\)", ans)
            ),
            time=60
        )
        
    elseif prob_type == 3
        # ELO 400-600: State the definition of continuity (recognition)
        conditions = [
            ("\\lim_{x \\to a} f(x) exists", "the limit exists"),
            ("f(a) is defined", "the function is defined at the point"),
            ("\\lim_{x \\to a} f(x) = f(a)", "the limit equals the function value"),
        ]
        correct_cond, desc = choice(conditions)
        
        problem(
            question="Which of the following is one of the three conditions for a function \\(f(x)\\) to be continuous at \\(x = a\\)?",
            answer=correct_cond,
            difficulty=(400, 600),
            answer_type="multiple_choice",
            solution=steps(
                "A function is continuous at \\(x = a\\) if three conditions hold:",
                "1. \\(f(a)\\) is defined",
                "2. \\(\\lim_{x \\to a} f(x)\\) exists",
                "3. \\(\\lim_{x \\to a} f(x) = f(a)\\)",
                sol("Answer", correct_cond)
            ),
            time=60
        )
        
    elseif prob_type == 4
        # ELO 200-400: Identify continuity on an interval
        intervals = [
            ("(-\\infty, \\infty)", "all real numbers", fmt_interval(-Inf, Inf, true, true)),
            ("[0, \\infty)", "non-negative numbers", fmt_interval(0, Inf, false, true)),
            ("(-\\infty, 0]", "non-positive numbers", fmt_interval(-Inf, 0, true, false)),
        ]
        interval_tex, desc, interval_ans = choice(intervals)
        
        lin = rand_linear(x; a=(-5,5), b=(-10,10))
        
        problem(
            question="On what interval is \\(f(x) = $(tex(lin.expr))\\) continuous?",
            answer=interval_ans,
            difficulty=(200, 400),
            answer_type="interval",
            solution=steps(
                sol("Given", "f(x) = $(tex(lin.expr))"),
                "This is a linear function",
                "Linear functions are continuous on all real numbers",
                sol("Answer", fmt_interval(-Inf, Inf, true, true))
            ),
            time=50
        )
        
    else
        # ELO 500-700: Check continuity at a point using the three conditions
        pt = randint(-4, 4)
        b = randint(-8, 8)
        func_val = pt^2 + b
        
        problem(
            question="Consider \\(f(x) = x^2 + $b\\). Verify that \\(f(x)\\) is continuous at \\(x = $pt\\) by checking that \\(f($pt)\\) is defined.",
            answer=func_val,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", "f(x) = x^2 + $b"),
                "Evaluate at \\(x = $pt\\)",
                sol("f($pt)", "($pt)^2 + $b = $(pt^2) + $b = $func_val"),
                "Since \\(f($pt) = $func_val\\) exists, the function is defined at \\(x = $pt\\)"
            ),
            time=75
        )
    end
end