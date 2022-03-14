import csv, json, os

artTermsTable = {}
culturesWithIds = {}
caaJson = []

i = 0
while i < 15000:
  caaJson.append({"accNumber": i})
  i += 1

monos = {}
    # sudo mysql -u root caf -e "select * from Artist_Information" > artist_info.txt 
csvArtist_Information  = r'./conversion/Artist_Information.csv'
csvLink_Art_Terms  = r'./conversion/Link_Art_Terms.csv'
csvLink_Cultures  = r'./conversion/Link_Cultures.csv'
csvLink_Monographs  = r'./conversion/Link_Monographs.csv'
csvLink_Periodicals  = r'./conversion/Link_Periodicals.csv'
csvUnique_Art_Terms  = r'./conversion/Unique_Art_Terms.csv'
csvUnique_Cultures  = r'./conversion/Unique_Cultures.csv'
csvUnique_monographs  = r'./conversion/Unique_monographs.csv'

with open(csvLink_Art_Terms, encoding='utf-8') as lf:
    linkData = csv.DictReader(lf)
    for a in linkData:
        at = a["Art_Term"]
        accno = int(a["Artists_Accession_Number"])
        if at not in artTermsTable: 
            artTermsTable[at] = [a["Artists_Accession_Number"]]
        else: 
            artTermsTable[at].append(a["Artists_Accession_Number"])
        try: 
            caaJson[accno]["artTerms"].append(at)
        except: 
            caaJson[accno]["artTerms"] = []
            caaJson[accno]["artTerms"].append(at)

with open(csvLink_Cultures, encoding='utf-8') as lf:
    linkData = csv.DictReader(lf)
    for a in linkData:
        at = a["Culture"]
        accno = int(a["Artists_Accession_Number"])
        if at not in culturesWithIds: 
            culturesWithIds[at] = [a["Artists_Accession_Number"]]
        else: 
            culturesWithIds[at].append(a["Artists_Accession_Number"])
        try: 
            caaJson[accno]["cultures"].append(at)
        except: 
            caaJson[accno]["cultures"] = []
            caaJson[accno]["cultures"].append(at)

# TOMORROW:
# needs to iterate over link_monographs and unique_monographs to put unique monographs into caaJson["monographs"]{}

with open(csvUnique_monographs, encoding='utf-8') as lf:
    linkData = csv.DictReader(lf)
    for a in linkData:
        monos[a["Call_Number"]] = {
            "callNumber": a["Call_Number"],
            "title": a["Title"],
            "lastName": a["Last_Name"],
            "firstName": a["First_Name"],
            "year": a["Year"]
        }

# sudo mysql -u root caf -e "select * from Artist_Information where ID = 1" > artist_info.txt

with open(csvArtist_Information, encoding='utf-8') as ai: 
    artistData = csv.DictReader(ai)
    for a in artistData: 
        try: 
            accno = int(a["Artist_Accession_Number"])
            caaJson[accno]["accNumber"] = accno
            caaJson[accno]["name"] = a["Name"]
            caaJson[accno]["dob"] = a["DOB"]
            caaJson[accno]["dod"] = a["DOD"]
            caaJson[accno]["notes"] = a["Notes"]
            caaJson[accno]["file"] = a["File"]
            caaJson[accno]["slides"] = a["Slides"]
            caaJson[accno]["videos"] = a["Video(s)"]
            caaJson[accno]["gender"] = a["Gender"]
            caaJson[accno]["resume"] = a["Resume/Vita"]
            caaJson[accno]["artistStatement"] = a["Artist_Statement"]
            caaJson[accno]["galleryNotice"] = a["Gallery_Notice"]
            caaJson[accno]["article"] = a["Article"]
            caaJson[accno]["poster"] = a["Poster"]
            caaJson[accno]["folio"] = a["Folio"]
            caaJson[accno]["cdrom"] = a["CD-ROM"]
            caaJson[accno]["correspondance"] = a["Correspondance"]
            caaJson[accno]["libex"] = a["Library_Exhibit"]
        except ValueError: 
            print("Artist_Accession_Number not numeric: " + a["Artist_Accession_Number"] )
           
with open(csvLink_Monographs, encoding='utf-8') as lf:
    linkData = csv.DictReader(lf)
    for a in linkData:
        accno = int(a["Artist_Accession_Number"])
        if "monographs" not in caaJson[accno]:
            caaJson[accno]["monographs"] = []
        if a['call_number'] in monos:
            caaJson[accno]["monographs"].append(monos[a["call_number"]])
        # else: 
            # print("call number not in monographs: " + a['call_number'] + " for Artist_Accession_Number "  + a["Artist_Accession_Number"])


dataFile = open("./cafoutput/artTerms.json", "w")
dataFile.write(json.dumps(artTermsTable, indent=4))

dataFile = open("./cafoutput/cultures.json", "w")
dataFile.write(json.dumps(culturesWithIds, indent=4))

dataFile = open("./cafoutput/caaJson.json", "w")
dataFile.write(json.dumps(caaJson, indent=4))


#  FROM MDB: 
# take mdb file and export the schema: 
# mdb-schema caf.mdb > schema.sql
# edit schema file; on 21/11/22, 
#   all [] had to be replaced with ``
#   replace Text (50) aka Text \(([0-9]{2})\) with VARCHAR(255) <- also do {1} and {3}
#   replace Long Integer with VARCHAR(255) 
#   (could probably just do `(.*?)`(.*?),?\n with `$1` VARCHAR(255),\n because datatype doesnt matter, it's all going to json 
# then go in mysql and drop caf and create caf; import the schema to caf: 
#   sudo mdb-schema schema.sql mysql | sudo mysql -u root caf
# then import data:
#   sudo mdb-export -D '%Y-%m-%d %H:%M:%S' -I mysql caf.mdb Artist_Information | sudo mysql  -u root caf 
#   (I made a script for each table; see "addData.sh")
# then export data from mysql to csv: in mysql: 
#   SELECT * FROM Unique_monographs INTO OUTFILE '/Users/nickwhite/Documents/cpldc/Unique_monographs.csv'  FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'; 
# ---smarter step needed: csv output files have no header row so I used SHOW COLUMNS FROM in mysql; could probably just use the headers from 21/11/22 files to awk them in?
# add headers to csvs 

# dataHandler.py takes csv output from above and puts it into json that works with the site; these 3 files need to give give "var *variablename* = " per the caa-db file and put into the same file (maybe someday we can do a bash script for this)