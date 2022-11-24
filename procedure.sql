DELIMITER $
CREATE PROCEDURE prc_lista_prod()
	BEGIN
		SELECT * FROM produto_tbl
        WHERE cod_produto IN (1,3,5,7);
	END $
DELIMITER ;

CALL prc_lista_prod();

-- DROP PROCEDURE prc_lista_prod() // exclua caso seja preciso alterar algum dado



-- exemplo com IN 
DELIMITER $
CREATE PROCEDURE prc_prod_param_in (IN nome_prod VARCHAR(50))
	BEGIN 
		SELECT * FROM produto_tbl WHERE nome_produto = nome_prod;
	END $
DELIMITER ;

CALL prc_prod_param_in('tomate');


-- exemplo com OUT

DELIMITER $
CREATE PROCEDURE lista_produto_parametro_out (OUT total DECIMAL(10,2))
	BEGIN 
		SELECT sum(valor) INTO total
        FROM produto_tbl;
	END $
DELIMITER ;

CALL lista_produto_parametro_out(@total);

SELECT @total;


-- exemplo com INOUT

DELIMITER $
CREATE PROCEDURE prc_prod_param_inout (IN codprod INT, INOUT nome_prod CHAR(15), INOUT valor_prod DECIMAL (10,2))
	BEGIN 
		SELECT nome_produto, valor
        FROM produto_tbl
        WHERE cod_produto = codprod;
	END $
DELIMITER ;

CALL prc_prod_param_inout(10, @nomeprod, @valorprod);


-- exemplo com IF ELSE

DELIMITER $
CREATE PROCEDURE prc_ins_prod  (IN vnomeprod CHAR(100), 
								IN vvalor decimal(10,2),
								OUT msg VARCHAR(100))
	BEGIN 
		DECLARE valor DECIMAL(10,2);
        DECLARE erro BOOL;
        
        SET erro = TRUE;
        
        IF (vvalor > 0) THEN 
			SET valor = vvalor;
		ELSE
			SET erro = FALSE;
            SET msg = "valor zerado, verifique!";
		END IF;
        
        IF (erro) THEN 
			INSERT INTO produto_tbl (nome_produto, valor)
			VALUES (vnomeprod, vvalor);
            SET msg = "incluindo com sucesso!";
		END IF;
	END $
DELIMITER ; 


CALL prc_ins_prod('ovo', 0,@msg);

SELECT @msg;

-- /////////////////////////////////////////////////////////////////////////////

-- ex1

DELIMITER $
CREATE PROCEDURE prc_aumento_valor (IN codProd INT, IN percentual DECIMAL (10,2), OUT msg VARCHAR(100))
	BEGIN
    
    UPDATE produto_tbl SET valor = valor + (valor * percentual /100) WHERE cod_produto = codProd;
		IF ROW_COUNT() = 0 THEN
			SET msg = "Não foi possivel atualizar os dados";
		ELSE
			SET msg = "Dados atualizados";
		END IF;
	END $
DELIMITER ; 

CALL prc_aumento_valor (2, 5, @msg);

select @msg;


-- ex 2
DELIMITER $
 CREATE PROCEDURE prc_insert_log_tbl(IN operacao VARCHAR(40), IN tbl VARCHAR(40))
	BEGIN
		INSERT INTO log_tbl(usuario, dt_log, hora, operacao, tbl) VALUES(USER(), CURDATE(), CURRENT_TIME(), operacao, tbl);
	END $
    
DELIMITER ;

CALL prc_insert_log_tbl ('Insercao', 'log_tbl');
select * from log_tbl;

insert into cliente_tbl values (100, 'gui', 12345678985, "2000-05-25", '6823250', 1001, "ponto final");

select * from cliente_tbl;

-- ex3
DELIMITER $
 CREATE TRIGGER trg_clientes BEFORE INSERT ON pedido_tbl
    FOR EACH ROW
		BEGIN
			CALL prc_insert_log_tbl("Inserção","tbl_pedido");
		END $
        
DELIMITER ;



