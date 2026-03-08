#= Physics utilities for problem generation scripts =#

# ---------------------------------------------------------------------------
# Physical constants
# ---------------------------------------------------------------------------

"""Named tuple of fundamental physical constants (SI units)."""
const PHYS = (
    g     = 9.80,       # gravitational acceleration (m/s²)
    G     = 6.674e-11,  # gravitational constant (N⋅m²/kg²)
    c     = 3.0e8,      # speed of light (m/s)
    k_e   = 8.988e9,    # Coulomb constant (N⋅m²/C²)
    eps_0 = 8.854e-12,  # vacuum permittivity (F/m)
    mu_0  = 1.257e-6,   # vacuum permeability (T⋅m/A)
    k_B   = 1.381e-23,  # Boltzmann constant (J/K)
    e     = 1.602e-19,  # elementary charge (C)
    m_e   = 9.109e-31,  # electron mass (kg)
    m_p   = 1.673e-27,  # proton mass (kg)
    N_A   = 6.022e23,   # Avogadro's number (1/mol)
    R     = 8.314,      # ideal gas constant (J/(mol⋅K))
    sigma = 5.670e-8,   # Stefan-Boltzmann constant (W/(m²⋅K⁴))
    atm   = 1.013e5,    # standard atmosphere (Pa)
)

# ---------------------------------------------------------------------------
# Formatting
# ---------------------------------------------------------------------------

"""Format a physical quantity with significant digits."""
fmt_phys(val; digits::Int=3) = string(round(Float64(val); sigdigits=digits))

# ---------------------------------------------------------------------------
# Unit conversions
# ---------------------------------------------------------------------------

const UNIT_CONVERSIONS = Dict{String,Float64}(
    "km_to_m"    => 1000.0,
    "m_to_cm"    => 100.0,
    "cm_to_m"    => 0.01,
    "mi_to_m"    => 1609.34,
    "ft_to_m"    => 0.3048,
    "in_to_m"    => 0.0254,
    "kg_to_g"    => 1000.0,
    "g_to_kg"    => 0.001,
    "lb_to_kg"   => 0.4536,
    "hr_to_s"    => 3600.0,
    "min_to_s"   => 60.0,
    "L_to_m3"    => 0.001,
    "atm_to_Pa"  => 1.013e5,
    "eV_to_J"    => 1.602e-19,
    "cal_to_J"   => 4.184,
    "deg_to_rad" => π / 180,
    "rad_to_deg" => 180 / π,
)

"""Convert a value using a named conversion key."""
convert_unit(val, key::String) = val * UNIT_CONVERSIONS[key]

# ---------------------------------------------------------------------------
# Kinematics
# ---------------------------------------------------------------------------

"""
Solve 1D kinematics. Give 3 of {v0, v, a, t, d}, get the other 2.
Returns a named tuple with all five values.
"""
function kinematic_1d(; v0=nothing, v=nothing, a=nothing, t=nothing, d=nothing)
    known = Dict(:v0 => v0, :v => v, :a => a, :t => t, :d => d)
    missing_keys = [k for (k, val) in known if val === nothing]
    length(missing_keys) == 2 || error("Provide exactly 3 of {v0, v, a, t, d}")

    v0f = v0 !== nothing ? Float64(v0) : NaN
    vf  = v  !== nothing ? Float64(v)  : NaN
    af  = a  !== nothing ? Float64(a)  : NaN
    tf  = t  !== nothing ? Float64(t)  : NaN
    df  = d  !== nothing ? Float64(d)  : NaN

    # Solve for unknowns using kinematic equations
    for _ in 1:3  # iterate to resolve dependencies
        if isnan(vf) && !isnan(v0f) && !isnan(af) && !isnan(tf)
            vf = v0f + af * tf
        end
        if isnan(df) && !isnan(v0f) && !isnan(tf) && !isnan(af)
            df = v0f * tf + 0.5 * af * tf^2
        end
        if isnan(df) && !isnan(vf) && !isnan(v0f) && !isnan(af)
            df = (vf^2 - v0f^2) / (2 * af)
        end
        if isnan(tf) && !isnan(v0f) && !isnan(vf) && !isnan(af)
            af != 0 || error("Cannot solve for t when a=0 and v0≠v")
            tf = (vf - v0f) / af
        end
        if isnan(af) && !isnan(v0f) && !isnan(vf) && !isnan(tf)
            tf != 0 || error("Cannot solve for a when t=0")
            af = (vf - v0f) / tf
        end
        if isnan(v0f) && !isnan(vf) && !isnan(af) && !isnan(tf)
            v0f = vf - af * tf
        end
        if isnan(v0f) && !isnan(df) && !isnan(af) && !isnan(tf)
            tf != 0 || error("Cannot solve for v0 when t=0")
            v0f = (df - 0.5 * af * tf^2) / tf
        end
        if isnan(tf) && !isnan(v0f) && !isnan(df) && !isnan(af)
            # d = v0*t + 0.5*a*t² → quadratic in t
            disc = v0f^2 + 2 * af * df
            disc >= 0 || error("No real solution for t (discriminant < 0)")
            if af != 0
                t1 = (-v0f + sqrt(disc)) / af
                t2 = (-v0f - sqrt(disc)) / af
                tf = t1 >= 0 ? t1 : t2
            else
                v0f != 0 || error("Cannot solve: a=0, v0=0")
                tf = df / v0f
            end
        end
        if isnan(vf) && !isnan(v0f) && !isnan(af) && !isnan(df)
            val = v0f^2 + 2 * af * df
            val >= 0 || error("No real solution for v")
            vf = sqrt(val)
        end
    end

    return (v0=v0f, v=vf, a=af, t=tf, d=df)
end

"""
Projectile motion. Returns (range, max_height, time_of_flight, vx, vy0).
Angles in degrees.
"""
function projectile(v0, angle_deg; g=PHYS.g)
    θ = angle_deg * π / 180
    vx = v0 * cos(θ)
    vy0 = v0 * sin(θ)
    t_flight = 2 * vy0 / g
    max_h = vy0^2 / (2g)
    R = vx * t_flight
    return (range=R, max_height=max_h, time=t_flight, vx=vx, vy0=vy0)
end

"""Generate random projectile parameters with clean numbers."""
function rand_projectile()
    v0 = randint(10, 50)
    angle = choice([30, 37, 45, 53, 60])
    return (v0=v0, angle=angle)
end

# ---------------------------------------------------------------------------
# Forces
# ---------------------------------------------------------------------------

"""Newton's second law: give 2 of {F, m, a}, get the third."""
function newton2(; F=nothing, m=nothing, a=nothing)
    count = (F !== nothing) + (m !== nothing) + (a !== nothing)
    count == 2 || error("Provide exactly 2 of {F, m, a}")
    if F === nothing
        return Float64(m) * Float64(a)
    elseif m === nothing
        return Float64(F) / Float64(a)
    else
        return Float64(F) / Float64(m)
    end
end

"""Weight from mass."""
weight(m; g=PHYS.g) = m * g

"""Friction force."""
friction(mu, N) = mu * N

"""Net force from a list of (magnitude, angle_deg) pairs."""
function net_force(forces::Vector)
    fx = sum(F * cosd(θ) for (F, θ) in forces)
    fy = sum(F * sind(θ) for (F, θ) in forces)
    mag = sqrt(fx^2 + fy^2)
    angle = atand(fy, fx)
    return (magnitude=mag, angle=angle, fx=fx, fy=fy)
end

# ---------------------------------------------------------------------------
# Energy & Work
# ---------------------------------------------------------------------------

"""Kinetic energy."""
ke(m, v) = 0.5 * m * v^2

"""Gravitational potential energy."""
pe(m, h; g=PHYS.g) = m * g * h

"""Spring potential energy."""
pe_spring(k, x) = 0.5 * k * x^2

"""Work done by force F over distance d at angle theta_deg."""
work(F, d; theta_deg=0) = F * d * cosd(theta_deg)

"""Power = work / time."""
power(W, t) = W / t

# ---------------------------------------------------------------------------
# Momentum & Collisions
# ---------------------------------------------------------------------------

"""Linear momentum."""
momentum(m, v) = m * v

"""Impulse."""
impulse(F, dt) = F * dt

"""1D elastic collision. Returns (v1_final, v2_final)."""
function elastic_collision(m1, v1, m2, v2)
    v1f = ((m1 - m2) * v1 + 2m2 * v2) / (m1 + m2)
    v2f = ((m2 - m1) * v2 + 2m1 * v1) / (m1 + m2)
    return (v1=v1f, v2=v2f)
end

"""1D perfectly inelastic collision. Returns final velocity."""
inelastic_collision(m1, v1, m2, v2) = (m1 * v1 + m2 * v2) / (m1 + m2)

# ---------------------------------------------------------------------------
# Rotation
# ---------------------------------------------------------------------------

"""Angular velocity from linear velocity and radius."""
angular_velocity(v, r) = v / r

"""Centripetal acceleration."""
centripetal_accel(v, r) = v^2 / r

"""Common moments of inertia."""
const INERTIA = (
    solid_sphere    = (m, r) -> 2/5 * m * r^2,
    hollow_sphere   = (m, r) -> 2/3 * m * r^2,
    solid_cylinder  = (m, r) -> 1/2 * m * r^2,
    hollow_cylinder = (m, r) -> m * r^2,
    rod_center      = (m, L) -> 1/12 * m * L^2,
    rod_end         = (m, L) -> 1/3 * m * L^2,
    disk            = (m, r) -> 1/2 * m * r^2,
)

"""Torque = r × F (magnitude)."""
torque(r, F; theta_deg=90) = r * F * sind(theta_deg)

"""Rotational kinetic energy."""
ke_rotational(I, omega) = 0.5 * I * omega^2

# ---------------------------------------------------------------------------
# Oscillations
# ---------------------------------------------------------------------------

"""Period of a mass-spring system."""
shm_period_spring(m, k) = 2π * sqrt(m / k)

"""Period of a simple pendulum."""
shm_period_pendulum(L; g=PHYS.g) = 2π * sqrt(L / g)

"""Frequency from period."""
shm_frequency(T) = 1.0 / T

"""Maximum velocity in SHM."""
shm_vmax(A, omega) = A * omega

# ---------------------------------------------------------------------------
# Waves
# ---------------------------------------------------------------------------

"""Wave speed v = f * λ."""
wave_speed(f, λ) = f * λ

"""Frequency from wave speed and wavelength."""
wave_frequency(v, λ) = v / λ

"""Wavelength from wave speed and frequency."""
wavelength(v, f) = v / f

"""Doppler effect: observed frequency."""
function doppler(f_source, v_sound, v_observer, v_source; approaching::Bool=true)
    if approaching
        return f_source * (v_sound + v_observer) / (v_sound - v_source)
    else
        return f_source * (v_sound - v_observer) / (v_sound + v_source)
    end
end

"""Speed of sound in air at temperature T (°C)."""
speed_of_sound(T_celsius) = 331.3 + 0.606 * T_celsius

# ---------------------------------------------------------------------------
# Fluids
# ---------------------------------------------------------------------------

"""Pressure = F / A."""
pressure(F, A) = F / A

"""Hydrostatic pressure at depth h."""
hydrostatic_pressure(rho, h; g=PHYS.g) = rho * g * h

"""Buoyant force (Archimedes)."""
buoyant_force(rho_fluid, V; g=PHYS.g) = rho_fluid * V * g

"""Volume flow rate Q = A * v."""
flow_rate(A, v) = A * v

# ---------------------------------------------------------------------------
# Thermodynamics
# ---------------------------------------------------------------------------

c_to_k(c) = c + 273.15
k_to_c(k) = k - 273.15
c_to_f(c) = c * 9/5 + 32
f_to_c(f) = (f - 32) * 5/9

"""Heat transfer Q = mcΔT."""
heat_transfer(m, c, dT) = m * c * dT

"""Ideal gas law: give 3 of {P, V, n, T}, get the fourth."""
function ideal_gas(; P=nothing, V=nothing, n=nothing, T=nothing)
    R = PHYS.R
    count = (P !== nothing) + (V !== nothing) + (n !== nothing) + (T !== nothing)
    count == 3 || error("Provide exactly 3 of {P, V, n, T}")
    if P === nothing
        return Float64(n) * R * Float64(T) / Float64(V)
    elseif V === nothing
        return Float64(n) * R * Float64(T) / Float64(P)
    elseif n === nothing
        return Float64(P) * Float64(V) / (R * Float64(T))
    else
        return Float64(P) * Float64(V) / (Float64(n) * R)
    end
end

"""Carnot efficiency."""
carnot_efficiency(T_cold, T_hot) = 1.0 - T_cold / T_hot

# ---------------------------------------------------------------------------
# Electrostatics & Circuits
# ---------------------------------------------------------------------------

"""Coulomb force between two charges."""
coulomb_force(q1, q2, r) = PHYS.k_e * abs(q1 * q2) / r^2

"""Electric field from a point charge at distance r."""
electric_field_point(q, r) = PHYS.k_e * abs(q) / r^2

"""Ohm's law: give 2 of {V, I, R}, get the third."""
function ohm(; V=nothing, I=nothing, R=nothing)
    count = (V !== nothing) + (I !== nothing) + (R !== nothing)
    count == 2 || error("Provide exactly 2 of {V, I, R}")
    if V === nothing
        return Float64(I) * Float64(R)
    elseif I === nothing
        return Float64(V) / Float64(R)
    else
        return Float64(V) / Float64(I)
    end
end

"""Total resistance in series."""
resistance_series(Rs...) = sum(Rs)

"""Total resistance in parallel."""
resistance_parallel(Rs...) = 1.0 / sum(1.0 / R for R in Rs)

"""Electrical power (P = VI or V²/R or I²R)."""
function electrical_power(; V=nothing, I=nothing, R=nothing)
    if V !== nothing && I !== nothing
        return Float64(V) * Float64(I)
    elseif V !== nothing && R !== nothing
        return Float64(V)^2 / Float64(R)
    elseif I !== nothing && R !== nothing
        return Float64(I)^2 * Float64(R)
    else
        error("Provide at least 2 of {V, I, R}")
    end
end

"""Generate a random circuit configuration."""
function rand_circuit()
    V = randint(3, 24)
    n_resistors = randint(2, 4)
    resistors = [randint(2, 20) * 10 for _ in 1:n_resistors]  # multiples of 10Ω
    topology = choice([:series, :parallel])
    return (V=V, resistors=resistors, topology=topology)
end

"""RC time constant."""
rc_time_constant(R, C) = R * C

"""Capacitors in parallel (add capacitances)."""
capacitance_parallel(Cs...) = sum(Cs)

"""Energy stored in a capacitor."""
capacitor_energy(C, V) = 0.5 * C * V^2

# ---------------------------------------------------------------------------
# Magnetism
# ---------------------------------------------------------------------------

"""Force on a charge moving in a magnetic field."""
magnetic_force_charge(q, v, B; theta_deg=90) = abs(q) * v * B * sind(theta_deg)

"""Force on a current-carrying wire in a magnetic field."""
magnetic_force_wire(I, L, B; theta_deg=90) = I * L * B * sind(theta_deg)

"""Magnetic field from a long straight wire at distance r."""
B_wire(I, r) = PHYS.mu_0 * I / (2π * r)

"""Magnetic field inside a solenoid."""
B_solenoid(n, I) = PHYS.mu_0 * n * I

# ---------------------------------------------------------------------------
# Optics
# ---------------------------------------------------------------------------

"""Snell's law: n1 sin(θ1) = n2 sin(θ2). Returns θ2 in degrees."""
function snell(n1, theta1_deg, n2)
    sin_theta2 = n1 * sind(theta1_deg) / n2
    abs(sin_theta2) <= 1 || error("Total internal reflection (sin > 1)")
    return asind(sin_theta2)
end

"""Critical angle for total internal reflection (degrees)."""
function critical_angle(n1, n2)
    n1 > n2 || error("n1 must be > n2 for total internal reflection")
    return asind(n2 / n1)
end

"""Thin lens/mirror equation: give 2 of {f, d_o, d_i}, get the third."""
function thin_lens(; f=nothing, d_o=nothing, d_i=nothing)
    count = (f !== nothing) + (d_o !== nothing) + (d_i !== nothing)
    count == 2 || error("Provide exactly 2 of {f, d_o, d_i}")
    if f === nothing
        return 1.0 / (1.0 / Float64(d_o) + 1.0 / Float64(d_i))
    elseif d_i === nothing
        return 1.0 / (1.0 / Float64(f) - 1.0 / Float64(d_o))
    else
        return 1.0 / (1.0 / Float64(f) - 1.0 / Float64(d_i))
    end
end

"""Magnification = -d_i / d_o."""
magnification(d_i, d_o) = -d_i / d_o

# ---------------------------------------------------------------------------
# Gravitation
# ---------------------------------------------------------------------------

"""Gravitational force between two masses."""
gravity_force(m1, m2, r) = PHYS.G * m1 * m2 / r^2

"""Orbital velocity."""
orbital_velocity(M, r) = sqrt(PHYS.G * M / r)

"""Orbital period."""
orbital_period(M, r) = 2π * r / orbital_velocity(M, r)

"""Escape velocity."""
escape_velocity(M, r) = sqrt(2 * PHYS.G * M / r)

# ---------------------------------------------------------------------------
# Electromagnetic induction
# ---------------------------------------------------------------------------

"""Magnetic flux Φ = BAcos(θ)."""
magnetic_flux(B, A; theta_deg=0) = B * A * cosd(theta_deg)

"""Faraday's EMF: ε = -N ΔΦ/Δt."""
faraday_emf(N, dPhi, dt) = -N * dPhi / dt

"""Motional EMF: ε = BLv."""
motional_emf(B, L, v) = B * L * v

"""Energy stored in an inductor."""
inductor_energy(L, I) = 0.5 * L * I^2

# ---------------------------------------------------------------------------
# Random mechanics problem generator
# ---------------------------------------------------------------------------

"""Generate random parameters for a basic mechanics problem."""
function rand_mech()
    m = randint(1, 50)
    v = randint(1, 30)
    h = randint(1, 20)
    theta = choice([0, 30, 37, 45, 53, 60, 90])
    mu = choice([0.1, 0.2, 0.25, 0.3, 0.4, 0.5])
    return (m=m, v=v, h=h, theta=theta, mu=mu)
end
