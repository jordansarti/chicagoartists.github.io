import csv, json, os
 
def make_json(csvFilePath, jsonFilePath):
    data = []
    with open(csvFilePath, encoding='utf-8') as csvf:
        csvReader = csv.DictReader(csvf)
        for rows in csvReader:
            data.append(rows)
    with open(jsonFilePath, 'w', encoding='utf-8') as jsonf:
        jsonf.write(json.dumps(data, indent=4))
         
directory = r'./'

for filename in os.listdir(directory):
    outputfiles = os.listdir('./op/')
    outputfilename = 'json_' + filename
    if filename.endswith(".csv"):
        csvFilePath = filename
        jsonFilePath = outputfilename
        make_json(csvFilePath, jsonFilePath)
 
#  artTermsTable
#  culturesWithIds
#  caaJson


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