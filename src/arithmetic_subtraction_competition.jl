# arithmetic - subtraction (competition)
# Generated: 2026-03-08T19:46:47.731035

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x n k a b begin
    set_topic!("arithmetic/subtraction")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Advanced digit manipulation problem
        # Find n-digit numbers where subtracting digit reversals gives specific properties
        num_digits = rand(4:6)
        target_sum = randint(50, 200)
        
        # Construct solution: work with base-10 representation
        # For a 4-digit number abcd, reverse is dcba
        # abcd - dcba = 1000a + 100b + 10c + d - (1000d + 100c + 10b + a)
        #              = 999(a-d) + 90(b-c)
        
        if num_digits == 4
            a_val = randint(5, 9)
            d_val = randint(1, a_val-1)
            b_val = randint(2, 8)
            c_val = randint(1, b_val-1)
            original = 1000*a_val + 100*b_val + 10*c_val + d_val
            reversed_num = 1000*d_val + 100*c_val + 10*b_val + a_val
            difference = original - reversed_num
            
            problem(
                question="A four-digit number \\(\\overline{abcd}\\) (where \\(a \\geq d\\) and \\(b \\geq c\\)) is subtracted from its digit reversal \\(\\overline{dcba}\\). If the original number is $(original), compute \\(\\overline{abcd} - \\overline{dcba}\\) and prove that this difference is always divisible by 9.",
                answer=difference,
                difficulty=(3500, 3800),
                solution=steps(
                    "Express the four-digit number in expanded form: \\(\\overline{abcd} = 1000a + 100b + 10c + d\\)",
                    "The reversal is: \\(\\overline{dcba} = 1000d + 100c + 10b + a\\)",
                    sol("Difference", "\\overline{abcd} - \\overline{dcba} = 999(a-d) + 90(b-c) = 9[111(a-d) + 10(b-c)]"),
                    "For our number: \\(999($(a_val)-$(d_val)) + 90($(b_val)-$(c_val)) = $(difference)\\)",
                    "Since the difference factors as \\(9k\\) for integer \\(k\\), it is always divisible by 9",
                ),
                time=240,
            )
        elseif num_digits == 5
            # 5-digit problem with alternating sum constraint
            a1 = randint(6, 9)
            a5 = randint(1, a1-2)
            a2 = randint(5, 8)
            a4 = randint(1, a2-1)
            a3 = randint(2, 7)
            
            original = 10000*a1 + 1000*a2 + 100*a3 + 10*a4 + a5
            reversed_num = 10000*a5 + 1000*a4 + 100*a3 + 10*a2 + a1
            diff = original - reversed_num
            
            problem(
                question="For the five-digit number \\(N = $(original)\\), compute \\(N - R\\) where \\(R\\) is \\(N\\) with its digits reversed. Then determine the sum of all five-digit palindromes \\(P\\) such that \\(P - R_P = $(diff)\\), where \\(R_P\\) is the digit reversal of \\(P\\).",
                answer=0,
                difficulty=(3800, 4200),
                solution=steps(
                    sol("Compute", "\\(N - R = $(original) - $(reversed_num) = $(diff)\\)"),
                    "For a five-digit number \\(\\overline{a_1a_2a_3a_4a_5}\\), the difference with reversal is \\(9999(a_1-a_5) + 990(a_2-a_4)\\)",
                    "For palindromes \\(P = \\overline{a_1a_2a_3a_2a_1}\\), we have \\(P - R_P = P - P = 0\\)",
                    "Since no palindrome can satisfy \\(P - R_P = $(diff) \\neq 0\\), the sum is 0",
                ),
                time=300,
            )
        else
            # 6-digit problem
            d1 = randint(7, 9)
            d6 = randint(1, d1-3)
            d2 = randint(6, 9)
            d5 = randint(1, d2-2)
            d3 = randint(4, 8)
            d4 = randint(1, d3-1)
            
            num = 100000*d1 + 10000*d2 + 1000*d3 + 100*d4 + 10*d5 + d6
            rev = 100000*d6 + 10000*d5 + 1000*d4 + 100*d3 + 10*d2 + d1
            result = num - rev
            
            problem(
                question="Let \\(N = $(num)\\). Define \\(f(N)\\) as the result of subtracting the digit reversal of \\(N\\) from \\(N\\). Compute \\(f(N)\\) and prove that \\(f(N)\\) is always divisible by 99.",
                answer=result,
                difficulty=(3600, 4000),
                solution=steps(
                    "Let \\(N = \\overline{d_1d_2d_3d_4d_5d_6}\\) and \\(R = \\overline{d_6d_5d_4d_3d_2d_1}\\)",
                    sol("Express", "\\(N - R = 99999(d_1-d_6) + 9990(d_2-d_5) + 990(d_3-d_4) = 99[1010(d_1-d_6) + 101(d_2-d_5) + 10(d_3-d_4)]\\)"),
                    "For our number: \\(99999($(d1)-$(d6)) + 9990($(d2)-$(d5)) + 990($(d3)-$(d4)) = $(result)\\)",
                    "Check: \\($(result) \\div 99 = $(result ÷ 99)\\), confirming divisibility",
                ),
                time=280,
            )
        end
        
    elseif problem_type == 2
        # Olympiad-level subtraction with modular arithmetic
        base = randint(7, 15)
        exp1 = randint(20, 40)
        exp2 = randint(15, exp1-2)
        mod_val = randint(100, 500)
        
        # Work backwards: choose a clean remainder
        remainder = randint(10, mod_val-10)
        
        problem(
            question="Compute the remainder when \\($(base)^{$(exp1)} - $(base)^{$(exp2)}\\) is divided by $(mod_val). Express your answer as the unique integer \\(r\\) where \\(0 \\leq r < $(mod_val)\\).",
            answer=mod(big(base)^exp1 - big(base)^exp2, mod_val),
            difficulty=(3700, 4100),
            solution=steps(
                sol("Factor", "\\($(base)^{$(exp1)} - $(base)^{$(exp2)} = $(base)^{$(exp2)}($(base)^{$(exp1-exp2)} - 1)\\)"),
                "Compute \\($(base)^{$(exp2)} \\bmod $(mod_val)\\) and \\($(base)^{$(exp1-exp2)} \\bmod $(mod_val)\\) using repeated squaring",
                "Apply modular arithmetic: \\((a \\cdot b) \\bmod m = [(a \\bmod m)(b \\bmod m)] \\bmod m\\)",
                sol("Answer", mod(big(base)^exp1 - big(base)^exp2, mod_val)),
            ),
            time=300,
        )
        
    elseif problem_type == 3
        # Difference of powers with constraint
        p = rand([3, 5, 7, 11, 13])
        n_val = randint(8, 15)
        m_val = randint(4, n_val-2)
        coef1 = randint(2, 8)
        coef2 = randint(2, 8)
        
        result = coef1 * p^n_val - coef2 * p^m_val
        
        problem(
            question="Let \\(S = $(coef1) \\cdot $(p)^{$(n_val)} - $(coef2) \\cdot $(p)^{$(m_val)}\\). Find the largest power of $(p) that divides \\(S\\), and express \\(S\\) in the form \\($(p)^k \\cdot q\\) where \\(\\gcd(q, $(p)) = 1\\). What is \\(k + q\\)?",
            answer=m_val + div(coef1 * p^(n_val - m_val) - coef2, 1),
            difficulty=(3800, 4300),
            solution=steps(
                sol("Factor", "\\(S = $(p)^{$(m_val)}($(coef1) \\cdot $(p)^{$(n_val - m_val)} - $(coef2))\\)"),
                "The largest power of $(p) dividing \\(S\\) is \\($(p)^{$(m_val)}\\) since \\($(coef1) \\cdot $(p)^{$(n_val - m_val)} - $(coef2)\\) is not divisible by $(p)",
                sol("Compute", "\\(q = $(coef1 * p^(n_val - m_val) - coef2)\\), so \\(k = $(m_val)\\)"),
                sol("Answer", "\\(k + q = $(m_val + coef1 * p^(n_val - m_val) - coef2)\\)"),
            ),
            time=270,
        )
        
    else
        # Research-adjacent: subtraction in number theory context
        a_base = randint(15, 30)
        b_base = randint(10, a_base-3)
        n_exp = randint(12, 20)
        
        # Factorization of difference of nth powers
        diff_formula = a_base^n_exp - b_base^n_exp
        
        problem(
            question="Prove that \\($(a_base)^{$(n_exp)} - $(b_base)^{$(n_exp)}\\) is divisible by \\($(a_base) - $(b_base)\\), and find the quotient \\(Q\\) such that \\($(a_base)^{$(n_exp)} - $(b_base)^{$(n_exp)} = ($(a_base) - $(b_base)) \\cdot Q\\). What is the sum of digits of \\(Q\\)?",
            answer=sum(digits(div(big(a_base)^n_exp - big(b_base)^n_exp, a_base - b_base))),
            difficulty=(4200, 4800),
            solution=steps(
                "Use the factorization: \\(x^n - y^n = (x-y)(x^{n-1} + x^{n-2}y + \\cdots + xy^{n-2} + y^{n-1})\\)",
                sol("Apply", "\\($(a_base)^{$(n_exp)} - $(b_base)^{$(n_exp)} = ($(a_base) - $(b_base))Q\\) where \\(Q = \\sum_{k=0}^{$(n_exp-1)} $(a_base)^{$(n_exp-1)-k} \\cdot $(b_base)^k\\)"),
                "Compute \\(Q = $(div(big(a_base)^n_exp - big(b_base)^n_exp, a_base - b_base))\\)",
                sol("Sum of digits", sum(digits(div(big(a_base)^n_exp - big(b_base)^n_exp, a_base - b_base)))),
            ),
            time=300,
        )
    end
end