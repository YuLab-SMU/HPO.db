createAnnDbBimaps <- getFromNamespace('createAnnDbBimaps','AnnotationDbi')
createMAPCOUNTS <- getFromNamespace('createMAPCOUNTS','AnnotationDbi')
prefixAnnObjNames <- getFromNamespace('prefixAnnObjNames','AnnotationDbi')


HPO_DB_AnnDbBimap_seeds <- list(
    list(
        objName="PARENTS",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_parent",
                Lcolname="hpoid",
                Rcolname="parent"
            )
        )
    ),

    list(
        objName="CHILDREN",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_children",
                Lcolname="hpoid",
                Rcolname="children"
            )
        )
    ),

    list(
        objName="ANCESTOR",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_ancestor",
                Lcolname="hpoid",
                Rcolname="ancestor"
            )
        )
    ),

    list(
        objName="OFFSPRING",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_offspring",
                Lcolname="hpoid",
                Rcolname="offspring"
            )
        )
    ),

    list(
        objName="TERM",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_term",
                Lcolname="hpoid",
                Rcolname="term"
            )
        )
    ),
    list(
        objName="ALIAS",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_alias",
                Lcolname="hpoid",
                Rcolname="alias"
            )
        )
    ),
    list(
        objName="SYNONYM",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_synonym",
                Lcolname="hpoid",
                Rcolname="synonym"
            )
        )
    ),
    list(
        objName="GENE",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="hpoid_gene",
                Lcolname="hpoid",
                Rcolname="gene"
            )
        )
    ),
    list(
        objName="DO",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="hpoid_doid",
                Lcolname="hpoid",
                Rcolname="doid"
            )
        )
    ),    
    list(
        objName="MPO",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="hpoid_mpoid",
                Lcolname="hpoid",
                Rcolname="mpoid"
            )
        )
    ),       
    list(
        objName="metadata",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="metadata",
                Lcolname="name",
                Rcolname="value"
            )
        )
    )
)

createAnnObjs.HPO_DB <- function(prefix, objTarget, dbconn, datacache)
{
    #Now skip here
    #checkDBSCHEMA(dbconn, "DO_DB")

    ## AnnDbBimap objects
    seed0 <- list(
        objTarget=objTarget,
        datacache=datacache
    )
    #ann_objs <- createAnnDbBimaps(DO_DB_AnnDbBimap_seeds, seed0)
    ann_objs <- createAnnDbBimaps(HPO_DB_AnnDbBimap_seeds, seed0)

    ## Reverse maps
    # ann_objs$CHILDREN <- revmap(ann_objs$PARENTS, objName = "CHILDREN")
    # ann_objs$OFFSPRING <- revmap(ann_objs$ANCESTOR, objName = "OFFSPRING")


    ## 1 special map that is not an AnnDbBimap object
    ## (just a named integer vector)
    #ann_objs$MAPCOUNTS <- createMAPCOUNTS(dbconn, prefix)
    ann_objs$MAPCOUNTS <- createMAPCOUNTS(dbconn, prefix)

    #prefixAnnObjNames(ann_objs, prefix)
    prefixAnnObjNames(ann_objs, prefix)
}




