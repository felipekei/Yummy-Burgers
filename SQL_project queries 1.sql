CREATE TABLE Restaurant (
    RestaurantID INT NOT NULL,
    Name VARCHAR(50),
    Location VARCHAR(50),
    PhoneNumber VARCHAR(20) NOT NULL,
    OpeningHours TIME
);

ALTER TABLE Restaurant
ADD CONSTRAINT pk_restaurant_id PRIMARY KEY (RestaurantID);

CREATE TABLE Customer (
    CustomerID INT NOT NULL,
    Name VARCHAR(50),
    Email VARCHAR(50),
    PhoneNumber VARCHAR(20),
    Address VARCHAR(50)
);

ALTER TABLE Customer
ADD CONSTRAINT pk_CustomerID PRIMARY KEY (CustomerID);

CREATE TABLE [Order] (
    OrderID INT NOT NULL,
    OrderDate DATE,
    Quantity INT,
    TotalPrice DECIMAL(10, 2),
    CustomerID INT NOT NULL
);

ALTER TABLE [Order]
ADD CONSTRAINT pk_order_id PRIMARY KEY (OrderID);

ALTER TABLE [Order]
ADD CONSTRAINT FK_Order_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);


CREATE TABLE Payment (
    PaymentID INT NOT NULL,
    CreditCardInformation VARCHAR(20),
    PaymentMethod VARCHAR(50),
    PaymentDate DATE,
    PaymentStatus VARCHAR(50),
    Total INT,
    OrderID INT NOT NULL
);

ALTER TABLE Payment
ADD CONSTRAINT pk_payment_id PRIMARY KEY (PaymentID);

ALTER TABLE Payment
ADD CONSTRAINT FK_Payment_Order FOREIGN KEY (OrderID) REFERENCES [Order](OrderID);

CREATE TABLE MenuItem (
    ItemID INT NOT NULL,
    ItemName VARCHAR(50),
    Description TEXT,
    Price DECIMAL(10, 2),
    TotalCalories INT,
    RestaurantId INT NOT NULL
);

ALTER TABLE MenuItem
ADD CONSTRAINT pk_item_id PRIMARY KEY (ItemID);

ALTER TABLE MenuItem
ADD CONSTRAINT FK_MenuItem_Restaurant FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantID);

CREATE TABLE MenuItemOrder (
    MenuItemOrderId INT NOT NULL,
    ItemID INT NOT NULL,
    OrderID INT NOT NULL,
    Quantity INT
);

ALTER TABLE MenuItemOrder
ADD CONSTRAINT pk_menu_item_order_id PRIMARY KEY (MenuItemOrderId);

ALTER TABLE MenuItemOrder
ADD CONSTRAINT FK_MenuItemOrder_Item FOREIGN KEY (ItemID) REFERENCES MenuItem(ItemID);

ALTER TABLE MenuItemOrder
ADD CONSTRAINT FK_MenuItemOrder_Order FOREIGN KEY (OrderID) REFERENCES [Order](OrderID);

CREATE TABLE Employee (
    EmployeeID INT NOT NULL,
    Name VARCHAR(50),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    DateOfBirth DATE,
    ContactInfo VARCHAR(50)
);

ALTER TABLE Employee
ADD CONSTRAINT pk_employee_id PRIMARY KEY (EmployeeID);

CREATE TABLE Feedback (
    FeedbackID INT NOT NULL,
    CustomerID INT NOT NULL,
    OrderID INT NOT NULL,
    Rating INT,
    Comment TEXT,
    FeedbackDate DATE
);

ALTER TABLE Feedback
ADD CONSTRAINT pk_feedback_id PRIMARY KEY (FeedbackID);

ALTER TABLE Feedback
ADD CONSTRAINT FK_Feedback_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

ALTER TABLE Feedback
ADD CONSTRAINT FK_Feedback_Order FOREIGN KEY (OrderID) REFERENCES [Order](OrderID);

CREATE TABLE Promotion (
    PromotionID INT NOT NULL,
    Name VARCHAR(50),
    Description TEXT,
    StartDate DATE,
    EndDate DATE,
    DiscountPercentage DECIMAL(5, 2)
);

ALTER TABLE Promotion
ADD CONSTRAINT pk_promotion_id PRIMARY KEY (PromotionID);

CREATE TABLE CustomerEmployee (
    CustomerEmployeeId INT NOT NULL,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    CustomerNote VARCHAR(50),
    [Date] DATE
);

ALTER TABLE CustomerEmployee
ADD CONSTRAINT pk_customer_employee_id PRIMARY KEY (CustomerEmployeeId);

ALTER TABLE CustomerEmployee
ADD CONSTRAINT FK_CustomerEmployee_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

ALTER TABLE CustomerEmployee
ADD CONSTRAINT FK_CustomerEmployee_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);

CREATE TABLE CustomerPromotion (
    CustomerPromotionId INT NOT NULL,
    CustomerID INT NOT NULL,
    PromotionID INT NOT NULL,
    PromotionCondition VARCHAR(50),
    PromoEvent VARCHAR(50)
);

ALTER TABLE CustomerPromotion
ADD CONSTRAINT pk_customer_promotion_id PRIMARY KEY (CustomerPromotionId);

ALTER TABLE CustomerPromotion
ADD CONSTRAINT FK_CustomerPromotion_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

ALTER TABLE CustomerPromotion
ADD CONSTRAINT FK_CustomerPromotion_Promotion FOREIGN KEY (PromotionID) REFERENCES Promotion(PromotionID);

INSERT INTO Restaurant (RestaurantID, Name, Location, PhoneNumber, OpeningHours)
VALUES 
    (1, 'Burger Palace', '123 Main Street', '123-456-7890', '09:00:00'),
    (2, 'Pizza Haven', '456 Elm Street', '987-654-3210', '10:00:00'),
    (3, 'Taco Time', '789 Oak Avenue', '555-123-4567', '08:00:00'),
    (4, 'Sushi Spot', '321 Maple Street', '555-987-6543', '11:30:00'),
    (5, 'BBQ Barn', '567 Pine Street', '555-555-5555', '12:00:00'),
    (6, 'Deli Delight', '890 Cedar Street', '777-777-7777', '07:30:00'),
    (7, 'Café Cravings', '234 Birch Street', '888-888-8888', '08:30:00'),
    (8, 'Pho Palace', '432 Willow Street', '999-999-9999', '11:00:00'),
    (9, 'Mediterranean Bistro', '876 Spruce Street', '111-111-1111', '10:30:00'),
    (10, 'Indian Spice', '678 Oak Street', '222-222-2222', '12:30:00');

SELECT * FROM Restaurant;

INSERT INTO Customer (CustomerID, Name, Email, PhoneNumber, Address)
VALUES 
    (1, 'John Smith', 'john@example.com', '555-123-4567', '789 Oak Avenue'),
    (2, 'Jane Doe', 'jane@example.com', '555-987-6543', '456 Maple Street'),
    (3, 'Michael Johnson', 'michael@example.com', '555-555-5555', '123 Elm Street'),
    (4, 'Emily Williams', 'emily@example.com', '555-444-3333', '567 Pine Street'),
    (5, 'Chris Brown', 'chris@example.com', '555-777-8888', '890 Cedar Street'),
    (6, 'Sarah Davis', 'sarah@example.com', '555-999-2222', '234 Birch Street'),
    (7, 'David Martinez', 'david@example.com', '555-333-1111', '432 Willow Street'),
    (8, 'Laura Wilson', 'laura@example.com', '555-666-9999', '876 Spruce Street'),
    (9, 'Jessica Taylor', 'jessica@example.com', '555-222-4444', '678 Oak Street'),
    (10, 'Kevin Anderson', 'kevin@example.com', '555-888-7777', '987 Cedar Street');

SELECT * FROM Customer;

INSERT INTO [Order] (OrderID, OrderDate, Quantity, TotalPrice, CustomerID)
VALUES 
    (1, '2024-04-01', 2, 20.00, 1),
    (2, '2024-04-02', 1, 15.00, 2),
    (3, '2024-04-03', 3, 30.00, 3),
    (4, '2024-04-04', 2, 25.00, 4),
    (5, '2024-04-05', 1, 10.00, 5),
    (6, '2024-04-06', 4, 40.00, 6),
    (7, '2024-04-07', 2, 20.00, 7),
    (8, '2024-04-08', 1, 12.00, 8),
    (9, '2024-04-09', 3, 35.00, 9),
    (10, '2024-04-10', 2, 18.00, 10);

SELECT * FROM [Order];

INSERT INTO Payment (PaymentID, CreditCardInformation, PaymentMethod, PaymentDate, PaymentStatus, Total, OrderID)
VALUES 
    (1, '1234 5678 9012 3456', 'Credit Card', '2024-04-01', 'Paid', 20, 1),
    (2, '9876 5432 1098 7654', 'Credit Card', '2024-04-02', 'Paid', 15, 2),
    (3, '1111 2222 3333 4444', 'Credit Card', '2024-04-03', 'Paid', 30, 3),
    (4, '5555 6666 7777 8888', 'Credit Card', '2024-04-04', 'Paid', 25, 4),
    (5, '9999 8888 7777 6666', 'Credit Card', '2024-04-05', 'Paid', 10, 5),
    (6, '4444 3333 2222 1111', 'Credit Card', '2024-04-06', 'Paid', 40, 6),
    (7, '7777 8888 9999 0000', 'Credit Card', '2024-04-07', 'Paid', 20, 7),
    (8, '1212 3434 5656 7878', 'Credit Card', '2024-04-08', 'Paid', 12, 8),
    (9, '9898 7878 6565 4343', 'Credit Card', '2024-04-09', 'Paid', 35, 9),
    (10, '1234 5678 9090 9090', 'Credit Card', '2024-04-10', 'Paid', 18, 10);

SELECT * FROM Payment;

INSERT INTO MenuItem (ItemID, ItemName, Description, Price, TotalCalories, RestaurantId)
VALUES 
    (1, 'Cheeseburger', 'Juicy beef patty with melted cheese', 9.99, 600, 1),
    (2, 'Pepperoni Pizza', 'Classic pizza with pepperoni toppings', 12.99, 800, 2),
    (3, 'Taco', 'Crispy shell filled with seasoned beef and toppings', 8.99, 500, 3),
    (4, 'California Roll', 'Sushi roll with crab, avocado, and cucumber', 10.99, 400, 4),
    (5, 'BBQ Ribs', 'Slow-cooked ribs smothered in barbecue sauce', 15.99, 900, 5),
    (6, 'Turkey Sandwich', 'Fresh turkey with lettuce, tomato, and mayo', 7.99, 400, 6),
    (7, 'Cappuccino', 'Espresso with steamed milk and foam', 4.99, 150, 7),
    (8, 'Pho', 'Vietnamese noodle soup with beef or chicken', 11.99, 700, 8),
    (9, 'Falafel Wrap', 'Falafel balls with hummus and veggies in a wrap', 8.99, 600, 9),
    (10, 'Chicken Tikka Masala', 'Indian curry dish with chicken and creamy sauce', 13.99, 800, 10);

SELECT * FROM MenuItem;

INSERT INTO MenuItemOrder (MenuItemOrderId, ItemID, OrderID, Quantity)
VALUES 
    (1, 1, 1, 2),
    (2, 2, 2, 1),
    (3, 3, 3, 3),
    (4, 4, 4, 2),
    (5, 5, 5, 1),
    (6, 6, 6, 4),
    (7, 7, 7, 2),
    (8, 8, 8, 1),
    (9, 9, 9, 3),
    (10, 10, 10, 2);

SELECT * FROM MenuItemOrder;

INSERT INTO Employee (EmployeeID, Name, Position, Salary, HireDate, DateOfBirth, ContactInfo)
VALUES 
    (1, 'Mike Johnson', 'Chef', 30000.00, '2023-01-15', '1990-05-20', '555-555-5555'),
    (2, 'Sarah Adams', 'Waitress', 25000.00, '2023-02-20', '1995-08-10', '666-666-6666'),
    (3, 'Chris Miller', 'Bartender', 28000.00, '2023-03-25', '1988-12-05', '777-777-7777'),
    (4, 'Jessica Lee', 'Hostess', 24000.00, '2023-04-30', '1992-04-15', '888-888-8888'),
    (5, 'David Brown', 'Manager', 40000.00, '2022-05-10', '1985-09-25', '999-999-9999'),
    (6, 'Emma Wilson', 'Server', 22000.00, '2023-06-15', '1997-02-18', '111-111-1111'),
    (7, 'Ryan Taylor', 'Cook', 26000.00, '2023-07-20', '1993-07-30', '222-222-2222'),
    (8, 'Olivia Martinez', 'Dishwasher', 20000.00, '2023-08-25', '1998-10-12', '333-333-3333'),
    (9, 'Ethan Harris', 'Busser', 21000.00, '2023-09-30', '1996-11-20', '444-444-4444'),
    (10, 'Sophia Jackson', 'Cashier', 23000.00, '2023-10-05', '1994-03-05', '555-555-5555');

SELECT * FROM Employee;

INSERT INTO Feedback (FeedbackID, CustomerID, OrderID, Rating, Comment, FeedbackDate)
VALUES 
    (1, 1, 1, 5, 'Great food and service!', '2024-04-01'),
    (2, 2, 2, 4, 'Pizza was good but service was slow.', '2024-04-02'),
    (3, 3, 3, 5, 'Best tacos in town!', '2024-04-03'),
    (4, 4, 4, 4, 'Sushi was fresh but portion size was small.', '2024-04-04'),
    (5, 5, 5, 5, 'Delicious ribs!', '2024-04-05'),
    (6, 6, 6, 3, 'Sandwich was average, could use more flavor.', '2024-04-06'),
    (7, 7, 7, 4, 'Great cappuccino!', '2024-04-07'),
    (8, 8, 8, 5, 'Pho was amazing!', '2024-04-08'),
    (9, 9, 9, 5, 'Love the falafel wraps!', '2024-04-09'),
    (10, 10, 10, 4, 'Tikka masala was tasty but a bit spicy.', '2024-04-10');

SELECT * FROM Feedback;

INSERT INTO Promotion (PromotionID, Name, Description, StartDate, EndDate, DiscountPercentage)
VALUES 
    (1, 'Weekend Special', '20% off on all orders over $30', '2024-04-01', '2024-04-07', 20.00),
    (2, 'Loyalty Discount', 'Get $5 off on your next order', '2024-04-01', '2024-04-30', 5.00),
    (3, 'Daily Deal', '10% off on select items every day', '2024-04-01', '2024-04-30', 10.00),
    (4, 'Happy Hour', 'Half-price appetizers from 4-6pm', '2024-04-01', '2024-04-30', 50.00),
    (5, 'Family Bundle', 'Meal deal for family of four', '2024-04-01', '2024-04-30', 15.00),
    (6, 'Student Discount', '10% off with student ID', '2024-04-01', '2024-04-30', 10.00),
    (7, 'Senior Discount', '15% off for customers aged 65+', '2024-04-01', '2024-04-30', 15.00),
    (8, 'Holiday Special', 'Special menu for holidays', '2024-04-01', '2024-04-30', 0.00),
    (9, 'Anniversary Promotion', 'Celebrate our anniversary with discounts', '2024-04-01', '2024-04-30', 25.00),
    (10, 'Limited Time Offer', 'Exclusive offer for a limited time only', '2024-04-01', '2024-04-15', 30.00);

SELECT * FROM Promotion;

INSERT INTO CustomerEmployee (CustomerEmployeeId, CustomerID, EmployeeID, CustomerNote, [Date])
VALUES 
    (1, 1, 1, 'Prefers well-done burgers', '2024-04-01'),
    (2, 2, 2, 'Allergic to gluten', '2024-04-02'),


    (3, 3, 3, 'Enjoys spicy food', '2024-04-03'),
    (4, 4, 4, 'Vegetarian', '2024-04-04'),
    (5, 5, 5, 'Birthday celebration', '2024-04-05'),
    (6, 6, 6, 'Regular customer', '2024-04-06'),
    (7, 7, 7, 'New customer', '2024-04-07'),
    (8, 8, 8, 'Repeat customer', '2024-04-08'),
    (9, 9, 9, 'Loyal customer', '2024-04-09'),
    (10, 10, 10, 'First-time visitor', '2024-04-10');

SELECT * FROM CustomerEmployee;

INSERT INTO CustomerPromotion (CustomerPromotionId, CustomerID, PromotionID, PromotionCondition, PromoEvent)
VALUES 
    (1, 1, 1, 'Minimum order $30', 'Weekend Special'),
    (2, 2, 2, 'Loyalty program member', 'Loyalty Discount'),
    (3, 3, 3, 'Daily deal', 'Daily Deal'),
    (4, 4, 4, 'Happy hour', 'Happy Hour'),
    (5, 5, 5, 'Family of four', 'Family Bundle'),
    (6, 6, 6, 'Student with ID', 'Student Discount'),
    (7, 7, 7, 'Aged 65+', 'Senior Discount'),
    (8, 8, 8, 'Holiday menu', 'Holiday Special'),
    (9, 9, 9, 'Anniversary celebration', 'Anniversary Promotion'),
    (10, 10, 10, 'Limited time only', 'Limited Time Offer');

SELECT * FROM CustomerPromotion;


