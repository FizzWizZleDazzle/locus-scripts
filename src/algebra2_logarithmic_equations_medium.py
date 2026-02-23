"""
algebra2 - logarithmic_equations (medium)
Generated: 2026-02-22T04:32:40.054385
"""

from problem_utils import *

def generate():
    problem_type = choice(['basic_log', 'exponential_form', 'combining_logs', 'log_both_sides', 'two_step'])

    if problem_type == 'basic_log':
        # log_b(ax + c) = n where answer is integer
        base = choice([2, 3, 4, 5, 10])
        power = randint(1, 4)
        a_val = randint(1, 5)
        c_val = randint(0, 10)
        # x = (base^power - c) / a
        num = base**power - c_val
        if num > 0 and num % a_val == 0:
            x_val = num // a_val
        else:
            a_val = 1; c_val = randint(0, 5)
            x_val = base**power - c_val
            if x_val <= 0:
                c_val = 0; x_val = base**power
        ans = x_val

        if a_val == 1 and c_val == 0:
            inner = "x"
        elif a_val == 1:
            inner = f"x + {c_val}" if c_val > 0 else f"x"
        elif c_val == 0:
            inner = f"{a_val}x"
        else:
            inner = f"{a_val}x + {c_val}"

        question = f"\\log_{{{base}}}({inner}) = {power}"

        return problem(
            question=f"Solve for $x$: ${question}$",
            answer=ans,
            difficulty=(1300, 1450),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Convert to exponential form: ${inner} = {base}^{{{power}}} = {base**power}$",
                f"Solve: $x = {ans}$"
            )
        )

    elif problem_type == 'exponential_form':
        # Solve log(ax + b) = c for various bases
        base = choice([2, 3, 5, 10])
        a_val = randint(1, 4)
        c_val = randint(1, 3)
        # pick x_val then compute b
        x_val = randint(1, 10)
        b_val = base**c_val - a_val * x_val
        ans = x_val

        if base == 10:
            log_str = "\\log"
        else:
            log_str = f"\\log_{{{base}}}"

        if b_val >= 0:
            inner = f"{a_val}x + {b_val}" if a_val > 1 else f"x + {b_val}"
        else:
            inner = f"{a_val}x - {-b_val}" if a_val > 1 else f"x - {-b_val}"

        question = f"{log_str}({inner}) = {c_val}"

        solution_steps = [
            f"Convert to exponential form: ${inner} = {base}^{{{c_val}}} = {base**c_val}$",
        ]
        if a_val > 1:
            solution_steps.append(f"${a_val}x = {base**c_val - b_val}$")
        solution_steps.append(f"$x = {ans}$")

        return problem(
            question=f"Solve for $x$: ${question}$",
            answer=ans,
            difficulty=(1300, 1450),
            topic="algebra2/logarithmic_equations",
            solution=steps(*solution_steps)
        )

    elif problem_type == 'combining_logs':
        # log_b(x) + log_b(k) = c or log_b(x) - log_b(k) = c
        base = choice([2, 3, 5, 10])
        use_addition = choice([True, False])

        if use_addition:
            # log_b(x) + log_b(k) = c  => kx = base^c
            c_val = randint(1, 3)
            k_val = randint(2, 6)
            rhs = base**c_val
            if rhs % k_val == 0:
                ans = rhs // k_val
            else:
                k_val = 1; ans = rhs

            if base == 10:
                question = f"\\log(x) + \\log({k_val}) = {c_val}"
            else:
                question = f"\\log_{{{base}}}(x) + \\log_{{{base}}}({k_val}) = {c_val}"

            return problem(
                question=f"Solve for $x$: ${question}$",
                answer=ans,
                difficulty=(1400, 1550),
                topic="algebra2/logarithmic_equations",
                solution=steps(
                    f"Use product rule: $\\log_{{{base}}}({k_val}x) = {c_val}$",
                    f"Convert: ${k_val}x = {base}^{{{c_val}}} = {base**c_val}$",
                    f"$x = {ans}$"
                )
            )
        else:
            # log_b(x) - log_b(k) = c  => x/k = base^c
            c_val = randint(1, 3)
            k_val = randint(2, 8)
            ans = k_val * base**c_val

            if base == 10:
                question = f"\\log(x) - \\log({k_val}) = {c_val}"
            else:
                question = f"\\log_{{{base}}}(x) - \\log_{{{base}}}({k_val}) = {c_val}"

            return problem(
                question=f"Solve for $x$: ${question}$",
                answer=ans,
                difficulty=(1400, 1550),
                topic="algebra2/logarithmic_equations",
                solution=steps(
                    f"Use quotient rule: $\\log_{{{base}}}\\left(\\frac{{x}}{{{k_val}}}\\right) = {c_val}$",
                    f"Convert: $\\frac{{x}}{{{k_val}}} = {base}^{{{c_val}}} = {base**c_val}$",
                    f"$x = {k_val} \\cdot {base**c_val} = {ans}$"
                )
            )

    elif problem_type == 'log_both_sides':
        # b^(cx + d) = b^k => cx + d = k  (integer solution)
        base = choice([2, 3, 5])
        c_val = randint(1, 4)
        d_val = randint(-3, 3)
        k_val = randint(2, 5)
        # c*x + d = k  =>  x = (k - d)/c
        if (k_val - d_val) % c_val == 0:
            x_val = (k_val - d_val) // c_val
        else:
            c_val = 1; x_val = k_val - d_val
        ans = x_val
        rhs = base**k_val

        if d_val > 0:
            exp_str = f"{c_val}x + {d_val}" if c_val > 1 else f"x + {d_val}"
        elif d_val < 0:
            exp_str = f"{c_val}x - {-d_val}" if c_val > 1 else f"x - {-d_val}"
        else:
            exp_str = f"{c_val}x" if c_val > 1 else "x"

        question = f"{base}^{{{exp_str}}} = {rhs}"

        return problem(
            question=f"Solve for $x$: ${question}$",
            answer=ans,
            difficulty=(1350, 1500),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Take $\\log_{{{base}}}$ of both sides",
                f"${exp_str} = \\log_{{{base}}}({rhs}) = {k_val}$",
                f"Solve: $x = {ans}$"
            )
        )

    else:  # two_step
        # a*log_b(x) + c = d  =>  log_b(x) = (d-c)/a  =>  x = b^((d-c)/a)
        base = choice([2, 3, 5, 10])
        a_val = randint(2, 4)
        exponent = randint(1, 4)
        n_val = a_val * exponent
        c_val = randint(1, 8)
        d_val = n_val + c_val
        ans = base**exponent

        if base == 10:
            log_str = "\\log"
        else:
            log_str = f"\\log_{{{base}}}"

        question = f"{a_val}{log_str}(x) + {c_val} = {d_val}"

        return problem(
            question=f"Solve for $x$: ${question}$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Subtract ${c_val}$: ${a_val}{log_str}(x) = {n_val}$",
                f"Divide by ${a_val}$: ${log_str}(x) = {exponent}$",
                f"Convert: $x = {base}^{{{exponent}}} = {ans}$"
            )
        )

emit(generate())
