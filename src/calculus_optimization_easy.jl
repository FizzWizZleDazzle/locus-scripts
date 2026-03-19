# calculus - optimization (easy)
# Generated: 2026-03-08T20:42:59.953007

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/optimization")
    
    prob_type = choice([1, 2, 3, 4, 5])
    
    if prob_type == 1
        # Maximum area of rectangle with fixed perimeter
        perimeter = randint(40, 120)
        half_p = perimeter // 2
        max_area = (half_p // 2)^2
        side_length = half_p // 2
        
        problem(
            question="A rectangle has a perimeter of $(perimeter) meters. What is the maximum possible area (in square meters)?",
            answer=max_area,
            difficulty=(700, 900),
            solution=steps(
                "Let width = \$w\$ and length = \$l\$. Perimeter: \$2w + 2l = $(perimeter)\$",
                "So \$l = $(half_p) - w\$. Area: \$A = w \\cdot l = w($(half_p) - w) = $(half_p)w - w^2\$",
                sol("Take derivative", diff(half_p*x - x^2, x)),
                "Set equal to zero: \$$(half_p) - 2w = 0\$, so \$w = $(side_length)\$ and \$l = $(side_length)\$",
                sol("Maximum area", max_area)
            ),
            time=120
        )
        
    elseif prob_type == 2
        # Find critical points of a quadratic
        a = nonzero(-5, -1)  # negative for maximum
        h = randint(-10, 10)
        k = randint(5, 25)
        
        expr = expand(a*(x - h)^2 + k)
        deriv = diff(expr, x)
        
        problem(
            question="Find the critical point of \$f(x) = $(tex(expr))\$",
            answer=h,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", expr),
                sol("Find derivative", deriv),
                "Set \$f'(x) = 0\$: \$$(tex(deriv)) = 0\$",
                "Solve for \$x\$",
                sol("Critical point", h)
            ),
            time=90
        )
        
    elseif prob_type == 3
        # Maximum product of two numbers with fixed sum
        total = randint(30, 80)
        half = total // 2
        max_product = half^2
        
        problem(
            question="Two positive numbers have a sum of $(total). What is their maximum product?",
            answer=max_product,
            difficulty=(800, 1000),
            solution=steps(
                "Let the numbers be \$x\$ and \$$(total) - x\$",
                sol("Product", x*(total - x)),
                "Expand: \$P(x) = $(total)x - x^2\$",
                sol("Take derivative", diff(total*x - x^2, x)),
                "Set equal to zero: \$$(total) - 2x = 0\$, so \$x = $(half)\$",
                "Both numbers equal $(half)",
                sol("Maximum product", max_product)
            ),
            time=120
        )
        
    elseif prob_type == 4
        # Minimize sum of two positive numbers with fixed product
        product = choice([36, 48, 64, 81, 100])
        sqrt_prod = isqrt(product)
        min_sum = 2 * sqrt_prod
        
        problem(
            question="Two positive numbers have a product of $(product). What is the minimum value of their sum?",
            answer=min_sum,
            difficulty=(900, 1100),
            solution=steps(
                "Let the numbers be \$x\$ and \$\\frac{$(product)}{x}\$",
                sol("Sum", x + product/x),
                sol("Take derivative", diff(x + product/x, x)),
                "Set equal to zero: \$1 - \\frac{$(product)}{x^2} = 0\$",
                "Solve: \$x^2 = $(product)\$, so \$x = $(sqrt_prod)\$",
                "Both numbers equal $(sqrt_prod)",
                sol("Minimum sum", min_sum)
            ),
            time=150
        )
        
    else  # prob_type == 5
        # Maximum value of a cubic on an interval
        a = randint(-3, -1)
        b = randint(2, 8)
        c = randint(-15, 15)
        d = randint(-20, 20)
        
        expr = a*x^3 + b*x^2 + c*x + d
        deriv = diff(expr, x)
        
        # Find critical points
        coeffs_deriv = [3*a, 2*b, c]
        discriminant = (2*b)^2 - 4*(3*a)*c
        
        left_bound = randint(-5, 0)
        right_bound = randint(3, 8)
        
        # Evaluate at endpoints
        val_left = substitute(expr, x => left_bound)
        val_right = substitute(expr, x => right_bound)
        max_val = max(val_left, val_right)
        
        problem(
            question="Find the maximum value of \$f(x) = $(tex(expr))\$ on the interval \$[$(left_bound), $(right_bound)]\$",
            answer=max_val,
            difficulty=(1000, 1200),
            solution=steps(
                sol("Given", expr),
                sol("Find derivative", deriv),
                "Find critical points by setting \$f'(x) = 0\$",
                "Evaluate at endpoints: \$f($(left_bound)) = $(val_left)\$, \$f($(right_bound)) = $(val_right)\$",
                "Check critical points in interval (if any)",
                sol("Maximum value", max_val)
            ),
            time=180
        )
    end
end