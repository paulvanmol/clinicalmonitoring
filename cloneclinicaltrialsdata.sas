options dlcreatedir; 
libname clintr "/home/christine/clinicaltrials/clinicaltrials");

data _null_;
RC = GITFN_CLONE("https://github.com/paulvanmol/SAS-Graphs-Clinical-Trials-Example.git",
"/home/christine/clinicaltrials/clinicaltrials");
run;
