CREATE TABLE Restaurant (
    RestaurantID INT NOT NULL,
    Name VARCHAR(50),
    Location VARCHAR(50),
    PhoneNumber VARCHAR(20) NOT NULL,
    OpeningHours TIME,
    CONSTRAINT chk_phone_number CHECK (PhoneNumber <> '')
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
    CustomerID INT NOT NULL,
    CONSTRAINT chk_total_price CHECK (TotalPrice >= 0),
    CONSTRAINT chk_quantity CHECK (Quantity > 0)
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
    OrderID INT NOT NULL,
    CONSTRAINT chk_total CHECK (Total >= 0)
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
    RestaurantID INT NOT NULL,
    CONSTRAINT chk_price CHECK (Price >= 0),
    CONSTRAINT chk_total_calories CHECK (TotalCalories >= 0)
);

ALTER TABLE MenuItem
ADD CONSTRAINT pk_item_id PRIMARY KEY (ItemID);

ALTER TABLE MenuItem
ADD CONSTRAINT FK_MenuItem_Restaurant FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID);

CREATE TABLE MenuItemOrder (
    MenuItemOrderId INT NOT NULL,
    ItemID INT NOT NULL,
    OrderID INT NOT NULL,
    Quantity INT,
    CONSTRAINT chk_quantity CHECK (Quantity > 0)
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
    ContactInfo VARCHAR(50),
    CONSTRAINT chk_salary CHECK (Salary >= 0)
);

ALTER TABLE Employee
ADD CONSTRAINT pk_employee_id PRIMARY KEY (EmployeeID);

CREATE TABLE Feedback (
    FeedbackID INT NOT NULL,
    CustomerID INT NOT NULL,
    OrderID INT NOT NULL,
    Rating INT,
    Comment TEXT,
    FeedbackDate DATE,
    CONSTRAINT chk_rating CHECK (Rating BETWEEN 1 AND 5)
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
    DiscountPercentage DECIMAL(5, 2),
    CONSTRAINT chk_discount_percentage CHECK (DiscountPercentage BETWEEN 0 AND 100),
    CONSTRAINT chk_dates CHECK (EndDate > StartDate)
);

ALTER TABLE Promotion
ADD CONSTRAINT pk_promotion_id PRIMARY KEY (PromotionID);

CREATE TABLE CustomerEmployee (
    CustomerEmployeeID INT NOT NULL,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    CustomerNote VARCHAR(50),
    [Date] DATE
);

ALTER TABLE CustomerEmployee
ADD CONSTRAINT pk_customer_employee_id PRIMARY KEY (CustomerEmployeeID);

ALTER TABLE CustomerEmployee
ADD CONSTRAINT FK_CustomerEmployee_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

ALTER TABLE CustomerEmployee
ADD CONSTRAINT FK_CustomerEmployee_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);

CREATE TABLE CustomerPromotion (
    CustomerPromotionID INT NOT NULL,
    CustomerID INT NOT NULL,
    PromotionID INT NOT NULL,
    PromotionCondition VARCHAR(50),
    PromoEvent VARCHAR(50)
);

ALTER TABLE CustomerPromotion
ADD CONSTRAINT pk_customer_promotion_id PRIMARY KEY (CustomerPromotionID);

ALTER TABLE CustomerPromotion
ADD CONSTRAINT FK_CustomerPromotion_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

ALTER TABLE CustomerPromotion
ADD CONSTRAINT FK_CustomerPromotion_Promotion FOREIGN KEY (PromotionID) REFERENCES Promotion(PromotionID);