# arithmetic - fractions (easy)
# Generated: 2026-03-08T19:47:54.349067

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/fractions")
    
    prob_type = rand(1:6)
    
    if prob_type == 1
        # Addition of fractions with different denominators (700-900)
        d1 = randint(2, 12)
        d2 = randint(2, 12)
        while gcd(d1, d2) == d1 || gcd(d1, d2) == d2
            d2 = randint(2, 12)
        end
        n1 = randint(1, d1-1)
        n2 = randint(1, d2-1)
        
        lcm_d = lcm(d1, d2)
        result_n = n1 * (lcm_d ÷ d1) + n2 * (lcm_d ÷ d2)
        result_d = lcm_d
        g = gcd(result_n, result_d)
        final_n = result_n ÷ g
        final_d = result_d ÷ g
        
        problem(
            question="Simplify: \$\\frac{$n1}{$d1} + \\frac{$n2}{$d2}\$",
            answer="$final_n/$final_d",
            difficulty=(700, 900),
            solution=steps(
                "Find common denominator: LCM($d1, $d2) = $lcm_d",
                "\$\\frac{$n1}{$d1} = \\frac{$(n1*(lcm_d÷d1))}{$lcm_d}\$ and \$\\frac{$n2}{$d2} = \\frac{$(n2*(lcm_d÷d2))}{$lcm_d}\$",
                "\$\\frac{$(n1*(lcm_d÷d1))}{$lcm_d} + \\frac{$(n2*(lcm_d÷d2))}{$lcm_d} = \\frac{$result_n}{$result_d}\$",
                sol("Simplify", "$final_n/$final_d")
            ),
            time=90
        )
        
    elseif prob_type == 2
        # Subtraction of fractions (700-900)
        d1 = randint(3, 12)
        d2 = randint(3, 12)
        while gcd(d1, d2) == d1 || gcd(d1, d2) == d2
            d2 = randint(3, 12)
        end
        n1 = randint(d1 ÷ 2, d1-1)
        n2 = randint(1, d2 ÷ 2)
        
        lcm_d = lcm(d1, d2)
        result_n = n1 * (lcm_d ÷ d1) - n2 * (lcm_d ÷ d2)
        result_d = lcm_d
        g = gcd(abs(result_n), result_d)
        final_n = result_n ÷ g
        final_d = result_d ÷ g
        
        problem(
            question="Simplify: \$\\frac{$n1}{$d1} - \\frac{$n2}{$d2}\$",
            answer="$final_n/$final_d",
            difficulty=(700, 900),
            solution=steps(
                "Find common denominator: LCM($d1, $d2) = $lcm_d",
                "\$\\frac{$n1}{$d1} = \\frac{$(n1*(lcm_d÷d1))}{$lcm_d}\$ and \$\\frac{$n2}{$d2} = \\frac{$(n2*(lcm_d÷d2))}{$lcm_d}\$",
                "\$\\frac{$(n1*(lcm_d÷d1))}{$lcm_d} - \\frac{$(n2*(lcm_d÷d2))}{$lcm_d} = \\frac{$result_n}{$result_d}\$",
                sol("Simplify", "$final_n/$final_d")
            ),
            time=90
        )
        
    elseif prob_type == 3
        # Multiplication of fractions (800-1000)
        n1 = randint(2, 15)
        d1 = randint(2, 15)
        n2 = randint(2, 15)
        d2 = randint(2, 15)
        
        result_n = n1 * n2
        result_d = d1 * d2
        g = gcd(result_n, result_d)
        final_n = result_n ÷ g
        final_d = result_d ÷ g
        
        problem(
            question="Multiply and simplify: \$\\frac{$n1}{$d1} \\times \\frac{$n2}{$d2}\$",
            answer="$final_n/$final_d",
            difficulty=(800, 1000),
            solution=steps(
                "Multiply numerators and denominators",
                "\$\\frac{$n1 \\times $n2}{$d1 \\times $d2} = \\frac{$result_n}{$result_d}\$",
                "GCD($result_n, $result_d) = $g",
                sol("Simplify", "$final_n/$final_d")
            ),
            time=75
        )
        
    elseif prob_type == 4
        # Division of fractions (800-1000)
        n1 = randint(2, 12)
        d1 = randint(2, 12)
        n2 = randint(2, 12)
        d2 = randint(2, 12)
        
        result_n = n1 * d2
        result_d = d1 * n2
        g = gcd(result_n, result_d)
        final_n = result_n ÷ g
        final_d = result_d ÷ g
        
        problem(
            question="Divide and simplify: \$\\frac{$n1}{$d1} \\div \\frac{$n2}{$d2}\$",
            answer="$final_n/$final_d",
            difficulty=(800, 1000),
            solution=steps(
                "Multiply by the reciprocal: \$\\frac{$n1}{$d1} \\times \\frac{$d2}{$n2}\$",
                "\$\\frac{$n1 \\times $d2}{$d1 \\times $n2} = \\frac{$result_n}{$result_d}\$",
                "GCD($result_n, $result_d) = $g",
                sol("Simplify", "$final_n/$final_d")
            ),
            time=75
        )
        
    elseif prob_type == 5
        # Complex fraction addition/subtraction (900-1100)
        d1 = randint(4, 10)
        d2 = randint(4, 10)
        d3 = randint(4, 10)
        n1 = randint(1, d1-1)
        n2 = randint(1, d2-1)
        n3 = randint(1, d3-1)
        
        op = rand(["+", "-"])
        
        lcm_d = lcm(lcm(d1, d2), d3)
        if op == "+"
            result_n = n1 * (lcm_d ÷ d1) + n2 * (lcm_d ÷ d2) + n3 * (lcm_d ÷ d3)
        else
            result_n = n1 * (lcm_d ÷ d1) + n2 * (lcm_d ÷ d2) - n3 * (lcm_d ÷ d3)
        end
        result_d = lcm_d
        g = gcd(abs(result_n), result_d)
        final_n = result_n ÷ g
        final_d = result_d ÷ g
        
        problem(
            question="Simplify: \$\\frac{$n1}{$d1} + \\frac{$n2}{$d2} $op \\frac{$n3}{$d3}\$",
            answer="$final_n/$final_d",
            difficulty=(900, 1100),
            solution=steps(
                "Find common denominator: LCM($d1, $d2, $d3) = $lcm_d",
                "Convert each fraction: \$\\frac{$(n1*(lcm_d÷d1))}{$lcm_d} + \\frac{$(n2*(lcm_d÷d2))}{$lcm_d} $op \\frac{$(n3*(lcm_d÷d3))}{$lcm_d}\$",
                "Combine: \$\\frac{$result_n}{$result_d}\$",
                sol("Simplify", "$final_n/$final_d")
            ),
            time=120
        )
        
    else
        # Mixed operations (1000-1200)
        n1 = randint(2, 10)
        d1 = randint(2, 10)
        n2 = randint(2, 10)
        d2 = randint(2, 10)
        n3 = randint(2, 10)
        d3 = randint(2, 10)
        
        # (n1/d1 * n2/d2) + n3/d3
        mult_n = n1 * n2
        mult_d = d1 * d2
        
        lcm_d = lcm(mult_d, d3)
        result_n = mult_n * (lcm_d ÷ mult_d) + n3 * (lcm_d ÷ d3)
        result_d = lcm_d
        g = gcd(result_n, result_d)
        final_n = result_n ÷ g
        final_d = result_d ÷ g
        
        problem(
            question="Simplify: \$\\left(\\frac{$n1}{$d1} \\times \\frac{$n2}{$d2}\\right) + \\frac{$n3}{$d3}\$",
            answer="$final_n/$final_d",
            difficulty=(1000, 1200),
            solution=steps(
                "First multiply: \$\\frac{$n1}{$d1} \\times \\frac{$n2}{$d2} = \\frac{$mult_n}{$mult_d}\$",
                "Find common denominator with \$\\frac{$n3}{$d3}\$: LCM($mult_d, $d3) = $lcm_d",
                "Add: \$\\frac{$(mult_n*(lcm_d÷mult_d))}{$lcm_d} + \\frac{$(n3*(lcm_d÷d3))}{$lcm_d} = \\frac{$result_n}{$result_d}\$",
                sol("Simplify", "$final_n/$final_d")
            ),
            time=150
        )
    end
end