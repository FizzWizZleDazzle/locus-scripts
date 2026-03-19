# algebra1 - polynomial_operations (easy)
# Generated: 2026-03-08T19:59:02.776162

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/polynomial_operations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Adding two polynomials (ELO 700-900)
        p1 = rand_quadratic(x; a=(-5,5), b=(-8,8), c=(-10,10))
        p2 = rand_quadratic(x; a=(-5,5), b=(-8,8), c=(-10,10))
        result = simplify(p1.expr + p2.expr)
        
        problem(
            question="Add the polynomials: \$($(tex(p1.expr))) + ($(tex(p2.expr)))\$",
            answer=result,
            difficulty=(700, 900),
            solution=steps(
                sol("First polynomial", p1.expr),
                sol("Second polynomial", p2.expr),
                "Combine like terms: coefficients of \$x^2\$, \$x\$, and constants",
                sol("Answer", result)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Subtracting polynomials (ELO 750-950)
        p1 = rand_quadratic(x; a=(-6,6), b=(-10,10), c=(-12,12))
        p2 = rand_quadratic(x; a=(-6,6), b=(-10,10), c=(-12,12))
        result = simplify(p1.expr - p2.expr)
        
        problem(
            question="Subtract the polynomials: \$($(tex(p1.expr))) - ($(tex(p2.expr)))\$",
            answer=result,
            difficulty=(750, 950),
            solution=steps(
                sol("First polynomial", p1.expr),
                sol("Second polynomial", p2.expr),
                "Distribute the negative sign and combine like terms",
                sol("Answer", result)
            ),
            time=100
        )
        
    elseif problem_type == 3
        # Multiplying a polynomial by a monomial (ELO 700-900)
        p = rand_quadratic(x; a=(-4,4), b=(-8,8), c=(-10,10))
        k = nonzero(-6, 6)
        result = expand(k * p.expr)
        
        problem(
            question="Multiply: \$$(k)($(tex(p.expr)))\$",
            answer=result,
            difficulty=(700, 900),
            solution=steps(
                sol("Polynomial", p.expr),
                "Multiply coefficient \$$(k)\$ through each term using distributive property",
                sol("Answer", result)
            ),
            time=80
        )
        
    elseif problem_type == 4
        # Multiplying two binomials (ELO 800-1000)
        l1 = rand_linear(x; a=(-5,5), b=(-8,8))
        l2 = rand_linear(x; a=(-5,5), b=(-8,8))
        result = expand(l1.expr * l2.expr)
        
        problem(
            question="Multiply using FOIL: \$($(tex(l1.expr)))($(tex(l2.expr)))\$",
            answer=result,
            difficulty=(800, 1000),
            solution=steps(
                sol("First binomial", l1.expr),
                sol("Second binomial", l2.expr),
                "Apply FOIL (First, Outer, Inner, Last) method",
                sol("Answer", result)
            ),
            time=100
        )
        
    else
        # Multiplying binomial by trinomial (ELO 900-1200)
        l = rand_linear(x; a=(-4,4), b=(-6,6))
        q = rand_quadratic(x; a=(-3,3), b=(-7,7), c=(-9,9))
        result = expand(l.expr * q.expr)
        
        problem(
            question="Multiply and simplify: \$($(tex(l.expr)))($(tex(q.expr)))\$",
            answer=result,
            difficulty=(900, 1200),
            solution=steps(
                sol("Binomial", l.expr),
                sol("Trinomial", q.expr),
                "Distribute each term of the binomial to each term of the trinomial",
                "Combine like terms",
                sol("Answer", result)
            ),
            time=120
        )
    end
end