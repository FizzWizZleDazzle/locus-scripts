# arithmetic - fractions (very_hard)
# Generated: 2026-03-08T19:48:32.046231

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/fractions")
    
    # Competition to Olympiad level fraction problems (2500-3500 ELO)
    # These require deep insight, non-obvious manipulations, and creative approaches
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Egyptian fraction decomposition with constraints
        # Find unique unit fractions summing to a given fraction
        target_num = randint(5, 15)
        target_den = randint(target_num + 3, target_num + 12)
        
        # Construct backwards: pick unit fractions that sum to target
        # For difficulty, use 3-4 distinct unit fractions
        n1 = randint(target_den + 1, target_den + 20)
        remainder1_num = target_num * n1 - target_den
        remainder1_den = target_den * n1
        
        # Simplify
        g1 = gcd(remainder1_num, remainder1_den)
        remainder1_num = remainder1_num ÷ g1
        remainder1_den = remainder1_den ÷ g1
        
        n2 = randint(remainder1_den + 1, remainder1_den + 30)
        remainder2_num = remainder1_num * n2 - remainder1_den
        remainder2_den = remainder1_den * n2
        
        g2 = gcd(abs(remainder2_num), remainder2_den)
        remainder2_num = remainder2_num ÷ g2
        remainder2_den = remainder2_den ÷ g2
        
        if remainder2_num > 0 && remainder2_num < remainder2_den
            n3 = remainder2_den ÷ remainder2_num
            if remainder2_num * n3 == remainder2_den
                answer = "\\frac{1}{$n1} + \\frac{1}{$n2} + \\frac{1}{$n3}"
                
                problem(
                    question="Express \\frac{$target_num}{$target_den} as a sum of distinct unit fractions (fractions with numerator 1). Give your answer in the form \\frac{1}{a} + \\frac{1}{b} + \\frac{1}{c} where a < b < c.",
                    answer=answer,
                    difficulty=(2800, 3200),
                    answer_type="expression",
                    solution=steps(
                        "Target: \\frac{$target_num}{$target_den}",
                        "Use greedy algorithm: subtract largest possible unit fraction repeatedly",
                        "\\frac{1}{$n1} is largest unit fraction ≤ \\frac{$target_num}{$target_den}",
                        "Remainder: \\frac{$target_num}{$target_den} - \\frac{1}{$n1} = \\frac{$remainder1_num}{$remainder1_den}",
                        "Continue: \\frac{1}{$n2}, then \\frac{1}{$n3}",
                        sol("Answer", answer)
                    ),
                    time=300
                )
            else
                # Fallback to simpler problem
                a = randint(2, 8)
                b = randint(a + 1, 15)
                c = randint(b + 1, 25)
                sum_num = b*c + a*c + a*b
                sum_den = a*b*c
                g = gcd(sum_num, sum_den)
                
                problem(
                    question="Simplify \\frac{1}{$a} + \\frac{1}{$b} + \\frac{1}{$c} to lowest terms.",
                    answer="\\frac{$(sum_num÷g)}{$(sum_den÷g)}",
                    difficulty=(2600, 2900),
                    solution=steps(
                        "Find common denominator: $a × $b × $c = $(a*b*c)",
                        "Convert: \\frac{$(b*c)}{$(a*b*c)} + \\frac{$(a*c)}{$(a*b*c)} + \\frac{$(a*b)}{$(a*b*c)}",
                        "Sum: \\frac{$sum_num}{$sum_den}",
                        "Simplify by dividing by GCD($sum_num, $sum_den) = $g",
                        sol("Answer", "\\frac{$(sum_num÷g)}{$(sum_den÷g)}")
                    ),
                    time=240
                )
            end
        else
            # Fallback
            a = randint(2, 8)
            b = randint(a + 1, 15)
            c = randint(b + 1, 25)
            sum_num = b*c + a*c + a*b
            sum_den = a*b*c
            g = gcd(sum_num, sum_den)
            
            problem(
                question="Simplify \\frac{1}{$a} + \\frac{1}{$b} + \\frac{1}{$c} to lowest terms.",
                answer="\\frac{$(sum_num÷g)}{$(sum_den÷g)}",
                difficulty=(2600, 2900),
                solution=steps(
                    "Find common denominator: $a × $b × $c = $(a*b*c)",
                    "Convert: \\frac{$(b*c)}{$(a*b*c)} + \\frac{$(a*c)}{$(a*b*c)} + \\frac{$(a*b)}{$(a*b*c)}",
                    "Sum: \\frac{$sum_num}{$sum_den}",
                    "Simplify by dividing by GCD($sum_num, $sum_den) = $g",
                    sol("Answer", "\\frac{$(sum_num÷g)}{$(sum_den÷g)}")
                ),
                time=240
            )
        end
        
    elseif problem_type == 2
        # Nested fraction simplification (deep nesting)
        a = randint(2, 9)
        b = randint(2, 9)
        c = randint(2, 9)
        d = randint(2, 9)
        
        # Calculate from inside out
        inner = (c * d + 1) // d  # c + 1/d
        middle_num = b * inner.den + inner.num
        middle_den = inner.den
        outer_num = a * middle_den + middle_num
        outer_den = middle_den
        
        g = gcd(outer_num, outer_den)
        final_num = outer_num ÷ g
        final_den = outer_den ÷ g
        
        problem(
            question="Simplify the continued fraction: $a + \\cfrac{1}{$b + \\cfrac{1}{$c + \\cfrac{1}{$d}}}",
            answer="\\frac{$final_num}{$final_den}",
            difficulty=(2700, 3100),
            solution=steps(
                "Work from innermost fraction outward",
                "Innermost: $c + \\frac{1}{$d} = \\frac{$(c*d + 1)}{$d}",
                "Middle: $b + \\frac{1}{\\frac{$(c*d + 1)}{$d}} = $b + \\frac{$d}{$(c*d + 1)} = \\frac{$(b*(c*d+1) + d)}{$(c*d + 1)}",
                "Outer: $a + \\frac{$(c*d + 1)}{$(b*(c*d+1) + d)} = \\frac{$outer_num}{$outer_den}",
                "Simplify: \\frac{$final_num}{$final_den}",
                sol("Answer", "\\frac{$final_num}{$final_den}")
            ),
            time=270
        )
        
    elseif problem_type == 3
        # Diophantine-style fraction equation
        # Solve for positive integers: 1/x + 1/y = 1/n
        n = randint(3, 12)
        
        # Solutions come from divisors of n²
        # If 1/x + 1/y = 1/n, then (x-n)(y-n) = n²
        # So x = n + d, y = n + n²/d where d divides n²
        
        nsq = n * n
        divisors = [d for d in 1:nsq if nsq % d == 0]
        d = choice(divisors)
        x = n + d
        y = n + nsq ÷ d
        
        if x > y
            x, y = y, x
        end
        
        problem(
            question="Find all pairs of positive integers (x, y) with x ≤ y such that \\frac{1}{x} + \\frac{1}{y} = \\frac{1}{$n}. Enter your answer as ordered pairs separated by semicolons, e.g., (2,3); (4,5)",
            answer="($x,$y)",
            difficulty=(3000, 3400),
            answer_type="text",
            solution=steps(
                "Rewrite: \\frac{1}{x} + \\frac{1}{y} = \\frac{1}{$n}",
                "Multiply through by xy($n): $n(x + y) = xy",
                "Rearrange: xy - $(n)x - $(n)y = 0",
                "Add $nsq: xy - $(n)x - $(n)y + $nsq = $nsq",
                "Factor: (x - $n)(y - $n) = $nsq",
                "Find divisor pairs of $nsq and solve for x, y",
                sol("Answer", "($x, $y)")
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Mediant and Farey sequence problem
        # Find fraction between two given fractions with smallest denominator
        a = randint(1, 8)
        b = randint(a + 2, 15)
        c = randint(1, 8)
        d = randint(c + 2, 15)
        
        # Ensure a/b < c/d
        if a * d >= c * b
            a, c = c, a
            b, d = d, b
        end
        
        # Mediant is (a+c)/(b+d)
        med_num = a + c
        med_den = b + d
        g = gcd(med_num, med_den)
        med_num = med_num ÷ g
        med_den = med_den ÷ g
        
        problem(
            question="Find the fraction with smallest denominator that lies strictly between \\frac{$a}{$b} and \\frac{$c}{$d}. Express in lowest terms.",
            answer="\\frac{$med_num}{$med_den}",
            difficulty=(2900, 3300),
            solution=steps(
                "Use mediant property from Farey sequences",
                "For consecutive Farey neighbors \\frac{a}{b} and \\frac{c}{d}, the simplest fraction between them is the mediant",
                "Mediant: \\frac{$a + $c}{$b + $d} = \\frac{$(a+c)}{$(b+d)}",
                "Simplify if needed: GCD($(a+c), $(b+d)) = $g",
                sol("Answer", "\\frac{$med_num}{$med_den}")
            ),
            time=240
        )
        
    else  # problem_type == 5
        # Complex fraction arithmetic with multiple operations
        a = randint(2, 7)
        b = randint(2, 7)
        c = randint(2, 7)
        d = randint(2, 7)
        e = randint(2, 7)
        f = randint(2, 7)
        
        # Calculate (a/b + c/d) × e/f
        sum_num = a * d + c * b
        sum_den = b * d
        g1 = gcd(sum_num, sum_den)
        sum_num = sum_num ÷ g1
        sum_den = sum_den ÷ g1
        
        prod_num = sum_num * e
        prod_den = sum_den * f
        g2 = gcd(prod_num, prod_den)
        final_num = prod_num ÷ g2
        final_den = prod_den ÷ g2
        
        problem(
            question="Calculate \\left(\\frac{$a}{$b} + \\frac{$c}{$d}\\right) \\times \\frac{$e}{$f}. Express in lowest terms.",
            answer="\\frac{$final_num}{$final_den}",
            difficulty=(2500, 2800),
            solution=steps(
                "First add fractions: \\frac{$a}{$b} + \\frac{$c}{$d}",
                "Common denominator: $(b*d). Convert: \\frac{$(a*d)}{$(b*d)} + \\frac{$(c*b)}{$(b*d)} = \\frac{$sum_num}{$sum_den}",
                "Multiply by \\frac{$e}{$f}: \\frac{$sum_num}{$sum_den} × \\frac{$e}{$f} = \\frac{$prod_num}{$prod_den}",
                "Simplify by GCD($prod_num, $prod_den) = $g2",
                sol("Answer", "\\frac{$final_num}{$final_den}")
            ),
            time=210
        )
    end
end