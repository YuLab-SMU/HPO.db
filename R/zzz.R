### second
make_HPO.db <- function() {
    ah <- suppressMessages(AnnotationHub())
    dbfile <- ah[["AH111587", verbose=FALSE]]  
    conn <- AnnotationDbi::dbFileConnect(dbfile)
    db <- new("HPODb", conn=conn)
    db
}


datacache <- new.env(hash=TRUE, parent=emptyenv())
HPO <- function() showQCData("HPO", datacache)
HPO_dbconn <- function() dbconn(datacache)
HPO_dbfile <- function() dbfile(datacache)
HPO_dbschema <- function(file="", show.indices=FALSE) dbschema(datacache,
    file=file, show.indices=show.indices)
HPO_dbInfo <- function() dbInfo(datacache)
.onLoad <- function(libname, pkgname) {
    ns <- asNamespace(pkgname)
    makeCachedActiveBinding("HPO.db", make_HPO.db, env=ns)
    namespaceExport(ns, "HPO.db")
    ah <- suppressMessages(AnnotationHub())
    dbfile <- ah[["AH111587", verbose=FALSE]]  
    dbconn <- AnnotationDbi::dbFileConnect(dbfile)
    assign("dbconn", dbconn, envir=datacache)
    ann_objs <- createAnnObjs.HPO_DB("HPO", "HPO", dbconn, datacache)
    mergeToNamespaceAndExport(ann_objs, "HPO.db")

}

.onAttach <- function(libname, pkgname) {
    packageStartupMessage("HPO.db version ", packageVersion(pkgname))
}

.onUnload <- function(libpath) {
    HPO.db$finalize()
}