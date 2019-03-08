"Solve Computing Eccentric Anomaly from Mean Anomally via Kepler's Equation"
module KeplerEqn

export calc_ecc_anom
export calc_ecc_anom_cpu, calc_ecc_anom_gpu
using CUDAnative

"""   ecc_anom_init_guess_danby(M, ecc)
Initial guess for eccentric anomaly given mean anomaly (M) and eccentricity (ecc)
    Based on "The Solution of Kepler's Equations - Part Three"  
    Danby, J. M. A. (1987) Journal: Celestial Mechanics, Volume 40, Issue 3-4, pp. 303-312  1987CeMec..40..303D
"""
function ecc_anom_init_guess_danby(M, ecc)
    k = convert(typeof(ecc),0.85)
    if(M<zero(M)) M += 2pi end
    (M<pi) ? M + k*ecc : M - k*ecc;
end

"""   update_ecc_anom_laguerre(E, M, ecc)
Update the current guess (E) for the solution to Kepler's equation given mean anomaly (M) and eccentricity (ecc)
   Based on "An Improved Algorithm due to Laguerre for the Solution of Kepler's Equation"
   Conway, B. A.  (1986) Celestial Mechanics, Volume 39, Issue 2, pp.199-211  1986CeMec..39..199C
"""
function update_ecc_anom_laguerre(E, M, ecc)
  es = ecc*sin(E)
  ec = ecc*cos(E)
  F = (E-es)-M
  Fp = one(E)-ec
  Fpp = es
  n = 5
  root = sqrt(abs((n-1)*((n-1)*Fp*Fp-n*F*Fpp)))
  denom = Fp>zero(E) ? Fp+root : Fp-root
  return E-n*F/denom
end

"Same as update_ecc_anom_laguerre_cpu, except uses GPU math functions"
function update_ecc_anom_laguerre_gpu(E, M, ecc)
  es = ecc*CUDAnative.sin(E)
  ec = ecc*CUDAnative.cos(E)
  F = (E-es)-M
  Fp = one(E)-ec
  Fpp = es
  n = 5
  root = CUDAnative.sqrt(abs((n-1)*((n-1)*Fp*Fp-n*F*Fpp)))
  denom = Fp>zero(E) ? Fp+root : Fp-root
  return E-n*F/denom
end

"Loop to update the current estimate of the solution to Kepler's equation"
function calc_ecc_anom_itterative_laguerre(mean_anom, ecc, tol, max_its)
    M = mod(mean_anom,convert(typeof(mean_anom),2pi))
    E = ecc_anom_init_guess_danby(M,ecc)
    for i in 1:max_its
       E_old = E
       E = update_ecc_anom_laguerre(E_old, M, ecc)
       if abs(E-E_old)<convert(typeof(mean_anom),tol) break end
    end
    return E
end

"Loop to update the current estimate of the solution to Kepler's equation.  Calls GPU update"
function calc_ecc_anom_itterative_laguerre_gpu(mean_anom, ecc, tol, max_its)
    @assert zero(ecc) <= ecc < one(ecc)
    @assert tol*100 <= one(tol)
    M = mod(mean_anom,convert(typeof(mean_anom),2pi))
    E = ecc_anom_init_guess_danby(M,ecc)
    for i in 1:max_its
       E_old = E
       E = update_ecc_anom_laguerre_gpu(E_old, M, ecc)
       if abs(E-E_old)<convert(typeof(mean_anom),tol) break end
    end
    return E
end

const default_max_its_laguerre = 200
const default_ecc_anom_tol = 1e-8
"Calculate eccentric anomaly given mean anomaly and eccentricty (in radians)"
calc_ecc_anom_cpu(mean_anom, ecc) = calc_ecc_anom_itterative_laguerre(mean_anom, ecc, default_ecc_anom_tol, default_max_its_laguerre)
calc_ecc_anom_gpu(mean_anom, ecc) = calc_ecc_anom_itterative_laguerre_gpu(mean_anom, ecc, default_ecc_anom_tol, default_max_its_laguerre)
calc_ecc_anom(mean_anom, ecc) = calc_ecc_anom_cpu(mean_anom, ecc)

end # module KeplerEqn
