#' Get Number Averted
#'
#' Calculate the number of averted events after increasing vaccine effectiveness in the population.
#'
#' @param E the original vacine effectiveness
#' @param E_n the new vacine effectiveness
#' @param u the uptake rate in the population
#' @param I the current incidence in the population
#' @return A the number of averted events
#'
#' @examples
#' # In a population changing vaccine effectiveness from
#' # 0.6 to 0.7 where the uptake rate is 0.5 and there is an incidence of
#' # 1 million yearly
#' qaverted(0.6, 0.7, 0.5, 1e6)
#' @export
qaverted <- function(E, E_n, u, I) {
    # I_v is the vaccinated incidence in the current population
    I_v <- ((1 - E) * u * I) / (1 - u + u * (1 - E))

    A <- (1 - ((1 - E_n) / (1 - E))) * I_v
    return(A)
}
