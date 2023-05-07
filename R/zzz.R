
datacache <- new.env(hash=TRUE, parent=emptyenv())

HPO <- function() showQCData("HPO", datacache)
HPO_dbconn <- function() dbconn(datacache)
HPO_dbfile <- function() dbfile(datacache)
HPO_dbschema <- function(file="", show.indices=FALSE) dbschema(datacache,
    file=file, show.indices=show.indices)
HPO_dbInfo <- function() dbInfo(datacache)

.onLoad <- function(libname, pkgname)
{
    ## To avoid error reason: this db is of type HPODb 
    ## but this is not a defined class
    # 
    # ah <- suppressMessages(AnnotationHub())
    ah <- AnnotationHub()
    # Modify the number after waiting for data to be received
    txdb <- ah[["AH111553", verbose=FALSE]] 
    # dbfile <- txdb$conn@dbname
    dbfile <- txdb
    HPODb <- setRefClass("HPODb", contains="AnnotationDb")
    txdb <- loadDb(dbfile, packageName=pkgname)

    ## To avoid error reason: replacement has 70029 rows, data has 0
    # save(txdb, file = "txdb.Rdata")
    # on.exit(file.remove("txdb.Rdata"))
    ##############

    assign("dbfile", dbfile, envir=datacache)
    dbconn <- dbFileConnect(dbfile)
    assign("dbconn", dbconn, envir=datacache)

    ## To avoid error reason: replacement has 70029 rows, data has 0
    # HPODb <- setRefClass("HPODb", contains="AnnotationDb")
    ##################
    ## Create the OrgDb object
    sPkgname <- sub(".db$","",pkgname) 
    # dbObjectName <- getFromNamespace("dbObjectName", "AnnotationDbi")
    # dbNewname <- dbObjectName(pkgname,"HPODb")
    dbNewname <- pkgname
    ns <- asNamespace(pkgname)
    assign(dbNewname, txdb, envir=ns)
    namespaceExport(ns, dbNewname)

    ## Create the AnnObj instances
    ann_objs <- createAnnObjs.HPO_DB(sPkgname, sPkgname, dbconn, datacache)
    mergeToNamespaceAndExport(ann_objs, pkgname)
}

.onUnload <- function(libpath)
{
    dbFileDisconnect(HPO_dbconn())
}

