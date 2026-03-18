CREATE DATABASE IF NOT EXISTS airline_db;
USE airline_db;

CREATE TABLE IF NOT EXISTS Passenger (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    passport_number VARCHAR(20) NOT NULL UNIQUE,
    nationality VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Booking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    booking_reference VARCHAR(10) NOT NULL UNIQUE,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    status VARCHAR(20) NOT NULL DEFAULT 'CONFIRMED',

    FOREIGN KEY (passenger_id)
    REFERENCES Passenger(passenger_id)
);

CREATE TABLE IF NOT EXISTS Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL UNIQUE,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_method VARCHAR(20) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'PENDING',

    FOREIGN KEY (booking_id)
    REFERENCES Booking(booking_id)
);


ALTER TABLE Passenger
ADD COLUMN phone VARCHAR(20);

ALTER TABLE Payment
MODIFY COLUMN payment_method VARCHAR(30);

ALTER TABLE Booking
RENAME COLUMN status TO booking_status;


INSERT INTO Passenger (first_name,last_name,email,passport_number,nationality,phone) VALUES
('Ali','Khan','ali@mail.com','P12345','Kazakhstan','87011111111'),
('Dana','Sadyk','dana@mail.com','P23456','Kazakhstan','87022222222'),
('Ivan','Petrov','ivan@mail.com','P34567','Russia','87033333333'),
('Aigerim','Nur','aigerim@mail.com','P45678','Kazakhstan','87044444444'),
('John','Smith','john@mail.com','P56789','USA','87055555555');

INSERT INTO Booking (passenger_id,booking_reference,total_amount,booking_status) VALUES
(1,'B001',150.00,'CONFIRMED'),
(2,'B002',200.00,'CONFIRMED'),
(3,'B003',180.00,'CONFIRMED'),
(4,'B004',220.00,'CONFIRMED'),
(5,'B005',300.00,'CONFIRMED');

INSERT INTO Payment (booking_id,amount,payment_method,payment_status) VALUES
(1,150.00,'CARD','COMPLETED'),
(2,200.00,'CARD','COMPLETED'),
(3,180.00,'CASH','PENDING'),
(4,220.00,'CARD','COMPLETED'),
(5,300.00,'TRANSFER','PENDING');


SHOW TABLES;

SELECT * FROM Passenger;

SELECT * FROM Booking;

SELECT * FROM Payment;

SELECT 
Passenger.first_name,
Passenger.last_name,
Booking.booking_reference,
Payment.amount,
Payment.payment_status
FROM Passenger
JOIN Booking ON Passenger.passenger_id = Booking.passenger_id
JOIN Payment ON Booking.booking_id = Payment.booking_id;