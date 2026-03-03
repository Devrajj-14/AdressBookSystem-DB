# AddressBook System DB (MySQL) — UC-Wise GitFlow Project (with CSV Proof)

A complete Address Book database project implemented in **MySQL Workbench**, tracked **UC-wise using GitFlow**, and verified using **CSV exports** as proof.

---

## What this project delivers (Outcome)

1. Create **AddressBook Service DB**
2. Apply **ER Modeling + Normalization** (UC11–UC13)
3. Implement DB queries using **MySQL Client (Workbench)**
4. Track UC-wise progress using **GitFlow** branches (feature/UCx-...)  
5. Upload **CSV proof** for each UC under `proof/`

---

## 🧩 Tech Stack

- **MySQL** (MySQL Workbench)
- **Git + GitFlow**
- **GitHub**

---

## 📁 Folder Structure
AdressBook_System-DB/
sql/
99_reset_db.sql
01_uc1_schema.sql
02_uc2_insert_contacts.sql
03_uc_queries.sql
proof/
UC1_.csv
UC2_.csv
...
UC13_*.csv
docs/
UC12_ERD.png
UC12_ERD_Notes.md
README.md

### 🔒 Stable file rule (VERY IMPORTANT)
To avoid GitHub “file not found” errors when switching branches:

Always keep the SAME file name:
- `sql/03_uc_queries.sql`

Only the **content changes UC-wise**, so GitHub shows clean diffs.

---

## 🚀 How to Run (Any Branch)

In **MySQL Workbench**, run scripts in this exact order:

1. `sql/99_reset_db.sql`
2. `sql/01_uc1_schema.sql`
3. `sql/02_uc2_insert_contacts.sql`
4. `sql/03_uc_queries.sql`

Then export required query results as CSV into `proof/`.

---

# ✅ Use Cases (UC1 → UC13) — Explained at the Top

## UC1 — Create AddressBook Table
Creates the database and AddressBook table with:
FirstName, LastName, Address, City, State, Zip, PhoneNumber, Email.

## UC2 — Insert New Contacts
Adds multiple contacts into AddressBook.

## UC3 — Edit Contact by Name
Updates an existing contact using FirstName + LastName.

## UC4 — Delete Contact by Name
Deletes a record using FirstName + LastName.

## UC5 — Retrieve by City or State
Fetch contacts for a given City or State.

## UC6 — Count by City and State
Counts number of contacts grouped by City and State.

## UC7 — Sort by Name for a City
Lists contacts sorted alphabetically (FirstName, LastName) for a city.

## UC8 — Add AddressBook Name and Type
Adds columns:
- `AddressBookName`
- `ContactType` (Family / Friends / Profession)

## UC9 — Count by ContactType
Counts contacts grouped by ContactType.

## UC10 — Add person to both Friends and Family
Demonstrates a person belonging to multiple types.

## UC11 — Normalized Schema (New Structure)
Moves from single table to normalized tables:
- Contact
- ContactAddress
- AddressBook
- ContactType
- AddressBookContact (junction table)

## UC12 — ER Diagram
Creates and uploads ER diagram and notes.

## UC13 — Ensure UC6/UC7/UC8/UC10 work on new structure
Rewrites key queries using JOINs so they work after normalization.

---

# 🧭 GitFlow + UC-Wise Step-By-Step Commands (UC1 → UC13)

> Commit format used everywhere:
`[Devraj]: <message>`

---

##  One-Time Setup (Before UC1)

### 1) Create folders
```bash
mkdir -p sql proof docs


2) Initialize GitFlow
git flow init


3) Create files in sql/
sql/99_reset_db.sql
sql/01_uc1_schema.sql
sql/02_uc2_insert_contacts.sql
sql/03_uc_queries.sql


UC1 — Create DB + Table
Branch
git checkout develop
git pull
git flow feature start UC1-CreateAddressBookTable


Save file: sql/99_reset_db.sql
DROP DATABASE IF EXISTS address_book_service;
CREATE DATABASE address_book_service;
USE address_book_service;
Save file: sql/01_uc1_schema.sql
USE address_book_service;

DROP TABLE IF EXISTS AddressBook;

CREATE TABLE AddressBook (
    ContactId INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName  VARCHAR(50) NOT NULL,
    Address   VARCHAR(150),
    City      VARCHAR(50),
    State     VARCHAR(50),
    Zip       VARCHAR(10),
    PhoneNumber VARCHAR(20),
    Email     VARCHAR(100)
);


Save file: sql/03_uc_queries.sql
USE address_book_service;
SELECT * FROM AddressBook;
Run order in Workbench
reset 2) schema 3) queries
Export CSV proof → proof/UC1_EmptyTable.csv
Commit + Push
git add .
git commit -m "[Devraj]: UC1 create AddressBook table with CSV proof"
git push -u origin feature/UC1-CreateAddressBookTable
git flow feature finish -k UC1-CreateAddressBookTable
git push origin develop



UC2 — Insert Contacts
Branch
git checkout develop
git pull
git flow feature start UC2-InsertContacts
Save file: sql/02_uc2_insert_contacts.sql
USE address_book_service;

INSERT INTO AddressBook (FirstName, LastName, Address, City, State, Zip, PhoneNumber, Email)
VALUES
('Amit',  'Sharma', 'MG Road',     'Pune',    'MH', '411001', '9999999999', 'amit@gmail.com'),
('Neha',  'Verma',  'Park Street', 'Kolkata', 'WB', '700001', '8888888888', 'neha@gmail.com'),
('Rahul', 'Mehta',  'Hill Road',   'Mumbai',  'MH', '400001', '7777777777', 'rahul@gmail.com'),
('Isha',  'Singh',  'Anna Salai',  'Chennai', 'TN', '600002', '6666666666', 'isha@gmail.com');
Update sql/03_uc_queries.sql
USE address_book_service;
SELECT * FROM AddressBook;


Run order: reset → schema → inserts → queries
Export CSV: proof/UC2_SelectAll.csv

Commit + Push
git add .
git commit -m "[Devraj]: UC2 insert contacts with CSV proof"
git push -u origin feature/UC2-InsertContacts
git flow feature finish -k UC2-InsertContacts
git push origin develop



UC3 — Edit Contact by Name
Branch
git checkout develop
git pull
git flow feature start UC3-EditContactByName
Update sql/03_uc_queries.sql (append)

-- UC3: Edit Rahul Mehta
UPDATE AddressBook
SET PhoneNumber='7000000000', City='Delhi', State='DL', Zip='110001', Address='Connaught Place'
WHERE FirstName='Rahul' AND LastName='Mehta';

SELECT * FROM AddressBook WHERE FirstName='Rahul' AND LastName='Mehta';
SELECT * FROM AddressBook;
Export CSV: proof/UC3_Update_Rahul.csv

Commit:
git add .
git commit -m "[Devraj]: UC3 edit contact by name with CSV proof"
git push -u origin feature/UC3-EditContactByName
git flow feature finish -k UC3-EditContactByName
git push origin develop



UC4 — Delete Contact by Name
Branch
git checkout develop
git pull
git flow feature start UC4-DeleteContactByName
Update sql/03_uc_queries.sql (append)

-- UC4: Delete Neha Verma
DELETE FROM AddressBook WHERE FirstName='Neha' AND LastName='Verma';
SELECT * FROM AddressBook;
Export CSV: proof/UC4_Delete_Neha.csv

Commit:
git add .
git commit -m "[Devraj]: UC4 delete contact by name with CSV proof"
git push -u origin feature/UC4-DeleteContactByName
git flow feature finish -k UC4-DeleteContactByName
git push origin develop



UC5 — Retrieve by City or State
Append:
-- UC5
SELECT * FROM AddressBook WHERE City='Mumbai';
SELECT * FROM AddressBook WHERE State='MH';

Proof:
proof/UC5_By_City_Mumbai.csv
proof/UC5_By_State_MH.csv



UC6 — Count by City and State
Append:
-- UC6
SELECT City, COUNT(*) AS CountByCity FROM AddressBook GROUP BY City ORDER BY City;
SELECT State, COUNT(*) AS CountByState FROM AddressBook GROUP BY State ORDER BY State;
Proof:
proof/UC6_Count_By_City.csv
proof/UC6_Count_By_State.csv



UC7 — Sort by Name for a City
Append:
-- UC7
SELECT * FROM AddressBook WHERE City='Mumbai'
ORDER BY FirstName ASC, LastName ASC;
Proof:
proof/UC7_Sorted_Mumbai.csv



UC8 — Add AddressBookName + ContactType
Update sql/01_uc1_schema.sql (append)
ALTER TABLE AddressBook
ADD COLUMN AddressBookName VARCHAR(100) NOT NULL DEFAULT 'DefaultBook',
ADD COLUMN ContactType VARCHAR(30) NOT NULL DEFAULT 'Friends';
Update inserts (sql/02_uc2_insert_contacts.sql) to include new columns.
Proof:
proof/UC8_DescribeTable.csv
proof/UC8_Count_By_Type.csv



UC9 — Count by ContactType
Append:
-- UC9
SELECT ContactType, COUNT(*) AS PeopleCount
FROM AddressBook
GROUP BY ContactType
ORDER BY ContactType;
Proof:

proof/UC9_Count_By_Type.csv



UC10 — Add Same Person to Friends & Family
Append inserts (same person twice with different ContactType).
Proof:
proof/UC10_Karan_Friends_Family.csv




UC11 — Normalized Schema (New Structure)
Replace schema + inserts to use:
Contact
ContactAddress
AddressBook
ContactType
AddressBookContact
Proof:
proof/UC11_Full_View.csv
proof/UC11_Karan_Types.csv




UC12 — ER Diagram
Upload:
docs/UC12_ERD.png
docs/UC12_ERD_Notes.md



UC13 — Queries on New Structure
Rewrite UC6/7/8/10 using JOINs.
Proof:
proof/UC13_UC6_By_City.csv
proof/UC13_UC6_By_State.csv
proof/UC13_UC7_Sorted_Mumbai.csv
proof/UC13_UC8_Count_By_Book_Type.csv
proof/UC13_UC10_Karan_Types.csv
Final Merge to master/main
git checkout master 2>/dev/null || git checkout main
git pull
git merge develop
git push
👤 Author
Devraj
