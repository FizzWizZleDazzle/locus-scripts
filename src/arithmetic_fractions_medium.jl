# arithmetic - fractions (medium)
# Generated: 2026-03-08T19:47:56.440863

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/fractions")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Multi-step fraction addition/subtraction with different denominators
        a = randint(1, 12)
        b = randint(2, 15)
        c = randint(1, 12)
        d = randint(2, 15)
        e = randint(1, 12)
        f = randint(2, 15)
        
        # Calculate answer
        lcm_bd = lcm(b, d)
        lcm_all = lcm(lcm_bd, f)
        
        ans_num = a * div(lcm_all, b) + c * div(lcm_all, d) - e * div(lcm_all, f)
        ans_den = lcm_all
        g = gcd(ans_num, ans_den)
        final_num = div(ans_num, g)
        final_den = div(ans_den, g)
        
        problem(
            question="Simplify: \\\$\\frac{$a}{$b} + \\frac{$c}{$d} - \\frac{$e}{$f}\\\$",
            answer="$final_num/$final_den",
            difficulty=(1200, 1500),
            solution=steps(
                "Find common denominator: \\\$\\text{lcm}($b, $d, $f) = $lcm_all\\\$",
                "Convert each fraction: \\\$\\frac{$(a * div(lcm_all, b))}{$lcm_all} + \\frac{$(c * div(lcm_all, d))}{$lcm_all} - \\frac{$(e * div(lcm_all, f))}{$lcm_all}\\\$",
                "Combine numerators: \\\$\\frac{$ans_num}{$ans_den}\\\$",
                "Simplify by dividing by \\\$\\gcd($ans_num, $ans_den) = $g\\\$",
                sol("Answer", "$final_num/$final_den")
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Fraction multiplication with three fractions
        a = randint(2, 15)
        b = randint(2, 15)
        c = randint(2, 15)
        d = randint(2, 15)
        e = randint(2, 15)
        f = randint(2, 15)
        
        ans_num = a * c * e
        ans_den = b * d * f
        g = gcd(ans_num, ans_den)
        final_num = div(ans_num, g)
        final_den = div(ans_den, g)
        
        problem(
            question="Multiply and simplify: \\\$\\frac{$a}{$b} \\times \\frac{$c}{$d} \\times \\frac{$e}{$f}\\\$",
            answer="$final_num/$final_den",
            difficulty=(1100, 1400),
            solution=steps(
                "Multiply numerators and denominators: \\\$\\frac{$a \\times $c \\times $e}{$b \\times $d \\times $f}\\\$",
                "Calculate: \\\$\\frac{$ans_num}{$ans_den}\\\$",
                "Find \\\$\\gcd($ans_num, $ans_den) = $g\\\$ and simplify",
                sol("Answer", "$final_num/$final_den")
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Division of fractions with simplification
        a = randint(2, 20)
        b = randint(2, 20)
        c = randint(2, 20)
        d = randint(2, 20)
        
        ans_num = a * d
        ans_den = b * c
        g = gcd(ans_num, ans_den)
        final_num = div(ans_num, g)
        final_den = div(ans_den, g)
        
        problem(
            question="Divide and simplify: \\\$\\frac{$a}{$b} \\div \\frac{$c}{$d}\\\$",
            answer="$final_num/$final_den",
            difficulty=(1200, 1500),
            solution=steps(
                "Multiply by the reciprocal: \\\$\\frac{$a}{$b} \\times \\frac{$d}{$c}\\\$",
                "Multiply: \\\$\\frac{$(a*d)}{$(b*c)}\\\$",
                "Find \\\$\\gcd($(a*d), $(b*c)) = $g\\\$ and simplify",
                sol("Answer", "$final_num/$final_den")
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Complex fraction (fraction divided by fraction)
        a = randint(1, 10)
        b = randint(2, 12)
        c = randint(1, 10)
        d = randint(2, 12)
        e = randint(1, 10)
        f = randint(2, 12)
        
        # Numerator of complex fraction: a/b + c/d
        lcm1 = lcm(b, d)
        num_top = a * div(lcm1, b) + c * div(lcm1, d)
        den_top = lcm1
        
        # Answer: (a/b + c/d) / (e/f) = (num_top/den_top) * (f/e)
        ans_num = num_top * f
        ans_den = den_top * e
        g = gcd(ans_num, ans_den)
        final_num = div(ans_num, g)
        final_den = div(ans_den, g)
        
        problem(
            question="Simplify the complex fraction: \\\$\\frac{\\frac{$a}{$b} + \\frac{$c}{$d}}{\\frac{$e}{$f}}\\\$",
            answer="$final_num/$final_den",
            difficulty=(1400, 1700),
            solution=steps(
                "Simplify numerator: \\\$\\frac{$a}{$b} + \\frac{$c}{$d} = \\frac{$num_top}{$den_top}\\\$",
                "Rewrite as division: \\\$\\frac{$num_top}{$den_top} \\div \\frac{$e}{$f}\\\$",
                "Multiply by reciprocal: \\\$\\frac{$num_top}{$den_top} \\times \\frac{$f}{$e} = \\frac{$ans_num}{$ans_den}\\\$",
                "Simplify using \\\$\\gcd($ans_num, $ans_den) = $g\\\$",
                sol("Answer", "$final_num/$final_den")
            ),
            time=240
        )
        
    else
        # Mixed operation: (a/b * c/d) + (e/f)
        a = randint(1, 12)
        b = randint(2, 12)
        c = randint(1, 12)
        d = randint(2, 12)
        e = randint(1, 12)
        f = randint(2, 12)
        
        # First multiply a/b * c/d
        mult_num = a * c
        mult_den = b * d
        g1 = gcd(mult_num, mult_den)
        simp_num = div(mult_num, g1)
        simp_den = div(mult_den, g1)
        
        # Then add e/f
        lcm_final = lcm(simp_den, f)
        ans_num = simp_num * div(lcm_final, simp_den) + e * div(lcm_final, f)
        ans_den = lcm_final
        g2 = gcd(ans_num, ans_den)
        final_num = div(ans_num, g2)
        final_den = div(ans_den, g2)
        
        problem(
            question="Simplify: \\\$\\frac{$a}{$b} \\times \\frac{$c}{$d} + \\frac{$e}{$f}\\\$",
            answer="$final_num/$final_den",
            difficulty=(1300, 1600),
            solution=steps(
                "First multiply: \\\$\\frac{$a}{$b} \\times \\frac{$c}{$d} = \\frac{$mult_num}{$mult_den} = \\frac{$simp_num}{$simp_den}\\\$",
                "Find common denominator with \\\$\\frac{$e}{$f}\\\$: \\\$\\text{lcm}($simp_den, $f) = $lcm_final\\\$",
                "Add: \\\$\\frac{$(simp_num * div(lcm_final, simp_den))}{$lcm_final} + \\frac{$(e * div(lcm_final, f))}{$lcm_final} = \\frac{$ans_num}{$ans_den}\\\$",
                "Simplify using \\\$\\gcd($ans_num, $ans_den) = $g2\\\$",
                sol("Answer", "$final_num/$final_den")
            ),
            time=210
        )
    end
end