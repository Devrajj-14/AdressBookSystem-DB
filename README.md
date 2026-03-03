# AddressBook System DB (MySQL) – GitFlow UC-wise

## Project Outcome
1. Create Address Book Service DB  
2. Apply normalization + ER modeling (UC11–UC13)  
3. Implement DB queries using MySQL Client (MySQL Workbench)  
4. Track UC-wise progress using GitFlow branches with SQL scripts + CSV proof exports  

---

## Tech Stack
- MySQL (MySQL Workbench)
- Git + GitFlow
- GitHub

---

## Repository Structure
sql/
99_reset_db.sql
01_uc1_schema.sql
02_uc2_insert_contacts.sql
03_uc_queries.sql
proof/
UCx_*.csv
docs/
UC12_ERD.png
UC12_ERD_Notes.md

### Stable file rule
- `sql/03_uc_queries.sql` stays the same filename in every branch.
- UC-wise progress is shown by changes inside this file.
- Proof is exported as CSV into `proof/` with UC-wise filenames.

---

## How to Run (Any Branch)
Run scripts in this exact order in MySQL Workbench:

1. `sql/99_reset_db.sql`
2. `sql/01_uc1_schema.sql`
3. `sql/02_uc2_insert_contacts.sql`
4. `sql/03_uc_queries.sql`

Then export required SELECT outputs to CSV inside the `proof/` folder.

---

## GitFlow Workflow (UC-wise)
For each UC:
1. Create feature branch from `develop`
2. Update SQL scripts + export CSV proof
3. Commit with format: `[Devraj]: <message>`
4. Push feature branch
5. Finish feature (merge into develop)

Example:
git checkout develop
git pull
git flow feature start UCx-Name
edit sql + export CSV proof
git add .
git commit -m "[Devraj]: UCx message"
git push -u origin feature/UCx-Name
git flow feature finish -k UCx-Name
git push origin develop

---

## Use Cases Implemented

### UC1: Create AddressBook table
- Create database + AddressBook table (FirstName, LastName, Address, City, State, Zip, Phone, Email)

### UC2: Insert new contacts
- Insert multiple contacts into AddressBook

### UC3: Edit existing contact by name
- Update fields using FirstName + LastName

### UC4: Delete person by name
- Delete a contact using FirstName + LastName

### UC5: Retrieve by City or State
- Retrieve contacts belonging to a given City or State

### UC6: Count by City and State
- Count contacts grouped by City and grouped by State

### UC7: Sort alphabetically for a city
- Retrieve contacts for a city sorted by FirstName, LastName

### UC8: Add AddressBookName and ContactType
- Add columns to identify AddressBook name and type (Family/Friends/Profession)

### UC9: Count contacts by type
- Count contacts grouped by ContactType

### UC10: Add person to both Friend and Family
- Demonstrated by mapping same person into multiple types

---

## Normalization Phase

### UC11: Normalized Address Book Service schema
Introduced tables:
- `Contact`
- `ContactAddress`
- `AddressBook`
- `ContactType`
- `AddressBookContact` (junction to support many-to-many)

This supports UC10 cleanly without duplicating a person row.

### UC12: ER Diagram
- ERD exported to `docs/UC12_ERD.png`
- Notes in `docs/UC12_ERD_Notes.md`

### UC13: Queries working on new structure
Ensured these queries work using JOINs on normalized schema:
- UC6 (count by city/state)
- UC7 (sort by name for a city)
- UC8 (count by book + type)
- UC10 (same person in multiple types)

---

## Notes
- Branch switching does not automatically change the database.  
  Always rebuild by running scripts in the order listed above for the current branch.
:wq
