\name{HPOSYNONYM}
\alias{HPOSYNONYM}
\title{Map from HPO synonyms to HPO terms}
\description{
    HPOSYNONYM is an R object that provides mapping
    from HPO synonyms to HPO terms
}
\details{
    Mappings were based on data provided by: Human Phenotype Ontology
    With a date stamp from the source of: 20230405


}

\value{
    \code{HPO_dbconn}: a DBIConnection object representing an
    open connection to the package annotation DB.

    \code{HPO_dbfile}: a character string with the path to the
    package annotation DB.

    \code{HPO_dbschema}: none (invisible \code{NULL}).

    \code{HPO_dbInfo}: none (invisible \code{NULL}).
}

\examples{
    # Convert the object to a list
    xx <- as.list(HPOSYNONYM)
}

\references{
\url{https://hpo.jax.org/app/data/ontology} 
}


\keyword{datasets}

