\name{HPOTERM}
\alias{HPOTERM}
\title{Annotation of HPO Identifiers to HPO Terms}
\description{
    This data set gives mappings between HPO identifiers and their
    respective terms.
}
\details{
    Each HPO identifier is mapped to a \code{HPOTerms} object that has 2 slots:
    do_id: HPO Identifier;
    Term: The term for that HPO id


    Mappings were based on data provided by: Human Phenotype Ontology
    With a date stamp from the source of: 220230405


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
    xx <- as.list(HPOTERM)
}
\references{
\url{https://hpo.jax.org/app/data/ontology}
}
\keyword{datasets}

