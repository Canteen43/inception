CREATE DATABASE testdb2;
USE testdb2;
CREATE TABLE test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO test_table (name) VALUES ('Gert'), ('Klaus'), ('Heinz'), ('Hans'), ('Günther'), ('Peter'), ('Fritz'), ('Uwe'), ('Ralf'), ('Wolfgang');

SELECT * FROM test_table;