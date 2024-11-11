INSERT INTO users (first_name, last_name, phone_number, date_of_birth) VALUES ('Jan', 'Kowalski', '123456789', '1990-01-01');
INSERT INTO accounts (user_id, email, password_hash) VALUES (1, 'jan@email.com', 'password1');
INSERT INTO clients (user_id) VALUES (1);
INSERT INTO users (first_name, last_name, phone_number, date_of_birth) VALUES ('Adam', 'Nowak', '424424424', '1990-01-01');
INSERT INTO accounts (user_id, email, password_hash) VALUES (2, 'adam@email.com', 'password1');
INSERT INTO employees (user_id) VALUES (1);