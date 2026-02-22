"""
algebra2 - exponential_growth_decay (hard)
Generated: 2026-02-22T04:29:10.433637
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Compound interest with multiple compounding periods and solving for time
        P = randint(1000, 5000)
        A = randint(int(P * 1.5), int(P * 3))
        r = choice([3, 4, 5, 6, 7, 8]) / 100
        n = choice([1, 2, 4, 12])
        
        # Solve for t: A = P(1 + r/n)^(nt)
        # t = ln(A/P) / (n * ln(1 + r/n))
        t_val = float(log(A/P) / (n * log(1 + r/n)))
        
        freq_map = {1: "annually", 2: "semi-annually", 4: "quarterly", 12: "monthly"}
        
        return problem(
            question=f"An investment of \\${P} grows to \\${A} with an annual interest rate of {r*100}\\% compounded {freq_map[n]}. How many years does this take? Round to two decimal places.",
            answer=round(t_val, 2),
            difficulty=(1600, 1700),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Use the compound interest formula: $A = P\\left(1 + \\frac{{r}}{{n}}\\right)^{{nt}}$",
                f"Substitute: ${A} = {P}\\left(1 + \\frac{{{r}}}{{{n}}}\\right)^{{{n}t}}$",
                f"Divide both sides by {P}: $\\frac{{{A}}}{{{P}}} = \\left(1 + \\frac{{{r}}}{{{n}}}\\right)^{{{n}t}}$",
                f"Take natural log: $\\ln\\left(\\frac{{{A}}}{{{P}}}\\right) = {n}t \\cdot \\ln\\left(1 + \\frac{{{r}}}{{{n}}}\\right)$",
                f"Solve for $t$: $t = \\frac{{\\ln\\left(\\frac{{{A}}}{{{P}}}\\right)}}{{{n} \\cdot \\ln\\left(1 + \\frac{{{r}}}{{{n}}}\\right)}}$",
                f"$t = \\frac{{\\ln({A/P:.4f})}}{{{n} \\cdot \\ln({1 + r/n:.6f})}} \\approx {round(t_val, 2)}$ years"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Exponential decay with half-life application
        half_life = choice([5, 8, 10, 12, 15, 20])
        initial = randint(100, 500)
        final = randint(10, int(initial * 0.4))
        
        # N(t) = N_0 * (1/2)^(t/h)
        # Solve for t: t = h * ln(N/N_0) / ln(1/2)
        t_val = float(half_life * log(final/initial) / log(0.5))
        
        return problem(
            question=f"A radioactive substance has a half-life of {half_life} years. If you start with {initial} grams, how many years will it take for the substance to decay to {final} grams? Round to two decimal places.",
            answer=round(t_val, 2),
            difficulty=(1650, 1750),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Use the half-life formula: $N(t) = N_0 \\cdot \\left(\\frac{{1}}{{2}}\\right)^{{t/h}}$",
                f"Substitute: ${final} = {initial} \\cdot \\left(\\frac{{1}}{{2}}\\right)^{{t/{half_life}}}$",
                f"Divide by {initial}: $\\frac{{{final}}}{{{initial}}} = \\left(\\frac{{1}}{{2}}\\right)^{{t/{half_life}}}$",
                f"Take natural log: $\\ln\\left(\\frac{{{final}}}{{{initial}}}\\right) = \\frac{{t}}{{{half_life}}} \\cdot \\ln\\left(\\frac{{1}}{{2}}\\right)$",
                f"Solve for $t$: $t = {half_life} \\cdot \\frac{{\\ln({final}/{initial})}}{{\\ln(0.5)}}$",
                f"$t \\approx {round(t_val, 2)}$ years"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Continuous compound interest with solving for rate
        P = randint(2000, 8000)
        multiplier = choice([2, 3, 4])
        A = P * multiplier
        t = randint(5, 15)
        
        # A = Pe^(rt), solve for r
        # r = ln(A/P) / t
        r_val = float(log(A/P) / t)
        r_percent = round(r_val * 100, 2)
        
        return problem(
            question=f"An investment of \\${P} grows to \\${A} in {t} years with continuous compounding. What is the annual interest rate? Express as a percentage rounded to two decimal places.",
            answer=r_percent,
            difficulty=(1600, 1700),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Use continuous compound interest: $A = Pe^{{rt}}$",
                f"Substitute: ${A} = {P}e^{{r \\cdot {t}}}$",
                f"Divide by {P}: $\\frac{{{A}}}{{{P}}} = e^{{{t}r}}$",
                f"Simplify: ${multiplier} = e^{{{t}r}}$",
                f"Take natural log: $\\ln({multiplier}) = {t}r$",
                f"Solve for $r$: $r = \\frac{{\\ln({multiplier})}}{{{t}}} \\approx {r_val:.6f}$",
                f"Convert to percentage: $r \\approx {r_percent}\\%$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Population growth with finding initial population
        k = choice([2, 3, 4, 5, 6]) / 100
        t = randint(8, 20)
        P_t = randint(15000, 50000)
        
        # P(t) = P_0 * e^(kt), solve for P_0
        P_0 = float(P_t / exp(k * t))
        
        return problem(
            question=f"A population grows exponentially according to $P(t) = P_0 e^{{{k}t}}$, where $t$ is in years. If the population is {P_t} after {t} years, what was the initial population? Round to the nearest whole number.",
            answer=round(P_0),
            difficulty=(1650, 1750),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Use the exponential growth model: $P(t) = P_0 e^{{kt}}$",
                f"Substitute known values: ${P_t} = P_0 e^{{{k} \\cdot {t}}}$",
                f"Simplify exponent: ${P_t} = P_0 e^{{{k*t}}}$",
                f"Solve for $P_0$: $P_0 = \\frac{{{P_t}}}{{e^{{{k*t}}}}}$",
                f"Calculate: $P_0 = \\frac{{{P_t}}}{{{exp(k*t):.6f}}} \\approx {round(P_0)}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Comparing two exponential growth scenarios
        P1 = randint(1000, 3000)
        P2 = randint(1000, 3000)
        r1 = choice([5, 6, 7, 8]) / 100
        r2 = choice([3, 4, 5]) / 100
        
        # Find when P1*e^(r1*t) = P2*e^(r2*t)
        # P1*e^(r1*t) = P2*e^(r2*t)
        # P1/P2 = e^((r2-r1)*t)
        # ln(P1/P2) = (r2-r1)*t
        # t = ln(P1/P2)/(r2-r1)
        
        if P1 > P2:
            t_val = float(log(P1/P2) / (r1 - r2))
            
            return problem(
                question=f"Investment A starts at \\${P1} and grows continuously at {r1*100}\\% per year. Investment B starts at \\${P2} and grows continuously at {r2*100}\\% per year. After how many years will Investment B exceed Investment A? Round to two decimal places.",
                answer=round(t_val, 2),
                difficulty=(1750, 1850),
                topic="algebra2/exponential_growth_decay",
                solution=steps(
                    f"Set up equations: $A(t) = {P1}e^{{{r1}t}}$ and $B(t) = {P2}e^{{{r2}t}}$",
                    f"Find when $B(t) > A(t)$, or equivalently when they're equal",
                    f"${P2}e^{{{r2}t}} = {P1}e^{{{r1}t}}$",
                    f"Divide: $\\frac{{{P2}}}{{{P1}}} = e^{{({r1}-{r2})t}}$",
                    f"Take natural log: $\\ln\\left(\\frac{{{P2}}}{{{P1}}}\\right) = ({r1}-{r2})t$",
                    f"Solve: $t = \\frac{{\\ln({P2}/{P1})}}{{({r1}-{r2})}} \\approx {round(t_val, 2)}$ years"
                ),
                calculator="scientific"
            )
        else:
            t_val = float(log(P2/P1) / (r1 - r2))
            
            return problem(
                question=f"Investment A starts at \\${P1} and grows continuously at {r1*100}\\% per year. Investment B starts at \\${P2} and grows continuously at {r2*100}\\% per year. After how many years will Investment A exceed Investment B? Round to two decimal places.",
                answer=round(t_val, 2),
                difficulty=(1750, 1850),
                topic="algebra2/exponential_growth_decay",
                solution=steps(
                    f"Set up equations: $A(t) = {P1}e^{{{r1}t}}$ and $B(t) = {P2}e^{{{r2}t}}$",
                    f"Find when $A(t) > B(t)$, or equivalently when they're equal",
                    f"${P1}e^{{{r1}t}} = {P2}e^{{{r2}t}}$",
                    f"Divide: $\\frac{{{P1}}}{{{P2}}} = e^{{({r2}-{r1})t}}$",
                    f"Take natural log: $\\ln\\left(\\frac{{{P1}}}{{{P2}}}\\right) = ({r2}-{r1})t$",
                    f"Solve: $t = \\frac{{\\ln({P1}/{P2})}}{{({r2}-{r1})}} \\approx {round(t_val, 2)}$ years"
                ),
                calculator="scientific"
            )

emit(generate())