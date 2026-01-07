-- Create enum type first
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'transaction_state') THEN
        CREATE TYPE transaction_state AS ENUM ('approved', 'declined');
    END IF;
END$$;

-- Create table if not exists
CREATE TABLE IF NOT EXISTS Transactions (
    id INT,
    country VARCHAR(4),
    state transaction_state,
    amount INT,
    trans_date DATE
);

-- Truncate the table
TRUNCATE TABLE Transactions;

-- Insert data
INSERT INTO Transactions (id, country, state, amount, trans_date) 
VALUES (121, 'US', 'approved', 1000, '2018-12-18');

INSERT INTO Transactions (id, country, state, amount, trans_date) 
VALUES (122, 'US', 'declined', 2000, '2018-12-19');

INSERT INTO Transactions (id, country, state, amount, trans_date) 
VALUES (123, 'US', 'approved', 2000, '2019-01-01');

INSERT INTO Transactions (id, country, state, amount, trans_date) 
VALUES (124, 'DE', 'approved', 2000, '2019-01-07');
