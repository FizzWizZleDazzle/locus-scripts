# calculus - optimization (medium)
# Generated: 2026-03-08T20:43:25.296980

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y w r begin
    set_topic!("calculus/optimization")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Rectangle perimeter fixed, maximize area
        perimeter = randint(40, 120)
        half_p = perimeter // 2
        max_area = (half_p // 2)^2
        side_length = half_p // 2
        
        problem(
            question="A rectangle has a fixed perimeter of $(perimeter) meters. What is the maximum possible area (in square meters)?",
            answer=max_area,
            difficulty=(1200, 1400),
            solution=steps(
                "Let width = \\\$w\\\$ and length = \\\$l\\\$. Perimeter: \\\$2w + 2l = $(perimeter)\\\$",
                "Thus \\\$l = $(half_p) - w\\\$. Area: \\\$A = w($(half_p) - w) = $(half_p)w - w^2\\\$",
                sol("\\frac{dA}{dw}", half_p - 2*x),
                "Set derivative to zero: \\\$$(half_p) - 2w = 0 \\Rightarrow w = $(side_length)\\\$",
                "Maximum area occurs when rectangle is a square with side $(side_length) m",
                sol("Maximum Area", max_area)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Box with square base, fixed volume, minimize surface area
        volume = choice([64, 128, 216, 256, 343, 512])
        # Optimal is cube: x^3 = volume
        cbrt_vol = round(Int, volume^(1/3))
        min_surface = 6 * cbrt_vol^2
        
        problem(
            question="A box with a square base and no top must have a volume of $(volume) cubic meters. What is the minimum surface area (in square meters) of such a box?",
            answer=min_surface,
            difficulty=(1400, 1600),
            solution=steps(
                "Let base side = \\\$x\\\$ and height = \\\$h\\\$. Volume: \\\$x^2 h = $(volume)\\\$, so \\\$h = \\frac{$(volume)}{x^2}\\\$",
                "Surface area (no top): \\\$S = x^2 + 4xh = x^2 + 4x \\cdot \\frac{$(volume)}{x^2} = x^2 + \\frac{$(4*volume)}{x}\\\$",
                sol("\\frac{dS}{dx}", 2*x - (4*volume)/x^2),
                "Set to zero: \\\$2x - \\frac{$(4*volume)}{x^2} = 0 \\Rightarrow 2x^3 = $(4*volume) \\Rightarrow x^3 = $(2*volume)\\\$",
                "Thus \\\$x = $(cbrt_vol)\\\$ meters and \\\$h = $(cbrt_vol)\\\$ meters",
                sol("Minimum Surface Area", min_surface)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Product of two numbers with fixed sum
        sum_val = randint(30, 80)
        max_product = (sum_val // 2)^2
        
        problem(
            question="Two positive numbers have a sum of $(sum_val). What is the maximum possible product of these two numbers?",
            answer=max_product,
            difficulty=(1200, 1400),
            solution=steps(
                "Let the numbers be \\\$x\\\$ and \\\$$(sum_val) - x\\\$",
                sol("Product P(x)", x*(sum_val - x)),
                sol("P(x)", sum_val*x - x^2),
                sol("P'(x)", sum_val - 2*x),
                "Set to zero: \\\$$(sum_val) - 2x = 0 \\Rightarrow x = $(sum_val//2)\\\$",
                "Both numbers equal \\\$$(sum_val//2)\\\$",
                sol("Maximum Product", max_product)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Fence along river (three sides)
        total_fence = randint(200, 600)
        max_area = (total_fence^2) // 8
        width = total_fence // 4
        
        problem(
            question="A farmer wants to fence a rectangular field along a straight river. No fence is needed along the river. If the farmer has $(total_fence) meters of fence, what is the maximum area (in square meters) that can be enclosed?",
            answer=max_area,
            difficulty=(1300, 1500),
            solution=steps(
                "Let width (perpendicular to river) = \\\$w\\\$ and length (parallel to river) = \\\$l\\\$",
                "Fence constraint: \\\$2w + l = $(total_fence)\\\$, so \\\$l = $(total_fence) - 2w\\\$",
                sol("Area A(w)", w*(total_fence - 2*w)),
                sol("A(w)", total_fence*w - 2*w^2),
                sol("A'(w)", total_fence - 4*w),
                "Set to zero: \\\$$(total_fence) - 4w = 0 \\Rightarrow w = $(width)\\\$ meters",
                "Then \\\$l = $(total_fence - 2*width)\\\$ meters",
                sol("Maximum Area", max_area)
            ),
            time=200
        )
        
    else
        # Minimize cost: cylinder with fixed volume
        volume = choice([500, 1000, 1500, 2000])
        cost_side = randint(2, 8)
        cost_top = randint(3, 10)
        # This is more complex, use numerical approach
        # Optimal r satisfies: cost_top * r = cost_side * h, with πr²h = volume
        # Result: r³ = (cost_side * volume)/(2π * cost_top)
        
        problem(
            question="A cylindrical can must hold $(volume) cubic cm. The material for the top and bottom costs \\\$$(cost_top) per square cm, and the material for the side costs \\\$$(cost_side) per square cm. Find the radius (in cm) that minimizes the total cost. Round to two decimal places.",
            answer=round(((cost_side * volume) / (2 * π * cost_top))^(1/3), digits=2),
            difficulty=(1600, 1800),
            solution=steps(
                "Let radius = \\\$r\\\$ and height = \\\$h\\\$. Volume: \\\$\\pi r^2 h = $(volume)\\\$, so \\\$h = \\frac{$(volume)}{\\pi r^2}\\\$",
                "Cost = $(cost_top)·(2πr²) + $(cost_side)·(2πrh) = $(2*cost_top)πr² + $(2*cost_side)·$(volume)/(πr²)",
                sol("C(r)", (2*cost_top)*π*r^2 + (2*cost_side*volume)/r),
                sol("C'(r)", (4*cost_top)*π*r - (2*cost_side*volume)/r^2),
                "Set to zero: \\\$$(4*cost_top)\\pi r^3 = $(2*cost_side*volume)\\\$",
                sol("r", round(((cost_side * volume) / (2 * π * cost_top))^(1/3), digits=2))
            ),
            time=300
        )
    end
end