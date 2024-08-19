/*=================================================== AULA 04 ===================================================*/

CREATE TABLE teste_priv (cod NUMBER(1), texto CHAR (1));
ALTER TABLE teste_priv MODIFY texto VARCHAR(10);
DROP TABLE teste_priv;

CREATE TABLE teste_priv (cod NUMBER(1), texto CHAR (10));

INSERT INTO teste_priv VALUES (1,'aaaaa');

CREATE SEQUENCE teste_id_seq INCREMENT BY 1 START WITH 2 NOCACHE;

INSERT INTO teste_priv VALUES (teste_id_seq.NEXTVAL, 'bbbbb');

CREATE VIEW v_teste_priv AS SELECT texto FROM teste_priv;

CREATE TABLE HR.teste_priv2 (id NUMBER(1), descricao CHAR(1));

CREATE VIEW HR.v_teste_priv2 AS SELECT descricao FROM HR.teste_priv2;

INSERT INTO hr.teste_priv2 VALUES (5, 'e');

GRANT select, insert
ON HR.clube
TO MARIA;















