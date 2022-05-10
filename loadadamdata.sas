/*****************************************************************************/
/*  Start a session named mySession using the existing CAS server connection */
/*  while allowing override of caslib, timeout (in seconds), and locale     */
/*  defaults.                                                                */
/*****************************************************************************/

cas mySession sessopts=(caslib=casuser timeout=1800 locale="en_US");

/*****************************************************************************/
/*  Create a default CAS session and create SAS librefs for existing caslibs */
/*  so that they are visible in the SAS Studio Libraries tree.               */
/*****************************************************************************/

caslib _all_ assign;




/*****************************************************************************/
/*  Create a CAS library (myCaslib) for the specified path ("/filePath/")    */ 
/*  and session (mySession).  If "sessref=" is omitted, the caslib is        */ 
/*  created and activated for the current session.  Setting subdirs extends  */
/*  the scope of myCaslib to subdirectories of "/filePath".                  */
/*****************************************************************************/
/*
caslib adamcas datasource=(srctype="path") 
	path="/workshop/clinicaltrials/Data/CDISC Pilot Study/adam" 
	sessref=mySession libref=adamcas;
caslib sdtmcas datasource=(srctype="path") 
	path="/workshop/clinicaltrials/Data/CDISC Pilot Study/sdtm" 
	sessref=mySession libref=sdtmcas;
caslib tflcas datasource=(srctype="path") 
	path="/workshop/clinicaltrials/Data/TFLDATA" 
	sessref=mySession libref=tflcas;
*/

libname tfldata "/home/christine/clinicaltrials/clinicaltrials/Data/TFLDATA";
libname adambase "/home/christine/clinicaltrials/clinicaltrials/Data/CDISC Pilot Study/adam";


/*****************************************************************************/
/*  Load SAS data set from a Base engine library (library.tableName) into    */
/*  the specified caslib ("myCaslib") and save as "targetTableName".         */
/*****************************************************************************/

proc casutil;
    droptable incaslib="public" casdata="ADSL" quiet; 
	load data=adambase.adsl outcaslib="public"
	casout="adsl" promote;
quit;
proc casutil;
    droptable incaslib="public" casdata="adaesummaryall1" quiet; 
	load data=tfldata.adaesummaryall1 outcaslib="public"
	casout="adaesummaryall1" promote;
quit;
/*****************************************************************************/
/*  Load a table ("sourceTableName") from the specified caslib               */
/*  ("sourceCaslib") to the target Caslib ("targetCaslib") and save it as    */
/*  "targetTableName".                                                       */
/*****************************************************************************/
/*
proc casutil;
    droptable incaslib="public" casdata="adaesummaryall1" quiet; 
	load casdata="adaesummaryall1.sas7bdat" incaslib="tflcas" 
	outcaslib="public" casout="adaesummaryall1" promote;
quit;
*/


/* Creates a permanent copy of an in-memory table ("table-name") from "sourceCaslib".      */
/* The in-memory table is saved to the data source that is associated with the target      */
/* caslib ("targetCaslib") using the specified name ("file-name").                         */
/*                                                                                         */
/* To find out the caslib associated with an CAS engine libref, right click on the libref  */
/* from "Libraries" and select "Properties". Then look for the entry named "Server Session */
/* CASLIB".                                                                                */
proc casutil;
    save casdata="adaesummaryall1" incaslib="public" outcaslib="public"
	     casout="adaesummaryall1.sashdat" replace;
quit;

*cas mysession terminate; 




