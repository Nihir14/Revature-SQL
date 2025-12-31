create database TriggerExample;

use TriggerExample;


CREATE TABLE items (
    id INT PRIMARY KEY, -- clustered index
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);
 
INSERT INTO items(id, name, price) 
VALUES (1, 'Item', 50.00);


CREATE TABLE item_changes (
    change_id INT PRIMARY KEY AUTO_INCREMENT,
    item_id INT,
    change_type VARCHAR(10),
    change_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items(id)
);

DELIMITER //

CREATE TRIGGER update_items_trigger
AFTER UPDATE
ON items
FOR EACH ROW
BEGIN
    INSERT INTO item_changes (item_id, change_type)
    VALUES (NEW.id, 'UPDATE');  -- new.id refers to the updated rows id  
END//

DELIMITER ;

-- This update will invoke the trigger
UPDATE items
SET name = 'Laptop'
WHERE id = 1;


SELECT * FROM item_changes;

DELIMITER //
 
CREATE TRIGGER before_price_update
BEFORE UPDATE
ON items
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Price cannot be negative';
    END IF;
END;
//
 
DELIMITER ;


 
