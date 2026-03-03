USE address_book_service;

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