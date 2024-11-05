INSERT INTO users (first_name, last_name, phone_number, date_of_birth) VALUES ('Jan', 'Kowalski', '123456789', '1990-01-01');
INSERT INTO accounts (user_id, email, password_hash) VALUES (1, 'jan@email.com', 'password');
INSERT INTO clients (user_id) VALUES (1);