-- UC8: Add AddressBookName and ContactType (Family/Friends/Profession etc.)

USE address_book_service;

INSERT INTO AddressBook
(FirstName, LastName, Address, City, State, Zip, PhoneNumber, Email, AddressBookName, ContactType)
VALUES
('Amit',  'Sharma', 'MG Road',     'Pune',    'MH', '411001', '9999999999', 'amit@gmail.com',  'MyBook', 'Family'),
('Neha',  'Verma',  'Park Street', 'Kolkata', 'WB', '700001', '8888888888', 'neha@gmail.com',  'MyBook', 'Friends'),
('Rahul', 'Mehta',  'Hill Road',   'Mumbai',  'MH', '400001', '7777777777', 'rahul@gmail.com', 'MyBook', 'Profession'),
('Isha',  'Singh',  'Anna Salai',  'Chennai', 'TN', '600002', '6666666666', 'isha@gmail.com',  'MyBook', 'Friends');
-- UC10: Same person added to both Friends and Family (duplicate row with different type)
INSERT INTO AddressBook
(FirstName, LastName, Address, City, State, Zip, PhoneNumber, Email, AddressBookName, ContactType)
VALUES
('Karan', 'Patel', 'Ring Road', 'Surat', 'GJ', '395003', '5555555555', 'karan@gmail.com', 'MyBook', 'Friends'),
('Karan', 'Patel', 'Ring Road', 'Surat', 'GJ', '395003', '5555555555', 'karan@gmail.com', 'MyBook', 'Family');