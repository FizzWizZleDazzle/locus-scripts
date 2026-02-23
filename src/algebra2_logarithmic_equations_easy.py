"""
algebra2 - logarithmic_equations (easy)
Generated: 2026-02-22T04:32:12.548868
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # log_b(b^x) = x  (ELO 1000-1100)
        base = choice([2, 3, 5, 7, 10])
        exponent = randint(1, 6)

        if base == 10:
            question = f"\\log\\left({base**exponent}\\right)"
        else:
            question = f"\\log_{{{base}}}\\left({base**exponent}\\right)"

        ans = exponent

        return problem(
            question=f"Evaluate: ${question}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Recognize that ${base**exponent} = {base}^{{{exponent}}}$",
                f"Using the property $\\log_b(b^x) = x$",
                f"$= {exponent}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Simple: log_b(x) = c  (ELO 1100-1200)
        base = choice([2, 3, 4, 5, 7])
        result = randint(1, 4)
        ans = base**result

        question = f"\\log_{{{base}}}(x) = {result}"

        return problem(
            question=f"Solve for $x$: ${question}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Given $\\log_{{{base}}}(x) = {result}$",
                f"Convert to exponential form: $x = {base}^{{{result}}}$",
                f"$x = {ans}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # log_b(number) = x  (ELO 1100-1200)
        base = choice([2, 3, 5, 7])
        exponent = randint(1, 4)
        value = base**exponent

        question = f"\\log_{{{base}}}({value}) = x"
        ans = exponent

        return problem(
            question=f"Solve for $x$: ${question}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Recognize that ${value} = {base}^{{{exponent}}}$",
                f"So $\\log_{{{base}}}({base}^{{{exponent}}}) = x$",
                f"Using $\\log_b(b^x) = x$: $x = {exponent}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # log(x) + const1 = const2  (ELO 1200-1300)
        base = choice([2, 3, 5, 10])
        log_result = randint(1, 4)
        const1 = randint(1, 5)
        const2 = log_result + const1
        ans = base**log_result

        if base == 10:
            log_notation = "\\log"
        else:
            log_notation = f"\\log_{{{base}}}"

        question = f"{log_notation}(x) + {const1} = {const2}"

        return problem(
            question=f"Solve for $x$: ${question}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Subtract ${const1}$ from both sides:",
                f"${log_notation}(x) = {log_result}$",
                f"Convert to exponential form: $x = {base}^{{{log_result}}}$",
                f"$x = {ans}$"
            ),
            calculator="scientific"
        )

    else:
        # k*log_b(x) = n  (ELO 1200-1300)
        base = choice([2, 3, 5, 7, 10])
        k = randint(2, 4)
        exponent = randint(1, 3)
        n = k * exponent
        ans = base**exponent

        if base == 10:
            log_notation = "\\log"
        else:
            log_notation = f"\\log_{{{base}}}"

        question = f"{k}{log_notation}(x) = {n}"

        return problem(
            question=f"Solve for $x$: ${question}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Divide both sides by ${k}$: ${log_notation}(x) = {exponent}$",
                f"Convert to exponential form: $x = {base}^{{{exponent}}}$",
                f"$x = {ans}$"
            ),
            calculator="scientific"
        )

emit(generate())
