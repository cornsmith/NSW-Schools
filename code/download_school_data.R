# NSW School List ---------------------------------------------------------
if(!file.exists("./data/school_list.csv")){
  download.file(
    "https://data.nsw.gov.au/data/dataset/ccb35a2f-c864-4537-8a71-8add3bf81960/resource/13aca3f1-5522-436b-ab7a-d651e412f932/download/NSW-Public-Schools-Master-Dataset-07032017.csv",
    "./data/school_list.csv",
    mode = "wb"
  )
}

# NSW School Enrolments ---------------------------------------------------
if(!file.exists("./data/school_enrolment.csv")){
  download.file(
    "https://data.cese.nsw.gov.au/data/dataset/1a8ee944-e56c-3480-aaf9-683047aa63a0/resource/da0fd2ec-6024-3206-98d4-81a2c663664b/download/2004-2015-enrolment-by-headcount.csv",
    "./data/school_enrolment.csv",
    mode = "wb"
  )
}

# Other potential datasets ------------------------------------------------
#https://data.cese.nsw.gov.au/data/dataset/sale-and-acquisition-of-land
#https://data.cese.nsw.gov.au/data/dataset/nsw-government-schools-by-school-type
