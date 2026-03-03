USE address_book_service;

-- Types
INSERT INTO ContactType (TypeName) VALUES
('Family'), ('Friends'), ('Profession');

-- Address Books
INSERT INTO AddressBook (AddressBookName) VALUES
('MyBook');

-- Contacts
INSERT INTO Contact (FirstName, LastName, PhoneNumber, Email) VALUES
('Amit',  'Sharma', '9999999999', 'amit@gmail.com'),
('Neha',  'Verma',  '8888888888', 'neha@gmail.com'),
('Rahul', 'Mehta',  '7777777777', 'rahul@gmail.com'),
('Isha',  'Singh',  '6666666666', 'isha@gmail.com'),
('Karan', 'Patel',  '5555555555', 'karan@gmail.com');

-- Addresses
INSERT INTO ContactAddress (ContactId, Address, City, State, Zip)
SELECT ContactId, 'MG Road', 'Pune', 'MH', '411001' FROM Contact WHERE Email='amit@gmail.com';
INSERT INTO ContactAddress (ContactId, Address, City, State, Zip)
SELECT ContactId, 'Park Street', 'Kolkata', 'WB', '700001' FROM Contact WHERE Email='neha@gmail.com';
INSERT INTO ContactAddress (ContactId, Address, City, State, Zip)
SELECT ContactId, 'Hill Road', 'Mumbai', 'MH', '400001' FROM Contact WHERE Email='rahul@gmail.com';
INSERT INTO ContactAddress (ContactId, Address, City, State, Zip)
SELECT ContactId, 'Anna Salai', 'Chennai', 'TN', '600002' FROM Contact WHERE Email='isha@gmail.com';
INSERT INTO ContactAddress (ContactId, Address, City, State, Zip)
SELECT ContactId, 'Ring Road', 'Surat', 'GJ', '395003' FROM Contact WHERE Email='karan@gmail.com';

-- Join: Put people into MyBook with types
-- MyBook + Amit => Family
INSERT INTO AddressBookContact (BookId, ContactId, TypeId)
SELECT b.BookId, c.ContactId, t.TypeId
FROM AddressBook b, Contact c, ContactType t
WHERE b.AddressBookName='MyBook' AND c.Email='amit@gmail.com' AND t.TypeName='Family';

-- MyBook + Neha => Friends
INSERT INTO AddressBookContact (BookId, ContactId, TypeId)
SELECT b.BookId, c.ContactId, t.TypeId
FROM AddressBook b, Contact c, ContactType t
WHERE b.AddressBookName='MyBook' AND c.Email='neha@gmail.com' AND t.TypeName='Friends';

-- MyBook + Rahul => Profession
INSERT INTO AddressBookContact (BookId, ContactId, TypeId)
SELECT b.BookId, c.ContactId, t.TypeId
FROM AddressBook b, Contact c, ContactType t
WHERE b.AddressBookName='MyBook' AND c.Email='rahul@gmail.com' AND t.TypeName='Profession';

-- MyBook + Isha => Friends
INSERT INTO AddressBookContact (BookId, ContactId, TypeId)
SELECT b.BookId, c.ContactId, t.TypeId
FROM AddressBook b, Contact c, ContactType t
WHERE b.AddressBookName='MyBook' AND c.Email='isha@gmail.com' AND t.TypeName='Friends';

-- UC10 in normalized form: Karan in BOTH Friends and Family (no duplicate person)
INSERT INTO AddressBookContact (BookId, ContactId, TypeId)
SELECT b.BookId, c.ContactId, t.TypeId
FROM AddressBook b, Contact c, ContactType t
WHERE b.AddressBookName='MyBook' AND c.Email='karan@gmail.com' AND t.TypeName='Friends';

INSERT INTO AddressBookContact (BookId, ContactId, TypeId)
SELECT b.BookId, c.ContactId, t.TypeId
FROM AddressBook b, Contact c, ContactType t
WHERE b.AddressBookName='MyBook' AND c.Email='karan@gmail.com' AND t.TypeName='Family';