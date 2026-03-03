# Devraj Blueprints — AddressBook System DB (MySQL) UC-Wise GitFlow Guide

This document is a step-by-step guide to build the same project structure and UC-wise progress workflow.
All SQL code can be copied from the GitHub repository. This guide focuses on commands, file names, and what to do in each UC.

## What you need before starting

1. MySQL installed (MySQL Workbench recommended)
2. Git installed
3. GitHub account
4. A new empty GitHub repository created (example: AdressBookSystem-DB)

## Simple idea of how this project works

- Git branches store versions of files UC-wise.
- Your database does not change automatically when you switch Git branches.
- So whenever you move to a new UC branch, you rebuild the database by running SQL files in this fixed order:

Run order (always):
1. sql/99_reset_db.sql
2. sql/01_uc1_schema.sql
3. sql/02_uc2_insert_contacts.sql
4. sql/03_uc_queries.sql

Then export query results as CSV into the proof/ folder and commit them.

## Folder structure (must match)

Create this structure once and keep it for all UCs:

AdressBook_System-DB/
  sql/
    99_reset_db.sql
    01_uc1_schema.sql
    02_uc2_insert_contacts.sql
    03_uc_queries.sql
  proof/
  docs/
  README.md

Important rule:
- Keep the file name sql/03_uc_queries.sql the same in every branch.
- Only change what is inside it. This avoids GitHub “file not found” when switching branches.

## Git configuration rule used in this project

Commit message format used everywhere:
[Devraj]: <message>

Example:
[Devraj]: UC5 retrieve contacts by city and state with CSV proof

## One-time setup commands

From Terminal:

1) Clone repo
git clone <YOUR_GITHUB_REPO_URL>
cd AdressBook_System-DB

2) Initialize GitFlow
git flow init

When asked:
- Production branch: main (or master if your repo uses master)
- Development branch: develop
- Keep defaults for feature/hotfix/release prefixes

3) Create folders
mkdir -p sql proof docs

4) Create the 4 SQL files in sql/
Create empty files (you can paste code later):
touch sql/99_reset_db.sql
touch sql/01_uc1_schema.sql
touch sql/02_uc2_insert_contacts.sql
touch sql/03_uc_queries.sql

5) Add .gitignore to prevent junk files
echo ".DS_Store" >> .gitignore

If .DS_Store is already tracked:
git rm --cached .DS_Store

6) Commit the base structure to develop
git checkout develop
git add .
git commit -m "[Devraj]: setup project structure for MySQL address book"
git push origin develop

## How to run SQL in MySQL Workbench (basic)

For any UC branch:
1) Open MySQL Workbench
2) Open each SQL file from the sql/ folder
3) Run files in this exact order:
   - 99_reset_db.sql
   - 01_uc1_schema.sql
   - 02_uc2_insert_contacts.sql
   - 03_uc_queries.sql
4) After running SELECT queries, export results as CSV:
   - In the result grid, use Export (or right click result grid) -> Export Resultset
   - Save into the proof/ folder with UC-wise filename

## UC workflow (the same steps for every UC)

For each UC:
1) Create a new feature branch from develop
2) Copy SQL code from GitHub (or write your changes) into the correct file
3) Run SQL files in Workbench using the fixed run order
4) Export required proof CSV into proof/
5) Commit changes
6) Push feature branch
7) Finish feature (merge to develop)
8) Push develop

Commands pattern:

git checkout develop
git pull origin develop
git flow feature start UCx-ShortName

# make changes in files + export proof CSV
git add .
git commit -m "[Devraj]: UCx message"
git push -u origin feature/UCx-ShortName

git flow feature finish -k UCx-ShortName
git push origin develop

## UC-by-UC instructions (commands + which file to edit)

Note:
- SQL code is in GitHub; copy it from the corresponding UC branch.
- This section tells which file gets updated and what proof CSV to export.

### UC1 — Create database and AddressBook table

Branch:
git checkout develop
git pull origin develop
git flow feature start UC1-CreateAddressBookTable

Files to edit:
- sql/99_reset_db.sql
- sql/01_uc1_schema.sql
- sql/03_uc_queries.sql

Run order in Workbench:
99_reset_db -> 01_uc1_schema -> 03_uc_queries

Proof CSV to export:
- proof/UC1_EmptyTable.csv (output of SELECT * FROM AddressBook)

Commit and push:
git add .
git commit -m "[Devraj]: UC1 create AddressBook table with CSV proof"
git push -u origin feature/UC1-CreateAddressBookTable
git flow feature finish -k UC1-CreateAddressBookTable
git push origin develop

### UC2 — Insert contacts

Branch:
git checkout develop
git pull origin develop
git flow feature start UC2-InsertContacts

Files to edit:
- sql/02_uc2_insert_contacts.sql
- sql/03_uc_queries.sql

Run order:
99_reset_db -> 01_uc1_schema -> 02_uc2_insert_contacts -> 03_uc_queries

Proof CSV:
- proof/UC2_SelectAll.csv (output of SELECT all contacts)

Commit:
git add .
git commit -m "[Devraj]: UC2 insert contacts with CSV proof"
git push -u origin feature/UC2-InsertContacts
git flow feature finish -k UC2-InsertContacts
git push origin develop

### UC3 — Edit existing contact by name

Branch:
git checkout develop
git pull origin develop
git flow feature start UC3-EditContactByName

Files to edit:
- sql/03_uc_queries.sql (add UC3 UPDATE + verification SELECT)

Run order:
99_reset_db -> 01_uc1_schema -> 02_uc2_insert_contacts -> 03_uc_queries

Proof CSV:
- proof/UC3_Update_By_Name.csv (export the SELECT showing updated record)

Commit:
git add .
git commit -m "[Devraj]: UC3 edit contact by name with CSV proof"
git push -u origin feature/UC3-EditContactByName
git flow feature finish -k UC3-EditContactByName
git push origin develop

### UC4 — Delete contact by name

Branch:
git checkout develop
git pull origin develop
git flow feature start UC4-DeleteContactByName

Files to edit:
- sql/03_uc_queries.sql (add UC4 DELETE + SELECT)

Proof CSV:
- proof/UC4_Delete_By_Name.csv (export final SELECT all)

Commit:
git add .
git commit -m "[Devraj]: UC4 delete contact by name with CSV proof"
git push -u origin feature/UC4-DeleteContactByName
git flow feature finish -k UC4-DeleteContactByName
git push origin develop

### UC5 — Retrieve contacts by City or State

Branch:
git checkout develop
git pull origin develop
git flow feature start UC5-RetrieveByCityOrState

Files to edit:
- sql/03_uc_queries.sql (add UC5 SELECT by city + SELECT by state)

Proof CSV:
- proof/UC5_By_City.csv
- proof/UC5_By_State.csv

Commit:
git add .
git commit -m "[Devraj]: UC5 retrieve contacts by city and state with CSV proof"
git push -u origin feature/UC5-RetrieveByCityOrState
git flow feature finish -k UC5-RetrieveByCityOrState
git push origin develop

### UC6 — Count contacts by City and State

Branch:
git checkout develop
git pull origin develop
git flow feature start UC6-CountByCityAndState

Files to edit:
- sql/03_uc_queries.sql (add UC6 GROUP BY counts)

Proof CSV:
- proof/UC6_Count_By_City.csv
- proof/UC6_Count_By_State.csv

Commit:
git add .
git commit -m "[Devraj]: UC6 count contacts by city and state with CSV proof"
git push -u origin feature/UC6-CountByCityAndState
git flow feature finish -k UC6-CountByCityAndState
git push origin develop

### UC7 — Sorted list by person name for a city

Branch:
git checkout develop
git pull origin develop
git flow feature start UC7-SortByNameForCity

Files to edit:
- sql/03_uc_queries.sql (add UC7 SELECT with ORDER BY)

Proof CSV:
- proof/UC7_Sorted_By_Name_City.csv

Commit:
git add .
git commit -m "[Devraj]: UC7 sort contacts by name for city with CSV proof"
git push -u origin feature/UC7-SortByNameForCity
git flow feature finish -k UC7-SortByNameForCity
git push origin develop

### UC8 — Add AddressBookName and ContactType

Branch:
git checkout develop
git pull origin develop
git flow feature start UC8-AddBookNameAndType

Files to edit:
- sql/01_uc1_schema.sql (ALTER TABLE to add AddressBookName + ContactType)
- sql/02_uc2_insert_contacts.sql (insert rows with new columns)
- sql/03_uc_queries.sql (add UC8 verification queries)

Proof CSV:
- proof/UC8_Describe_AddressBook.csv (DESCRIBE AddressBook)
- proof/UC8_Count_By_Book_And_Type.csv (GROUP BY AddressBookName, ContactType)

Commit:
git add .
git commit -m "[Devraj]: UC8 add address book name and contact type with CSV proof"
git push -u origin feature/UC8-AddBookNameAndType
git flow feature finish -k UC8-AddBookNameAndType
git push origin develop

### UC9 — Count contacts by ContactType

Branch:
git checkout develop
git pull origin develop
git flow feature start UC9-CountByType

Files to edit:
- sql/03_uc_queries.sql (add UC9 GROUP BY ContactType)

Proof CSV:
- proof/UC9_Count_By_Type.csv

Commit:
git add .
git commit -m "[Devraj]: UC9 count contacts by type with CSV proof"
git push -u origin feature/UC9-CountByType
git flow feature finish -k UC9-CountByType
git push origin develop

### UC10 — Same person in both Friends and Family

Branch:
git checkout develop
git pull origin develop
git flow feature start UC10-AddPersonToMultipleTypes

Files to edit:
- sql/02_uc2_insert_contacts.sql (add the same person twice with different ContactType)
- sql/03_uc_queries.sql (add UC10 proof SELECT for that person)

Proof CSV:
- proof/UC10_Person_In_Two_Types.csv

Commit:
git add .
git commit -m "[Devraj]: UC10 add person to both friends and family with CSV proof"
git push -u origin feature/UC10-AddPersonToMultipleTypes
git flow feature finish -k UC10-AddPersonToMultipleTypes
git push origin develop

### UC11 — Normalized new structure (schema upgrade)

Branch:
git checkout develop
git pull origin develop
git flow feature start UC11-NormalizeAddressBook

Files to edit:
- sql/01_uc1_schema.sql (replace old table with normalized tables)
- sql/02_uc2_insert_contacts.sql (replace inserts for normalized tables)
- sql/03_uc_queries.sql (replace queries with JOIN-based full view + UC10 proof)

Proof CSV:
- proof/UC11_Full_View.csv
- proof/UC11_Karan_Types.csv

Commit:
git add .
git commit -m "[Devraj]: UC11 normalize schema for address book service with CSV proof"
git push -u origin feature/UC11-NormalizeAddressBook
git flow feature finish -k UC11-NormalizeAddressBook
git push origin develop

### UC12 — ER Diagram upload

Branch:
git checkout develop
git pull origin develop
git flow feature start UC12-ERDiagram

Files to add:
- docs/UC12_ERD.png (or PDF)
- docs/UC12_ERD_Notes.md

Proof files:
- docs/UC12_ERD.png
- docs/UC12_ERD_Notes.md

Commit:
git add .
git commit -m "[Devraj]: UC12 add ER diagram and normalization notes"
git push -u origin feature/UC12-ERDiagram
git flow feature finish -k UC12-ERDiagram
git push origin develop

### UC13 — Make UC6/UC7/UC8/UC10 queries work on new structure

Branch:
git checkout develop
git pull origin develop
git flow feature start UC13-QueriesOnNewStructure

Files to edit:
- sql/03_uc_queries.sql (replace or append JOIN-based versions of UC6/UC7/UC8/UC10)

Proof CSV:
- proof/UC13_UC6_Count_By_City.csv
- proof/UC13_UC6_Count_By_State.csv
- proof/UC13_UC7_Sorted_By_Name_City.csv
- proof/UC13_UC8_Count_By_Book_And_Type.csv
- proof/UC13_UC10_Person_Types.csv

Commit:
git add .
git commit -m "[Devraj]: UC13 ensure key queries work on normalized structure with CSV proof"
git push -u origin feature/UC13-QueriesOnNewStructure
git flow feature finish -k UC13-QueriesOnNewStructure
git push origin develop

## Final step: bring develop into main/master

If your production branch is main:
git checkout main
git pull
git merge develop
git push

If your production branch is master:
git checkout master
git pull
git merge develop
git push

## Troubleshooting

### GitFlow finish fails with “working tree contains unstaged changes”
Run:
git status

If .DS_Store is the problem:
echo ".DS_Store" >> .gitignore
git rm --cached .DS_Store
git add .gitignore
git commit -m "[Devraj]: ignore DS_Store file"
git push

Then retry:
git flow feature finish -k <feature-name>

### GitHub shows “file not found” when switching branches
This happens if a file name exists in one branch but not another.
Fix: keep stable file names (especially sql/03_uc_queries.sql) in every branch.

### Database results look different between branches
This is normal.
Always rebuild DB from scratch by running reset + schema + inserts + queries in order for the current branch.
