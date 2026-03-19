# algebra2 - complex_number_operations (very_hard)
# Generated: 2026-03-08T20:14:39.028172

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/complex_number_operations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # High-degree polynomial roots with complex numbers (ELO 2500-2800)
        # Find all nth roots of unity or variants
        n = rand(5:8)
        k = randint(1, n-1)
        
        # Problem: Find all solutions to z^n = e^(2πik/n)
        theta = 2*k//n
        
        question = "Find all complex numbers \\(z\\) such that \\(z^{$n} = e^{$(k == 1 ? "2\\pi i/$n" : "$(2*k)\\pi i/$n")}\\). Express your answer as a set of complex exponentials \\(e^{i\\theta}\\) where \\(0 \\leq \\theta < 2\\pi\\)."
        
        # Solutions are e^(i(2πk/n + 2πm/n)) for m = 0, 1, ..., n-1
        angles = [rationalize((2*k + 2*m)/n, tol=1e-10) for m in 0:n-1]
        answer_parts = ["e^{$(a == 0 ? "0" : a == 1 ? "\\pi i" : "$(numerator(a))\\pi i/$(denominator(a))")}" for a in angles]
        answer = "\\{" * join(answer_parts, ", ") * "\\}"
        
        solution = steps(
            "Given: \\(z^{$n} = e^{$(2*k)\\pi i/$n}\\)",
            "Using De Moivre's theorem, the solutions are \\(z = e^{i(\\frac{$(2*k)\\pi}{$n} + \\frac{2\\pi m}{$n})}\\) for \\(m = 0, 1, \\ldots, $(n-1)\\)",
            "Simplifying the exponents: \\(z = e^{i\\frac{2\\pi($(k) + m)}{$n}}\\)",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2500, 2800),
            solution=solution,
            answer_type="expression",
            time=240
        )
        
    elseif problem_type == 2
        # Complex number equation with symmetry (ELO 2600-3000)
        # Solve z^n + conjugate(z)^n = c for specific c
        
        n = rand(3:5)
        c = randint(-10, 10)
        
        question = "Find all complex numbers \\(z\\) satisfying \\(z^{$n} + \\overline{z}^{$n} = $c\\)."
        
        # For z = re^(iθ), this becomes r^n(e^(inθ) + e^(-inθ)) = 2r^n cos(nθ) = c
        # So r^n cos(nθ) = c/2
        
        solution = steps(
            "Let \\(z = re^{i\\theta}\\) where \\(r \\geq 0\\) and \\(\\theta \\in [0, 2\\pi)\\)",
            "Then \\(z^{$n} = r^{$n}e^{i$(n)\\theta}\\) and \\(\\overline{z}^{$n} = r^{$n}e^{-i$(n)\\theta}\\)",
            "So \\(z^{$n} + \\overline{z}^{$n} = r^{$n}(e^{i$(n)\\theta} + e^{-i$(n)\\theta}) = 2r^{$n}\\cos($(n)\\theta) = $c\\)",
            "This gives \\(r^{$n}\\cos($(n)\\theta) = $(c//2)\\)",
            "Solutions depend on finding \\(r\\) and \\(\\theta\\) satisfying this constraint"
        )
        
        answer = "r^{$n}\\cos($(n)\\theta) = $(rationalize(c/2, tol=1e-10))"
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2600, 3000),
            solution=solution,
            answer_type="expression",
            time=300
        )
        
    elseif problem_type == 3
        # Sum of powers of complex roots (ELO 2700-3200)
        # If ω is a primitive nth root of unity, compute sum
        
        n = rand(5:9)
        k = randint(2, 3*n)
        
        question = "Let \\(\\omega = e^{2\\pi i/$n}\\) be a primitive \\($n\\)-th root of unity. Compute \\(\\sum_{j=0}^{$(n-1)} \\omega^{$(k)j}\\)."
        
        # If k is divisible by n, sum = n. Otherwise sum = 0
        remainder = mod(k, n)
        answer = remainder == 0 ? string(n) : "0"
        
        solution = steps(
            "The sum \\(S = \\sum_{j=0}^{$(n-1)} \\omega^{$(k)j}\\) is a geometric series with first term 1 and ratio \\(\\omega^{$k}\\)",
            "Since \\(\\omega^{$n} = 1\\), we have \\(\\omega^{$k} = \\omega^{$(remainder)}\\)",
            remainder == 0 ? "Since \\($k \\equiv 0 \\pmod{$n}\\), each term equals 1, so \\(S = $n\\)" : "For \\(r = \\omega^{$(remainder)} \\neq 1\\), the geometric sum is \\(S = \\frac{1 - r^{$n}}{1 - r} = \\frac{1 - (\\omega^{$(remainder)})^{$n}}{1 - \\omega^{$(remainder)}} = \\frac{1 - 1}{1 - \\omega^{$(remainder)}} = 0\\)",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2700, 3200),
            solution=solution,
            time=270
        )
        
    elseif problem_type == 4
        # Complex polynomial with specific properties (ELO 2800-3400)
        # Find polynomial with given complex roots and constraints
        
        r = randint(2, 5)
        a = randint(1, 4)
        b = randint(1, 4)
        
        question = "Find the monic polynomial of degree 4 with real coefficients that has roots \\($a + $b i\\) and \\($r\\), where \\($r\\) is a root of multiplicity 2."
        
        # Roots are: a+bi, a-bi (conjugate), r, r
        # Polynomial = (x - (a+bi))(x - (a-bi))(x - r)^2
        # = ((x-a)^2 + b^2)(x-r)^2
        # = (x^2 - 2ax + a^2 + b^2)(x^2 - 2rx + r^2)
        
        c1 = -2*a
        c2 = a^2 + b^2
        d1 = -2*r
        d2 = r^2
        
        # Expand (x^2 + c1*x + c2)(x^2 + d1*x + d2)
        coef4 = 1
        coef3 = c1 + d1
        coef2 = c2 + c1*d1 + d2
        coef1 = c1*d2 + c2*d1
        coef0 = c2*d2
        
        answer = "x^4"
        if coef3 != 0
            answer *= coef3 > 0 ? " + $(coef3)x^3" : " - $(abs(coef3))x^3"
        end
        if coef2 != 0
            answer *= coef2 > 0 ? " + $(coef2)x^2" : " - $(abs(coef2))x^2"
        end
        if coef1 != 0
            answer *= coef1 > 0 ? " + $(coef1)x" : " - $(abs(coef1))x"
        end
        if coef0 != 0
            answer *= coef0 > 0 ? " + $(coef0)" : " - $(abs(coef0))"
        end
        
        solution = steps(
            "The roots are \\($a + $b i\\), \\($a - $b i\\) (conjugate pair), and \\($r\\) with multiplicity 2",
            "The polynomial is \\(P(x) = (x - ($a + $b i))(x - ($a - $b i))(x - $r)^2\\)",
            "Simplify the complex conjugate pair: \\((x - $a - $b i)(x - $a + $b i) = (x - $a)^2 + $(b^2) = x^2 - $(2*a)x + $(a^2 + b^2)\\)",
            "Expand \\((x - $r)^2 = x^2 - $(2*r)x + $(r^2)\\)",
            "Multiply the quadratics to get the final polynomial",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2800, 3400),
            solution=solution,
            answer_type="expression",
            time=300
        )
        
    else
        # Olympiad-level: Complex numbers in geometry (ELO 3000-3500)
        # Find locus or prove property using complex plane
        
        n = rand(3:6)
        
        question = "Let \\(z_1, z_2, \\ldots, z_{$n}\\) be complex numbers on the unit circle (i.e., \\(|z_k| = 1\\)) such that \\(z_1 + z_2 + \\cdots + z_{$n} = 0\\). Prove that \\(z_1, z_2, \\ldots, z_{$n}\\) form the vertices of a regular \\($n\\)-gon if and only if \\(\\sum_{k=1}^{$n} z_k^2 = 0\\) as well."
        
        answer = "Proof: For a regular $n-gon centered at origin with vertices on unit circle, \\(z_k = e^{2\\pi i(k-1)/$n}\\). Both sums equal 0 by roots of unity. Conversely, the constraints force regularity."
        
        solution = steps(
            "Forward direction: If \\(z_k = e^{2\\pi i(k-1)/$n}\\) (regular $n-gon), then \\(\\sum z_k = \\sum_{k=0}^{$(n-1)} e^{2\\pi ik/$n} = 0\\) (sum of $n-th roots of unity)",
            "Also \\(\\sum z_k^2 = \\sum_{k=0}^{$(n-1)} e^{4\\pi ik/$n} = 0\\) (sum of $(2*n)-th roots with period $n)",
            "Reverse direction: Given \\(|z_k| = 1\\) and both power sums zero, write \\(z_k = e^{i\\theta_k}\\)",
            "The constraints \\(\\sum e^{i\\theta_k} = 0\\) and \\(\\sum e^{2i\\theta_k} = 0\\) with \\($n\\) points on unit circle force equal angular spacing",
            sol("Conclusion", "The conditions are equivalent to forming a regular $n-gon")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3000, 3500),
            solution=solution,
            answer_type="expression",
            time=360
        )
    end
end