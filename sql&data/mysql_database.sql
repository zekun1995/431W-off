/*CMPSC431 Project Main Code*/

/*USED FOR TESTING*/
DROP DATABASE tester;
CREATE DATABASE tester;
USE tester;
/*Problems
ISA RELATIONSHIP
Bid item end time needs to be something else
add a year to points expired time
sample data needs to be corrected
*/

/*Main Tables*/ 
CREATE TABLE Customer (
	CustomerID INTEGER AUTO_INCREMENT NOT NULL,
	Email VARCHAR(50) UNIQUE NOT NULL,
	Password VARCHAR(50) NOT NULL,
	Name VARCHAR(30) NOT NULL,
	Income REAL NOT NULL,
	Age INTEGER,
	Gender VARCHAR(8),
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
	Type INTEGER NOT NULL, /*0 is indi 1 is supplier*/
	PRIMARY KEY (SellerID)
);
CREATE TABLE Item (
	ItemID INTEGER NOT NULL,
	Name VARCHAR(255) NOT NULL,
	Info VARCHAR (511),
	Sell_Method INTEGER NOT NULL, /* 0 is sell, 1 is bid*/
	Categorie INTEGER NOT NULL, /*0 books, 1 Technology, 2 Apparel*/
    Picture_Link VARCHAR(255),
	PRIMARY KEY (ItemID, Name)
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
	End_Time TIMESTAMP NOT NULL,
	Start_Price REAL,
	Reserve_Price REAL,
	Status VARCHAR(30),
	PRIMARY KEY (ItemID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
		ON DELETE CASCADE
);
CREATE TABLE Sell_Item (
	ItemID INTEGER NOT NULL,
    Price REAL NOT NULL,
	PRIMARY KEY (ItemID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
		ON DELETE CASCADE
);
CREATE TABLE Books (
	ItemID INTEGER NOT NULL,
	Author VARCHAR(255),
	Categories VARCHAR(30),
	PRIMARY KEY (ItemID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
		ON DELETE CASCADE
);
CREATE TABLE Technology (
	ItemID INTEGER NOT NULL,
	Categories VARCHAR(255),
	PRIMARY KEY (ItemID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
		ON DELETE CASCADE
);
CREATE TABLE Apparel (
	ItemID INTEGER NOT NULL,
	Gender VARCHAR(1),
	Categories VARCHAR(30),
	Size CHAR (2),
	PRIMARY KEY (ItemID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
		ON DELETE CASCADE
);

/*Transaction Tables*/
CREATE TABLE Orders (
	OrderID INTEGER AUTO_INCREMENT NOT NULL,
	Qty INTEGER NOT NULL,
	Order_Date TIMESTAMP NOT NULL,
	Ship_Date TIMESTAMP,
	PRIMARY KEY (OrderID)
);
CREATE TABLE Bid (
	BidID INTEGER AUTO_INCREMENT NOT NULL,
	Price INTEGER NOT NULL,
	PRIMARY KEY (BidID)
);
CREATE TABLE Points (
	PointsID INTEGER AUTO_INCREMENT NOT NULL,
	Quantity INTEGER NOT NULL,
	EarnedTime TIMESTAMP,
	PRIMARY KEY (PointsID)
);
CREATE TABLE Returns (
	ReturnID INTEGER AUTO_INCREMENT NOT NULL,
	Return_Date TIMESTAMP NOT NULL,
	PRIMARY KEY (ReturnID)
);

/*Relationships*/
CREATE TABLE Cus_has_Card (
	CustomerID INTEGER NOT NULL,
	Card_Num CHAR(16),
	Address VARCHAR(50),
	PRIMARY KEY (CustomerID, Card_Num),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
		ON DELETE CASCADE
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
CREATE TABLE Cus_Earns_Points (
	CustomerID INTEGER NOT NULL,
	PointsID INTEGER NOT NULL,
	PRIMARY KEY (CustomerID, PointsID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (PointsID) REFERENCES Points(PointsID)
);
CREATE TABLE Seller_Supplied (
	SellerID INTEGER NOT NULL,
	ItemID INTEGER NOT NULL,
	Amount INTEGER NOT NULL,
	PRIMARY KEY (SellerID, ItemID),
	FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
CREATE TABLE Order_Contains (
	OrderID INTEGER NOT NULL,
	ItemID INTEGER NOT NULL,
	PRIMARY KEY (OrderID, ItemID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
CREATE TABLE Bid_Contains (
	BidID INTEGER NOT NULL,
	ItemID INTEGER NOT NULL,
	PRIMARY KEY (BidID, ItemID),
	FOREIGN KEY (BidID) REFERENCES Bid(BidID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);
CREATE TABLE Shipped_by (
	ShipperID INTEGER NOT NULL,
	OrderID INTEGER NOT NULL,
	PRIMARY KEY (ShipperID, OrderID),
	FOREIGN KEY (ShipperID) REFERENCES Shipper(ShipperID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
CREATE TABLE Order_has_ShippingInfo (
	OrderID INTEGER NOT NULL,
	TrackingNum VARCHAR(20) NOT NULL,
	Distribution_Date TIMESTAMP,
	PRIMARY KEY (OrderID, TrackingNum),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
		ON DELETE CASCADE
);
CREATE TABLE Returning_Order (
	ReturnID INTEGER NOT NULL,
	OrderID INTEGER NOT NULL,
	PRIMARY KEY (ReturnID, OrderID),
	FOREIGN KEY (ReturnID) REFERENCES Returns(ReturnID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
CREATE TABLE Gives_Feedback (
	FeebackID INTEGER AUTO_INCREMENT NOT NULL,
    ItemID INTEGER NOT NULL,
	Rating_Star INTEGER,
	FeedBack_Info VARCHAR(1023),
	PRIMARY KEY (FeebackID, ItemID),
	FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
		ON DELETE CASCADE
);

/*CREATE TABLE Points_Convert (
	PointsID INTEGER NOT NULL,
	issuedTime TIMESTAMP,
	PRIMARY KEY (PointsID),
	FOREIGN KEY (PointsID) REFERENCES Points(PointsID)
		ON DELETE CASCADE
);*/
/*CREATE TABLE CorrespondTo (
	BidID INTEGER NOT NULL,
	WinnerEmail CHAR (50) NOT NULL,
	Minimum_Price REAL NOT NULL,
	PRIMARY KEY (BidID),
	FOREIGN KEY (BidID) REFERENCES Bid(BidID)
		ON DELETE CASCADE
);*/

/*WHAT*/
/*CREATE TABLE Ind_Seller_Accept (
	SellerID INTEGER NOT NULL,
	BidID INTEGER NOT NULL,
	PRIMARY KEY (SellerID, BidID),
	FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
	FOREIGN KEY (BidID) REFERENCES Bid(BidID)
);*/

/*CREATE TABLE Deliver (
	ShipperID INTEGER NOT NULL,
	TrackingNum VARCHAR(20) NOT NULL,
	CustomerID INTEGER NOT NULL,
	PRIMARY KEY (ShipperID, TrackingNum, CustomerID),
	FOREIGN KEY (ShipperID) REFERENCES Shipper(ShipperID),
	FOREIGN KEY (TrackingNum) REFERENCES Shipping_Info(TrackingNum),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);*/

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

/*CREATE TRIGGER add_items_method_type AFTER INSERT ON Item
	FOR EACH ROW BEGIN
		IF NEW.Sell_Method = 0 THEN
			INSERT INTO Sell_Item(ItemID) VALUES (NEW.ItemID);
		ELSEIF NEW.Sell_Method = 1 THEN
			INSERT INTO Bid_Item(ItemID) VALUES (NEW.ItemID);
		END IF;
		IF NEW.Categorie = 0 THEN
			INSERT INTO Books(ItemID) VALUES (NEW.ItemID);
		ELSEIF NEW.Categorie = 1 THEN
			INSERT INTO Technology(ItemID) VALUES (NEW.ItemID);
		ELSEIF NEW.Categorie = 2 THEN
			INSERT INTO Apparel(ItemID) VALUES (NEW.ItemID);
		END IF;
	END$$*/
DELIMITER ;

/*Adding Info*/
INSERT INTO Customer (Email, Password, Name, Income, Age, Gender) 
VALUES ('admin', 'admin', 'admin', 1000000, 1000, 'Superman'),
('meixin_kok@hotmail.com', '123456', 'Maggie Coulson', 100000, 34, 'Female'),    
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


INSERT INTO Item(ItemID, Name, Info, Sell_Method, Categorie, Picture_Link)
VALUES(0000, 'The Book of the Unnamed Midwife', 'When she fell asleep, the world was doomed. When she awoke, it was dead.', 1, 0, 'images/Books/scifi/the book of the unnamed midwife.jpg'),
	  (0001, 'Deaths End', 'The New York Times bestselling conclusion to a tour de force near-future adventure trilogy from Chinas bestselling and beloved science fiction writer.', 0, 0, 'images/Books/scifi/deaths end.jpg'),
	  (0002, 'The Obelisk Gate (The Broken Earth)', 'This is the way the world ends, for the last time. The season of endings grows darker, as civilization fades into the long cold night.', 0, 0, 'images/Books/scifi/the obelisk gate.jpg'),
	  (0003, 'All the Birds in the Sky', 'From the former editor-in-chief of io9.com, a stunning novel about the end of the world―and the beginning of our future', 0, 0, 'images/Books/scifi/all the birds in the sky.jpg'),
	  (0004, 'The Invisible Library', 'Collecting books can be a dangerous prospect in this fun, time-traveling, fantasy adventure from a spectacular debut author.', 0, 0, 'images/Books/scifi/the invisible library.jpg'),
	  (0005, 'The Hike: A Novel', 'From the author of The Postmortal, a fantasy saga unlike any you’ve read before, weaving elements of folk tales and video games into a riveting, unforgettable adventure of what a man will endure to return to his family', 0, 0, 'images/Books/scifi/the hike.jpg'),
	  (0006, 'Every Heart a Doorway', 'Read Every Heart a Doorway, the transformative book that won the 2017 Alex Award, is a finalist for the Hugo and Nebula Awards for Best Novella, and made the 2016 Tiptree Honor List', 0, 0, 'images/Books/scifi/every heart a doorway.jpg'),
	  (0007, 'Ninefox Gambit', 'To win an impossible war Captain Kel Cheris must awaken an ancient weapon and a despised traitor general.', 0, 0, 'images/Books/scifi/ninefox gambit.jpg'),
	  (0008, 'Age of Myth', 'The Age of Myth is over; the time of rebellion has begun.', 0, 0, 'images/Books/scifi/age of myth.jpg'),
	  (0009, 'The Biabolid', 'A Diabolic is ruthless. A Diabolic is powerful. A Diabolic has a single task: Kill in order to protect the person you’ve been created for.', 0, 0, 'images/Books/scifi/the diabolic.jpg'),
	  (0010, 'A Lowcountry Wedding', 'Nothing could be more enchanting than a summer wedding—or two!—in Charleston’s fabled lowcountry. A centuries-old plantation, an avenue of ancient oaks dripping moss, a storied ballroom, a sand dune at sunset…', 0, 0, 'images/Books/romance/a lowcountry wedding.jpg'),
	  (0011, 'First Star I See Tonight', 'A no-nonsense sports hero and a feisty female detective go head-to-head in this funny, fresh, seductive novel from the award winning NYT bestselling author known for her unforgettable characters, heartfelt emotion, and laugh out loud humor.', 0, 0, 'images/Books/romance/a promise of fire.jpg'),
	  (0012, 'Sting', '#1 New York Times and USA Today bestselling author Sandra Brown jolts the reader from the first page of this heart-pounding story of corruption, treachery, and ceaseless deception . . . where nothing is what it seems and every truth brought to light exposes a darker lie.', 0, 0, 'images/Books/romance/first star i see tonight.jpg'),
	  (0013, 'Sweet Tomorrow', 'The much-anticipated conclusion to Debbie Macomber’s beloved Rose Harbor series, set in the picturesque town of Cedar Cove, Sweet Tomorrows is a vibrant and poignant novel of letting go of fear, following your heart, and embracing the future—come what may.', 0, 0, 'images/Books/romance/sting.jpg'),
	  (0014, 'A Promise if Fire', 'A Kirkus Reviews Best Book of 2016! An NPR Best Book of 2016!', 0, 0, 'images/Books/romance/sweet tomorrow.jpg'),
	  (0015, 'A Scot in the Dark', 'Miss Lillian Hargrove has lived much of her life alone in a gilded cage, longing for love and companionship. When an artist offers her pretty promises and begs her to pose for a scandalous portrait, Lily doesn’t hesitate . . . until the lying libertine leaves her in disgrace.', 0, 0, 'images/Books/romance/a scot in the dark.jpg'),
	  (0016, 'Duke of Sin', 'Devastatingly handsome. Vain. Unscrupulous. Valentine Napier, the Duke of Montgomery, is the man London whispers about in boudoirs and back alleys. A notorious rake and blackmailer, Montgomery has returned from exile, intent on seeking revenge on those who have wronged him.', 0, 0, 'images/Books/romance/duke of sin.jpg'),
	  (0017, 'Wicked Sexy Liar', 'When three college besties meet three hot guys in Vegas, anything can—and does—happen. Book Four in the New York Times Wild Seasons series that began with Sweet Filthy Boy.', 0, 0, 'images/Books/romance/wicked sexy liar.jpg'),
	  (0018, 'My American Duchess', 'The arrogant Duke of Trent intends to marry a well-bred Englishwoman. The last woman he would ever consider marrying is the adventuresome Merry Pelford— an American heiress who has infamously jilted two fiancés.', 0, 0, 'images/Books/romance/my american duchess.jpg'),
	  (0019, 'Because Im Watching', '2016 Amazon Best of Romance! 2016 Booklist Best of Romantic Suspense!', 0, 0, 'images/Books/romance/because im watching.jpg'),
	  (0020, 'Big Little Lies', 'The #1 New York Times bestseller that Entertainment Weekly called “a surefire hit.”', 0, 0, 'images/Books/mystery/big little lies.jpg'),
	  (0021, 'It: A Novel', 'Soon to be a major motion picture—Stephen King’s terrifying, classic #1 New York Times bestseller, “a landmark in American literature” (Chicago Sun-Times)—about seven adults who return to their hometown to confront a nightmare they had first stumbled on as teenagers…an evil without a name: It.', 0, 0, 'images/Books/mystery/it.jpg'),
	  (0022, 'Mississippi Blood', 'The #1 New York Times Bestseller. The final installment in the epic Natchez Burning trilogy by Greg Iles', 0, 0, 'images/Books/mystery/mississippi blood.jpg'),
	  (0023, 'The Fix', 'THE NEW MEMORY MAN NOVEL! Amos Decker witnesses a murder just outside FBI headquarters. A man shoots a woman execution-style on a crowded sidewalk, then turns the gun on himself.', 0, 0, 'images/Books/mystery/the fix.jpg'),
	  (0024, 'All by Myself, Alone', 'A glamorous cruise on a luxurious ocean liner turns deadly in the latest mystery from “Queen of Suspense” and #1 New York Times bestselling author Mary Higgins Clark.', 0, 0, 'images/Books/mystery/all by myself, alone.jpg'),
	  (0025, 'Earthly Remains', 'In Earthly Remains, the twenty-sixth novel in this series, Brunetti’s endurance is tested more than ever before. During an interrogation of an entitled, arrogant man suspected of giving drugs to a young girl who then died, Brunetti acts rashly, doing something he will quickly come to regret.', 0, 0, 'images/Books/mystery/earthly remains.jpg'),
	  (0026, 'The Life We Bury', 'College student Joe Talbert has the modest goal of completing a writing assignment for an English class. His task is to interview a stranger and write a brief biography of the person. With deadlines looming, Joe heads to a nearby nursing home to find a willing subject.', 0, 0, 'images/Books/mystery/the life we bury.jpg'),
	  (0027, 'Vicious Circle', 'The past comes back to haunt game warden Joe Pickett and his family with devastating effect in the thrilling new novel from #1 New York Times–bestselling author C. J. Box.', 0, 0, 'images/Books/mystery/vicious circle.jpg'),
	  (0028, 'Golden Prey', 'Lucas Davenport’s first case as a U.S. Marshal sends him into uncharted territory in the thrilling new novel in the #1 New York Times-bestselling series. The man was smart and he didn’t mind killing people. Welcome to the big leagues, Davenport.', 0, 0, 'images/Books/mystery/golden prey.jpg'),
	  (0029, 'The MIdnight Line', 'From the #1 New York Times bestselling author of Night School comes the newest powerhouse thriller featuring international man of action Jack Reacher.', 0, 0, 'images/Books/mystery/the midnight line.jpg'),
	  (0030, 'Python Crash Course', 'Python Crash Course is a fast-paced, thorough introduction to programming with Python that will have you writing programs, solving problems, and making things that work in no time.', 0, 0, 'images/Books/Tech/python crash course.jpg'),
	  (0031, 'JavaScript: The Ultimate Beginners Guide', 'This book will help you understand what JavaScript is, its importance, and how you can use this knowledge to create your own scripts for your websites.', 0, 0, 'images/Books/Tech/javascript.jpg'),
	  (0032, 'The Phoenix Project', 'Bill is an IT manager at Parts Unlimited. It is Tuesday morning and on his drive into the office, Bill gets a call from the CEO.', 0, 0, 'images/Books/Tech/the phoenix project.jpg'),
	  (0033, 'Web Design with HTML, CSS, JavaScript and jQuery Set', 'A two-book set for web designers and front-end developers', 0, 0, 'images/Books/Tech/web design.jpg'),
	  (0034, 'Python 3: The Ultimate Beginners Guide for Python 3 programming', 'Python is a programming language used for interactive, portable and flexible programs. It has a syntax that can easily interface with other systems. It’s object-oriented, meaning, it focuses on object-oriented data, modules and classes.', 0, 0, 'images/Books/Tech/python 3.jpg'),
	  (0035, 'R for Data Science', 'Learn how to use R to turn raw data into insight, knowledge, and understanding. This book introduces you to R, RStudio, and the tidyverse, a collection of R packages designed to work together to make data science fast, fluent, and fun.', 0, 0, 'images/Books/Tech/R for data science.jpg'),
	  (0036, 'Raspberry Pi: The Blueprint to Raspberry Pi 3', 'Want to get the most from your Raspberry Pi? Start with the blueprint! The Raspberry Pi is a remarkable computer in many ways from size to price, through to the distinctive way in which it can be used by plugging it into a TV and keyboard.', 0, 0, 'images/Books/Tech/raspberry pi.jpg'),
	  (0037, 'C# for Beginners: The tactical guidebook', 'This book is for YOU if you are a prospective C# programmer and like a CHALLENGE. This is not your run of the mill encyclopedic programming book; it is highly modularized, tactical and practical, meaning that you learn by reading theory and then implement targeted exercises.', 0, 0, 'images/Books/Tech/c for beginners.jpg'),
	  (0038, 'Adobe Photoshop CC Classroom in a Book', 'Creative professionals seeking the fastest, easiest, most comprehensive way to learn Adobe Photoshop choose Adobe Photoshop CC Classroom in a Book (2017 release) from Adobe Press.', 0, 0, 'images/Books/Tech/adobe photoshop cc.jpg'),
	  (0039, 'The C Programming Language', 'The authors present the complete guide to ANSI standard C language programming.', 0, 0, 'images/Books/Tech/the c programming.jpg'),
	  (0040, 'Romeo and Juliet', 'No Fear Shakespeare gives you the complete text of Romeo and Juliet on the left-hand page, side-by-side with an easy-to-understand translation on the right.', 0, 0, 'images/Books/drama/romeo and juliet.jpg'),
	  (0041, 'A Raisin in the Sun', 'This groundbreaking play starred Sidney Poitier, Claudia McNeill, Ruby Dee and Diana Sands in the Broadway production which opened in 1959. Set on Chicago South Side, the plot revolves around the divergent dreams and conflicts within three generations of the Younger family', 0, 0, 'images/Books/drama/a raisin in the sun.jpg'),
	  (0042, 'The Tale of Three Trees', 'Featuring the wonderful illustrations of Tim Jonke, this best-selling children’s book tells the Easter story from a new and unusual point of view.', 0, 0, 'images/Books/drama/the tale of three trees.jpg'),
	  (0043, 'Macbeth', 'In 1603, James VI of Scotland ascended the English throne, becoming James I of England. London was alive with an interest in all things Scottish, and Shakespeare turned to Scottish history for material.', 0, 0, 'images/Books/drama/macbeth.jpg'),
	  (0044, 'Death of Salesman', 'The Pulitzer Prize-winning tragedy of a salesman’s deferred American dream', 0, 0, 'images/Books/drama/death of salesman.jpg'),
	  (0045, 'Hamlet', 'Hamlet: An UPDATED EDITION from the Folger Shakespeare Library. Hamlet is Shakespeares most popular, and most puzzling, play.', 0, 0, 'images/Books/drama/hamlet.jpg'),
	  (0046, 'A Streetcar Named Desire', 'The Pulitzer Prize and Drama Critics Circle Award winning play―reissued with an introduction by Arthur Miller (Death of a Salesman and The Crucible)', 0, 0, 'images/Books/drama/a streetcar named desire.jpg'),
	  (0047, 'Fences', 'Now a Major Motion Picture directed by Denzel Washington, and starring Denzel Washington and Viola Davis (winner of the Academy Award and Golden Globe for her role)', 0, 0, 'images/Books/drama/fences.jpg'),
	  (0048, 'The Crucible', 'Based on historical people and real events, Arthur Miller play uses the destructive power of socially sanctioned violence unleashed by the rumors of witchcraft as a powerful parable about McCarthyism.', 0, 0, 'images/Books/drama/the crucible.jpg'),
	  (0049, 'Whiskey Moth', 'Michelle left behind everything she knows to move from the Midwest to Long Beach, California in hopes of leaving behind the memories of her past. Unfortunately, no amount of alcohol can make her forget about how she betrayed her mother.', 0, 0, 'images/Books/drama/whiskey moth.jpg'),
	  (0100, 'Samsung 4K Ultra HD TV', 'Samsung 55" Class (54.6" Diag.) - LED - 2160p - Smart - 4K Ultra HD TV.', 1, 1, 'images/technology/TV&HomeTheater/Samsung55.jpg'),
	  (0101, 'Insignia™ - 32" HDTV', 'Insignia™ - 32" Class - (31.5" Diag.) - LED - 720p - HDTV - Black', 0, 1, 'images/technology/TV&HomeTheater/insignia32.jpg'),
	  (0102, 'Toshiba - 50" HDTV', 'Toshiba - 50" Class (49.5" Diag.) - LED - 1080p - HDTV - Black', 0, 1, 'images/technology/TV&HomeTheater/toshiba50.jpg'),
	  (0103, 'Amazon Fire TV', 'Amazon Fire TV supports 4K Ultra HD for true-to-life picture quality. Watch high-definition 1080p streams on Amazon Video, Netflix, YouTube, Hulu and more, even without a 4K TV.', 0, 1, 'images/technology/TV&HomeTheater/Amazon Fire TV.jpg'),
	  (0104, 'Fire TV Stick with Alexa Voice Remote', 'The next generation of our bestselling Fire TV Stick. The most powerful streaming media stick under $50–now with the Alexa Voice Remote.', 0, 1, 'images/technology/TV&HomeTheater/Fire TV Stick with Alexa Voice Remote.jpg'),
	  (0110, 'Apple - MacBook Air', 'Apple - MacBook Air® (Latest Model) - 13.3" Display - Intel Core i5 - 8GB Memory - 128GB Flash Storage - Silver', 0, 1, 'images/technology/computer&tablet/mac air.jpg'),
	  (0111, 'Dell - Inspiron 2-in-1', 'Dell - Inspiron 2-in-1 13.3" Touch-Screen Laptop - Intel Core i5 - 8GB Memory - 256GB Solid State Drive - Gray', 0, 1, 'images/technology/computer&tablet/dell.jpg'),
	  (0112, 'Apple - MacBook® Pro', 'Apple - MacBook® Pro - 15.4" Display - Intel Core i7 - 16GB Memory - 256GB Flash Storage - Silver', 0, 1, 'images/technology/computer&tablet/mac pro.jpg'),
	  (0113, 'Apple - iPad', 'Apple - iPad with WiFi - 32GB - Silver', 0, 1, 'images/technology/computer&tablet/ipad.jpg'),
	  (0114, 'Fire HD 8 Tablet','Fire HD 8 Tablet with Alexa, 8" HD Display, 16 GB, Black - with Special Offers', 0, 1, 'images/technology/computer&tablet/Fire HD tablet.jpg'),
	  (0120, 'Canon - EOS Rebel T6', 'Canon - EOS Rebel T6 DSLR Camera with EF-S 18-55mm IS II and EF 75-300mm III lens', 0, 1, 'images/technology/camera/canon EOS.jpg'),
	  (0121, 'Fujifilm - instax mini 8','Fujifilm - instax mini 8 Instant Film Camera - Blue', 0, 1, 'images/technology/camera/fujifilm.jpg'),
	  (0122, 'Nikon - Coolpix', 'Nikon - Coolpix L340 20.2-Megapixel Digital Camera - Black', 0, 1, 'images/technology/camera/nikon coolpix.jpg'),
	  (0123, 'Sony - Alpha a6000', 'Sony - Alpha a6000 Mirrorless Camera with 16-50mm and 55-210mm Lenses - Black', 0, 1, 'images/technology/camera/sony alpha.jpg'),
	  (0124, 'GoPro - HERO5', 'GoPro - HERO5 Black 4K Action Camera', 0, 1, 'images/technology/camera/gopro.jpg'),
	  (0130, 'Samsung - Galaxy S7', 'Samsung - Galaxy S7 4G LTE with 32GB Memory Cell Phone (Unlocked) - Black Onyx', 0, 1, 'images/technology/phone&earPhone/samsung s7.jpg'),
	  (0131, 'Motorola - Moto G Plus', 'Motorola - Moto G Plus (5th Gen) 4G LTE with 32GB Memory Cell Phone (Unlocked) - Lunar Gray', 0, 1, 'images/technology/phone&earPhone/motorola.jpg'),
	  (0132, 'Apple - iPhone 6', 'Apple - iPhone 6 128GB Cell Phone (Unlocked) - Gold', 0, 1, 'images/technology/phone&earPhone/iphone 6.jpg'),
	  (0133, 'Bose® - SoundSport®', 'Bose® - SoundSport® wireless headphones - Black', 0, 1, 'images/technology/phone&earPhone/bose.jpg'),
	  (0134, 'Sony - Noise-Canceling', 'Sony - Noise-Canceling Over-the-Ear Headphones - Black', 0, 1, 'images/technology/phone&earPhone/sony.jpg'),
	  (0140, 'Keurig - K50 Coffeemaker', 'The compact size takes up minimal space on your counters, and the removable drip tray prevents splashes and spills.', 0, 1, 'images/technology/appliances/coffee.jpg'),
	  (0141, 'Hamilton Beach - 12-Cup Coffeemaker', 'Brew coffee for friends and family with this Hamilton Beach 12-cup coffeemaker that features bold, regular and 1-4 cup options for custom brewing.', 0, 1, 'images/technology/appliances/coffee 2.jpg'),
	  (0142, 'Hoover - WindTunnel 2 High Capacity Bagless Pet Upright Vacuum', 'Clean up after your furry friend with this upright vacuum that features a rotating Pet Power brush to remove hair and fur from furniture and more.', 0, 1, 'images/technology/appliances/hoover.jpg'),
	  (0143, 'Shark - Professional Steam Power Iron', 'Efficiently remove wrinkles from your clothing with this Shark Professional GI405 steam power iron that features a tapered-tip soleplate to reach between buttons.', 0, 1, 'images/technology/appliances/iron.jpg'),
	  (0144, 'Ninja - Professional 3-Speed Blender', 'A professional-grade power base and large-capacity pitcher make large batches a snap to prepare.', 0, 1, 'images/technology/appliances/blender.jpg'),
	  (0200, 'Boat Neck Loose Top', 'Boat neck, 3/4 sleeve, Plain, Loose', 1, 2, 'images/clothes/women/top/boat neck.jpg'),
	  (0201, 'Cut-Out Knit Top', 'Round neck, Short sleeve', 0, 2, 'images/clothes/women/top/cut out.jpg'),
	  (0202, 'steal the scene tee', '100% cotton, crew neck', 0, 2, 'images/clothes/women/top/steal.jpeg'),
	  (0203, 'SHORT SLEEVE BUTTON DOWN SHIRT', 'Lightweight cotton, Easy and relaxed fit, length hits at waistband, Full button front, Straight point collar', 0, 2, 'images/clothes/women/top/short.jpeg'),
	  (0204, 'SOFT & SEXY PLUSH HOODIE', 'Classic fit, length hits at waistband, Full zip front, Full hood, Split kangaroo pocket', 0, 2, 'images/clothes/women/top/soft.jpeg'),
	  (0210, 'Black Pencil Pants', 'Materials:100%POLYESTER', 0, 2, 'images/clothes/women/bottom/black.jpg'),
	  (0211, 'Belted Wide Leg Pants', 'Materials:100%POLYESTER', 0, 2, 'images/clothes/women/bottom/belted.jpg'),
	  (0212, 'High Waist Skinny Jeans', 'Materials:100%COTTON', 0, 2, 'images/clothes/women/bottom/high.jpg'),
	  (0213, 'SILKY TRACK PANT', '100% Polyester Woven', 0, 2, 'images/clothes/women/bottom/silky.jpeg'),
	  (0214, 'AERIE CHILL CROP', '92% Cotton, 8% Spandex', 0, 2, 'images/clothes/women/bottom/chill.jpeg'),
	  (0220, 'BOMBER JACKET', '65% Cotton, 35% Nylon Twill', 0, 2, 'images/clothes/women/outerwear/bomber.jpeg'),
	  (0221, 'CLASSIC DENIM JACKET', '100% Cotton', 0, 2, 'images/clothes/women/outerwear/denim.jpeg'),
	  (0222, 'Fashion Motorcycle Jacket', 'Includes belt, Zipper', 0, 2, 'images/clothes/women/outerwear/motor.jpg'),
	  (0223, 'Whitby Bomber', 'Taking inspiration from retro flight jackets, this bomber is made with a slick, smooth fabric.', 0, 2, 'images/clothes/women/outerwear/talula.jpg'),
	  (0224, 'Corsan Vest', 'This super-light — yet incredibly warm — puffer vest is streamlined enough to work as an inner or outer layer.', 0, 2, 'images/clothes/women/outerwear/vest.jpg'),
	  (0230, 'New Balance WX615v1', 'Stay on top of your workout routine in the lightweight performance of the New Balance® WX615v1 cross-training shoe!', 0, 2, 'images/clothes/women/shoes/new balance.jpg'),
	  (0231, 'Vans Era 59', 'The Era 59 is a sophisticated skate shoe for the style savvy shredder.', 0, 2, 'images/clothes/women/shoes/vans.jpg'),
	  (0232, 'Nike Free RN', 'Unleash your stride in the lightweight cushioning and unrestricted performance of the Nike® Free RN running shoe!', 0, 2, 'images/clothes/women/shoes/nike.jpg'),
	  (0233, 'Harley-Davidson Arcola', 'It features all the best you have come to know with its sleek casual style and sturdy outsole that will keep you in style for years to come.', 0, 2, 'images/clothes/women/shoes/harley.jpg'),
	  (0234, 'Yosi Samra Roee Metallic Leather Flip Flop', 'Get the party started with Roee Metallic Leather Flip Flop, they are snazzy.', 0, 2, 'images/clothes/women/shoes/yosi.jpg'),
	  (0240, 'Marble Earrings in Diamond Shape', 'Diamond Shape', 0, 2, 'images/clothes/women/accessories/marble.jpg'),
	  (0241, 'Round Reflective Sunglasses', 'Round Reflective Sunglasses', 0, 2, 'images/clothes/women/accessories/round.jpg'),
	  (0242, 'STRIPED BOW HEADBAND', 'Striped', 0, 2, 'images/clothes/women/accessories/striped.jpeg'),
	  (0243, 'STREET LEVEL SIDE TASSEL TOTE', 'Faux leather, 20” w x 6.5” D x 13” h', 0, 2, 'images/clothes/women/accessories/street.jpeg'),
	  (0244, 'Herscel Supply Co. Packable Daypack', 'Classic lightweight daypack design.', 0, 2, 'images/clothes/women/accessories/bag.jpg'),
	  (0250, 'TROPICAL PRINT SHORT SLEEVE SHIRT', 'Seriously Soft fabric, Classic fit, Button down collar', 0, 2, 'images/clothes/men/top/tropical.jpeg'),
	  (0251, 'STRIPE DYE CREW T-SHIRT', 'Stretch flex jersey, Classic fit, Crew neck', 0, 2, 'images/clothes/men/top/stripe.jpeg'),
	  (0252, 'Ariat Andy, Shirt', 'The serious cowboy can handle the rugged lifestyle in ease in this grand Andy Shirt.', 0, 2, 'images/clothes/men/top/ariat.jpg'),
	  (0253, 'Obey Next Round 2', 'Soft loose fitted tee.', 0, 2, 'images/clothes/men/top/obey.jpg'),
	  (0254, 'Outdoor 1/2 Zip Long Sleeve Top', 'Athletic Fit.', 0, 2, 'images/clothes/men/top/outdoor.jpg'),
	  (0260, 'EXTREME FLEX SLIM 7" FLAT FRONT SHORT', 'Garment dyed for softness and rich color, Stretches horizontally, which is most important for everyday movement.', 0, 2, 'images/clothes/men/bottom/flex.jpeg'),
	  (0261, 'Rock and Roll Cowboy Pistol Bootcut', 'Five-pocket design. 100% cotton.', 0, 2, 'images/clothes/men/bottom/rock.jpg'),
	  (0262, 'EXTREME FLEX LONGER LENGTH CARGO SHORT', 'Designed for ultimate comfort, retention and durability', 0, 2, 'images/clothes/men/bottom/longer.jpeg'),
	  (0263, 'UA Sportstyle Jogger Pants', 'Sports have made the crossover to the fashion lane and we like it.', 0, 2, 'images/clothes/men/bottom/UA.jpg'),
	  (0264, 'Slim Fit Separate Pants', 'Slimmer fit delivers a more contemporary look.', 0, 2, 'images/clothes/men/bottom/reaction.jpg'),
	  (0270, 'Outdoor Terrex Skyclimb Insulation Jacket', 'The higher the altitude, the tougher the climb. Keep out the wind and cold without your gear getting you down in the Terrex Skyclimb Insulation Jacket 2.', 0, 2, 'images/clothes/men/outerwear/outdoor.jpg'),
	  (0271, 'Softshell Vest', 'Vest with structured seaming.', 0, 2, 'images/clothes/men/outerwear/vest.jpg'),
	  (0272, 'Steens Mountain Full Zip', 'Modern classic fit is relaxed, but not sloppy, and perfect for everyday activities.', 0, 2, 'images/clothes/men/outerwear/steens.jpg'),
	  (0273, 'Devils Horn Zip Crew Fleece', 'Soft cotton-poly fleece allows for added warmth and comfort.', 0, 2, 'images/clothes/men/outerwear/horn.jpg'),
	  (0274, '3-in-1 Systems Jacket', 'Three-in-one jacket features a lightweight shell and warm liner that can be worn together or separate.', 0, 2, 'images/clothes/men/outerwear/systems.jpg'),
	  (0280, 'PUMA Propel', 'Pull tab for easy on and off.', 0, 2, 'images/clothes/men/shoes/puma.jpg'),
	  (0281, 'Mix-Er', 'Blind-eyelet lace construction. Plain round toe.', 0, 2, 'images/clothes/men/shoes/mix.jpg'),
	  (0282, 'Tommy Hilfiger Denver', 'Faux leather upper. Slip-on silhouette.', 0, 2, 'images/clothes/men/shoes/denver.jpg'),
	  (0283, 'Nike Free RN', 'Unleash your stride in the lightweight cushioning and unrestricted performance of the Nike® Free RN running shoe!', 0, 2, 'images/clothes/men/shoes/free.jpg'),
	  (0284, 'Timberland 6" Basic Boot', 'Leather and textile upper. Lace-up closure.', 0, 2, 'images/clothes/men/shoes/boot.jpg'),
	  (0290, 'Spy Optic Showtime', 'Ultra-tough and shatter-resistant 8x4 polycarbonate lenses.', 0, 2, 'images/clothes/men/accessories/optic.jpg'),
	  (0291, 'Nike Wool Tailwind Cap', 'Keep it cool and casual when the temps start to dip with the Nike® Wool Tailwind Cap.', 0, 2, 'images/clothes/men/accessories/cap.jpg'),
	  (0292, 'Trafalgar Seth', 'The handsome style of the Trafalgar® Seth belt is what your wardrobe needs!', 0, 2, 'images/clothes/men/accessories/seth.jpg'),
	  (0293, 'Missoni Ties', '100% silk.', 0, 2, 'images/clothes/men/accessories/missoni.jpg'),
	  (0294, 'Mountain Hardwear Enterprise 29L Backpck', 'Spacious main compartment with dual-zip closure.', 0, 2, 'images/clothes/men/accessories/hardwear.jpg');


INSERT INTO Bid_Item(ItemID, Start_Price, Reserve_Price, Status)
VALUES(0000, 1.00, 9.00, 'Bidding'),
	  (0100, 500.00, 899.99, 'Bidding'),
      (0200, 20.00, 39.00, 'Bidding');

INSERT INTO Sell_Item(ItemID, Price)
VALUES #(0000, 9.00),
	  (0001, 16.06),
	  (0002, 8.70),
	  (0003, 15.47),
	  (0004, 8.16),
	  (0005, 11.00),
	  (0006, 10.44),
	  (0007, 9.99),
	  (0008, 7.83),
	  (0009, 16.00),
	  (0010, 10.00),
	  (0011, 16.91),
	  (0012, 15.01),
	  (0013, 14.74),
	  (0014, 5.98),
	  (0015, 5.43),
	  (0016, 7.99),
	  (0017, 10.07),
	  (0018, 7.99),
	  (0019, 16.42),
	  (0020, 10.72),
	  (0021, 14.35),
	  (0022, 17.39),
	  (0023, 19.46),
	  (0024, 16.19),
	  (0025, 16.51),
	  (0026, 8.96),
	  (0027, 16.20),
	  (0028, 21.25),
	  (0029, 25.53),
	  (0030, 21.73),
	  (0031, 18.19),
	  (0032, 17.86),
	  (0033, 26.50),
	  (0034, 16.81),
	  (0035, 33.44),
	  (0036, 11.38),
	  (0037, 38.41),
	  (0038, 38.98),
	  (0039, 19.99),
	  (0040, 2.97),
	  (0041, 6.36),
	  (0042, 9.82),
	  (0043, 2.78),
	  (0044, 10.66),
	  (0045, 4.31),
	  (0046, 8.30),
	  (0047, 8.75),
	  (0048, 8.16),
	  (0049, 9.99),
	  #(0100, 899.99),
	  (0101, 199.99),
	  (0102, 279.99),
	  (0103, 89.99),
	  (0104, 39.99),
	  (0110, 799.99),
	  (0111, 599.99),
	  (0112, 1799.99),
	  (0113, 329.99),
	  (0114, 69.99),
	  (0120, 549.99),
	  (0121, 59.99),
	  (0122, 149.99),
	  (0123, 799.99),
	  (0124, 399.99),
	  (0130, 569.99),
	  (0131, 229.99),
	  (0132, 599.99),
	  (0133, 149.99),
	  (0134, 49.99),
	  (0140, 99.99), 
	  (0141, 49.99),
	  (0142, 82.99),
	  (0143, 39.99),
	  (0144, 103.99),
	  #(0200, 39.90),
	  (0201, 29.90),
	  (0202, 39.00),
	  (0203, 23.79),
	  (0204, 26.97),
	  (0210, 39.90),
	  (0211, 79.90),
	  (0212, 79.90),
	  (0213, 23.97),
	  (0214, 14.97),
	  (0220, 41.97),
	  (0221, 35.97),
	  (0222, 99.90),
	  (0223, 85.00),
	  (0224, 45.00),
	  (0230, 39.99),
	  (0231, 22.99),
	  (0232, 80.00),
	  (0233, 95.99),
	  (0234, 33.76),
	  (0240, 35.00),
	  (0241, 49.90),
	  (0242, 7.77),
	  (0243, 59.95),
	  (0244, 32.99),
	  (0250, 23.99),
	  (0251, 14.97),
	  (0252, 32.99),
	  (0253, 19.99),
	  (0254, 32.99),
	  (0260, 26.97),
	  (0261, 39.99),
	  (0262, 26.97),
	  (0263, 44.99),
	  (0264, 79.99),
	  (0270, 59.99),
	  (0271, 59.99),
	  (0272, 26.99),
	  (0273, 29.99),
	  (0274, 49.99),
	  (0280, 62.84),
	  (0281, 79.99),
	  (0282, 42.99),
	  (0283, 79.99),
	  (0284, 127.99),
	  (0290, 79.99),
	  (0291, 14.00),
	  (0292, 59.99),
	  (0293, 49.99),
	  (0294, 75.99);

INSERT INTO Books(ItemID, Author, Categories)
VALUES(0000, 'Meg Elison', 'Sci-Fi'),
	  (0001, 'Cixin Liu', 'Sci-Fi'),
	  (0002, 'N. K. Jemisin', 'Sci-Fi'),
	  (0003, 'Charlie Jane Anders', 'Sci-Fi'),
	  (0004, 'Genevieve Cogman', 'Sci-Fi'),
	  (0005, 'Drew Magary', 'Sci-Fi'),
	  (0006, 'Seanan McGuire', 'Sci-Fi'),
	  (0007, 'Yoon Ha Lee', 'Sci-Fi'),
	  (0008, 'Michael J. Sullivan', 'Sci-Fi'),
	  (0009, 'S. J. Kincaid', 'Sci-Fi'),
	  (0010, 'Mary Alice Monroe', 'Romance'),
	  (0011, 'Susan Elizabeth Phillips', 'Romance'),
	  (0012, 'Sandra Brown', 'Romance'),
	  (0013, 'Debbie Macomber', 'Romance'),
	  (0014, 'Amanda Bouchet', 'Romance'),
	  (0015, 'Sarah MacLean', 'Romance'),
	  (0016, 'Elizabeth Hoyt', 'Romance'),
	  (0017, 'Christina Lauren', 'Romance'),
	  (0018, 'Eloisa James', 'Romance'),
	  (0019, 'Christina Dodd', 'Romance'),
	  (0020, 'Liane Moriarty', 'Mystery'),
	  (0021, 'Stephen King', 'Mystery'),
	  (0022, 'Greg Iles', 'Mystery'),
	  (0023, 'David Baldacci', 'Mystery'),
	  (0024, 'Mary Higgins Clark', 'Mystery'),
	  (0025, 'Donna Leon', 'Mystery'),
	  (0026, 'Allen Eskens', 'Mystery'),
	  (0027, 'C. J. Box', 'Mystery'),
	  (0028, 'John Sandford', 'Mystery'),
	  (0029, 'Lee Child', 'Mystery'),
	  (0030, 'Eric Matthes', 'Tech'),
	  (0031, 'Steve Tale', 'Tech'),
	  (0032, 'Gene Kim, Kevin Behr, Geirge Spafford', 'Tech'),
	  (0033, 'Jon Duckett', 'Tech'),
	  (0034, 'Steve Tale', 'Tech'),
	  (0035, 'Hadley Wickham, Garrett Grolemund', 'Tech'),
	  (0036, 'CyberPunk Architects', 'Tech'),
	  (0037, 'Jonas Fagerberg', 'Tech'),
	  (0038, 'Andrew Faulkner, Conrad Chavez', 'Tech'),
	  (0039, 'Brian W. Kernighan, Dennis M. Ritchie', 'Tech'),
	  (0040, 'William Shakespeare', 'Drama'),
	  (0041, 'Lorraine Hansberry, Robert Nemiroff', 'Drama'),
	  (0042, 'Angela Elwell Hunt, Tim Jonke', 'Drama'),
	  (0043, 'William Shakespeare', 'Drama'),
	  (0044, 'Arthur Miller', 'Drama'),
	  (0045, 'William Shakespeare', 'Drama'),
	  (0046, 'Tennessee Williams', 'Drama'),
	  (0047, 'August Wilson', 'Drama'),
	  (0048, 'Arthur Niller', 'Drama'),
	  (0049, 'A. M. Wegelin', 'Drama');


INSERT INTO Technology(ItemID, Categories)
VALUES(0100, 'TV & Home Theater'),
	  (0101, 'TV & Home Theater'),
	  (0102, 'TV & Home Theater'),
	  (0103, 'TV & Home Theater'),
	  (0104, 'TV & Home Theater'),
	  (0110, 'Computer & Tablet'),
	  (0111, 'Computer & Tablet'),
	  (0112, 'Computer & Tablet'),
	  (0113, 'Computer & Tablet'),
	  (0114, 'Computer & Tablet'),
	  (0120, 'Camera'),
	  (0121, 'Camera'),
	  (0122, 'Camera'),
	  (0123, 'Camera'),
	  (0124, 'Camera'),
	  (0130, 'Phone & Earphone'),
	  (0131, 'Phone & Earphone'),
	  (0132, 'Phone & Earphone'),
	  (0133, 'Phone & Earphone'),
	  (0134, 'Phone & Earphone'),
	  (0140, 'Appliances'),
	  (0141, 'Appliances'),
	  (0142, 'Appliances'),
	  (0143, 'Appliances'),
	  (0144, 'Appliances');


INSERT INTO Apparel(ItemID, Gender, Categories, Size)
VALUES(0200, 'F', 'Top', 'M'),
	  (0201, 'F', 'Top', 'M'),
	  (0202, 'F', 'Top', 'M'),
	  (0203, 'F', 'Top', 'M'),
	  (0204, 'F', 'Top', 'M'),
	  (0210, 'F', 'Bottom', '2'),
	  (0211, 'F', 'Bottom', '4'),
	  (0212, 'F', 'Bottom', '4'),
	  (0213, 'F', 'Bottom', '2'),
	  (0214, 'F', 'Bottom', '4'),
	  (0220, 'F', 'Outerwear', 'M'),
	  (0221, 'F', 'Outerwear', 'M'),
	  (0222, 'F', 'Outerwear', 'M'),
	  (0223, 'F', 'Outerwear', 'M'),
	  (0224, 'F', 'Outerwear', 'M'),
	  (0230, 'F', 'Shoes', '7'),
	  (0231, 'F', 'Shoes', '6'),
	  (0232, 'F', 'Shoes', '7'),
	  (0233, 'F', 'Shoes', '8'),
	  (0234, 'F', 'Shoes', '9'),
	  (0240, 'F', 'Accessories', ''),
	  (0241, 'F', 'Accessories', ''),
	  (0242, 'F', 'Accessories', ''),
	  (0243, 'F', 'Accessories', ''),
	  (0244, 'F', 'Accessories', ''),
	  (0250, 'M', 'Top', 'M'),
	  (0251, 'M', 'Top', 'M'),
	  (0252, 'M', 'Top', 'M'),
	  (0253, 'M', 'Top', 'M'),
	  (0254, 'M', 'Top', 'M'),
	  (0260, 'M', 'Bottom', '4'),
	  (0261, 'M', 'Bottom', '6'),
	  (0262, 'M', 'Bottom', '2'),
	  (0263, 'M', 'Bottom', '2'),
	  (0264, 'M', 'Bottom', '4'),
	  (0270, 'M', 'Outerwear', 'M'),
	  (0271, 'M', 'Outerwear', 'M'),
	  (0272, 'M', 'Outerwear', 'M'),
	  (0273, 'M', 'Outerwear', 'M'),
	  (0274, 'M', 'Outerwear', 'M'),
	  (0280, 'M', 'Shoes', '8'),
	  (0281, 'M', 'Shoes', '9'),
	  (0282, 'M', 'Shoes', '10'),
	  (0283, 'M', 'Shoes', '7'),
	  (0284, 'M', 'Shoes', '8'),
	  (0290, 'M', 'Accessories', ''),
	  (0291, 'M', 'Accessories', ''),
	  (0292, 'M', 'Accessories', '32'),
	  (0293, 'M', 'Accessories', ''),
	  (0294, 'M', 'Accessories', '');
      

    
INSERT INTO Orders (Qty) 
VALUES (5), 
(6);

INSERT INTO cus_place_ord (OrderID, CustomerID)
VALUES (1, 15),
(2, 15);