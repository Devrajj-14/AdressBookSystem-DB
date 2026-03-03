USE address_book_service;

-- UC2: View inserted contacts
SELECT * FROM AddressBook;


-- UC3: Edit existing contact by name (FirstName + LastName)
-- Update Rahul Mehta's phone number and city
UPDATE AddressBook
SET PhoneNumber = '7000000000',
    City = 'Delhi',
    Address = 'Connaught Place',
    State = 'DL',
    Zip = '110001'
WHERE FirstName = 'Rahul' AND LastName = 'Mehta';

-- Proof: Show only the updated person
SELECT * 
FROM AddressBook
WHERE FirstName = 'Rahul' AND LastName = 'Mehta';

-- Proof: Show all contacts (to see the change in the table)
SELECT * FROM AddressBook;

-- UC4: Delete a person using person's name
DELETE FROM AddressBook
WHERE FirstName = 'Neha' AND LastName = 'Verma';

-- Proof: verify Neha is deleted
SELECT *
FROM AddressBook
WHERE FirstName = 'Neha' AND LastName = 'Verma';

-- Proof: show all contacts after deletion
SELECT * FROM AddressBook;

-- UC5: Retrieve person belonging to a City
SELECT *
FROM AddressBook
WHERE City = 'Mumbai';

-- UC5: Retrieve person belonging to a State
SELECT *
FROM AddressBook
WHERE State = 'MH';

-- UC6: Size of Address Book by City (count)
SELECT City, COUNT(*) AS CountByCity
FROM AddressBook
GROUP BY City
ORDER BY City;

-- UC6: Size of Address Book by State (count)
SELECT State, COUNT(*) AS CountByState
FROM AddressBook
GROUP BY State
ORDER BY State;

-- UC7: Retrieve entries sorted alphabetically by person's name for a given city
SELECT *
FROM AddressBook
WHERE City = 'Mumbai'
ORDER BY FirstName ASC, LastName ASC;

-- UC8: Proof that AddressBookName and ContactType exist and data is stored
DESCRIBE AddressBook;

SELECT AddressBookName, ContactType, COUNT(*) AS CountPerType
FROM AddressBook
GROUP BY AddressBookName, ContactType
ORDER BY AddressBookName, ContactType;

SELECT * FROM AddressBook;