/*CMPSC431 Project Main Code*/

/*USED FOR TESTING*/
DROP DATABASE tester;
CREATE DATABASE tester;
USE tester;
/*Problems
add a year to points expired time
*/

/*Main Tables*/ 
CREATE TABLE Customer (
	CustomerID INTEGER AUTO_INCREMENT NOT NULL,
	Email VARCHAR(50) UNIQUE NOT NULL,
	Password VARCHAR(50) NOT NULL,
	Name VARCHAR(30) NOT NULL,
	Income REAL,
	Age INTEGER,
	Gender VARCHAR(7),
	PRIMARY KEY (CustomerID)
);
CREATE TABLE Seller (
	SellerID INTEGER AUTO_INCREMENT NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Name VARCHAR(30) NOT NULL,
	Address VARCHAR (50),
	Phone CHAR(12),
	Revenue REAL,
    Type INTEGER NOT NULL, /* can be 0 or 1, 0 is indi 1 is supplier*/
	PRIMARY KEY (SellerID)
);
CREATE TABLE Item (
	ItemID INTEGER AUTO_INCREMENT NOT NULL,
	Name VARCHAR(255) NOT NULL,
	Info VARCHAR (255),
	Price REAL NOT NULL,
    Method INTEGER NOT NULL, /* 0 is sell, 1 is bid*/
    Type INTEGER NOT NULL, /*0 electronics, 1 clothes, 2 books*/
	PRIMARY KEY (ItemID)
);
CREATE TABLE Shipper (
	ShipperID INTEGER AUTO_INCREMENT NOT NULL,
    Name VARCHAR(30),
    Email VARCHAR(50),
    Phone CHAR(12),
	PRIMARY KEY (ShipperID)
);

/*Subsets*/
CREATE TABLE Individual_Seller (
	SellerID INTEGER NOT NULL,
	Shipping_Method CHAR(20),
	PRIMARY KEY (SellerID),
	FOREIGN KEY (SellerID) REFERENCES Seller(SellerID)
		ON DELETE CASCADE
);
CREATE TABLE Supplier (
	SellerID INTEGER NOT NULL,
	Website VARCHAR(50),
	PRIMARY KEY (SellerID),
	FOREIGN KEY (SellerID) REFERENCES Seller(SellerID)
		ON DELETE CASCADE
);
CREATE TABLE Bid_Item (
	ItemID INTEGER NOT NULL,
    Start_Time TIMESTAMP NOT NULL,
    End_Time TIMESTAMP NOT NULL, /*need to add a year to this*/
    Reserve_Price REAL,
    Status VARCHAR(30),
    PRIMARY KEY (ItemID),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
CREATE TABLE Sell_Item (
	ItemID INTEGER NOT NULL,
    PRIMARY KEY (ItemID),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
CREATE TABLE Electronics (
	ItemID INTEGER NOT NULL,
    Categories VARCHAR(30),
	PRIMARY KEY (ItemID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
		ON DELETE CASCADE
);
CREATE TABLE Clothes (
	ItemID INTEGER NOT NULL,
    Gender VARCHAR(1),
    Categories VARCHAR(30),
    Age_Group VARCHAR(10),
	Size CHAR (2),
	PRIMARY KEY (ItemID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
		ON DELETE CASCADE
);
CREATE TABLE Books (
	ItemID INTEGER NOT NULL,
	Author VARCHAR(25),
    Categories VARCHAR(30),
	PRIMARY KEY (ItemID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
		ON DELETE CASCADE
);

/*"Action Tables"*/
CREATE TABLE Orders (
	OrderID INTEGER AUTO_INCREMENT NOT NULL,
    ItemID INTEGER NOT NULL,
	Qty INTEGER NOT NULL,
	Order_Date TIMESTAMP NOT NULL,
	Ship_Date TIMESTAMP,
	PRIMARY KEY (OrderID),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
CREATE TABLE Bid (
	BidID INTEGER AUTO_INCREMENT NOT NULL,
    ItemID INTEGER NOT NULL,
	Price INTEGER NOT NULL,
	PRIMARY KEY (BidID)
);
CREATE TABLE Points (
	PointsID INTEGER AUTO_INCREMENT NOT NULL,
	Quantity INTEGER NOT NULL,
	expiredTime TIMESTAMP,
	PRIMARY KEY (PointsID)
);
CREATE TABLE Shipping_Info (
	TrackingNum VARCHAR(20) NOT NULL,
	Distribution_Date DATE,
	PRIMARY KEY (TrackingNum)
);

/*Relationships*/
CREATE TABLE Cus_has (
	CustomerID INTEGER NOT NULL,
	Card_Num CHAR(16),
	Address VARCHAR(50),
	PRIMARY KEY (CustomerID, Card_Num),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
		ON DELETE CASCADE
);
CREATE TABLE Cus_Earns (
	CustomerID INTEGER NOT NULL,
	PointsID INTEGER NOT NULL,
	PRIMARY KEY (CustomerID, PointsID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (PointsID) REFERENCES Points(PointsID)
);
CREATE TABLE Cus_Place_Ord (
	OrderID INTEGER NOT NULL,
	CustomerID INTEGER NOT NULL,
	PRIMARY KEY (OrderID, CustomerID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
CREATE TABLE Cus_Place_Bid (
	BidID INTEGER NOT NULL,
	CustomerID INTEGER NOT NULL,
    PRIMARY KEY (BidID, CustomerID),
    FOREIGN KEY (BidID) REFERENCES Bid(BidID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
CREATE TABLE Seller_Supplied (
	SellerID INTEGER NOT NULL,
	ItemID INTEGER NOT NULL,
	Amount INTEGER NOT NULL,
	PRIMARY KEY (SellerID, ItemID),
	FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
CREATE TABLE Ind_Seller_Accept (
	SellerID INTEGER NOT NULL,
	BidID INTEGER NOT NULL,
	PRIMARY KEY (SellerID, BidID),
	FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
	FOREIGN KEY (BidID) REFERENCES Bid(BidID)
);
CREATE TABLE Order_Contains (
	OrderID INTEGER NOT NULL,
	ItemID INTEGER NOT NULL,
	PRIMARY KEY (OrderID, ItemID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
CREATE TABLE Shipped (
		ShipperID INTEGER NOT NULL,
        TrackingNum VARCHAR(20),
		ItemID INTEGER NOT NULL,
		PRIMARY KEY (TrackingNum),
		FOREIGN KEY (ShipperID) REFERENCES Shipper(ShipperID),
		FOREIGN KEY (TrackingNum) REFERENCES Shipping_Info(TrackingNum),
		FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
CREATE TABLE Deliver (
	ShipperID INTEGER NOT NULL,
    TrackingNum VARCHAR(20) NOT NULL,
    CustomerID INTEGER NOT NULL,
	PRIMARY KEY (ShipperID, TrackingNum, CustomerID),
	FOREIGN KEY (ShipperID) REFERENCES Shipper(ShipperID),
	FOREIGN KEY (TrackingNum) REFERENCES Shipping_Info(TrackingNum),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

/*Dependencies*/
CREATE TABLE Points_Convert (
	PointsID INTEGER NOT NULL,
	issuedTime TIMESTAMP,
	PRIMARY KEY (PointsID),
	FOREIGN KEY (PointsID) REFERENCES Points(PointsID)
		ON DELETE CASCADE
);
CREATE TABLE Gives_Feedback (
	FeebackID INTEGER AUTO_INCREMENT NOT NULL,
	OrderID INTEGER NOT NULL,
	Rating_Star INTEGER NOT NULL,
	FeedBack_Info VARCHAR(255),
	PRIMARY KEY (FeebackID, OrderID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
		ON DELETE CASCADE
);
CREATE TABLE CorrespondTo (
	BidID INTEGER NOT NULL,
	WinnerEmail CHAR (50) NOT NULL,
	Minimum_Price REAL NOT NULL,
	PRIMARY KEY (BidID),
	FOREIGN KEY (BidID) REFERENCES Bid(BidID)
		ON DELETE CASCADE
);

/*Triggers*/
DELIMITER $$
CREATE TRIGGER add_sellers AFTER INSERT ON Seller
	FOR EACH ROW BEGIN
		IF NEW.type = 0 THEN
			INSERT INTO Individual_Seller(SellerID) VALUES (NEW.SellerID);
		ELSE
			INSERT INTO Supplier(SellerID) VALUES (NEW.SellerID);
		END IF;
	END$$

CREATE TRIGGER add_items_method_type AFTER INSERT ON Item
    FOR EACH ROW BEGIN
		IF NEW.Method = 0 THEN
			INSERT INTO Sell_Item(ItemID) VALUES (NEW.ItemID);
		ELSEIF NEW.Method = 1 THEN
			INSERT INTO Bid_Item(ItemID) VALUES (NEW.ItemID);
		END IF;
        IF NEW.Type = 0 THEN
			INSERT INTO Electronics(ItemID) VALUES (NEW.ItemID);
		ELSEIF NEW.Type = 1 THEN
			INSERT INTO Clothes(ItemID) VALUES (NEW.ItemID);
		ELSEIF NEW.Type = 2 THEN
			INSERT INTO Books(ItemID) VALUES (NEW.ItemID);
		END IF;
	END$$

CREATE TRIGGER update_bid AFTER INSERT ON Bid
    FOR EACH ROW BEGIN
		UPDATE Item
        SET Item.Price = NEW.Price
        WHERE Item.ItemID = NEW.ItemID;
	END$$
DELIMITER ;

/*Adding Info*/
INSERT INTO Customer (Email, Password, Name, Income, Age, Gender) 
VALUES ('meixin_kok@hotmail.com', '123456', 'Maggie Coulson', 100000, 34, 'Female'),    
('Kami_gal@hotmail.com', '234567', 'Ami Knauf', 120000, 24, 'Female'),
('Elias_Cust@yahoo.com', '223344', 'Elias Custard', 230000, 28, 'Male'),
('Ross_Britni@hotmail.com', '356724', 'Britni Rossow', 170000, 39, 'Female'),
('anisah2511@yahoo.com', '345678', 'Filomena Fenlon', 175000, 30, 'Female'),
('frens_luv_sad_hatred@hotmail.com', '435672', 'Stan Oconner', 210000, 29, 'Male'),
('kid_diyanah@hotmail.com', '547812', 'Marylyn Wenzel', 300000, 27, 'Female'),
('goodyme@hotmail.com', '678590', 'Johnna Shelor', 210000, 30, 'Female'),
('oeighto@gmail.com', '890123', 'August Necessary', 280000, 35, 'Male'),
('dareenpuff@hotmail.com', '783672', 'Tonia Farnsworth', 265000, 29, 'Female'),
('quik_boi93@hotmail.com', '678901', 'Cindy Stoltenberg', 188000, 23, 'Female'),
('winter_times@hotmail.com', '879132', 'Jessia Durand', 220000, 35, 'Female'),
('yxy5176@psu.edu', '050317', 'Yueqin Yang', 120000, 22,'Female'),
('xiz5158@psu.edu', '4172142', 'Xuejian Zhou', 100000, 22, 'Male'),
('kvc5433@psu.edu', 'qwerty', 'Ko-Chen Chen', 100000, 22, 'Male'),
('yang@psu.edu','123456789','Zekun Yang', 100000,21,'Male'),
('yzw5284@psu.edu','00000000', 'Yingsheng Wang', 666, 22, 'Male');

INSERT INTO Seller (Email, Password, Name, Address, Phone, Revenue, Type) 
VALUES ('meixin_kok@hotmail.com', '123456', 'Maggie Coulson1', '601 Vairo', '814-765-4321', 100000, 1),    
('Kami_gal@hotmail.com', '234567', 'Ami Knauf1', '601 Vairo', '814-765-4321', 120000, 0),
('Elias_Cust@yahoo.com', '223344', 'Elias Custard1', '601 Vairo', '814-765-4321', 230000, 1),
('Ross_Britni@hotmail.com', '356724', 'Britni Rossow1', '601 Vairo', '814-765-4321', 170000, 0),
('anisah2511@yahoo.com', '345678', 'Filomena Fenlon1', '601 Vairo', '814-765-4321', 175000, 1),
('frens_luv_sad_hatred@hotmail.com', '435672', 'Stan Oconner1', '601 Vairo', '814-765-4321', 210000, 0),
('kid_diyanah@hotmail.com', '547812', 'Marylyn Wenzel1', '601 Vairo', '814-765-4321', 300000, 1),
('goodyme@hotmail.com', '678590', 'Johnna Shelor1', '601 Vairo', '814-765-4321', 210000, 0),
('oeighto@gmail.com', '890123', 'August Necessary1', '601 Vairo', '814-765-4321', 280000, 1),
('dareenpuff@hotmail.com', '783672', 'Tonia Farnsworth1', '601 Vairo', '814-765-4321', 265000, 0),
('quik_boi93@hotmail.com', '678901', 'Cindy Stoltenberg1', '601 Vairo', '814-765-4321', 188000, 1),
('winter_times@hotmail.com', '879132', 'Jessia Durand1', '601 Vairo', '814-765-4321', 220000, 0),
('yxy5176@psu.edu', '050317', 'Yueqin Yang1', '601 Vairo', '814-765-4321', 120000, 1),
('xiz5158@psu.edu', '4172142', 'Xuejian Zhou1', '601 Vairo', '814-765-4321', 100000, 0),
('kvc5433@psu.edu', 'qwerty', 'Ko-Chen Chen1', '601 Vairo', '814-765-4321', 100000, 1),
('yang@psu.edu','123456789','Zekun Yang1', '601 Vairo', '814-765-4321', 100000, 0),
('yzw5284@psu.edu','00000000', 'Yingsheng Wang1', '601 Vairo', '814-765-4321', 666, 1);

INSERT INTO Shipper (Name, Email, Phone)
VALUES ('Very Fast', 'very_fast@gmail.com', '814-312-4123'),
('Fast', 'fast@gmail.com', '814-312-9832'),
('Normal Inc.', 'normal_inc@gmail.com', '814-312-2380'),
('Slow Snail', 'slow_snail@gmail.com', '814-312-8758'),
('Never Arrive', 'never_arrive@gmail.com', '814-312-7483');

INSERT INTO Item (Name, Info, Price, Method, Type)
VALUES
/*Tech*/
('Fire TV Stick with Alexa Voice Remote', 'Say it, Play it', 39.99, 1, 0),
('Echo Dot (2nd Generation)', 'Add Alexa to any room', 49.99, 0, 0),
('Fujifilm INSTAX Mini Instant Film Twin Pack', 'Fujifilm', 12.49, 0, 0),
('Amazon Fire TV', 'Watch Anywhere', 89.99, 0, 0),
('Fire Tablet', 'Best 7 Inches you will ever see', 39.99, 0, 0),
('SENSO Bluetooth Headphones', 'Best Earbuds', 36.97, 1, 0),
('Amazon Echo', 'Talk to Alexa anywhere', 179.99, 0, 0),
('Fire HD Tablet', 'HD Display', 36.97, 0, 0),
('Kindle Paperwhite', 'Black', 119.99, 0, 0),
('Roku Express', 'Black', 29.00, 0, 0),

/*Top
Adult*/
('Womens Summer Cross Front Tops', 'Haola', 14.9, 0, 1),
('Womens Casual Irregular Hem T-Shirt', 'Haola', 14.9, 1, 1),
('Womens Long Sleeve Tops Round Neck', 'Haola', 15.8, 0, 1),
('Women Long Sleeve/Short Sleeve O-Neck', 'POGTMM', 12, 1, 1),
('Girl Workout Jogging T-Shirt Fitted Long Sleeve Tops', 'Comemall', 20, 0, 1),
('Womens Spring Casual Print Long Sleeve T-shirt Top', 'Chellysun', 13, 1, 1),
('Womens Spring Casual Print Long Sleeve T-shirt Top', 'Lisingtoo', 5.2, 0, 1),
('Womens O Neck Feather Print Shirt', 'Lovaru', 10.55, 1, 1),
('Womens Casual Cold Shoulder Tops', 'Lovaru', 10, 0, 1),

/*Junior*/ 
('Soffe Big Girls Colorblock Hoody', 'Duchini', 8.38, 0, 1),
('Disney Girls Minnie Hoodie with Bow and Ear', 'Disney', 19.24, 1, 1),
('iEFiEL Summer Wedding Junior Bridesmaid', 'iefiel' , 11.95, 0, 1),
('Curry Girl Womens Cartoon Nightshirts', 'Curry girl', 6.55, 1, 1),
('Union Bay Girls Juniors Lace Shoulders Hooded', 'union bay', 6.99, 0, 1),
('Kids Chef Hat and Kids Apron Set', 'chefocity', 13.94, 1, 1),
('Disney Girls 2 Pack Minnie Mouse Dresses', 'Disney', 24.9, 0, 1),
('Emoji Basic Vest For Girls', 'ABCHIC', 7.0, 1, 1),
('iEFiEL Big Girls Youth Peace Signs', 'iEFiEL', 8.89, 0, 1),

/*Senior*/
('Adaptive T Shirt For Women', 'Silvet', 25, 1, 1),
('Alfred Dunner Biadere Knit Tee', 'Alfred', 34.5, 0, 1),
('The Senior Shop Womens Cotton Camisole', 'Indera', 7.99, 1, 1),
('Seniors 2017 Graduate Tee', 'customized Girl', 12.5, 0, 1),
('Pretty Adaptive Clothes Top For Women', 'Silvet', 44.62, 0, 1),
('Alfred Dunner Womens Plus Size Stripe Top', 'Alfred Dunner', 36, 0, 1),
('Mock Turtleneck Top', 'Silvert', 27.88, 1, 1),
('Adaptive Open Back Knit Nursing Home', 'Silvert', 30.67, 0, 1),
('Adaptive Blouses For Women', 'Silvert', 34.39, 0, 1),
('Cotton Adaptive Snap Back Blouse', 'Silvert',44.62, 0, 1),

/*Bottom adult */
('CYZ Womens Basic Stretch Cotton Knit' , 'CYZ', 12.99, 0, 1),
('Zoozie LA Womens Bell Bottoms', 'Zoozie', 35.99, 0, 1),
('Missy Womens 100% Narrow bottom', 'alki', 21.99, 0, 1),
('Rekucci Womens "Ease In To Comfort Fit"', 'Rekucci', 31.99, 1, 1),
('Novias Fashion High Waist Tie-Dye', 'Novias', 13.99, 0, 1),
('Rouge Collection Women Stretch Capri Pant', 'collection rogue', 17.99, 0, 1),
('Womens Tie-Dye Style Paisley Print 70s', 'Rogur fay', 32.98, 0, 1),
('Plumsika Womens Chevron Aztec Tribal', 'Plumsika', 13.29, 1, 1),
('Womens Plus Size Safari Jogger Pants', 'Romans', 34.77, 0, 1),
('Ellos Womens Plus Size Cargo Capris', 'Ellos', 34.68, 1, 1),

/*Bottom junior*/
('Nautica Girls Uniform Bootcut Twill Pant', 'NATICUA', 19.93, 1, 1),
('Nautica Girls Uniform Stretch Interlock Leggi', 'NATIcua', 10.83, 0, 1),
('Coolibar UPF 50+ Girls Beach Board Short', 'Collobar ', 14.99, 1, 1),
('Kids Tales Little Baby Girls Skinny Bell-Bottom Blue Jean Pants', 'kid tale', 8.79, 0, 1),
('French Toast School Uniforms Pull-On Girls Pant', 'French Toast', 9.88, 1, 1),
('PUMA Girls Active Double Mesh Short', 'PUMA', 10.99, 0, 1),
('Freestyle Revolution Toddler Girls 2pack Ind', 'Freestyle Revolution', 7.08, 0, 1),
('Colored Organics Baby Organic Lightweight Pants', 'Colored Organic', 6.95, 1, 1),
('Meru Boys and Girls Unisex Solid Color Pajamas', 'Meru', 8.99, 0, 1),
('Levis Baby Girls Haley May Super Skinny P', 'Levis', 6.69, 1, 1),

/*Shoes woman*/
('Balamasa Womens Open Toe High Heels Sandals', 'balamasa', 27.91, 1, 1),
('1TO9 Ladies Anti-Skidding Bottom Wheeled', '1TO9', 43.99, 0, 1),
('1TO9 Womens Color Matching Thick Bottom Heel European Style Boots', '1TO9', 45.9, 0, 1),
('AmoonyFashion Womens Closed Toe Low Heels Pumps-Shoes', 'AmoonyFashion', 30.99, 1, 1),
('MayMeenth Womens Soft Material Pointed C', 'MayMeenth', 29.05, 0, 1),
('AllhqFashion Womens Round Closed Toe Lo', 'AllhqFashion', 36.01, 1, 1),
('Schutz Womens Billie Pointed Toe Flat', 'Schutz', 165.00, 0, 1),
('Sam Edelman Womens Fallon Ballet Flat', 'Sam edlman', 41.98, 1, 1),
('Jessica Simpson Womens Libra Pointed Toe', 'Jessica Simpson', 24.56, 0, 1),
('Jessica Simpson', 'CK', 80.97, 0, 1),

/*junior*/
('PUMA Steeple Glitz Glam V Kids Sneaker', 'PUMA', 22.96, 1, 1),
('PUMA Steeple Glitz Glam V Kids Sneaker', 'Adidas', 37.92, 0, 1),
('New Balance Kids KL574 Sneaker', 'New Balance', 26.74, 1, 1),
('See Kai Run Kristin Sneaker (Toddler)', 'see kai', 25.9, 0, 1),
('carters Tween Girls Novelty Slip-On', 'Carters', 10.76, 1, 1),
('KEEN Encanto Sneaker (Toddler/Little Kid)', 'KENN', 25.99, 0, 1),
('PUMA GV Special Kids Sneaker', 'PUMA', 26.99, 1, 1),
('adidas Originals Samoa Sneaker', 'Adidas', 26.56, 0, 1),
('adidas NEO Daily K Sneaker', 'Adidas', 24.95, 1, 1),

/*TOP
Adult*/
('Nike Dry Knit', 'Nike', 22.8, 1, 1),
('Nike Pro Warm', 'Nike', 56.7, 0, 1),
('Nike Breath', 'Nike', 27.5, 0, 1),
('Nike Futura Icon', 'Nike', 25.8, 0, 1),
('Nike Dry Element', 'Nike', 212, 1, 1),
('Hurley Montauk', 'Nike', 127, 0, 1),
('Nike Court', 'Nike', 42, 1, 1),
('Hurley Staple', 'Nike', 10.12, 0, 1),
('Jordan 23', 'Nike', 18.88, 0, 1),

/*Junior*/
('Nike Dry LeBron Pixel', 'Nike', 8.38, 0, 1),
('Nike shoebox', 'Nike', 19.24, 0, 1),
('Nike SB', 'Nike', 11.95, 1, 1),
('Nike Kyrie', 'Nike', 6.55, 0, 1),
('Nike Dry Element', 'Nike', 26.99, 1, 1),
('Hurley Staple', 'Nike' ,13.94, 0, 1),
('Hurley Staple', 'Nike', 24.9, 0, 1),
('Nike Dry Element', 'Nike', 7.0, 1, 1),
('Hurley Staple', 'Nike' ,8.89, 0, 1),

/*Senior*/
('Nike Dry LeBron Pixel', 'Nike', 25, 0, 1),
('Nike Dry Element', 'Nike',34.5, 0, 1),
('Nike shoebox', 'Nike',47.99, 0, 1),
('Nike Dry LeBron Pixel', 'Nike', 112.5, 0, 1),
('Nike shoebox', 'Nike',44.62, 0, 1),
('Nike Dry Element', 'Nike',36, 0, 1),
('Nike Dry', 'Nike',27.88, 0, 1),
('Nike Dry Element', 'Nike',30.67, 0, 1),
('Nike Dry Element', 'Nike', 34.39, 0, 1),
('Nike shoebox', 'Nike',44.62, 0, 1),

/*Bottom 
Adult*/
('Nike Dry Knit', 'Nike',22.8, 0, 1),
('Nike Pro Warm', 'Nike',56.7,0, 1),
('Nike Breath', 'Nike',27.5, 0, 1),
('Nike Futura Icon', 'Nike',25.8, 0, 1),
('Nike Dry Element', 'Nike' ,212, 0, 1),
('Hurley Montauk', 'Nike', 127, 0, 1),
('Nike Court', 'Nike', 42, 0, 1),
('Hurley Staple', 'Nike', 10.12, 0, 1),
('Jordan 23', 'Nike', 18.88, 0, 1),

/*Junior*/
('Nike Dry LeBron Pixel', 'Nike', 8.38, 0, 1),
('Nike shoebox', 'Nike', 19.24, 0, 1),
('Nike SB', 'Nike', 11.95, 0, 1),
('Nike Kyrie', 'Nike', 6.55, 0, 1),
('Nike Dry Element', 'Nike', 26.99, 0, 1),
('Hurley Staple', 'Nike' ,13.94, 0, 1),
('Hurley Staple', 'Nike', 24.9, 0, 1),
('Nike Dry Element', 'Nike', 7.0, 0, 1),
('Hurley Staple', 'Nike' ,8.89, 0, 1),

/*Senior*/
('Nike Dry LeBron Pixel', 'Nike', 25.13, 0, 1),
('Nike Dry Element', 'Nike',324.5, 0, 1),
('Nike shoebox', 'Nike',473.99, 0, 1),
('Nike Dry LeBron Pixel', 'Nike', 112.5, 0, 1),
('Nike shoebox', 'Nike',44.62, 0, 1),
('Nike Dry Element', 'Nike',36.56, 0, 1),
('Nike Dry', 'Nike',27.88, 0, 1),
('Nike Dry Element', 'Nike',30.67, 0, 1),
('Nike Dry Element', 'Nike', 34.39, 0, 1),
('Nike shoebox', 'Nike',44.62, 0, 1),

/*Shoes
Adult*/
('Stan Smith Boost Shoes', 'Adidas',142.9, 0, 1),
('Superstar', 'Adidas', 124.9, 0, 1),
('Gazelle', 'Adidas', 105.8, 0, 1),
('Stan Smith Boost Shoes', 'Adidas', 112, 0, 1),
('Gazelle', 'Adidas' ,120, 0, 1),
('Stan Smith Boost Shoes' ,' Adidas', 13, 0, 1),
('Tubular',' Adidas', 5.2, 0, 1),
('Gazelle' , 'Adidas', 110.55, 1, 1),
('Superstar', 'Adidas', 180, 0, 1),

/*Junior*/
('Stan Smith Boost Shoes', 'Adidas',142.9, 0, 1),
('Superstar', 'Adidas',124.9, 1, 1),
('Gazelle', 'Adidas',105.8, 0, 1),
('Stan Smith Boost Shoes', 'Adidas', 112, 1, 1),
('Gazelle', 'Adidas' ,120, 0, 1),
('Stan Smith Boost Shoes' ,' Adidas', 13, 0, 1),
('Tubular',' Adidas', 5.2, 0, 1),
('Gazelle' , 'Adidas', 110.55, 1, 1),
('Superstar', 'Adidas', 180, 0, 1),

/*Senior*/
('Stan Smith Boost Shoes', 'Adidas', 72.9, 0, 1),
('Superstar', 'Adidas', 84.9, 1, 1),
('Gazelle', 'Adidas', 105.8, 0, 1),
('Stan Smith Boost Shoes', 'Adidas', 60, 1, 1),
('Gazelle', 'Adidas' ,75, 0, 1),
('Stan Smith Boost Shoes', 'Adidas', 153, 0, 1),
('Tubular',' Adidas', 5.2, 1, 1),
('Gazelle' , 'Adidas', 110.55, 0, 1),
('Superstar', 'Adidas', 180, 0, 1),

/*books*/
('When Breath Becomes Air', 'Paul Kalanithi', 28, 0, 1),
('The Couple Next Door', 'Shari Lapena', 25, 1, 2),
('The Magnolia Story', 'Chip & Joanna Gaines', 24, 0, 2),
('Dark Matter', 'Blake Crouch', 18, 1, 2),
('You Are A Badass', 'Jen Sincero', 28, 0, 2),
('I Let You Go', 'Clare Mackintosh', 13, 1, 2),
('It Ends With Us', 'Colleen Hoover', 28, 0, 2),
('A House Without Windows', 'Nadia Hashimi', 28, 1, 2),
('A Man Called Ove', 'Fredrik Backman', 28, 0, 2),
('The Nightingale', 'Kristin Hannah', 14, 1, 2),
('What She Knew', 'Gilly Macmillan', 28, 0, 2),
('All the Missing Girls', 'Megan Miranda', 32, 1, 2),
('Faithful', 'Alice Hoffman', 15, 0, 2),
('Small Great Things', 'Jodi Picoult', 10, 1, 2),
('Carry On', 'Rainbow Rowell', 54, 0, 2),
('Bring Me Back', 'Micalea Smeltzer', 30, 1, 2),
('Moonglow', 'Michael Chabon', 16, 0, 2),
('Me Before You', 'Jojo Moyes', 18, 1, 2),
('The Zookeepers Wife', 'Diane Ackerman', 30, 0, 2),  
('The Book Thief', 'Markus Zusak', 30, 0, 2),
('The Dark Tower', 'Stephen King', 21, 0, 2),
('The Tipping Point', 'Malcolm Gladwel', 22, 0, 2),
('The Nest', 'Cynthia D Aprix Sweeney', 17, 1, 2),
('Empty Mansions', 'Bill Dedman', 9.9, 0, 2),
('Truly Madly Guilty', 'Liane Moriarty', 9.9, 0, 2),
('The Reason You Walk', 'Wab Kinew', 9.9, 0, 2),
('The Underground Railroad', 'Colson Whitehead', 9.9, 1, 2),
('Orphan Train', 'Christina Baker Kline', 9.9, 0, 2),
('Atlas Obscura', 'Joshua Foer', 8.5, 0, 2),
('The Tipping Point', 'Malcolm Gladwell', 8.5, 0, 2),
('Founders at Work', 'Jessica Livingston', 8.5, 0, 2),
('Growing Great Employees: Turning Ordinary People into Extraordinary Performers', 'Erika Andersen', 8.5, 0, 2),
('Financial Intelligence for Entrepreneurs: What You Really Need to Know About the Numbers', 'Karen Berman', 8.5, 0, 2),
('The Entrepreneur Mind', 'Kevin D. Johnson', 8.5, 0, 2),
('The Brand Called You', 'Peter Montoya', 8.5, 0, 2),
('Influence: Science Practice', 'Robert B. Cialdini', 5.5, 0, 2),
('Uncommon Genius: How Great Ideas are Born', 'Denise Shekerjian', 27, 0, 2),
('Your Marketing Sucks', 'Mark Stevens', 5.5, 0, 2),
('Book Yourself Solid', 'Michael Port', 5.5, 1, 2),
('Business Model Generation', 'Alexander Osterwalder', 5.5, 0, 2),
('Poke the Box', 'Seth Godin', 5.5, 0, 2),
('Click Millionaires', 'Scott Fox', 5.5, 0, 2),
('Crossing the Chasm', 'Geoffrey Moore', 5.5, 1, 2),
('The Four Steps to Epiphany', 'Steve Blank', 5.5, 0, 2),
('The Startup Game', ' William H. Draper', 5.5, 0, 2),
('The $100 Startup: Reinvent the Way You Make a Living, Do What You Love, and Create a New Future', 'Chris Guillebeau', 5.5, 0, 2),
('Grown Up Digital: How the Net Generation is Changing Your World', 'Don Tapscott', 10, 0, 2),
('First, Break All the Rules', 'Marcus Buckingham', 5.5, 0, 2),
('Reinvent the Way You Make a Living, Do What You Love, and Create a New Future', 'Chris Draper', 5.5, 0, 2),
('How the Net Generation is Changing Your World', 'Don Blank', 10, 0, 2);
