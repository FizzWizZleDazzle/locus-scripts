"""
calculus - integration_by_parts (easy)
Generated: 2026-02-22T05:13:17.268202
"""

from problem_utils import *

def generate():
    # Easy integration by parts: single application, obvious u/dv choices
    # Large parameter spaces ensure 500+ distinct problems

    problem_type = randint(1, 5)

    if problem_type == 1:
        # ∫ x^n * e^(ax) dx  with n=1, a in {1..5}
        a = randint(1, 5)

        question = rf"\int x e^{{{a}x}} \, dx" if a != 1 else r"\int x e^{x} \, dx"
        # u = x, dv = e^(ax), v = e^(ax)/a
        # Result: x*e^(ax)/a - e^(ax)/a^2
        ans = x * exp(a * x) / a - exp(a * x) / a**2

        a_str = str(a) if a != 1 else ""
        solution = steps(
            r"Use integration by parts: $\int u \, dv = uv - \int v \, du$",
            rf"Let $u = x$ and $dv = e^{{{a}x}} \, dx$",
            rf"Then $du = dx$ and $v = \frac{{1}}{{{a}}} e^{{{a}x}}$",
            rf"$\int x e^{{{a}x}} \, dx = \frac{{x}}{{{a}}} e^{{{a}x}} - \int \frac{{1}}{{{a}}} e^{{{a}x}} \, dx$",
            rf"$= \frac{{x}}{{{a}}} e^{{{a}x}} - \frac{{1}}{{{a**2}}} e^{{{a}x}} + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1050, 1200),
            topic="calculus/integration_by_parts",
            solution=solution
        )

    elif problem_type == 2:
        # ∫ x * sin(ax) dx  with a in {1..5}
        a = randint(1, 5)

        question = rf"\int x \sin({a}x) \, dx" if a != 1 else r"\int x \sin(x) \, dx"
        # u = x, dv = sin(ax), v = -cos(ax)/a
        # Result: -x*cos(ax)/a + sin(ax)/a^2
        ans = -x * cos(a * x) / a + sin(a * x) / a**2

        solution = steps(
            r"Use integration by parts: $\int u \, dv = uv - \int v \, du$",
            rf"Let $u = x$ and $dv = \sin({a}x) \, dx$",
            rf"Then $du = dx$ and $v = -\frac{{1}}{{{a}}} \cos({a}x)$",
            rf"$\int x \sin({a}x) \, dx = -\frac{{x}}{{{a}}} \cos({a}x) + \frac{{1}}{{{a}}} \int \cos({a}x) \, dx$",
            rf"$= -\frac{{x}}{{{a}}} \cos({a}x) + \frac{{1}}{{{a**2}}} \sin({a}x) + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/integration_by_parts",
            solution=solution
        )

    elif problem_type == 3:
        # ∫ x * cos(ax) dx  with a in {1..5}
        a = randint(1, 5)

        question = rf"\int x \cos({a}x) \, dx" if a != 1 else r"\int x \cos(x) \, dx"
        # u = x, dv = cos(ax), v = sin(ax)/a
        # Result: x*sin(ax)/a + cos(ax)/a^2
        ans = x * sin(a * x) / a + cos(a * x) / a**2

        solution = steps(
            r"Use integration by parts: $\int u \, dv = uv - \int v \, du$",
            rf"Let $u = x$ and $dv = \cos({a}x) \, dx$",
            rf"Then $du = dx$ and $v = \frac{{1}}{{{a}}} \sin({a}x)$",
            rf"$\int x \cos({a}x) \, dx = \frac{{x}}{{{a}}} \sin({a}x) - \frac{{1}}{{{a}}} \int \sin({a}x) \, dx$",
            rf"$= \frac{{x}}{{{a}}} \sin({a}x) + \frac{{1}}{{{a**2}}} \cos({a}x) + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/integration_by_parts",
            solution=solution
        )

    elif problem_type == 4:
        # ∫ ln(ax) dx  with a in {1..6}
        a = randint(1, 6)

        question = rf"\int \ln({a}x) \, dx" if a != 1 else r"\int \ln(x) \, dx"
        # u = ln(ax), dv = dx => v = x
        # Result: x*ln(ax) - x
        ans = x * log(a * x) - x

        solution = steps(
            r"Use integration by parts: $\int u \, dv = uv - \int v \, du$",
            rf"Let $u = \ln({a}x)$ and $dv = dx$",
            rf"Then $du = \frac{{1}}{{x}} dx$ and $v = x$",
            rf"$\int \ln({a}x) \, dx = x \ln({a}x) - \int x \cdot \frac{{1}}{{x}} \, dx$",
            rf"$= x \ln({a}x) - x + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1150, 1300),
            topic="calculus/integration_by_parts",
            solution=solution
        )

    else:
        # ∫ x * e^(-ax) dx  with a in {1..4}  (negative exponent variant)
        a = randint(1, 4)

        question = rf"\int x e^{{-{a}x}} \, dx"
        # u = x, dv = e^(-ax), v = -e^(-ax)/a
        # Result: -x*e^(-ax)/a - e^(-ax)/a^2
        ans = -x * exp(-a * x) / a - exp(-a * x) / a**2

        solution = steps(
            r"Use integration by parts: $\int u \, dv = uv - \int v \, du$",
            rf"Let $u = x$ and $dv = e^{{-{a}x}} \, dx$",
            rf"Then $du = dx$ and $v = -\frac{{1}}{{{a}}} e^{{-{a}x}}$",
            rf"$\int x e^{{-{a}x}} \, dx = -\frac{{x}}{{{a}}} e^{{-{a}x}} + \frac{{1}}{{{a}}} \int e^{{-{a}x}} \, dx$",
            rf"$= -\frac{{x}}{{{a}}} e^{{-{a}x}} - \frac{{1}}{{{a**2}}} e^{{-{a}x}} + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1150, 1300),
            topic="calculus/integration_by_parts",
            solution=solution
        )

emit(generate())
