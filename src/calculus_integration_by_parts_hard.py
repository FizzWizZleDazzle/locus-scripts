"""
calculus - integration_by_parts (hard)
Generated: 2026-02-22T05:14:12.753863
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type 1: Polynomial times trig/exp (1600-1700)
        power = randint(2, 3)
        coeff = nonzero(-3, 3)
        trig_choice = choice(['sin', 'cos'])
        
        if trig_choice == 'sin':
            u = x**power
            dv = sin(x)
            v = -cos(x)
            du = power * x**(power-1)
            
            expr = coeff * x**power * sin(x)
            
            # First integration by parts
            first_term = coeff * x**power * (-cos(x))
            integral_term = -coeff * power * integrate(x**(power-1) * (-cos(x)), x)
            
            ans = simplify(integrate(expr, x))
            
            return problem(
                question=f"\\int {latex(expr)} \\, dx",
                answer=ans,
                difficulty=(1600, 1700),
                topic="calculus/integration_by_parts",
                solution=steps(
                    f"Use integration by parts with $u = {latex(u)}$ and $dv = {latex(dv)} dx$",
                    f"Then $du = {latex(du)} dx$ and $v = {latex(v)}$",
                    f"$\\int u \\, dv = uv - \\int v \\, du$",
                    f"Apply the formula and integrate the remaining term (may need parts again)",
                    f"${latex(ans)} + C$"
                ),
            )
        else:
            u = x**power
            dv = cos(x)
            v = sin(x)
            du = power * x**(power-1)
            
            expr = coeff * x**power * cos(x)
            ans = simplify(integrate(expr, x))
            
            return problem(
                question=f"\\int {latex(expr)} \\, dx",
                answer=ans,
                difficulty=(1600, 1700),
                topic="calculus/integration_by_parts",
                solution=steps(
                    f"Use integration by parts with $u = {latex(u)}$ and $dv = {latex(dv)} dx$",
                    f"Then $du = {latex(du)} dx$ and $v = {latex(v)}$",
                    f"$\\int u \\, dv = uv - \\int v \\, du$",
                    f"Apply the formula and integrate the remaining term (may need parts again)",
                    f"${latex(ans)} + C$"
                ),
            )
    
    elif problem_type == 2:
        # Type 2: ln(x) times polynomial (1650-1750)
        power = randint(2, 4)
        coeff = nonzero(-2, 2)
        
        u = log(x)
        dv = x**power
        du = 1/x
        v = x**(power+1)/(power+1)
        
        expr = coeff * x**power * log(x)
        ans = simplify(integrate(expr, x))
        
        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/integration_by_parts",
            solution=steps(
                f"Use integration by parts with $u = \\ln(x)$ and $dv = {latex(coeff * x**power)} dx$",
                f"Then $du = \\frac{{1}}{{x}} dx$ and $v = {latex(coeff * v)}$",
                f"$\\int u \\, dv = uv - \\int v \\, du$",
                f"$= {latex(coeff * v * log(x))} - \\int {latex(coeff * v)} \\cdot \\frac{{1}}{{x}} dx$",
                f"${latex(ans)} + C$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: e^x times trig (requires two applications) (1750-1850)
        a = nonzero(-2, 2)
        trig_choice = choice(['sin', 'cos'])
        
        if trig_choice == 'sin':
            expr = exp(a*x) * sin(x)
        else:
            expr = exp(a*x) * cos(x)
        
        ans = simplify(integrate(expr, x))
        
        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1750, 1850),
            topic="calculus/integration_by_parts",
            solution=steps(
                f"Use integration by parts twice with $u = {latex(expr.args[1] if len(expr.args) > 1 else sin(x))}$",
                f"First application gives an integral similar to the original",
                f"Second application produces the original integral again",
                f"Solve for the original integral algebraically",
                f"${latex(ans)} + C$"
            ),
        )
    
    elif problem_type == 4:
        # Type 4: Inverse trig times polynomial (1700-1800)
        power = randint(1, 2)
        coeff = nonzero(-3, 3)
        inv_trig = choice(['asin', 'atan'])
        
        if inv_trig == 'asin':
            if power == 1:
                expr = coeff * x * asin(x)
            else:
                expr = coeff * x**2 * asin(x)
        else:
            if power == 1:
                expr = coeff * x * atan(x)
            else:
                expr = coeff * x**2 * atan(x)
        
        ans = simplify(integrate(expr, x))
        
        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1700, 1800),
            topic="calculus/integration_by_parts",
            solution=steps(
                f"Use integration by parts with $u = {latex(expr.args[1] if len(expr.args) > 1 else asin(x))}$",
                f"The derivative of the inverse trig function becomes $du$",
                f"$dv$ is the polynomial part",
                f"Apply the integration by parts formula",
                f"${latex(ans)} + C$"
            ),
        )
    
    else:
        # Type 5: Definite integral with integration by parts (1650-1800)
        coeff = nonzero(-2, 2)
        power = randint(1, 2)
        
        expr = coeff * x**power * exp(x)
        
        # Use bounds that give nice values
        lower = 0
        upper = 1
        
        ans = integrate(expr, (x, lower, upper))
        ans = simplify(ans)
        
        return problem(
            question=f"\\int_{{{lower}}}^{{{upper}}} {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/integration_by_parts",
            solution=steps(
                f"Use integration by parts with $u = {latex(x**power)}$ and $dv = {latex(coeff * exp(x))} dx$",
                f"Then $du = {latex(diff(x**power, x))} dx$ and $v = {latex(coeff * exp(x))}$",
                f"Find the antiderivative first, then evaluate at bounds",
                f"Evaluate at ${upper}$ and ${lower}$",
                f"${latex(ans)}$"
            ),
        )

emit(generate())