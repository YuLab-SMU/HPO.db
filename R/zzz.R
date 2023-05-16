
# datacache <- new.env(hash=TRUE, parent=emptyenv())

# HPO <- function() showQCData("HPO", datacache)
# HPO_dbconn <- function() dbconn(datacache)
# HPO_dbfile <- function() dbfile(datacache)
# HPO_dbschema <- function(file="", show.indices=FALSE) dbschema(datacache,
#     file=file, show.indices=show.indices)
# HPO_dbInfo <- function() dbInfo(datacache)

# .onLoad <- function(libname, pkgname)
# {
#     ## To avoid error reason: this db is of type HPODb 
#     ## but this is not a defined class
#     # 
#     # ah <- suppressMessages(AnnotationHub())
#     ah <- AnnotationHub()
#     txdb <- ah[["AH111587", verbose=FALSE]] 
#     dbfile <- txdb
#     HPODb <- setRefClass("HPODb", contains="AnnotationDb")
#     txdb <- loadDb(dbfile, packageName=pkgname)
#     assign("dbfile", dbfile, envir=datacache)
#     dbconn <- dbFileConnect(dbfile)
#     assign("dbconn", dbconn, envir=datacache)

#     ## To avoid error reason: replacement has 70029 rows, data has 0
#     HPODb <- setRefClass("HPODb", contains="AnnotationDb")
#     ##################
#     ## Create the OrgDb object
#     sPkgname <- sub(".db$","",pkgname) 
#     # dbObjectName <- getFromNamespace("dbObjectName", "AnnotationDbi")
#     # dbNewname <- dbObjectName(pkgname,"HPODb")
#     dbNewname <- pkgname
#     ns <- asNamespace(pkgname)
#     assign(dbNewname, txdb, envir=ns)
#     namespaceExport(ns, dbNewname)

#     ## Create the AnnObj instances
#     ann_objs <- createAnnObjs.HPO_DB(sPkgname, sPkgname, dbconn, datacache)
#     mergeToNamespaceAndExport(ann_objs, pkgname)
# }

# .onUnload <- function(libpath)
# {
#     dbFileDisconnect(HPO_dbconn())
# }


########## first

# make_HPO.db <- function() {
#     ah <- suppressMessages(AnnotationHub())
#     dbfile <- ah[["AH111587", verbose=FALSE]]  
#     conn <- AnnotationDbi::dbFileConnect(dbfile)
#     db <- new("HPODb", conn=conn)
#     db
# }

# .onLoad <- function(libname, pkgname) {
#     ns <- asNamespace(pkgname)
#     makeCachedActiveBinding("HPO.db", make_HPO.db, env=ns)
#     namespaceExport(ns, "HPO.db")

# }

# .onAttach <- function(libname, pkgname) {
#     packageStartupMessage("HPO.db version ", packageVersion(pkgname))
# }

# .onUnload <- function(libpath) {
#     HPO.db$finalize()
# }

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