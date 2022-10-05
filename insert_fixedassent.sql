INSERT INTO fixedassent_tbl (assent_number, serial_number, assent_name, brand, model, product_batch, 
tax_invoice, fk_labs, complement, value_assent, verify, color) VALUES 
(1234567, 13476, "cpu", "lenovo", "thinkcentre", 2, 465752, 1 ,"maquina com ryzen 5", 1.500, 1, "preto");

SELECT * FROM fixedassent_tbl;

SELECT * FROM address_tbl;

SELECT * FROM instruction_tbl;
SELECT * FROM users_tbl;

SELECT * FROM labs_tbl;

INSERT INTO address_tbl (type_address, address, number_address, complement, neighborhood, city, state, zip_code)
VALUES (
	"", "Rua Pam", 1002, "", "JD. São Marcos", "Itapecerica da Serra", "SP", 06267966
);

INSERT INTO typeUser_tbl (type_name)
VALUES ("Coordenador"),
	   ("Professor"),
       ("Alunos")
;
