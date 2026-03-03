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