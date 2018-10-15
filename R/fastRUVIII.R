# Rewriting of the RUVIII algorithm to optimise it for use with CyTOF data

# Notes:
# We use the fast residop function which forces smaller matrices to be
# multiplied together. We also use the rsvd package to speed up the
# core svd operation. For both of these optimisations I would like to
# thank the authors of the scMerge package
# We also perform a different core SVD opertation to ruv::RUVIII
# which is optimised for genomic data with many more columns than rows.
# Instead we simply SVD the data matrix and compute DV^T (up to a constant).
# To simplify development I have removed any error checking or support for case
# that we were not interested in testing.
# N.B: empirical testing shows that for mass cytof data eta = NULL i.e. no use
# of the RUVI function should be used.
# Otherwise inputs/return value etc. is the same as ruv::RUVIII

fastRUVIII = function(Y, M, ctl, k=NULL, eta=NULL, average=FALSE, fullalpha=NULL){
  # Assumes good input
  if (!(k > 0)) stop("Bad input - read the docs")

  Y = ruv::RUV1(Y,eta,ctl)
  m = nrow(Y)
  Y0 = ruv::residop(Y, M)
  fullalpha = diag(rsvd::rsvd(Y0)$d) %*% t(rsvd::rsvd(Y0)$v)
  alpha = fullalpha[1:k,,drop=FALSE]
  ac = alpha[,ctl,drop=FALSE]
  W = Y[,ctl] %*% t(ac) %*% solve(ac %*% t(ac))
  newY = Y - W %*% alpha
  return(list(newY = newY, fullalpha=fullalpha))
}

fast_residop <- function (A, B) {
  return(A - B %*% solve(t(B) %*% B) %*% (t(B) %*% A))
}


