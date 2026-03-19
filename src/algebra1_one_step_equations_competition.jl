# algebra1 - one_step_equations (competition)
# Generated: 2026-03-08T19:52:55.305205

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/one_step_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Olympiad-level: Solve ax ≡ b (mod p^k) with large prime power modulus
        p = choice([7, 11, 13, 17, 19, 23])
        k = randint(3, 5)
        mod_val = p^k
        
        # Pick answer coprime to p
        ans = nonzero(1, min(100, mod_val-1))
        while gcd(ans, p) != 1
            ans = nonzero(1, min(100, mod_val-1))
        end
        
        # Pick a coprime to p
        a = nonzero(2, min(50, mod_val-1))
        while gcd(a, p) != 1
            a = nonzero(2, min(50, mod_val-1))
        end
        
        b = mod(a * ans, mod_val)
        
        # Compute modular inverse using extended Euclidean algorithm
        function mod_inverse(a, m)
            g, x, _ = gcdx(a, m)
            return mod(x, m)
        end
        
        a_inv = mod_inverse(a, mod_val)
        solution_val = mod(a_inv * b, mod_val)
        
        problem(
            question="Solve the modular equation: \$$(a)x \\equiv $(b) \\pmod{$(mod_val)}\$. Find the unique solution \$x\$ where \$0 \\le x < $(mod_val)\$.",
            answer=solution_val,
            difficulty=(3500, 4000),
            solution=steps(
                "Given: \$$(a)x \\equiv $(b) \\pmod{$(p)^{$(k)}}\$",
                "Since \$\\gcd($(a), $(p)^{$(k)}) = 1\$, we can find the modular inverse of $(a) modulo $(mod_val)",
                "Using the extended Euclidean algorithm, \$$(a)^{-1} \\equiv $(a_inv) \\pmod{$(mod_val)}\$",
                "Multiply both sides: \$x \\equiv $(a_inv) \\cdot $(b) \\equiv $(solution_val) \\pmod{$(mod_val)}\$",
                sol("Answer", solution_val)
            ),
            time=240,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Research-adjacent: Solve equation in finite field F_p with nested operations
        p = choice([31, 37, 41, 43, 47, 53, 59, 61, 67, 71])
        
        ans = nonzero(1, p-1)
        
        # Create equation: a*x^(p-2) + b ≡ c (mod p), using Fermat's little theorem
        a = nonzero(1, p-1)
        b = randint(0, p-1)
        
        # ans^(p-2) is the modular inverse of ans in F_p
        c = mod(a * powermod(ans, p-2, p) + b, p)
        
        # Solution: x = ((c-b)/a)^((p-1)/2) mod p
        function solve_fermat(a, b, c, p)
            diff = mod(c - b, p)
            a_inv = powermod(a, p-2, p)
            val = mod(diff * a_inv, p)
            # val = x^(p-2), so x = val^((p-1)/2) mod p (using Fermat)
            # Actually x^(p-2) = val means x = val^(inverse of p-2 mod p-1)
            exp_inv = invmod(p-2, p-1)
            return powermod(val, exp_inv, p)
        end
        
        solution_val = solve_fermat(a, b, c, p)
        
        problem(
            question="In the finite field \$\\mathbb{F}_{$(p)}\$, solve for \$x\$: \$$(a)x^{$(p-2)} + $(b) \\equiv $(c) \\pmod{$(p)}\$. Find the unique solution where \$0 \\le x < $(p)\$.",
            answer=solution_val,
            difficulty=(4000, 4500),
            solution=steps(
                "Given: \$$(a)x^{$(p-2)} + $(b) \\equiv $(c) \\pmod{$(p)}\$",
                "Subtract $(b): \$$(a)x^{$(p-2)} \\equiv $(mod(c-b, p)) \\pmod{$(p)}\$",
                "By Fermat's Little Theorem, \$x^{$(p-1)} \\equiv 1 \\pmod{$(p)}\$ for \$x \\not\\equiv 0\$",
                "Multiply both sides by \$$(a)^{-1} \\equiv $(powermod(a, p-2, p)) \\pmod{$(p)}\$",
                "We get \$x^{$(p-2)} \\equiv $(mod(mod(c-b, p) * powermod(a, p-2, p), p)) \\pmod{$(p)}\$",
                "Solving the discrete logarithm problem using properties of \$\\mathbb{F}_{$(p)}\$",
                sol("Answer", solution_val)
            ),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Olympiad: Diophantine equation with constrained solution
        # ax + by = c where we want positive integer solutions with additional constraint
        
        a = randint(7, 20)
        b = randint(7, 20)
        while gcd(a, b) != 1
            b = randint(7, 20)
        end
        
        # Pick specific solution
        x0 = randint(5, 15)
        y0 = randint(5, 15)
        c = a * x0 + b * y0
        
        # Add constraint: find x such that both x and y are positive and x + y is minimized
        # General solution: x = x0 + bt, y = y0 - at
        # We need x > 0 and y > 0
        # x0 + bt > 0 => t > -x0/b
        # y0 - at > 0 => t < y0/a
        
        t_min = ceil(-x0/b) |> Int
        t_max = floor(y0/a) |> Int
        
        # Find t that minimizes x + y = x0 + y0 + t(b - a)
        if b > a
            t_opt = t_min
        else
            t_opt = t_max
        end
        
        ans = x0 + b * t_opt
        
        problem(
            question="Find the positive integer \$x\$ that minimizes \$x + y\$ subject to the linear Diophantine equation \$$(a)x + $(b)y = $(c)\$ where both \$x, y\$ are positive integers.",
            answer=ans,
            difficulty=(3800, 4200),
            solution=steps(
                "Given: \$$(a)x + $(b)y = $(c)\$ with \$x, y > 0\$",
                "Since \$\\gcd($(a), $(b)) = 1\$ divides $(c), solutions exist",
                "Find particular solution using extended Euclidean algorithm: \$(x_0, y_0) = ($(x0), $(y0))\$",
                "General solution: \$x = $(x0) + $(b)t\$, \$y = $(y0) - $(a)t\$ for integer \$t\$",
                "Constraints: \$$(x0) + $(b)t > 0\$ and \$$(y0) - $(a)t > 0\$",
                "This gives \$t \\in [$(t_min), $(t_max)]\$",
                "To minimize \$x + y = $(x0 + y0) + t($(b - a))\$, choose \$t = $(t_opt)\$",
                sol("Answer", ans)
            ),
            time=270,
            calculator="none"
        )
        
    else
        # Research-adjacent: Matrix equation over Z_p
        p = choice([11, 13, 17, 19, 23])
        
        # Solve det([[a, x], [b, c]]) ≡ d (mod p) for x
        a = nonzero(1, p-1)
        b = nonzero(1, p-1)
        c = nonzero(1, p-1)
        
        ans = randint(1, p-1)
        
        # det = ac - bx
        d = mod(a*c - b*ans, p)
        
        # Solve: ac - bx ≡ d (mod p)
        # bx ≡ ac - d (mod p)
        # x ≡ (ac - d) * b^(-1) (mod p)
        
        b_inv = powermod(b, p-2, p)
        solution_val = mod((a*c - d) * b_inv, p)
        
        problem(
            question="In \$\\mathbb{Z}_{$(p)}\$, find \$x\$ such that \$\\det\\begin{pmatrix} $(a) & x \\\\ $(b) & $(c) \\end{pmatrix} \\equiv $(d) \\pmod{$(p)}\$. Give the unique solution where \$0 \\le x < $(p)\$.",
            answer=solution_val,
            difficulty=(3600, 4100),
            solution=steps(
                "The determinant is \$$(a) \\cdot $(c) - $(b) \\cdot x = $(a*c) - $(b)x\$",
                "Set equal to $(d): \$$(a*c) - $(b)x \\equiv $(d) \\pmod{$(p)}\$",
                "Rearrange: \$$(b)x \\equiv $(mod(a*c - d, p)) \\pmod{$(p)}\$",
                "Find modular inverse: \$$(b)^{-1} \\equiv $(b_inv) \\pmod{$(p)}\$ using Fermat's Little Theorem",
                "Multiply: \$x \\equiv $(mod(a*c - d, p)) \\cdot $(b_inv) \\equiv $(solution_val) \\pmod{$(p)}\$",
                sol("Answer", solution_val)
            ),
            time=240,
            calculator="none"
        )
    end
end