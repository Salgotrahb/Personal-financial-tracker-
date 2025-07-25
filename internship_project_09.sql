create database Personal_Tracker;

use Personal_Tracker;

CREATE TABLE Users (
    id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Income (
    id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10 , 2 ) NOT NULL,
    date DATE NOT NULL,
    description VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES Users (id)
);

CREATE TABLE Expenses (
    id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10 , 2 ) NOT NULL,
    date DATE NOT NULL,
    description VARCHAR(100) NOT NULL,
    category_id INT,
    FOREIGN KEY (user_id)
        REFERENCES Users (id)
);

CREATE TABLE Categories (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(100) NOT NULL
);
INSERT INTO Users (id, username, password, email) VALUES (1, 'john_doe', 'password123', 'john.doe@example.com');

INSERT INTO Income (id, user_id, amount, date, description) VALUES (1, 1, 5000.00, '2022-01-01', 'Salary');

INSERT INTO Expenses (id, user_id, amount, date, description, category_id) VALUES (1, 1, 1000.00, '2022-01-02', 'Groceries', 1);

INSERT INTO Expenses (id, user_id, amount, date, description, category_id) VALUES (2, 1, 500.00, '2022-01-03', 'Dining Out', 2);

INSERT INTO Categories (id, name, description) VALUES (1, 'Groceries', 'Food and household items');

INSERT INTO Categories (id, name, description) VALUES (2, 'Dining Out', 'Eating at restaurants');

-- queries to summarize expenses monthly:


SELECT 
    user_id,
    DATE_FORMAT(date, '%Y-%m') AS data,
    SUM(amount) AS total_expenses
FROM
    Expenses
GROUP BY user_id , data
ORDER BY data ;

-- Use GROUP BY for category-wise spending:


SELECT 
    c.name AS category, SUM(e.amount) AS total_spending
FROM
    Expenses e
        JOIN
    Categories c ON e.category_id = c.id
WHERE
    e.user_id = 1
GROUP BY c.name
ORDER BY total_spending DESC ;

-- Create views for balance tracking:


CREATE VIEW user_balance AS
    SELECT 
        u.username, SUM(i.amount) - SUM(e.amount) AS balance
    FROM
        Users u
            JOIN
        Income i ON u.id = i.user_id
            JOIN
        Expenses e ON u.id = e.user_id
    GROUP BY u.username ;

-- Export monthly reports:

SELECT 
    *
FROM
    user_balance;

SELECT 
    *
FROM
    user_balance;




