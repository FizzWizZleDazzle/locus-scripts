# arithmetic - fractions (competition)
# Generated: 2026-03-08T19:48:44.563371

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/fractions")
    
    # Generate Olympiad/Research-Adjacent level fraction problems (3500-5000 ELO)
    # These problems involve deep number theory, Egyptian fractions, continued fractions,
    # Farey sequences, and advanced fraction properties
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Egyptian fraction representation - find distinct unit fractions summing to a given fraction
        # This is a classic hard problem in number theory
        target_num = randint(2, 15)
        target_den = randint(target_num + 1, 25)
        
        # Simplify the target fraction
        g = gcd(target_num, target_den)
        target_num = target_num ÷ g
        target_den = target_den ÷ g
        
        # Use greedy algorithm to find Egyptian fraction representation
        egypt_denoms = Int[]
        remaining_num = target_num
        remaining_den = target_den
        
        while remaining_num > 0 && length(egypt_denoms) < 6
            # Find smallest unit fraction 1/d that fits
            d = Int(ceil(remaining_den / remaining_num))
            push!(egypt_denoms, d)
            remaining_num = remaining_num * d - remaining_den
            remaining_den = remaining_den * d
            if remaining_num > 0
                g = gcd(remaining_num, remaining_den)
                remaining_num = remaining_num ÷ g
                remaining_den = remaining_den ÷ g
            end
        end
        
        egypt_str = join(["\\frac{1}{$d}" for d in egypt_denoms], " + ")
        
        problem(
            question="Express \\(\\frac{$target_num}{$target_den}\\) as a sum of distinct unit fractions (Egyptian fraction representation) using the greedy algorithm. Write your answer as a sum of fractions \\(\\frac{1}{a_1} + \\frac{1}{a_2} + \\cdots\\) where \\(a_1 < a_2 < \\cdots\\).",
            answer=egypt_str,
            difficulty=(3500, 4000),
            answer_type="expression",
            solution=steps(
                "Start with \\(\\frac{$target_num}{$target_den}\\)",
                "Apply the greedy algorithm: at each step, subtract the largest unit fraction that doesn't exceed the remaining value",
                "The greedy algorithm yields: \\($egypt_str\\)",
                "Verify: each denominator is distinct and the sum equals \\(\\frac{$target_num}{$target_den}\\)"
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Continued fraction convergents and best rational approximations
        # Find the nth convergent of a continued fraction
        a0 = randint(1, 8)
        a1 = randint(2, 12)
        a2 = randint(1, 10)
        a3 = randint(1, 8)
        a4 = randint(1, 6)
        
        # Calculate convergents using recurrence relations
        h_minus1, h_0 = 1, a0
        k_minus1, k_0 = 0, 1
        
        h_1 = a1 * h_0 + h_minus1
        k_1 = a1 * k_0 + k_minus1
        
        h_2 = a2 * h_1 + h_0
        k_2 = a2 * k_1 + k_0
        
        h_3 = a3 * h_2 + h_1
        k_3 = a3 * k_2 + k_1
        
        h_4 = a4 * h_3 + h_2
        k_4 = a4 * k_3 + k_2
        
        problem(
            question="Consider the continued fraction \\([a_0; a_1, a_2, a_3, a_4] = [$a0; $a1, $a2, $a3, $a4]\\). Find the fourth convergent \\(\\frac{h_4}{k_4}\\) in simplest form.",
            answer="\\frac{$h_4}{$k_4}",
            difficulty=(3800, 4200),
            answer_type="expression",
            solution=steps(
                "Use the recurrence relations: \\(h_n = a_n h_{n-1} + h_{n-2}\\) and \\(k_n = a_n k_{n-1} + k_{n-2}\\)",
                "Initialize: \\(h_{-1} = 1, h_0 = $a0, k_{-1} = 0, k_0 = 1\\)",
                "Compute convergents: \\(h_1 = $h_1, k_1 = $k_1\\); \\(h_2 = $h_2, k_2 = $k_2\\); \\(h_3 = $h_3, k_3 = $k_3\\); \\(h_4 = $h_4, k_4 = $k_4\\)",
                "The fourth convergent is \\(\\frac{$h_4}{$k_4}\\)"
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Farey sequence neighbor property
        # Given two adjacent fractions in Farey sequence F_n, find their mediant
        p1 = randint(1, 15)
        q1 = randint(p1 + 2, 25)
        g1 = gcd(p1, q1)
        p1, q1 = p1 ÷ g1, q1 ÷ g1
        
        # Find Farey neighbor using property |p2*q1 - p1*q2| = 1
        p2 = randint(p1 + 1, min(p1 + 10, q1 - 1))
        q2 = (p2 * q1 - 1) ÷ p1
        if q2 <= 0 || gcd(p2, q2) != 1 || p2 >= q2
            p2 = p1 + 1
            q2 = (p2 * q1 + 1) ÷ p1
        end
        
        # Ensure p2/q2 > p1/q1 and they are Farey neighbors
        if p2 * q1 <= p1 * q2 || abs(p2 * q1 - p1 * q2) != 1
            # Fallback to a simple case
            p1, q1 = 1, 3
            p2, q2 = 1, 2
        end
        
        mediant_p = p1 + p2
        mediant_q = q1 + q2
        
        n = max(q1, q2, mediant_q)
        
        problem(
            question="In the Farey sequence \\(F_n\\) (the sequence of completely reduced fractions between 0 and 1 with denominators at most \\(n\\), in increasing order), the fractions \\(\\frac{$p1}{$q1}\\) and \\(\\frac{$p2}{$q2}\\) are consecutive neighbors. What is the smallest \\(n\\) such that their mediant \\(\\frac{$p1 + $p2}{$q1 + $q2}\\) appears between them in \\(F_n\\)?",
            answer=mediant_q,
            difficulty=(3600, 4100),
            solution=steps(
                "Two fractions \\(\\frac{a}{b}\\) and \\(\\frac{c}{d}\\) are Farey neighbors in \\(F_n\\) if and only if \\(|bc - ad| = 1\\)",
                "Verify: \\(|$p2 \\cdot $q1 - $p1 \\cdot $q2| = |$(p2*q1) - $(p1*q2)| = $(abs(p2*q1 - p1*q2))\\)",
                "The mediant is \\(\\frac{$mediant_p}{$mediant_q}\\), which appears in \\(F_n\\) when \\(n \\geq $mediant_q\\)",
                "Answer: \\(n = $mediant_q\\)"
            ),
            time=240
        )
        
    elseif problem_type == 4
        # Diophantine equation involving fractions
        # Find all positive integer solutions to 1/x + 1/y = 1/n
        n = randint(3, 12)
        
        # Solutions are (x,y) where x = n + d, y = n + (n²/d) for divisors d of n²
        n_squared = n^2
        divisors = [d for d in 1:n_squared if n_squared % d == 0 && d >= n]
        
        solutions = []
        for d in divisors
            if d > n && n_squared % d == 0
                x = n + d
                y_num = n_squared
                y_den = d
                if y_num % y_den == 0
                    y = n + y_num ÷ y_den
                    if x <= y
                        push!(solutions, (x, y))
                    end
                end
            end
        end
        
        num_solutions = length(divisors)
        
        problem(
            question="Find the number of ordered pairs \\((x, y)\\) of positive integers satisfying \\(\\frac{1}{x} + \\frac{1}{y} = \\frac{1}{$n}\\) where \\(x \\leq y\\).",
            answer=num_solutions,
            difficulty=(3700, 4300),
            solution=steps(
                "Rewrite as \\(\\frac{x+y}{xy} = \\frac{1}{$n}\\), so \\($n(x+y) = xy\\)",
                "Rearrange: \\(xy - $n x - $n y = 0\\), or \\((x-$n)(y-$n) = $(n^2)\\)",
                "Let \\(x - $n = a\\) and \\(y - $n = b\\) where \\(ab = $(n^2)\\)",
                "The number of positive divisor pairs \\((a,b)\\) with \\(a \\leq b\\) equals the number of divisors of \\($(n^2)\\) that are \\(\\geq $n\\), which is $num_solutions",
                "Answer: $num_solutions"
            ),
            time=270
        )
        
    else
        # Stern-Brocot tree and finding the kth term
        # Or a problem about mediants and continued fractions
        
        # Problem: infinite sum of reciprocals of products
        k = randint(2, 6)
        
        # Sum of 1/(n(n+k)) from n=1 to infinity = (1/k) * sum of (1/n - 1/(n+k))
        # This is a telescoping series = (1/k) * (1 + 1/2 + ... + 1/k)
        harmonic_sum_num = sum([k ÷ gcd(k, i) for i in 1:k])
        harmonic_sum_den = k * prod([i ÷ gcd(k, i) for i in 1:k])
        
        # Actually compute H_k = 1 + 1/2 + ... + 1/k
        h_num = 0
        h_den = 1
        for i in 1:k
            h_num = h_num * i + h_den
            h_den = h_den * i
            g = gcd(h_num, h_den)
            h_num ÷= g
            h_den ÷= g
        end
        
        result_num = h_num
        result_den = h_den * k
        g = gcd(result_num, result_den)
        result_num ÷= g
        result_den ÷= g
        
        problem(
            question="Evaluate the infinite sum \\(\\sum_{n=1}^{\\infty} \\frac{1}{n(n+$k)}\\) and express your answer as a fraction in simplest form.",
            answer="\\frac{$result_num}{$result_den}",
            difficulty=(3900, 4500),
            answer_type="expression",
            solution=steps(
                "Use partial fractions: \\(\\frac{1}{n(n+$k)} = \\frac{1}{$k}\\left(\\frac{1}{n} - \\frac{1}{n+$k}\\right)\\)",
                "The sum becomes \\(\\frac{1}{$k}\\sum_{n=1}^{\\infty}\\left(\\frac{1}{n} - \\frac{1}{n+$k}\\right)\\), a telescoping series",
                "The partial sum is \\(\\frac{1}{$k}\\left(1 + \\frac{1}{2} + \\cdots + \\frac{1}{$k}\\right) = \\frac{1}{$k} \\cdot H_$k\\)",
                "Computing \\(H_$k = \\frac{$h_num}{$h_den}\\), we get \\(\\frac{1}{$k} \\cdot \\frac{$h_num}{$h_den} = \\frac{$result_num}{$result_den}\\)"
            ),
            time=300
        )
    end
end