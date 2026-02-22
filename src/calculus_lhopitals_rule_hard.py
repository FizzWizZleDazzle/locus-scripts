"""
calculus - lhopitals_rule (hard)
Generated: 2026-02-22T05:11:01.379869
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Exponential over polynomial with parameter
        power = randint(2, 4)
        coeff = nonzero(-5, 5)
        const = nonzero(-3, 3)
        
        numerator = exp(coeff * x)
        denominator = x**power + const
        
        # L'Hopital not needed at x->infinity, but indeterminate form appears
        # Actually create 0/0 form
        # Better: e^x / x^n as x -> infinity (infinity/infinity)
        
        expr = numerator / denominator
        limit_point = oo
        
        # Apply L'Hopital multiple times
        steps_list = [f"Evaluate $\\lim_{{x \\to \\infty}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$"]
        steps_list.append(f"This is an $\\infty/\\infty$ form, apply L'Hôpital's rule")
        
        num_current = numerator
        den_current = denominator
        
        for i in range(power):
            num_current = diff(num_current, x)
            den_current = diff(den_current, x)
            steps_list.append(f"After differentiation: $\\lim_{{x \\to \\infty}} \\frac{{{latex(num_current)}}}{{{latex(den_current)}}}$")
        
        steps_list.append(f"As $x \\to \\infty$, exponential dominates polynomial, limit is $\\infty$")
        
        ans = oo
        
        return problem(
            question=f"Evaluate $\\lim_{{x \\to \\infty}} {latex(expr)}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/lhopitals_rule",
            solution=steps(*steps_list),
        )
    
    elif problem_type == 2:
        # (1 + a/x)^(bx) as x -> infinity
        a_val = nonzero(-5, 5)
        b_val = nonzero(-3, 3)
        
        expr = (1 + a_val/x)**(b_val*x)
        
        # Answer is e^(a*b)
        ans = exp(a_val * b_val)
        
        steps_list = [
            f"Evaluate $\\lim_{{x \\to \\infty}} {latex(expr)}$",
            f"This is a $1^\\infty$ indeterminate form",
            f"Take logarithm: $\\ln L = \\lim_{{x \\to \\infty}} {b_val}x \\ln\\left(1 + \\frac{{{a_val}}}{{x}}\\right)$",
            f"Rewrite as $\\ln L = \\lim_{{x \\to \\infty}} \\frac{{\\ln\\left(1 + \\frac{{{a_val}}}{{x}}\\right)}}{{\\frac{{1}}{{{b_val}x}}}}$",
            f"This is $0/0$ form, apply L'Hôpital's rule",
            f"$\\ln L = \\lim_{{x \\to \\infty}} \\frac{{\\frac{{-{a_val}}}{{x^2 \\left(1 + \\frac{{{a_val}}}{{x}}\\right)}}}}{{\\frac{{-1}}{{{b_val}x^2}}}} = {a_val * b_val}$",
            f"Therefore $L = e^{{{a_val * b_val}}} = {latex(ans)}$"
        ]
        
        return problem(
            question=f"Evaluate $\\lim_{{x \\to \\infty}} {latex(expr)}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/lhopitals_rule",
            solution=steps(*steps_list),
        )
    
    elif problem_type == 3:
        # (sin(ax) - bx) / x^3 as x -> 0
        a_val = nonzero(-4, 4)
        b_val = a_val  # Need b = a for limit to exist and be finite
        
        numerator = sin(a_val * x) - b_val * x
        denominator = x**3
        
        # Answer: -a^3/6
        ans = Rational(-a_val**3, 6)
        
        steps_list = [
            f"Evaluate $\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            f"This is $0/0$ form, apply L'Hôpital's rule",
            f"$\\lim_{{x \\to 0}} \\frac{{{latex(diff(numerator, x))}}}{{{latex(diff(denominator, x))}}}$ = $\\lim_{{x \\to 0}} \\frac{{{a_val}\\cos({a_val}x) - {b_val}}}{{3x^2}}$",
            f"Still $0/0$, apply L'Hôpital again",
            f"$\\lim_{{x \\to 0}} \\frac{{{latex(diff(diff(numerator, x), x))}}}{{{latex(diff(diff(denominator, x), x))}}}$ = $\\lim_{{x \\to 0}} \\frac{{-{a_val**2}\\sin({a_val}x)}}{{6x}}$",
            f"Still $0/0$, apply L'Hôpital once more",
            f"$\\lim_{{x \\to 0}} \\frac{{-{a_val**3}\\cos({a_val}x)}}{{6}} = \\frac{{-{a_val**3}}}{{6}} = {latex(ans)}$"
        ]
        
        return problem(
            question=f"Evaluate $\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            answer=ans,
            difficulty=(1750, 1900),
            topic="calculus/lhopitals_rule",
            solution=steps(*steps_list),
        )
    
    elif problem_type == 4:
        # (e^(ax) - e^(bx)) / sin(cx) as x -> 0
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        while b_val == a_val:
            b_val = nonzero(-4, 4)
        c_val = nonzero(-3, 3)
        
        numerator = exp(a_val * x) - exp(b_val * x)
        denominator = sin(c_val * x)
        
        # Answer: (a - b) / c
        ans = Rational(a_val - b_val, c_val)
        
        steps_list = [
            f"Evaluate $\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            f"This is $0/0$ form, apply L'Hôpital's rule",
            f"$\\lim_{{x \\to 0}} \\frac{{{latex(diff(numerator, x))}}}{{{latex(diff(denominator, x))}}}$",
            f"$= \\lim_{{x \\to 0}} \\frac{{{a_val}e^{{{a_val}x}} - {b_val}e^{{{b_val}x}}}}{{{c_val}\\cos({c_val}x)}}$",
            f"$= \\frac{{{a_val} - {b_val}}}{{{c_val}}} = {latex(ans)}$"
        ]
        
        return problem(
            question=f"Evaluate $\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="calculus/lhopitals_rule",
            solution=steps(*steps_list),
        )
    
    else:
        # x^(1/ln(x)) as x -> infinity
        expr = x**(1/log(x))
        
        # Answer is e
        ans = exp(1)
        
        steps_list = [
            f"Evaluate $\\lim_{{x \\to \\infty}} x^{{1/\\ln(x)}}$",
            f"This is an indeterminate form $\\infty^0$",
            f"Take logarithm: $\\ln L = \\lim_{{x \\to \\infty}} \\frac{{\\ln(x)}}{{\\ln(x)}} = 1$",
            f"Therefore $L = e^1 = e$"
        ]
        
        return problem(
            question=f"Evaluate $\\lim_{{x \\to \\infty}} x^{{\\frac{{1}}{{\\ln(x)}}}}$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/lhopitals_rule",
            solution=steps(*steps_list),
        )

emit(generate())