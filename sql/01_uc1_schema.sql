USE address_book_service;

-- Drop in dependency order
DROP TABLE IF EXISTS AddressBookContact;
DROP TABLE IF EXISTS ContactAddress;
DROP TABLE IF EXISTS AddressBook;
DROP TABLE IF EXISTS ContactType;
DROP TABLE IF EXISTS Contact;

-- 1) Contact
CREATE TABLE Contact (
  ContactId INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName  VARCHAR(50) NOT NULL,
  PhoneNumber VARCHAR(20),
  Email VARCHAR(100),
  UNIQUE KEY uq_contact_email (Email)
);

-- 2) Address (1 contact -> 1 address for now)
CREATE TABLE ContactAddress (
  AddressId INT AUTO_INCREMENT PRIMARY KEY,
  ContactId INT NOT NULL,
  Address VARCHAR(150),
  City VARCHAR(50),
  State VARCHAR(50),
  Zip VARCHAR(10),
  CONSTRAINT fk_address_contact
    FOREIGN KEY (ContactId) REFERENCES Contact(ContactId)
    ON DELETE CASCADE
);

-- 3) AddressBook (just the book name)
CREATE TABLE AddressBook (
  BookId INT AUTO_INCREMENT PRIMARY KEY,
  AddressBookName VARCHAR(100) NOT NULL,
  UNIQUE KEY uq_book_name (AddressBookName)
);

-- 4) Type
CREATE TABLE ContactType (
  TypeId INT AUTO_INCREMENT PRIMARY KEY,
  TypeName VARCHAR(30) NOT NULL,
  UNIQUE KEY uq_type_name (TypeName)
);

-- 5) Join table: contact can belong to multiple books and multiple types
CREATE TABLE AddressBookContact (
  BookId INT NOT NULL,
  ContactId INT NOT NULL,
  TypeId INT NOT NULL,
  PRIMARY KEY (BookId, ContactId, TypeId),
  CONSTRAINT fk_abc_book
    FOREIGN KEY (BookId) REFERENCES AddressBook(BookId)
    ON DELETE CASCADE,
  CONSTRAINT fk_abc_contact
    FOREIGN KEY (ContactId) REFERENCES Contact(ContactId)
    ON DELETE CASCADE,
  CONSTRAINT fk_abc_type
    FOREIGN KEY (TypeId) REFERENCES ContactType(TypeId)
    ON DELETE CASCADE
);