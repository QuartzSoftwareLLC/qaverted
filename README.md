# QAverted

## Installation

```{R}
remotes::install_github("QuartzSoftwareLLC/qaverted")
```

## Usage

Use the `qaverted` function to run find the number of averted events based on the Averted Formula [derived below](#prevention-derivation).

| Variable | Description |
| --- | --- |
| $A$ | Events Averted |
| $E$ | Current Vaccine Effectiveness |
| $E_n$ | New Vaccine Effectiveness |
| $I_v$ | Incidence in vaccinated population |
| $u$ | Vaccine uptake |

$$I_v = \frac{(1 - E) * u * I}{1 - u + u * (1 - E)} $$

$$ A =  (1 - \frac{1 - E_n}{1 - E})* I_v$$

```{R}
qaverted(0.6, 0.7, 0.5, 1e6)
```

## Prevention Derivation

Using unvaccinated attack $A_{uv}$ and vaccinated attack rate $A_v$, we can calculate vaccine efficacy $E$.

$$E = \frac{A_{uv} - A_v}{A_{uv}}$$

Which can be simplified to

$$ E = 1 - \frac{A_v}{A_{uv}}$$

Attack rate ($A$) can be calculated from incidence ($I$) and population ($P$):

$$A = I / P$$

Furthermore vaccinated population ($P_v$) and unvaccinated population ($P_{uv}$) can be calculated using total population ($P$) and vaccine uptake $u$.

$$P_v = P * u$$

$$P_{uv} = P * (1 - u)$$

Consequently,

$$E = 1 - \frac{I_v}{P*u} / \frac{I_{uv}}{P  (1 - u)}$$

$I_{uv}$ can be calculated as the difference between total incidence ($I$) and vaccinated incidence ($I_v$)


$$E = 1 - \frac{I_v}{P*u} / \frac{I - I_{v}}{P  (1 - u)}$$

Solving for ($I_v$)

$$I_v = \frac{(1 - E) * u * I}{1 - u + u * (1 - E)} $$

After solving for ($I_v$) we calculate the number of cases in the vaccinated population if efficacy were 0 ($I_{E0}$)

$$ I_{E0} = \frac{I_v}{1 - E} $$

Next we calculate the number of predicted cases ($I_n$) at the new efficacy provided ($E_n$)

$$ I_n = I_{E0} * (1 - E_n) $$

Lastly we take the difference between ($I_n$) and ($I_v$) to calculate the change in incidence ($I_{\Delta}$)

$$I_{\Delta} = I_n - I_v$$

This simplifies further to

$$I_{\Delta} = I_{E0} * (1 - E_n) - I_v$$

Expanding $I_{E0}$

$$I_{\Delta} = \frac{I_v}{1 - E} * (1 - E_n) - I_v$$

Rearranging

$$I_{\Delta} = \frac{1 - E_n}{1 - E} * I_v - I_v$$

Factoring out $I_v$

$$I_{\Delta} = \frac{1 - E_n}{1 - E} * I_v - I_v$$


$$I_{\Delta} = (\frac{1 - E_n}{1 - E}  - 1)* I_v$$

Lastly we can calculate events averted ($A$) by multiplying $I_\Delta$ by $-1$.

$$ A = - I_\Delta$$

$$ A =  (1 - \frac{1 - E_n}{1 - E})* I_v$$

This leaves us with two final formulas required to calculate number averted ($A$)

$$ A =  (1 - \frac{1 - E_n}{1 - E})* I_v$$

$$I_v = \frac{(1 - E) * u * I}{1 - u + u * (1 - E)} $$