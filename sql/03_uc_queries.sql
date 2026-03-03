USE address_book_service;

-- UC11 Proof: Show full view (contact + address + book + type)
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

-- UC11 Proof: Karan belongs to both Friends and Family
SELECT
  c.FirstName, c.LastName, c.Email,
  GROUP_CONCAT(t.TypeName ORDER BY t.TypeName) AS Types
FROM AddressBookContact abc
JOIN Contact c     ON c.ContactId = abc.ContactId
JOIN ContactType t ON t.TypeId = abc.TypeId
WHERE c.Email = 'karan@gmail.com'
GROUP BY c.ContactId;