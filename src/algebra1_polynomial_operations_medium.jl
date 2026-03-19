# algebra1 - polynomial_operations (medium)
# Generated: 2026-03-08T19:59:18.900878

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/polynomial_operations")
    
    problem_type = choice([
        :add_polynomials,
        :subtract_polynomials,
        :multiply_polynomials,
        :multiply_binomial_trinomial,
        :expand_binomial_squared,
        :expand_difference_of_squares,
        :evaluate_polynomial,
        :simplify_polynomial_expression
    ])
    
    if problem_type == :add_polynomials
        p1 = rand_quadratic(x; a=(-8,8), b=(-15,15), c=(-20,20))
        p2 = rand_quadratic(x; a=(-8,8), b=(-15,15), c=(-20,20))
        ans = expand(p1.expr + p2.expr)
        
        problem(
            question="Add the polynomials: \$($(tex(p1.expr))) + ($(tex(p2.expr)))\$",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("First polynomial", p1.expr),
                sol("Second polynomial", p2.expr),
                "Combine like terms: \$($(p1.a)+$(p2.a))x^2 + ($(p1.b)+$(p2.b))x + ($(p1.c)+$(p2.c))\$",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == :subtract_polynomials
        p1 = rand_quadratic(x; a=(-8,8), b=(-15,15), c=(-20,20))
        p2 = rand_quadratic(x; a=(-8,8), b=(-15,15), c=(-20,20))
        ans = expand(p1.expr - p2.expr)
        
        problem(
            question="Subtract the polynomials: \$($(tex(p1.expr))) - ($(tex(p2.expr)))\$",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("First polynomial", p1.expr),
                sol("Second polynomial", p2.expr),
                "Distribute the negative sign and combine like terms",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == :multiply_polynomials
        p1 = rand_linear(x; a=(-8,8), b=(-15,15))
        p2 = rand_linear(x; a=(-8,8), b=(-15,15))
        ans = expand(p1.expr * p2.expr)
        
        problem(
            question="Multiply the polynomials: \$($(tex(p1.expr)))($(tex(p2.expr)))\$",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                sol("First polynomial", p1.expr),
                sol("Second polynomial", p2.expr),
                "Use FOIL or distributive property",
                "First: \$($(p1.a))($(p2.a))x^2 = $(p1.a * p2.a)x^2\$",
                "Outer + Inner: \$($(p1.a))($(p2.b))x + ($(p1.b))($(p2.a))x = $(p1.a*p2.b + p1.b*p2.a)x\$",
                "Last: \$($(p1.b))($(p2.b)) = $(p1.b * p2.b)\$",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == :multiply_binomial_trinomial
        p1 = rand_linear(x; a=(-6,6), b=(-12,12))
        p2 = rand_quadratic(x; a=(-5,5), b=(-10,10), c=(-15,15))
        ans = expand(p1.expr * p2.expr)
        
        problem(
            question="Multiply and simplify: \$($(tex(p1.expr)))($(tex(p2.expr)))\$",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Binomial", p1.expr),
                sol("Trinomial", p2.expr),
                "Distribute each term of the binomial to each term of the trinomial",
                "Combine like terms",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == :expand_binomial_squared
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        binomial = a*x + b
        ans = expand(binomial^2)
        
        problem(
            question="Expand and simplify: \$($(tex(binomial)))^2\$",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Expression", binomial^2),
                "Use the formula \$(ax+b)^2 = a^2x^2 + 2abx + b^2\$",
                "Calculate: \$($(a))^2x^2 + 2($(a))($(b))x + ($(b))^2\$",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == :expand_difference_of_squares
        a = nonzero(-10, 10)
        b = nonzero(-12, 12)
        term1 = a*x + b
        term2 = a*x - b
        ans = expand(term1 * term2)
        
        problem(
            question="Multiply using difference of squares: \$($(tex(term1)))($(tex(term2)))\$",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Expression", term1 * term2),
                "Recognize difference of squares pattern: \$(A+B)(A-B) = A^2 - B^2\$",
                "Here \$A = $(tex(a*x))\$ and \$B = $(abs(b))\$",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == :evaluate_polynomial
        p = rand_quadratic(x; a=(-6,6), b=(-10,10), c=(-15,15))
        val = randint(-5, 5)
        ans = substitute(p.expr, x => val)
        
        problem(
            question="Evaluate the polynomial \$$(tex(p.expr))\$ when \$x = $(val)\$",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Polynomial", p.expr),
                "Substitute \$x = $(val)\$",
                "Calculate: \$$(p.a)($(val))^2 + $(p.b)($(val)) + $(p.c)\$",
                "Simplify: \$$(p.a * val^2) + $(p.b * val) + $(p.c)\$",
                sol("Answer", ans)
            ),
            time=90
        )
        
    else  # :simplify_polynomial_expression
        p1 = rand_quadratic(x; a=(-5,5), b=(-10,10), c=(-12,12))
        p2 = rand_linear(x; a=(-6,6), b=(-10,10))
        p3 = rand_linear(x; a=(-6,6), b=(-10,10))
        
        expr = p1.expr + p2.expr * p3.expr
        ans = expand(expr)
        
        problem(
            question="Simplify the expression: \$$(tex(p1.expr)) + ($(tex(p2.expr)))($(tex(p3.expr)))\$",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Expression", expr),
                "First multiply the binomials: \$($(tex(p2.expr)))($(tex(p3.expr)))\$",
                sol("Product", expand(p2.expr * p3.expr)),
                "Add the result to the first polynomial",
                "Combine all like terms",
                sol("Answer", ans)
            ),
            time=180
        )
    end
end