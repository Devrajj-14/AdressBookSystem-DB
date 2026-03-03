USE address_book_service;

-- =========================
-- UC13: Queries working on NEW normalized tables
-- Tables: Contact, ContactAddress, AddressBook, ContactType, AddressBookContact
-- =========================

-- Helper "Full View" (useful for proof/debug)
SELECT
  b.AddressBookName,
  t.TypeName,
  c.FirstName, c.LastName, c.PhoneNumber, c.Email,
  a.Address, a.City, a.State, a.Zip
FROM AddressBookContact abc
JOIN AddressBook b   ON b.BookId = abc.BookId
JOIN Contact c       ON c.ContactId = abc.ContactId
JOIN ContactType t   ON t.TypeId = abc.TypeId
LEFT JOIN ContactAddress a ON a.ContactId = c.ContactId
ORDER BY b.AddressBookName, t.TypeName, c.FirstName, c.LastName;

-- -------------------------
-- UC6: Size (count) by City and State
-- NOTE: We count DISTINCT contacts (by ContactId) to avoid double-count when person has multiple types/books
-- -------------------------
SELECT
  a.City,
  COUNT(DISTINCT c.ContactId) AS PeopleCount
FROM Contact c
JOIN ContactAddress a ON a.ContactId = c.ContactId
GROUP BY a.City
ORDER BY a.City;

SELECT
  a.State,
  COUNT(DISTINCT c.ContactId) AS PeopleCount
FROM Contact c
JOIN ContactAddress a ON a.ContactId = c.ContactId
GROUP BY a.State
ORDER BY a.State;

-- -------------------------
-- UC7: Sorted alphabetically by Person’s name for a given City
-- Example City: Mumbai
-- -------------------------
SELECT
  c.FirstName, c.LastName, c.PhoneNumber, c.Email,
  a.Address, a.City, a.State, a.Zip
FROM Contact c
JOIN ContactAddress a ON a.ContactId = c.ContactId
WHERE a.City = 'Mumbai'
ORDER BY c.FirstName ASC, c.LastName ASC;

-- -------------------------
-- UC8 (new structure): Identify each Address Book with name and Type
-- Show count of contacts per AddressBookName + Type
-- -------------------------
SELECT
  b.AddressBookName,
  t.TypeName,
  COUNT(DISTINCT c.ContactId) AS PeopleCount
FROM AddressBookContact abc
JOIN AddressBook b ON b.BookId = abc.BookId
JOIN ContactType t ON t.TypeId = abc.TypeId
JOIN Contact c     ON c.ContactId = abc.ContactId
GROUP BY b.AddressBookName, t.TypeName
ORDER BY b.AddressBookName, t.TypeName;

-- -------------------------
-- UC10 (new structure): Same person in BOTH Friends and Family
-- Proof for Karan Patel (seeded in UC11 inserts)
-- -------------------------
SELECT
  c.FirstName, c.LastName, c.Email,
  GROUP_CONCAT(DISTINCT t.TypeName ORDER BY t.TypeName) AS Types
FROM AddressBookContact abc
JOIN Contact c     ON c.ContactId = abc.ContactId
JOIN ContactType t ON t.TypeId = abc.TypeId
WHERE c.Email = 'karan@gmail.com'
GROUP BY c.ContactId;

-- Optional: show which AddressBook Karan belongs to and under what types
SELECT
  b.AddressBookName,
  c.FirstName, c.LastName, c.Email,
  t.TypeName
FROM AddressBookContact abc
JOIN AddressBook b ON b.BookId = abc.BookId
JOIN Contact c     ON c.ContactId = abc.ContactId
JOIN ContactType t ON t.TypeId = abc.TypeId
WHERE c.Email = 'karan@gmail.com'
ORDER BY b.AddressBookName, t.TypeName;