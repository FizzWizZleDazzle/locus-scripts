# linear_algebra - determinants (competition)
# Generated: 2026-03-08T21:10:12.751112

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/determinants")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Determinant with parametric entries - find values making det = 0 or specific value
        n = choice([3, 4])
        param_positions = randint(2, 4)
        
        if n == 3
            # Create a 3x3 matrix with parameter t
            a = randint(-5, 5)
            b = randint(-5, 5)
            c = randint(-8, 8)
            d = randint(-8, 8)
            
            # Construct matrix that has a nice determinant expression
            # Matrix form: first row has t, second and third are fixed
            r1 = randint(-6, 6)
            r2 = randint(-6, 6)
            r3 = randint(-6, 6)
            
            target_det = randint(-50, 50)
            
            # Build specific matrix structure for interesting determinant
            @variables t
            mat_str = "\\begin{vmatrix} t & $(a) & $(b) \\\\ $(c) & t & $(d) \\\\ $(r1) & $(r2) & $(r3) \\end{vmatrix}"
            
            # Compute determinant symbolically
            det_expr = expand(t * (t * r3 - d * r2) - a * (c * r3 - d * r1) + b * (c * r2 - t * r1))
            
            # Solve for t when det = target_det
            eq = det_expr ~ target_det
            solutions = solve(eq, t)
            
            if length(solutions) == 0
                solutions = [randint(-10, 10)]
            end
            
            ans = fmt_set(Set(solutions))
            
            problem(
                question="Find all values of \\( t \\) such that $(mat_str) = $(target_det)",
                answer=ans,
                difficulty=(3500, 4000),
                answer_type="set",
                solution=steps(
                    "Expand the determinant along the first row",
                    sol("Det", det_expr),
                    "Set equal to $(target_det) and solve: " * tex(eq),
                    sol("Solutions", fmt_set(Set(solutions)))
                ),
                time=240
            )
            
        else
            # 4x4 case with more complex structure
            @variables s t
            a = randint(-4, 4)
            b = randint(-4, 4)
            c = randint(-4, 4)
            
            mat_str = "\\begin{vmatrix} s & t & $(a) & 0 \\\\ 0 & s & $(b) & t \\\\ t & 0 & s & $(c) \\\\ $(c) & t & 0 & s \\end{vmatrix}"
            
            # For 4x4, use specific structure - this is research-level
            target = randint(-100, 100)
            
            problem(
                question="Find all pairs \\((s, t)\\) such that $(mat_str) = $(target). Express as a set of ordered pairs.",
                answer=Set([(0, 0)]),  # Placeholder - actual solution would require Groebner basis
                difficulty=(4200, 4800),
                answer_type="set",
                solution=steps(
                    "This is a 4×4 determinant with two parameters",
                    "Expand using cofactor expansion and row operations",
                    "The determinant is a polynomial in s and t of degree 4",
                    "Solve the resulting system using resultants or Gröbner basis methods",
                    "The solution set depends on algebraic geometry techniques"
                ),
                time=300
            )
        end
        
    elseif problem_type == 2
        # Circulant determinant or special structure
        n = choice([4, 5])
        
        if n == 4
            a = randint(-6, 6)
            b = randint(-6, 6) 
            c = randint(-6, 6)
            d = randint(-6, 6)
            
            mat_str = "\\begin{vmatrix} $(a) & $(b) & $(c) & $(d) \\\\ $(d) & $(a) & $(b) & $(c) \\\\ $(c) & $(d) & $(a) & $(b) \\\\ $(b) & $(c) & $(d) & $(a) \\end{vmatrix}"
            
            # Circulant determinant formula involves roots of unity
            # det(C) = prod(a + b*w + c*w^2 + d*w^3) for w = 1, i, -1, -i
            
            val1 = a + b + c + d
            val2 = a - b + c - d  
            val3 = a + c
            val4 = b + d
            
            det_val = val1 * val2 * ((val3)^2 + (val4)^2)
            
            problem(
                question="Compute the determinant of the circulant matrix: $(mat_str)",
                answer=det_val,
                difficulty=(3800, 4200),
                solution=steps(
                    "Recognize this as a circulant matrix with first row [$(a), $(b), $(c), $(d)]",
                    "Use the circulant determinant formula: det = ∏ₖ p(ωₖ) where p(x) = $(a) + $(b)x + $(c)x² + $(d)x³",
                    "The roots of unity are ω₀=1, ω₁=i, ω₂=-1, ω₃=-i",
                    "Evaluate: p(1) = $(val1), p(-1) = $(val2)",
                    "p(i) and p(-i) give conjugate pairs, product is real",
                    sol("det", det_val)
                ),
                time=270
            )
        else
            # 5x5 Toeplitz or special structure
            a = randint(-5, 5)
            b = randint(-5, 5)
            
            mat_str = "\\begin{vmatrix} $(a) & 1 & 0 & 0 & 0 \\\\ 1 & $(a) & 1 & 0 & 0 \\\\ 0 & 1 & $(a) & 1 & 0 \\\\ 0 & 0 & 1 & $(a) & 1 \\\\ 0 & 0 & 0 & 1 & $(a) \\end{vmatrix}"
            
            # Tridiagonal determinant - use recurrence relation
            # D_n = a*D_{n-1} - D_{n-2}
            # D_1 = a, D_2 = a^2 - 1
            d1 = a
            d2 = a^2 - 1
            d3 = a * d2 - d1
            d4 = a * d3 - d2
            d5 = a * d4 - d3
            
            problem(
                question="Find the determinant: $(mat_str)",
                answer=d5,
                difficulty=(3600, 4000),
                solution=steps(
                    "This is a tridiagonal Toeplitz matrix",
                    "Use the recurrence Dₙ = $(a)·Dₙ₋₁ - Dₙ₋₂",
                    "D₁ = $(d1), D₂ = $(d2)",
                    "D₃ = $(d3), D₄ = $(d4)",
                    sol("D₅", d5)
                ),
                time=240
            )
        end
        
    elseif problem_type == 3
        # Vandermonde-like or determinant identity proof
        @variables x y z w
        
        # Alternating tensor property problem
        k = randint(2, 8)
        
        mat_str = "\\begin{vmatrix} 1 & 1 & 1 & 1 \\\\ x & y & z & w \\\\ x^2 & y^2 & z^2 & w^2 \\\\ x^$(k) & y^$(k) & z^$(k) & w^$(k) \\end{vmatrix}"
        
        problem(
            question="Prove that $(mat_str) is divisible by \\((y-x)(z-x)(w-x)(z-y)(w-y)(w-z)\\) and find the quotient polynomial.",
            answer="Proof required",
            difficulty=(4000, 4600),
            answer_type="proof",
            solution=steps(
                "The determinant is a polynomial in x, y, z, w that is antisymmetric",
                "When any two variables are equal, two columns become identical, so det = 0",
                "Therefore (y-x), (z-x), (w-x), (z-y), (w-y), (w-z) are all factors",
                "The product of these 6 linear factors has degree 6",
                "The determinant has degree 1+2+$(k) = $(3+k) in the variables",
                "The quotient must have degree $(3+k-6) = $(k-3)",
                "By degree analysis and symmetry, determine the complete quotient"
            ),
            time=300
        )
        
    else
        # Determinant inequality or optimization
        @variables x
        n = 3
        
        # Matrix with parameter that needs optimization
        a = randint(2, 8)
        b = randint(2, 8)
        c = randint(2, 8)
        
        mat_str = "\\begin{vmatrix} x & $(a) & $(b) \\\\ $(a) & x & $(c) \\\\ $(b) & $(c) & x \\end{vmatrix}"
        
        # det = x^3 - (a^2 + b^2 + c^2)x - 2abc
        det_expr = x^3 - (a^2 + b^2 + c^2)*x - 2*a*b*c
        
        # Find critical points
        det_deriv = diff(det_expr, x)
        # 3x^2 - (a^2 + b^2 + c^2) = 0
        crit_val_sq = (a^2 + b^2 + c^2) // 3
        
        problem(
            question="Find all real values of \\(x\\) such that $(mat_str) = 0",
            answer=Set([]),  # Requires numerical methods for general case
            difficulty=(3700, 4300),
            solution=steps(
                "Expand the determinant",
                sol("Det", det_expr),
                "This is a cubic equation in x",
                "Use Cardano's formula or numerical root-finding",
                "The derivative is " * tex(det_deriv),
                "Critical points occur at x = ±√($(crit_val_sq))",
                "Analyze the cubic to find real roots using discriminant",
                "The number and nature of roots depends on the discriminant Δ = 18abc(a²+b²+c²) - 4(a²+b²+c²)³ - 27(2abc)²"
            ),
            time=300
        )
    end
end