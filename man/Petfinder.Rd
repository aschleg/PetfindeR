% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api.R
\name{Petfinder}
\alias{Petfinder}
\title{Creates an authenticated connection with the Petfinder API. The stored
authentication is then used to call the Petfinder API methods. An API key can
be obtained from Petfinder by creating an account on their developer page
(https://www.petfinder.com/developers/api-key). The function wraps the
.Petfinder.class R6 class.}
\usage{
Petfinder(key, secret)
}
\arguments{
\item{key}{The API key received from Petfinder}

\item{secret}{The secret key received from Petfinder along with the API key.}
}
\value{
Intialized Petfinder object that is then used to access the API.
}
\description{
Creates an authenticated connection with the Petfinder API. The stored
authentication is then used to call the Petfinder API methods. An API key can
be obtained from Petfinder by creating an account on their developer page
(https://www.petfinder.com/developers/api-key). The function wraps the
.Petfinder.class R6 class.
}
\examples{
\dontrun{
pf <- Petfinder(key) # Creates the connection with the Petfinder API.
pf$breeds('cat') # The connection can now be used to access the Petfinder API methods.
}
}
