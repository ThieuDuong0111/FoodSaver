INSERT INTO Role(Name) VALUES
('admin'),
('food_creator'),
('user');

INSERT INTO User(Role_Id, Name, Password, Email, Phone, Address) VALUES
(1, 'thieuduong', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'duongthieu1995@gmail.com', '0707046410', '107 Bau Cat 2, P.12, Q.TB'),
(2, 'laidao', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'laidao1995@gmail.com', '0707046411', '234 Hoang Hoa Tham, P.14, Q.TB'),
(2, 'landao', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'landao1993@gmail.com', '0707046412', '234 Hoang Hoa Tham, P.14, Q.TB'),
(2, 'phuongdao', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'phuongdao1989@gmail.com', '0707046413', '113 Phan Van Hon, P.Tan Thoi Nhat, Q.12'),
(2, 'haunguyen', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'haunguyen1989@gmail.com', '0707046414', '234 Hoang Hoa Tham, P.14, Q.TB'),
(2, 'lungnguyen', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'lungnguyen1983@gmail.com', '0707046415', '113 Phan Van Hon, P.Tan Thoi Nhat, Q.12'),
(3, 'phatduong', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'phatduong2005@gmail.com', '0707046417', '107 Bau Cat 2, P.12, Q.TB'),
(3, 'tanhduong', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'tanhduong1963@gmail.com', '0707046418', '107 Bau Cat 2, P.12, Q.TB'),
(3, 'longnguyen', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'longnguyen1963@gmail.com', '0707046419', '107 Bau Cat 2, P.12, Q.TB'),
(3, 'anhnguyen', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'anhnguyen@gmail.com', '0707046420', '107 Bau Cat 2, P.12, Q.TB'),
(3, 'thachtran', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'thachtran1963@gmail.com', '0707046421', '107 Bau Cat 2, P.12, Q.TB'),
(3, 'thanhnguyen', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'thanhnguyen1963@gmail.com', '0707046422', '107 Bau Cat 2, P.12, Q.TB'),
(3, 'nhantong', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'nhanhtong1963@gmail.com', '0707046423', '107 Bau Cat 2, P.12, Q.TB'),
(3, 'minhly', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'minhly1963@gmail.com', '0707046424', '107 Bau Cat 2, P.12, Q.TB'),
(3, 'namnguyen', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'namnguyen1963@gmail.com', '0707046425', '107 Bau Cat 2, P.12, Q.TB'),
(3, 'tranhong', '$2a$12$zR8r1NRxUyM14NHuoqm/.O8Ib5jNdK8wL6zr2UIsseJEeCsb7bRs6', 'tranhong1973@gmail.com', '0707046426', '107 Bau Cat 2, P.12, Q.TB');


INSERT INTO Category(Name, Description) VALUES
('Fruits', 'Fruits are natural, sweet-tasting foods that are high in vitamins, minerals, and fiber. Common fruits include apples, oranges, bananas, pineapples, and grapes.'),
('Vegetable', 'Vegetables are plant-based foods that are typically low in calories but high in nutrients such as vitamins, minerals, and fiber. Examples include carrots, broccoli, spinach, tomatoes, and potatoes.'),
('Meat', 'Meat is a primary source of protein in the diet, including types like beef, chicken, pork, and lamb. It provides essential nutrients such as iron, zinc, and vitamin B12.'),
('Seafood', 'Seafood includes fish, shrimp, crabs, clams, and squid. It is a source of protein, omega-3 fatty acids, and minerals like iodine and selenium.'),
('Grains', 'Grains include wheat, rice, oats, corn, and barley. They provide energy in the form of carbohydrates and also contain fiber, vitamins, and minerals.'),
('Dairy', 'Dairy products include milk, cheese, yogurt, and butter. They are rich in calcium, vitamin D, and protein, supporting bone and dental health.'),
('Sweets', 'Sweets encompass candies, chocolates, ice cream, and desserts. They are typically high in sugar and fats, so should be consumed in moderation.'),
('Beverages', 'Beverages include water, fruit juices, tea, coffee, soda, and alcoholic drinks like wine and beer. They provide hydration and may offer various nutrients or stimulants.');

INSERT INTO Product(Creator_Id, Category_Id, Name, Description, Price, Discount_Price, Quantity) VALUES
(2, 1, 'Apple', 'The apple is one of the pome (fleshy) fruits. Apples at harvest vary widely in size, shape, colour, and acidity, but most are fairly round and some shade of red or yellow. The thousands of varieties fall into three broad classes: cider, cooking, and dessert varieties.', 
100000, 50000, 100),
(2, 1, 'Grape', 'A grape is a fruit, botanically a berry, of the deciduous woody vines of the flowering plant genus Vitis. Grapes are a non-climacteric type of fruit, generally occurring in clusters. The cultivation of grapes began perhaps 8,000 years ago, and the fruit has been used as human food over history.', 
50000, 25000, 150),
(2, 2, 'Potato', 'The potato is a starchy root vegetable native to the Americas that is consumed as a staple food in many parts of the world. Potatoes are tubers of the plant ...', 
10000, 5000, 300),
(2, 2, 'Tomato', 'The tomato is the edible berry of the plant Solanum lycopersicum, commonly known as the tomato plant. The species originated in western South America, Mexico, and Central America. The Nahuatl word tomatl gave rise to the Spanish word tomate, from which the English word tomato derives.', 
75000, 55000, 200),
(3, 1, 'Apple', 'The apple is one of the pome (fleshy) fruits. Apples at harvest vary widely in size, shape, colour, and acidity, but most are fairly round and some shade of red or yellow. The thousands of varieties fall into three broad classes: cider, cooking, and dessert varieties.', 
100000, 50000, 100),
(3, 1, 'Grape', 'A grape is a fruit, botanically a berry, of the deciduous woody vines of the flowering plant genus Vitis. Grapes are a non-climacteric type of fruit, generally occurring in clusters. The cultivation of grapes began perhaps 8,000 years ago, and the fruit has been used as human food over history.', 
200000, 150000, 500),
(3, 2, 'Potato', 'The potato is a starchy root vegetable native to the Americas that is consumed as a staple food in many parts of the world. Potatoes are tubers of the plant ...', 
88000, 60000, 300),
(3, 2, 'Tomato', 'The tomato is the edible berry of the plant Solanum lycopersicum, commonly known as the tomato plant. The species originated in western South America, Mexico, and Central America. The Nahuatl word tomatl gave rise to the Spanish word tomate, from which the English word tomato derives.', 
75000, 55000, 200);

