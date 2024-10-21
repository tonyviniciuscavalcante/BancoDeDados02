ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE
/*************************************************
*** Elimina??o das tabelas (quando necess?rio) ***
*************************************************/
/*
drop table esporte;
drop table centro_treinamento;
drop table pratica;
drop table participa;
drop table campeonato;
drop table modalidade;
drop table olimpico;
drop table paraolimpico;
drop table clube;
drop table presidente;
drop table atleta_contato;
drop table atleta;
*/

CREATE TABLE PRESIDENTE
(
    id       NUMBER(4),
    cpf      VARCHAR2(14) NOT NULL,
    nome     VARCHAR2(50) NOT NULL,
    email    VARCHAR2(80),
    telefone VARCHAR2(20),
    CONSTRAINT presidente_pk PRIMARY KEY (id),
    CONSTRAINT presidente_cpf_uk UNIQUE (nome)
);

CREATE TABLE clube
(
    id            NUMBER(4)    NOT NULL,
    nome          VARCHAR2(40) NOT NULL,
    data_fundacao DATE,
    id_presidente NUMBER(4),
    CONSTRAINT clube_pk PRIMARY KEY (id),
    CONSTRAINT clube_nome_uk UNIQUE (nome),
    CONSTRAINT clube_presidente_fk FOREIGN KEY (id_presidente) REFERENCES presidente (id)
);

CREATE TABLE atleta
(
    id       NUMBER(4)    NOT NULL,
    cpf      VARCHAR2(14) NOT NULL,
    nome     VARCHAR2(60) NOT NULL,
    sexo     CHAR(1),
    datanasc DATE,
    endereco VARCHAR2(50),
    salario  NUMBER(8, 2) NOT NULL,
    id_clube NUMBER(4),
    CONSTRAINT atleta_pk PRIMARY KEY (id),
    CONSTRAINT atleta_uk UNIQUE (cpf),
    CONSTRAINT atleta_sexo_ck CHECK (sexo in ('M', 'F', 'm', 'f')),
    CONSTRAINT atleta_salario_ck CHECK (salario > 0),
    CONSTRAINT atleta_clube_fk FOREIGN KEY (id_clube) REFERENCES clube (id)
);

CREATE TABLE OLIMPICO
(
    id_atleta         NUMBER(4),
    incentivo_governo CHAR(1),
    CONSTRAINT olimpico_pk PRIMARY KEY (id_atleta),
    CONSTRAINT olimpico_incentivo_ck CHECK (incentivo_governo IN ('S', 's', 'N', 'n')),
    CONSTRAINT olimpico_atleta_fk FOREIGN KEY (id_atleta) REFERENCES atleta (id)
);

CREATE TABLE PARAOLIMPICO
(
    id_atleta   NUMBER(4),
    deficiencia VARCHAR2(30),
    nivel       NUMBER,
    CONSTRAINT paraolimpico_pk PRIMARY KEY (id_atleta),
    CONSTRAINT paraolimpico_nivel_ck CHECK (nivel BETWEEN 1 AND 5),
    CONSTRAINT paraolimpico_atleta_fk FOREIGN KEY (id_atleta) REFERENCES atleta (id)
);

CREATE TABLE MODALIDADE
(
    id        NUMBER(3),
    descricao VARCHAR2(30),
    olimpica  CHAR(1) DEFAULT 'N',
    CONSTRAINT modalidade_pk PRIMARY KEY (id),
    CONSTRAINT modalidade_olimpica_ck CHECK (olimpica IN ('S', 's', 'N', 'n'))
);

CREATE TABLE CAMPEONATO
(
    id          NUMBER(3),
    nome        VARCHAR2(70) NOT NULL,
    local       VARCHAR2(40),
    data_inicio DATE,
    data_fim    DATE,
    CONSTRAINT campeonato_pk PRIMARY KEY (id)
);

CREATE TABLE CENTRO_TREINAMENTO
(
    id_clube  NUMBER(4),
    id_centro NUMBER(4),
    fone      VARCHAR2(20),
    rua       VARCHAR2(50),
    nro       NUMBER,
    bairro    VARCHAR2(50),
    CEP       VARCHAR2(9),
    cidade    VARCHAR2(50),
    UF        CHAR(2),
    CONSTRAINT ct_pk PRIMARY KEY (id_clube, id_centro),
    CONSTRAINT ct_clube_fk FOREIGN KEY (id_clube) REFERENCES clube (id)
);

CREATE TABLE ATLETA_CONTATO
(
    id_atleta NUMBER(4),
    contato   VARCHAR(20),
    CONSTRAINT atleta_contato_pk PRIMARY KEY (id_atleta, contato),
    CONSTRAINT atleta_contato_fk FOREIGN KEY (id_atleta) REFERENCES atleta (id)
);

CREATE TABLE PRATICA
(
    id_atleta     NUMBER(4),
    id_modalidade NUMBER(3),
    data_inicio   DATE,
    experiencia   NUMBER,
    CONSTRAINT pratica_pk PRIMARY KEY (id_atleta, id_modalidade),
    CONSTRAINT pratica_atleta_fk FOREIGN KEY (id_atleta) REFERENCES atleta (id),
    CONSTRAINT pratica_modalidade_fk FOREIGN KEY (id_modalidade) REFERENCES modalidade (id)
);

CREATE TABLE ESPORTE
(
    registro_atleta NUMBER(8),
    id_atleta       NUMBER(4),
    id_modalidade   NUMBER(3),
    CONSTRAINT esporte_pk PRIMARY KEY (registro_atleta),
    CONSTRAINT esporte_pratica_fk FOREIGN KEY (id_atleta, id_modalidade) REFERENCES pratica (id_atleta, id_modalidade)
);

CREATE TABLE PARTICIPA
(
    registro_atleta NUMBER(8),
    id_campeonato   NUMBER(3),
    colocacao       NUMBER(5),
    valor_premiacao NUMBER(10, 2) DEFAULT 0,
    CONSTRAINT participa_pk PRIMARY KEY (registro_atleta, id_campeonato),
    CONSTRAINT participa_registro_fk FOREIGN KEY (registro_atleta) REFERENCES esporte (registro_atleta),
    CONSTRAINT participa_campeonato_fk FOREIGN KEY (id_campeonato) REFERENCES campeonato (id)
);


insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (1, '785-45-5286', 'Tamera Bravington', 'tbravington0@studiopress.com', '367-956-3178');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (2, '289-05-0419', 'Billie Dargavel', 'bdargavel1@clickbank.net', '995-722-9098');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (3, '261-92-1249', 'Murdock Evesque', 'mevesque2@merriam-webster.com', '320-493-9072');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (4, '167-95-8399', 'Sharai Jahncke', 'sjahncke3@wordpress.org', '907-590-0532');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (5, '150-79-1794', 'Uta Guillond', 'uguillond4@odnoklassniki.ru', '426-617-7731');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (6, '727-49-8657', 'Casi Bilborough', 'cbilborough5@youku.com', '445-135-1562');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (7, '296-08-8396', 'Delila Inkpen', 'dinkpen6@creativecommons.org', '780-365-0148');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (8, '161-20-9079', 'Diana Leamon', 'dleamon7@360.cn', '229-312-6061');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (9, '672-60-6443', 'Conrado Dumbare', 'cdumbare8@nsw.gov.au', '615-551-0726');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (10, '706-68-9424', 'Hilary Manilow', 'hmanilow9@nymag.com', '992-959-5363');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (11, '749-67-5859', 'Coop Coslett', 'ccosletta@jimdo.com', '298-186-9432');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (12, '869-37-7117', 'Ursola Brownhill', 'ubrownhillb@whitehouse.gov', '311-276-9951');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (13, '600-92-1234', 'Loise Farrand', 'lfarrandc@fastcompany.com', '407-452-7376');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (14, '738-74-2426', 'Cash Dubock', 'cdubockd@w3.org', '833-696-6152');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (15, '800-64-7952', 'Ermanno Tremblett', 'etremblette@hatena.ne.jp', '182-481-9114');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (16, '417-01-9088', 'Sherlock Laxtonne', 'slaxtonnef@google.es', '533-285-4276');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (17, '875-11-9904', 'Elvira Gerry', 'egerryg@webmd.com', '761-323-5782');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (18, '286-95-6512', 'Chelsey Swatland', 'cswatlandh@flavors.me', '636-503-9898');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (19, '211-93-3474', 'Ainsley Choppin', 'achoppini@jiathis.com', '493-555-8065');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (20, '488-96-9333', 'Moreen Abdee', 'mabdeej@loc.gov', '502-474-3238');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (21, '641-03-9023', 'Carlin Hamper', 'champerk@tinypic.com', '530-138-7253');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (22, '612-83-3180', 'Shantee Jouhning', 'sjouhningl@topsy.com', '889-807-8646');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (23, '454-70-4908', 'Dionysus Fazzioli', 'dfazziolim@netlog.com', '545-870-5186');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (24, '821-98-6400', 'Kristyn Ormesher', 'kormeshern@oaic.gov.au', '111-146-0515');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (25, '786-87-1352', 'Analiese Parsand', 'aparsando@biglobe.ne.jp', '865-996-7431');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (26, '404-63-8997', 'Prissie Cunningham', 'pcunninghamp@g.co', '662-906-6610');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (27, '219-35-2949', 'Sancho Belford', 'sbelfordq@unesco.org', '748-551-7883');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (28, '570-56-9819', 'Newton Iacomi', 'niacomir@ftc.gov', '510-573-3936');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (29, '331-09-4646', 'Frances Carslaw', 'fcarslaws@soup.io', '547-390-0108');
insert into PRESIDENTE (id, cpf, nome, email, telefone)
values (30, '617-42-7162', 'Nina Budden', 'nbuddent@state.gov', '108-605-5951');


insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (1, 'Bigtax Team', to_date('24/06/1930', 'dd/mm/yyyy'), 3);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (2, 'Prodder Club', to_date('28/02/1977', 'dd/mm/yyyy'), 1);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (3, 'Itil Club', null, 5);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (4, 'Trippledex Club', to_date('16/09/1987', 'dd/mm/yyyy'), 11);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (5, 'Jabbing Club', null, 16);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (6, 'Bamity Team', to_date('04/01/1949', 'dd/mm/yyyy'), 15);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (7, 'Solarbreeze Club', null, 26);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (8, 'Duobam Team', to_date('18/08/1990', 'dd/mm/yyyy'), 6);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (9, 'Flowdesk Team', to_date('10/11/1934', 'dd/mm/yyyy'), 17);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (10, 'Veribet Club', to_date('07/07/1994', 'dd/mm/yyyy'), 25);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (11, 'Fixflex Club', to_date('25/04/1998', 'dd/mm/yyyy'), 18);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (12, 'Powerful Team', null, 27);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (13, 'Solowarm Team', to_date('20/03/1939', 'dd/mm/yyyy'), 2);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (14, 'Tresom Club', to_date('15/04/1955', 'dd/mm/yyyy'), 20);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (15, 'Sonsing Club', to_date('17/11/1967', 'dd/mm/yyyy'), 7);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (16, 'Dragon Team', to_date('29/08/1982', 'dd/mm/yyyy'), 19);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (17, 'Zamit Team', null, 28);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (18, 'Tregold Club', to_date('01/09/1996', 'dd/mm/yyyy'), 24);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (19, 'Flexidy Team', to_date('04/11/1999', 'dd/mm/yyyy'), 4);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (20, 'Toughjoy Club', to_date('20/12/1945', 'dd/mm/yyyy'), 12);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (21, 'Stronghold Team', to_date('16/07/1983', 'dd/mm/yyyy'), 29);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (22, 'Redhold Team', to_date('23/09/1965', 'dd/mm/yyyy'), 8);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (23, 'Alpha Team', to_date('16/10/1951', 'dd/mm/yyyy'), null);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (24, 'Temp Club', to_date('25/07/1989', 'dd/mm/yyyy'), 22);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (25, 'Kanlam Team', to_date('08/12/1996', 'dd/mm/yyyy'), 9);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (26, 'Tamplight Club', to_date('21/04/1946', 'dd/mm/yyyy'), 10);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (27, 'Holdlamis Club', to_date('04/11/1961', 'dd/mm/yyyy'), 23);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (28, 'Ventosanzap Team', to_date('14/02/1972', 'dd/mm/yyyy'), 13);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (29, 'Monster Team', to_date('12/01/1933', 'dd/mm/yyyy'), 21);
insert into CLUBE (id, nome, data_fundacao, id_presidente)
values (30, 'Voyatouch Club', to_date('15/03/1952', 'dd/mm/yyyy'), 14);


insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (1, '505-75-9669', 'Lawry Peterken', 'M', to_date('23/01/1984', 'dd/mm/yyyy'), '82920 Kedzie Trail', 5767.3, 14);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (2, '259-09-1273', 'Frederic Bernardoux', 'M', to_date('01/11/1994', 'dd/mm/yyyy'), '822 Valley Edge Hill',
        85648.36, 27);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (3, '332-26-7082', 'Agatha Renard', 'F', to_date('29/06/1990', 'dd/mm/yyyy'), '874 Hermina Alley', 82419.55, 6);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (4, '291-05-4193', 'Humfrid Iacovino', 'M', to_date('05/11/1994', 'dd/mm/yyyy'), '0379 Hoard Way', 58567.74, 19);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (5, '330-36-7223', 'Foster Rushmere', 'M', to_date('01/03/2002', 'dd/mm/yyyy'), '3546 Eastlawn Point', 86158.05,
        24);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (6, '878-04-7790', 'Ranice Sherbourne', 'F', to_date('24/08/2004', 'dd/mm/yyyy'), '991 Almo Pass', 65187.24, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (7, '246-93-5580', 'Ringo Vidgeon', 'M', to_date('11/10/1996', 'dd/mm/yyyy'), '07 Jenifer Drive', 83651.2, 27);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (8, '360-11-1351', 'Shurwood Soan', 'M', to_date('02/08/2003', 'dd/mm/yyyy'), '831 Farmco Junction', 75644.7,
        29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (9, '620-48-2618', 'Pernell Boorer', 'M', to_date('01/12/1984', 'dd/mm/yyyy'), '47817 Marquette Hill', 81478.62,
        11);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (10, '266-64-4666', 'Gannie Pidgeley', 'M', to_date('01/08/1990', 'dd/mm/yyyy'), '44 Columbus Pass', 31384.28,
        15);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (11, '831-23-8244', 'Franzen Clawe', 'M', to_date('17/06/1988', 'dd/mm/yyyy'), '9 Dayton Parkway', 27425.2, 24);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (12, '628-15-0557', 'Sophie Teodorski', 'F', to_date('16/07/1985', 'dd/mm/yyyy'), '50703 Monica Court', 33139.7,
        26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (13, '435-84-4340', 'Ike Hakonsson', 'M', to_date('02/04/1999', 'dd/mm/yyyy'), '7 Lakeland Center', 99488.3, 19);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (14, '664-74-5725', 'Leandra Piner', 'F', to_date('08/12/2002', 'dd/mm/yyyy'), '04 Corben Parkway', 18400.73, 4);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (15, '655-85-9107', 'Blanche Lillico', 'F', to_date('12/09/1986', 'dd/mm/yyyy'), '04 Nelson Lane', 16602.8, 25);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (16, '682-27-0643', 'Yulma Robatham', 'M', to_date('05/11/1992', 'dd/mm/yyyy'), '8604 Gulseth Park', 37310.43,
        21);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (17, '355-49-7452', 'Donavon Grason', 'M', to_date('20/05/1984', 'dd/mm/yyyy'), '3 Independence Trail', 71435.4,
        29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (18, '128-31-4916', 'Madella Musgrove', 'F', to_date('22/11/1985', 'dd/mm/yyyy'), null, 81106.95, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (19, '517-09-3553', 'Filip Dodamead', 'M', to_date('24/02/1995', 'dd/mm/yyyy'), null, 80580.89, 28);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (20, '569-15-6773', 'Allie Tessier', 'F', to_date('18/02/2000', 'dd/mm/yyyy'), '2 Merchant Place', 51752.76, 20);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (21, '353-94-5414', 'Lambert Taffs', 'M', to_date('12/11/1985', 'dd/mm/yyyy'), null, 8726.67, 13);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (22, '130-39-3125', 'Stanleigh Ruddock', 'M', to_date('11/12/1988', 'dd/mm/yyyy'), '9 Warner Pass', 95669.88,
        25);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (23, '168-50-2229', 'Almire Beddard', 'F', to_date('27/07/1997', 'dd/mm/yyyy'), '88331 Canary Avenue', 29395.38,
        7);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (24, '712-34-8456', 'Dominick Ivankin', null, to_date('18/09/1998', 'dd/mm/yyyy'), null, 87476.5, null);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (25, '675-71-4440', 'Ulises Damrel', 'M', to_date('31/12/1998', 'dd/mm/yyyy'), '76459 Mccormick Terrace',
        23071.69, 8);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (26, '220-07-5418', 'Averill Drogan', 'M', to_date('30/01/1994', 'dd/mm/yyyy'), '50 Fordem Plaza', 89908.05, 9);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (27, '340-97-8450', 'Lancelot Apdell', 'M', to_date('09/07/1993', 'dd/mm/yyyy'), null, 74344.23, 23);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (28, '787-79-7183', 'Grace Pleavin', null, to_date('28/01/2002', 'dd/mm/yyyy'), '8 Bunting Trail', 28456.48,
        null);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (29, '724-38-1676', 'Yale Buttle', 'M', to_date('18/03/1996', 'dd/mm/yyyy'), '9 Brown Street', 71999.78, 2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (30, '102-98-8071', 'Heinrick Samter', 'M', to_date('19/07/1995', 'dd/mm/yyyy'), null, 6483.21, 24);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (31, '588-35-6857', 'Addi Pryell', 'F', to_date('06/01/1982', 'dd/mm/yyyy'), '452 Sommers Parkway', 68771.69,
        17);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (32, '686-72-1859', 'Johna Belf', null, to_date('02/07/1988', 'dd/mm/yyyy'), '1056 Birchwood Center', 84061.29,
        null);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (33, '469-83-6887', 'Hoyt Hawker', 'M', to_date('31/07/1995', 'dd/mm/yyyy'), '9 Dorton Terrace', 91900.05, 11);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (34, '471-78-5539', 'Isadora Renny', 'F', to_date('07/11/1983', 'dd/mm/yyyy'), '357 Mayer Point', 26402.05, 9);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (35, '714-45-3007', 'Paula Wotton', 'F', to_date('29/12/1998', 'dd/mm/yyyy'), '2 Nevada Junction', 93320.55, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (36, '694-18-8019', 'Matthaeus Ferran', 'M', to_date('16/02/1984', 'dd/mm/yyyy'), '2004 New Castle Drive',
        93107.43, 24);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (37, '407-36-6488', 'Caspar Perago', 'M', to_date('15/01/2003', 'dd/mm/yyyy'), '366 Mesta Center', 60880.46, 8);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (38, '163-16-3947', 'Colleen Tunnacliffe', null, to_date('09/09/2004', 'dd/mm/yyyy'),
        '62028 Little Fleur Junction', 92680.28, null);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (39, '637-11-6317', 'Hazel Rheubottom', 'F', to_date('14/01/2002', 'dd/mm/yyyy'), '7838 Scoville Plaza',
        32834.63, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (40, '735-67-1419', 'Doloritas Torald', 'F', to_date('15/10/2001', 'dd/mm/yyyy'), '30286 Westport Center',
        65209.14, 2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (41, '247-52-2228', 'Merwyn Sivills', 'M', to_date('03/07/2000', 'dd/mm/yyyy'), '072 Kensington Crossing',
        4461.3, 10);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (42, '542-62-1084', 'Herc Pococke', 'M', to_date('03/01/1995', 'dd/mm/yyyy'), '35538 Briar Crest Plaza',
        27190.48, 10);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (43, '135-46-2106', 'Galven Duckett', 'M', to_date('25/09/1993', 'dd/mm/yyyy'), '316 Banding Street', 54741.98,
        10);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (44, '798-27-7620', 'Miquela Malloy', 'F', to_date('09/04/1983', 'dd/mm/yyyy'), '21 Cottonwood Street', 6998.47,
        9);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (45, '435-02-4281', 'Mickie Kille', 'F', to_date('19/11/1999', 'dd/mm/yyyy'), '44277 6th Court', 60622.94, 18);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (46, '835-52-6663', 'Oren Peers', 'M', to_date('22/01/2002', 'dd/mm/yyyy'), null, 34656.84, 1);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (47, '599-51-1118', 'Josephine Chelam', 'F', to_date('23/05/2002', 'dd/mm/yyyy'), '758 Cordelia Way', 68826.28,
        16);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (48, '763-03-7123', 'Tessi Eyckel', 'F', to_date('24/01/1997', 'dd/mm/yyyy'), '02130 Graceland Road', 63682.13,
        7);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (49, '567-41-3531', 'Buddy Riddell', 'M', to_date('20/12/1999', 'dd/mm/yyyy'), '16 Clemons Alley', 72662.65, 3);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (50, '690-41-7944', 'Ianthe MacRory', 'F', to_date('25/11/1998', 'dd/mm/yyyy'), '558 6th Pass', 56328.64, 28);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (51, '876-07-0897', 'Tootsie Filochov', 'F', to_date('05/10/1986', 'dd/mm/yyyy'), '0 Oxford Terrace', 61866.27,
        23);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (52, '104-47-6827', 'Lou Lovie', 'M', to_date('26/11/2004', 'dd/mm/yyyy'), '6 Marcy Lane', 11438.04, 10);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (53, '889-40-5983', 'Toddy McCormick', 'M', to_date('17/05/1983', 'dd/mm/yyyy'), '074 Village Street', 41665.36,
        17);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (54, '315-51-0136', 'Marshall McSporrin', 'M', to_date('21/07/1990', 'dd/mm/yyyy'), '677 Claremont Center',
        58388.74, 7);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (55, '668-46-5053', 'Cyndi Gianulli', 'F', to_date('14/03/2003', 'dd/mm/yyyy'), '6 Clemons Avenue', 24114.04, 2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (56, '148-54-7626', 'Estele Stapele', 'F', to_date('07/12/2002', 'dd/mm/yyyy'), null, 39272.93, 13);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (57, '710-41-8143', 'Laurie Castellino', 'M', to_date('14/02/1990', 'dd/mm/yyyy'), '9 Forster Drive', 83247.63,
        1);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (58, '645-82-3678', 'Alisun Skelly', 'F', to_date('16/09/2003', 'dd/mm/yyyy'), null, 44655.4, 14);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (59, '164-99-8076', 'Rube Jossum', 'M', to_date('17/10/1986', 'dd/mm/yyyy'), '42 Coleman Street', 19398.26, 21);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (60, '469-69-8829', 'Nappy Flory', 'M', to_date('21/12/1997', 'dd/mm/yyyy'), null, 70949.4, 8);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (61, '446-79-9387', 'Bendix Alti', 'M', to_date('30/03/2002', 'dd/mm/yyyy'), null, 17586.7, 1);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (62, '480-71-4866', 'Eyde Juschke', 'F', to_date('08/09/1993', 'dd/mm/yyyy'), '83 Hanover Parkway', 67042.57,
        18);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (63, '881-45-4652', 'Wilhelmina Iggulden', 'F', to_date('16/01/1994', 'dd/mm/yyyy'), '116 8th Terrace', 27070.16,
        29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (64, '424-08-9564', 'Matteo Sidaway', 'M', to_date('02/01/1986', 'dd/mm/yyyy'), null, 80626.06, 28);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (65, '639-69-7692', 'Hurleigh Bradnick', null, to_date('01/02/1986', 'dd/mm/yyyy'), '9010 Sheridan Drive',
        43988.82, null);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (66, '472-14-4192', 'Ketti Huerta', 'F', to_date('05/05/2003', 'dd/mm/yyyy'), '3933 Clemons Way', 40242.36, 29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (67, '522-30-5384', 'Neel Rootham', 'M', to_date('27/03/1983', 'dd/mm/yyyy'), '3 Milwaukee Point', 61059.0, 26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (68, '222-27-8381', 'Richard Burcombe', 'M', to_date('14/04/1994', 'dd/mm/yyyy'), null, 35821.87, 16);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (69, '808-28-5674', 'Niko Ripsher', 'M', to_date('04/05/1989', 'dd/mm/yyyy'), '019 Loeprich Place', 58856.83,
        28);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (70, '301-96-5323', 'Sonia Guinnane', 'F', to_date('16/03/1995', 'dd/mm/yyyy'), '07 Truax Point', 76937.27, 2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (71, '787-68-4041', 'Eberhard Pusill', 'M', to_date('17/12/1990', 'dd/mm/yyyy'), '72 Beilfuss Street', 44553.49,
        22);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (72, '325-66-8575', 'Debby Emmines', 'F', to_date('15/07/1991', 'dd/mm/yyyy'), '9814 Continental Alley',
        47790.93, 18);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (73, '323-24-3904', 'Lewes Labroue', 'M', to_date('02/10/2001', 'dd/mm/yyyy'), '1 Miller Center', 26166.84, 29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (74, '711-95-2411', 'Olwen Dellenbrok', 'F', to_date('29/06/1986', 'dd/mm/yyyy'), '22362 Summit Road', 12481.42,
        26);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (75, '191-09-9408', 'Tina Iacovides', 'F', to_date('26/12/1989', 'dd/mm/yyyy'), '3 Straubel Circle', 23094.61,
        2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (76, '845-78-6212', 'Ingunna Caseborne', 'F', to_date('24/05/1985', 'dd/mm/yyyy'), '55 Golf View Place',
        72146.38, 30);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (77, '490-71-0232', 'Carmita Filipponi', 'F', to_date('08/07/1994', 'dd/mm/yyyy'), null, 79400.65, 18);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (78, '296-14-1783', 'Karlene Raff', 'F', to_date('24/06/1989', 'dd/mm/yyyy'), null, 9283.43, 25);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (79, '383-85-3985', 'Janene Edelheid', 'F', to_date('08/07/2002', 'dd/mm/yyyy'), '22356 Michigan Place',
        36309.65, 6);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (80, '184-50-2282', 'Nial Crockett', 'M', to_date('12/04/1990', 'dd/mm/yyyy'), '2008 Union Trail', 34466.84, 17);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (81, '321-24-7713', 'Charlene Aisthorpe', 'F', to_date('22/11/1983', 'dd/mm/yyyy'), '2 Morrow Road', 4849.42, 9);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (82, '373-19-2338', 'Britt Balnaves', 'F', to_date('14/03/1990', 'dd/mm/yyyy'), '71720 Melby Point', 65351.02,
        21);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (83, '718-76-9515', 'Anet Wanderschek', 'F', to_date('14/01/1998', 'dd/mm/yyyy'), '21 Sherman Avenue', 39513.26,
        15);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (84, '758-73-6597', 'Timotheus Cudiff', 'M', to_date('13/05/2003', 'dd/mm/yyyy'), '35 Schurz Trail', 72189.55,
        23);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (85, '519-10-0270', 'Karlene Freckelton', 'F', to_date('16/11/1993', 'dd/mm/yyyy'), null, 68886.78, 1);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (86, '208-82-4304', 'Engelbert Brawson', 'M', to_date('28/07/1994', 'dd/mm/yyyy'), '46995 Loomis Junction',
        78588.68, 29);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (87, '782-62-0990', 'Lu McOrkil', 'F', to_date('26/10/1989', 'dd/mm/yyyy'), '68 Farwell Parkway', 35230.62, 12);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (88, '842-68-9833', 'Gustaf Tilbury', 'M', to_date('25/08/1985', 'dd/mm/yyyy'), '1 Westport Crossing', 28960.24,
        22);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (89, '403-40-0578', 'Elyn Hubbucke', 'F', to_date('23/12/1988', 'dd/mm/yyyy'), '9 Harper Junction', 69247.67,
        22);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (90, '156-48-3523', 'Beryle Standall', 'F', to_date('05/05/1988', 'dd/mm/yyyy'), '3040 Lien Lane', 7516.45, 10);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (91, '593-56-5435', 'Royal Sallter', 'M', to_date('30/03/2004', 'dd/mm/yyyy'), '4261 Jackson Hill', 12685.38,
        20);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (92, '462-05-6321', 'Lincoln Kingman', 'M', to_date('04/10/1999', 'dd/mm/yyyy'), '9 Sommers Hill', 36671.07, 17);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (93, '863-17-0494', 'Wesley Dregan', 'M', to_date('26/02/1984', 'dd/mm/yyyy'), '374 Macpherson Park', 4369.48,
        5);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (94, '485-71-7411', 'Tracey Lineham', 'F', to_date('21/09/1986', 'dd/mm/yyyy'), '845 Hermina Hill', 67609.64,
        15);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (95, '205-52-2681', 'Pincus Prangle', 'M', to_date('12/09/1997', 'dd/mm/yyyy'), '2761 La Follette Alley',
        68900.2, 2);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (96, '255-76-8860', 'Delinda Crowth', 'F', to_date('19/09/1983', 'dd/mm/yyyy'), '94312 Darwin Alley', 19997.72,
        16);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (97, '526-92-9368', 'Wendeline Braunds', 'F', to_date('25/04/1994', 'dd/mm/yyyy'), null, 1696.42, 18);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (98, '656-79-4815', 'Byrle Liepins', 'M', to_date('18/07/2004', 'dd/mm/yyyy'), '37 Bay Alley', 74400.91, 9);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (99, '372-76-5429', 'Jesselyn Minall', 'F', to_date('06/11/1985', 'dd/mm/yyyy'), '3 Grover Trail', 73084.88, 13);
insert into ATLETA (id, cpf, nome, sexo, datanasc, endereco, salario, id_clube)
values (100, '449-34-3717', 'Zachariah Eddowis', 'M', to_date('06/09/1989', 'dd/mm/yyyy'), null, 36736.02, 8);


insert into ATLETA_CONTATO (id_atleta, contato)
values (3, '(601) 7382910');
insert into ATLETA_CONTATO (id_atleta, contato)
values (35, '(424) 1277153');
insert into ATLETA_CONTATO (id_atleta, contato)
values (8, '(853) 4939806');
insert into ATLETA_CONTATO (id_atleta, contato)
values (10, '(537) 7676929');
insert into ATLETA_CONTATO (id_atleta, contato)
values (5, '(930) 3424502');
insert into ATLETA_CONTATO (id_atleta, contato)
values (24, '(805) 8850394');
insert into ATLETA_CONTATO (id_atleta, contato)
values (21, '(961) 4319690');
insert into ATLETA_CONTATO (id_atleta, contato)
values (39, '(582) 5786007');
insert into ATLETA_CONTATO (id_atleta, contato)
values (19, '(327) 4362855');
insert into ATLETA_CONTATO (id_atleta, contato)
values (25, '(334) 6464131');
insert into ATLETA_CONTATO (id_atleta, contato)
values (36, '(220) 5874448');
insert into ATLETA_CONTATO (id_atleta, contato)
values (14, '(245) 6444676');
insert into ATLETA_CONTATO (id_atleta, contato)
values (3, '(204) 7075984');
insert into ATLETA_CONTATO (id_atleta, contato)
values (29, '(831) 6814772');
insert into ATLETA_CONTATO (id_atleta, contato)
values (8, '(823) 9114157');
insert into ATLETA_CONTATO (id_atleta, contato)
values (1, '(172) 4988196');
insert into ATLETA_CONTATO (id_atleta, contato)
values (40, '(528) 3226452');
insert into ATLETA_CONTATO (id_atleta, contato)
values (3, '(304) 7327208');
insert into ATLETA_CONTATO (id_atleta, contato)
values (31, '(167) 8232204');
insert into ATLETA_CONTATO (id_atleta, contato)
values (36, '(903) 1863360');
insert into ATLETA_CONTATO (id_atleta, contato)
values (17, '(803) 1615017');
insert into ATLETA_CONTATO (id_atleta, contato)
values (1, '(663) 8443211');
insert into ATLETA_CONTATO (id_atleta, contato)
values (14, '(931) 5897442');
insert into ATLETA_CONTATO (id_atleta, contato)
values (20, '(859) 8551564');
insert into ATLETA_CONTATO (id_atleta, contato)
values (12, '(973) 3484414');
insert into ATLETA_CONTATO (id_atleta, contato)
values (24, '(620) 1429068');
insert into ATLETA_CONTATO (id_atleta, contato)
values (15, '(418) 3535451');
insert into ATLETA_CONTATO (id_atleta, contato)
values (25, '(464) 6517647');
insert into ATLETA_CONTATO (id_atleta, contato)
values (15, '(376) 3345143');
insert into ATLETA_CONTATO (id_atleta, contato)
values (29, '(750) 2970402');
insert into ATLETA_CONTATO (id_atleta, contato)
values (22, '(402) 2094554');
insert into ATLETA_CONTATO (id_atleta, contato)
values (5, '(934) 8184141');
insert into ATLETA_CONTATO (id_atleta, contato)
values (19, '(508) 1233810');
insert into ATLETA_CONTATO (id_atleta, contato)
values (15, '(524) 9040828');
insert into ATLETA_CONTATO (id_atleta, contato)
values (10, '(949) 7263269');
insert into ATLETA_CONTATO (id_atleta, contato)
values (6, '(827) 9983340');
insert into ATLETA_CONTATO (id_atleta, contato)
values (27, '(634) 9608119');
insert into ATLETA_CONTATO (id_atleta, contato)
values (17, '(353) 1617571');
insert into ATLETA_CONTATO (id_atleta, contato)
values (27, '(930) 3096037');
insert into ATLETA_CONTATO (id_atleta, contato)
values (21, '(705) 3022456');
insert into ATLETA_CONTATO (id_atleta, contato)
values (36, '(901) 2881330');
insert into ATLETA_CONTATO (id_atleta, contato)
values (2, '(190) 1524601');
insert into ATLETA_CONTATO (id_atleta, contato)
values (15, '(665) 6201461');
insert into ATLETA_CONTATO (id_atleta, contato)
values (16, '(685) 9381272');
insert into ATLETA_CONTATO (id_atleta, contato)
values (32, '(344) 4370898');
insert into ATLETA_CONTATO (id_atleta, contato)
values (16, '(974) 2598779');
insert into ATLETA_CONTATO (id_atleta, contato)
values (3, '(208) 5945890');
insert into ATLETA_CONTATO (id_atleta, contato)
values (31, '(874) 3764618');
insert into ATLETA_CONTATO (id_atleta, contato)
values (19, '(335) 4648941');
insert into ATLETA_CONTATO (id_atleta, contato)
values (7, '(645) 3624445');
insert into ATLETA_CONTATO (id_atleta, contato)
values (16, '(146) 1553210');
insert into ATLETA_CONTATO (id_atleta, contato)
values (8, '(920) 5577754');
insert into ATLETA_CONTATO (id_atleta, contato)
values (5, '(535) 7174885');
insert into ATLETA_CONTATO (id_atleta, contato)
values (10, '(519) 9464991');
insert into ATLETA_CONTATO (id_atleta, contato)
values (39, '(493) 5374018');
insert into ATLETA_CONTATO (id_atleta, contato)
values (19, '(634) 4159429');
insert into ATLETA_CONTATO (id_atleta, contato)
values (24, '(950) 5932172');
insert into ATLETA_CONTATO (id_atleta, contato)
values (23, '(599) 3251876');
insert into ATLETA_CONTATO (id_atleta, contato)
values (31, '(584) 3107077');
insert into ATLETA_CONTATO (id_atleta, contato)
values (1, '(566) 9226280');


insert into OLIMPICO (id_atleta, incentivo_governo)
values (1, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (2, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (5, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (7, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (8, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (10, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (12, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (13, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (15, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (16, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (17, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (19, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (20, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (21, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (25, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (28, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (30, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (31, 'S');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (32, 'N');
insert into OLIMPICO (id_atleta, incentivo_governo)
values (35, 'N');


insert into PARAOLIMPICO (id_atleta, deficiencia, nivel)
values (4, 'Motora', 5);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel)
values (9, 'Visual', 3);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel)
values (11, 'Auditiva', 2);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel)
values (14, 'Motora', 2);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel)
values (18, 'Motora', 4);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel)
values (24, 'Motora', 1);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel)
values (29, 'Visual', 4);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel)
values (33, 'Motora', 2);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel)
values (36, 'Auditiva', 2);
insert into PARAOLIMPICO (id_atleta, deficiencia, nivel)
values (39, 'Motora', 1);


insert into MODALIDADE (id, descricao, olimpica)
values (1, 'Soccer', 'S');
insert into MODALIDADE (id, descricao, olimpica)
values (2, 'Volleyball', 'S');
insert into MODALIDADE (id, descricao, olimpica)
values (3, 'Basketball', 'S');
insert into MODALIDADE (id, descricao, olimpica)
values (4, 'Fight', 'S');
insert into MODALIDADE (id, descricao, olimpica)
values (5, 'Hockey', 'S');
insert into MODALIDADE (id, descricao, olimpica)
values (6, 'Swimming', 'S');
insert into MODALIDADE (id, descricao, olimpica)
values (7, 'Cycling', 'S');
insert into MODALIDADE (id, descricao, olimpica)
values (8, 'Fencing', 'S');
insert into MODALIDADE (id, descricao, olimpica)
values (9, 'Running', 'S');
insert into MODALIDADE (id, descricao, olimpica)
values (10, 'Gymnastics', 'S');
insert into MODALIDADE (id, descricao, olimpica)
values (11, 'Cards', 'N');
insert into MODALIDADE (id, descricao, olimpica)
values (12, 'Videogame', 'N');


insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (29, 5, to_date('23/03/2002', 'dd/mm/yyyy'), 18.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (22, 1, to_date('30/09/1991', 'dd/mm/yyyy'), 29.0);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (27, 11, to_date('04/05/1993', 'dd/mm/yyyy'), 27.4);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (31, 10, to_date('18/03/1991', 'dd/mm/yyyy'), 29.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (25, 10, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (30, 8, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (9, 9, to_date('28/07/2016', 'dd/mm/yyyy'), 4.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (34, 7, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (30, 2, to_date('11/08/1993', 'dd/mm/yyyy'), 27.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (20, 1, to_date('11/05/2008', 'dd/mm/yyyy'), 12.4);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (2, 4, to_date('13/02/1995', 'dd/mm/yyyy'), 25.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (35, 5, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (4, 12, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (25, 11, to_date('18/08/1995', 'dd/mm/yyyy'), 25.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (18, 9, to_date('27/07/2000', 'dd/mm/yyyy'), 20.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (37, 7, to_date('19/02/1993', 'dd/mm/yyyy'), 27.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (38, 4, to_date('27/12/2012', 'dd/mm/yyyy'), 7.8);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (4, 9, to_date('19/04/1991', 'dd/mm/yyyy'), 29.5);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (1, 9, to_date('30/03/1997', 'dd/mm/yyyy'), 23.5);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (17, 8, to_date('10/03/2002', 'dd/mm/yyyy'), 18.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (14, 4, to_date('18/03/1998', 'dd/mm/yyyy'), 22.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (26, 6, to_date('27/01/2007', 'dd/mm/yyyy'), 13.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (32, 9, to_date('06/10/2016', 'dd/mm/yyyy'), 4.0);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (1, 8, to_date('22/08/2002', 'dd/mm/yyyy'), 18.1);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (21, 11, to_date('23/12/1994', 'dd/mm/yyyy'), 25.8);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (11, 7, to_date('16/08/2003', 'dd/mm/yyyy'), 17.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (10, 10, to_date('05/06/1990', 'dd/mm/yyyy'), 30.4);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (21, 5, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (25, 9, to_date('25/11/1995', 'dd/mm/yyyy'), 24.9);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (4, 8, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (17, 4, to_date('05/09/2003', 'dd/mm/yyyy'), 17.1);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (14, 12, to_date('04/02/2006', 'dd/mm/yyyy'), 14.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (22, 9, to_date('12/07/1995', 'dd/mm/yyyy'), 25.3);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (37, 9, to_date('25/10/2017', 'dd/mm/yyyy'), 3.0);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (17, 7, to_date('03/04/2000', 'dd/mm/yyyy'), 20.5);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (8, 3, to_date('12/01/1998', 'dd/mm/yyyy'), 22.8);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (27, 6, to_date('13/08/2001', 'dd/mm/yyyy'), 19.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (17, 10, to_date('02/12/1997', 'dd/mm/yyyy'), 22.9);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (30, 12, to_date('28/04/2004', 'dd/mm/yyyy'), 16.5);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (8, 6, to_date('11/04/1993', 'dd/mm/yyyy'), 27.5);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (36, 4, to_date('01/12/1996', 'dd/mm/yyyy'), 23.9);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (16, 7, to_date('09/02/1991', 'dd/mm/yyyy'), 29.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (23, 3, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (17, 2, to_date('19/08/2001', 'dd/mm/yyyy'), 19.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (37, 5, to_date('13/09/1993', 'dd/mm/yyyy'), 27.1);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (26, 9, to_date('29/01/2000', 'dd/mm/yyyy'), 20.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (8, 1, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (7, 6, to_date('08/03/1990', 'dd/mm/yyyy'), 30.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (35, 8, to_date('11/03/2012', 'dd/mm/yyyy'), 8.6);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (10, 12, to_date('19/02/1995', 'dd/mm/yyyy'), 25.7);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (16, 4, to_date('20/06/2018', 'dd/mm/yyyy'), 2.3);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (7, 2, to_date('30/12/2009', 'dd/mm/yyyy'), 10.8);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (14, 6, to_date('05/06/1993', 'dd/mm/yyyy'), 27.4);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (30, 5, to_date('28/08/1994', 'dd/mm/yyyy'), 26.1);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (9, 2, to_date('16/11/2007', 'dd/mm/yyyy'), 12.9);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (10, 9, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (38, 1, to_date('22/11/2016', 'dd/mm/yyyy'), 3.9);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (35, 1, null, null);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (39, 4, to_date('22/07/2010', 'dd/mm/yyyy'), 10.2);
insert into PRATICA (id_atleta, id_modalidade, data_inicio, experiencia)
values (24, 4, to_date('14/05/1997', 'dd/mm/yyyy'), 23.4);


insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (1, 'Vipe Cup', 'Huolongping', to_date('09/10/2016', 'dd/mm/yyyy'), to_date('31/10/2016', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (2, 'Vitz Championship', 'Kapotnya', to_date('12/02/2019', 'dd/mm/yyyy'), to_date('30/11/2019', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (3, 'Youfeed Championship', 'Zeljezno Polje', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (4, 'Mynte Cup', 'Langxi', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (5, 'Skimia Cup', 'San Miguel', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (6, 'Npath Championship', 'Taibao', to_date('19/09/2015', 'dd/mm/yyyy'), to_date('26/09/2015', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (7, 'Mydo Championship', 'Nova Lima', to_date('07/02/2015', 'dd/mm/yyyy'), to_date('07/03/2015', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (8, 'Thoughtworks Tournament', 'Lengkongsari', to_date('09/05/2018', 'dd/mm/yyyy'),
        to_date('31/07/2018', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (9, 'Lazzy Cup', 'Shanghudi', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (10, 'BlogXS Championship', 'Shinan', to_date('19/11/2013', 'dd/mm/yyyy'), to_date('21/11/2013', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (11, 'Skipstorm Tournament', 'Sindou', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (12, 'Trilith Cup', 'Sebu', to_date('16/06/2020', 'dd/mm/yyyy'), to_date('20/06/2020', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (13, 'Topicstorm Championship', 'Rawasan', to_date('17/03/2011', 'dd/mm/yyyy'),
        to_date('24/03/2011', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (14, 'Quinu Cup', 'Zlotniki Kujawskie', to_date('03/09/2017', 'dd/mm/yyyy'),
        to_date('15/09/2017', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (15, 'Youspan Tournament', 'Pahonjean', to_date('07/11/2017', 'dd/mm/yyyy'),
        to_date('20/12/2017', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (16, 'Camido Championship', 'Masipi West', to_date('19/06/2017', 'dd/mm/yyyy'),
        to_date('24/06/2017', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (17, 'Nlounge Cup', 'Sanying', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (18, 'Yombu Cup', 'Menara', to_date('28/03/2014', 'dd/mm/yyyy'), to_date('03/05/2014', 'dd/mm/yyyy'));
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (19, 'Skiptube Championship', 'Gaoping', null, null);
insert into CAMPEONATO (id, nome, local, data_inicio, data_fim)
values (20, 'Browsecat Tournament', 'Tomakivka', to_date('13/05/2019', 'dd/mm/yyyy'),
        to_date('15/06/2019', 'dd/mm/yyyy'));


insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (87715634, 29, 5);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (33416420, 22, 1);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (86986384, 27, 11);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (11547175, 31, 10);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (95166144, 9, 9);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (62048185, 30, 2);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (98353043, 20, 1);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (28626679, 2, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (59911312, 37, 7);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (96196461, 38, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (56608784, 4, 9);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (53241057, 17, 8);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (37285072, 14, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (68327832, 1, 8);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (44528889, 21, 11);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (47362586, 25, 9);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (96395079, 10, 10);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (24731406, 17, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (17671679, 11, 7);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (57253633, 26, 6);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (78031632, 32, 9);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (63644507, 1, 8);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (91373515, 21, 11);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (75844070, 11, 7);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (88442722, 17, 2);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (26063016, 17, 7);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (91645641, 8, 3);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (28339718, 27, 6);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (45811774, 35, 8);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (48981675, 10, 12);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (69592247, 16, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (68685407, 14, 6);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (78173025, 10, 9);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (79043780, 38, 1);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (61056193, 35, 1);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (81655809, 39, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (25609911, 24, 4);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (47090406, 9, 2);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (18546292, 35, 5);
insert into ESPORTE (registro_atleta, id_atleta, id_modalidade)
values (95531262, 4, 12);


insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (87715634, 13, 6, 4407.8);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (33416420, 4, 16, 270.07);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (86986384, 11, 18, 350.31);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (11547175, 1, 15, 39618.25);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (95166144, 18, 25, 98.99);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (62048185, 6, 16, 2005.09);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (98353043, 2, 15, 170.56);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (28626679, 19, 22, 314.14);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (59911312, 4, 29, 14.87);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (96196461, 11, 5, 2506.61);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (56608784, 13, 10, 15511.94);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (87715634, 12, 20, 109.86);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (53241057, 13, 22, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (37285072, 17, 13, 270.44);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (33416420, 12, 19, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (68327832, 9, 30, 191.64);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (44528889, 12, 9, 465.57);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (47362586, 13, 7, 906.08);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (96395079, 13, 11, 86.92);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (62048185, 7, 21, 107.6);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (24731406, 7, 22, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (17671679, 5, 30, 37.57);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (57253633, 4, 2, 2331.09);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (78031632, 5, 24, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (63644507, 8, 1, 70224.88);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (98353043, 18, 16, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (91373515, 2, 2, 10261.26);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (28626679, 11, 3, 16243.92);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (75844070, 9, 1, 29506.26);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (86986384, 6, 24, 76.42);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (88442722, 6, 29, 8.14);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (96196461, 3, 22, 239.66);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (62048185, 19, 1, 35869.31);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (95166144, 11, 5, 4085.82);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (26063016, 19, 2, 18760.85);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (96395079, 9, 8, 1629.99);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (91645641, 10, 19, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (86986384, 8, 13, 167.56);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (53241057, 18, 21, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (37285072, 5, 16, 262.87);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (57253633, 3, 5, 2165.82);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (28339718, 10, 7, 1474.87);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (45811774, 10, 15, 227.4);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (48981675, 14, 1, 74397.52);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (69592247, 11, 23, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (68685407, 9, 2, 30752.48);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (44528889, 17, 20, 81.41);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (78173025, 19, 10, 692.19);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (79043780, 10, 2, 6065.36);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (95166144, 16, 19, 620.1);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (61056193, 2, 14, 272.75);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (81655809, 10, 1, 14597.76);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (25609911, 18, 5, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (61056193, 20, 3, 6428.57);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (37285072, 12, 17, null);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (78173025, 17, 20, 926.2);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (62048185, 4, 20, 727.44);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (48981675, 19, 3, 22099.41);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (91373515, 14, 28, 143.31);
insert into PARTICIPA (registro_atleta, id_campeonato, colocacao, valor_premiacao)
values (57253633, 5, 6, 1736.93);


insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (17, 1, '(203) 8852807', 'Forest Run', '360', 'Center', '06726', 'Waterbury', 'CT');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (25, 2, '(518) 1705042', 'Elmside', '843', 'Plaza', '12242', 'Albany', 'NY');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (17, 3, '(713) 7019153', 'Kings', '4', 'Circle', '77045', 'Houston', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (24, 4, '(203) 1509611', 'International', '106', 'Avenue', '06816', 'Danbury', 'CT');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (29, 5, '(786) 8411691', 'Dexter', '092', 'Park', '33134', 'Miami', 'FL');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (21, 6, '(434) 3343181', 'Debra', '20896', 'Terrace', '27705', 'Durham', 'NC');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (29, 7, '(412) 2100712', 'Graceland', '0093', 'Avenue', '15215', 'Pittsburgh', 'PA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (4, 8, '(808) 3236645', 'Hayes', '870', 'Hill', '96815', 'Honolulu', 'HI');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (15, 9, '(917) 1765373', 'Knutson', '1', 'Lane', '10280', 'New York City', 'NY');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (18, 10, '(412) 7739903', 'Waywood', '223', 'Circle', '15250', 'Pittsburgh', 'PA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (7, 11, '(406) 1340148', 'Arizona', '1773', 'Road', '59806', 'Missoula', 'MT');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (11, 12, '(937) 1593587', 'Lillian', '6', 'Hill', '45414', 'Dayton', 'OH');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (15, 13, '(469) 5734653', 'Westerfield', '07111', 'Parkway', '75342', 'Dallas', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (6, 14, '(404) 5859229', 'Brentwood', '917', 'Court', '30336', 'Atlanta', 'GA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (10, 15, '(414) 7746157', 'Hoepker', '04', 'Drive', '53205', 'Milwaukee', 'WI');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (8, 16, '(213) 9957974', 'Bluejay', '5', 'Crossing', '90025', 'Los Angeles', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (1, 17, '(303) 5974224', 'Alpine', '580', 'Hill', '80127', 'Littleton', 'CO');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (12, 18, '(626) 5855274', 'Jenna', '4', 'Circle', '91199', 'Pasadena', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (21, 19, '(571) 3492863', 'Stephen', '45344', 'Street', '22093', 'Ashburn', 'VA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (16, 20, '(713) 7112184', 'Columbus', '675', 'Drive', '77035', 'Houston', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (19, 21, '(410) 3538543', 'Calypso', '6132', 'Pass', '21216', 'Baltimore', 'MD');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (26, 22, '(714) 7586665', 'Jana', '18739', 'Court', '92812', 'Anaheim', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (12, 23, '(253) 1156055', 'Moulton', '0976', 'Hill', '98166', 'Seattle', 'WA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (10, 24, '(832) 3039011', 'Boyd', '12352', 'Terrace', '77201', 'Houston', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (29, 25, '(951) 5257547', 'Sommers', '94', 'Hill', '92878', 'Corona', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (3, 26, '(754) 7559434', 'Hagan', '39245', 'Junction', '33336', 'Fort Lauderdale', 'FL');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (9, 27, '(205) 1247664', 'Mayer', '02', 'Hill', '35487', 'Tuscaloosa', 'AL');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (12, 28, '(334) 8729842', 'Rutledge', '52082', 'Drive', '36134', 'Montgomery', 'AL');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (25, 29, '(803) 7932508', 'Johnson', '02961', 'Parkway', '29225', 'Columbia', 'SC');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (24, 30, '(510) 7973790', 'Dixon', '7', 'Crossing', '94622', 'Oakland', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (7, 31, '(775) 9934404', 'Buena Vista', '261', 'Street', '89595', 'Reno', 'NV');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (12, 32, '(212) 1827738', 'Cardinal', '4447', 'Pass', '11254', 'Brooklyn', 'NY');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (12, 33, '(310) 3485729', 'Sunbrook', '0567', 'Point', '90805', 'Long Beach', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (13, 34, '(434) 8733507', 'Spohn', '161', 'Center', '22111', 'Manassas', 'VA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (16, 35, '(402) 3060768', 'Blaine', '39', 'Place', '68124', 'Omaha', 'NE');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (23, 36, '(314) 7800399', 'Sunfield', '0890', 'Circle', '63167', 'Saint Louis', 'MO');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (30, 37, '(774) 6028432', 'Drewry', '55', 'Drive', '01610', 'Worcester', 'MA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (27, 38, '(225) 7049300', 'Jay', '2311', 'Circle', '70820', 'Baton Rouge', 'LA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (23, 39, '(212) 5469699', 'Dapin', '075', 'Junction', '10131', 'New York City', 'NY');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (11, 40, '(504) 9639309', 'Ryan', '61518', 'Road', '70142', 'New Orleans', 'LA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (24, 41, '(617) 7482347', 'Lawn', '00825', 'Crossing', '02208', 'Boston', 'MA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (2, 42, '(701) 1337802', 'Arizona', '15586', 'Center', '58122', 'Fargo', 'ND');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (18, 43, '(202) 3571515', 'Badeau', '76', 'Circle', '20088', 'Washington', 'DC');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (19, 44, '(602) 7233920', 'Express', '6507', 'Alley', '85010', 'Phoenix', 'AZ');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (6, 45, '(215) 2518875', 'Farmco', '9964', 'Point', '19172', 'Philadelphia', 'PA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (19, 46, '(417) 2791827', 'Marcy', '1', 'Lane', '65810', 'Springfield', 'MO');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (13, 47, '(619) 9955921', 'Rutledge', '39', 'Trail', '92153', 'San Diego', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (11, 48, '(763) 7567922', 'Bluestem', '212', 'Place', '55598', 'Loretto', 'MN');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (4, 49, '(907) 4629296', 'Northfield', '86725', 'Crossing', '99512', 'Anchorage', 'AK');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (27, 50, '(325) 4359571', 'Texas', '97946', 'Center', '79699', 'Abilene', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (20, 51, '(502) 1917772', 'Vidon', '18626', 'Road', '40618', 'Frankfort', 'KY');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (7, 52, '(408) 6747243', 'Hoffman', '6', 'Center', '95123', 'San Jose', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (1, 53, '(208) 2292372', 'Blue Bill Park', '8', 'Drive', '83716', 'Boise', 'ID');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (14, 54, '(903) 6070958', 'Spaight', '54', 'Drive', '75705', 'Tyler', 'TX');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (29, 55, '(714) 6899483', 'Fieldstone', '460', 'Center', '92725', 'Santa Ana', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (10, 56, '(559) 9332511', 'Oxford', '19', 'Circle', '93740', 'Fresno', 'CA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (30, 57, '(412) 9936053', 'Porter', '7', 'Point', '15134', 'Mc Keesport', 'PA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (12, 58, '(706) 6696603', 'Rowland', '1', 'Trail', '30919', 'Augusta', 'GA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (5, 59, '(404) 9864853', 'Petterle', '3', 'Point', '30343', 'Atlanta', 'GA');
insert into CENTRO_TREINAMENTO (id_clube, id_centro, fone, rua, nro, bairro, CEP, cidade, UF)
values (13, 60, '(469) 7153460', 'Onsgard', '3', 'Lane', '75342', 'Dallas', 'TX');


/*=================================================== AULA 02 - Sequence ===================================================*/

SELECT SYSDATE
FROM dual;

SELECT 1
FROM dual;

SELECT 2 + 2, 'A', TO_CHAR(sysdate, 'DD/MM/YYYY')
FROM dual;


CREATE SEQUENCE teste_seq INCREMENT BY 10
    START WITH 1 MAXVALUE 9999 CYCLE NOCACHE;

CREATE SEQUENCE teste2_seq INCREMENT BY 25
    START WITH 100 NOMAXVALUE NOCYCLE CACHE 10;

CREATE SEQUENCE teste3_seq INCREMENT BY 1
    START WITH 1 NOCACHE;



CREATE table tabela_teste
(
    numero    number(3),
    descricao varchar2(10),
    CONSTRAINT teste_pk PRIMARY KEY (numero)
);

INSERT INTO tabela_teste (numero, descricao)
VALUES (teste_seq.NEXTVAL, 'Tony');

SELECT *
FROM tabela_teste;

SELECT teste_seq.CURRVAL
FROM dual;

ALTER SEQUENCE teste_seq INCREMENT BY 20
    MAXVALUE 999999 NOCACHE CYCLE;

INSERT INTO tabela_teste (numero, descricao)
VALUES (teste_seq.NEXTVAL, 'Alexandre');

select *
from tabela_teste;

DROP SEQUENCE teste_seq;


CREATE SEQUENCE clube_seq INCREMENT BY 10
    START WITH 100 MAXVALUE 9999 NOCACHE NOCYCLE;

INSERT INTO clube (id, nome)
VALUES (clube_seq.nextval, 'Tabajara');

SELECT clube_seq.currval
FROM dual;

SELECT *
FROM clube;

ALTER SEQUENCE clube_seq INCREMENT BY 40;

INSERT INTO modalidade (id, descricao, olimpica)
VALUES (clube_seq.nextval, 'Skating', 'N');

SELECT clube_seq.currval
FROM dual;

SELECT *
FROM modalidade;

DROP SEQUENCE clube_seq;

SELECT *
FROM ATLETA;

SELECT id, datanasc, endereco, salario
FROM ATLETA;

SELECT id as ID_CLUBE, nome AS NOME_CLUBE, id_presidente as PRESIDENTE
FROM CLUBE;

SELECT nome, salario
FROM ATLETA
WHERE nome like 'R%';

SELECT nome, sexo
FROM atleta
WHERE nome like '%t_';

SELECT nome, salario
FROM atleta
WHERE salario BETWEEN 15000 and 25000;

SELECT cpf, nome
FROM atleta
WHERE id_clube is null
ORDER BY nome asc;

SELECT id, nome, salario
FROM atleta
WHERE salario < 10000
ORDER BY salario DESC;

SELECT LOWER(nome), UPPER(nome), INITCAP(endereco)
from atleta;

SELECT CONCAT(nome, data_fundacao)
from clube;

SELECT nome || data_fundacao
from clube;

select SUBSTR(nome, 1, 5)
from atleta;
select SUBSTR(nome, -4, 4)
from clube;
select SUBSTR(nome, -4)
from clube;

select nome, LENGTH(nome) as TAM
from atleta;
select ROUND(salario, 0), TRUNC(salario, 1)
from atleta;
select TRIM(nome)
from atleta;
select nome, REPLACE(nome, 'e', 'i')
from clube;
select TRANSLATE(nome, 'aei', 'ouy')
from clube;

select nome, NVL(id_clube, 0)
from atleta;
select nome, NVL(TO_CHAR(id_clube), 'Não possui') ID_CLUBE
from atleta;

select nome,
       sexo,
       case sexo
           when 'M' then 'Masculino'
           when 'F' then 'Feminino'
           ELSE 'Não informado'
           end
from atleta;

select nome,
       salario,
       case
           when salario > 50000 then 0.3
           when salario > 25000 then 0.2
           when salario > 5000 then 0.1
           else 0
           end as Imposto
from atleta;

select nome,
       sexo,
       DECODE(sexo, 'M', 'Masculino', 'F', 'Feminino')
from ATLETA;

select nome,
       to_char(datanasc, 'DD "de" Month month MONTH "de" YYYY')
           as data_nasc
from atleta;

select to_char(valor_premiacao, '$99,999.00') valor
from participa
where id_campeonato in (7, 10);

select UPPER(nome),
       datanasc,
       case
           when datanasc < to_date('01/01/1990', 'dd/mm/yyyy') then 5000
           when datanasc < to_date('01/01/2000', 'dd/mm/yyyy') then 3000
           else 0
           end                                                                     as bonus,
       decode(substr(endereco, -6), 'Avenue', 'Avenida', 'Street', 'Rua', 'Outro') as tipo_endereco
from atleta;

select nome,
       replace(replace(endereco, 'Avenue', 'Av.'), 'Street', 'St.') as "Endereço",
       NVL(TO_CHAR(id_clube), 'Não possui')                         as clube,
       to_char(salario, '$999,999.00')                              as salario
from atleta;

select max(salario)
from atleta;
select min(salario)
from atleta;
select avg(salario)
from atleta;
select sum(salario)
from atleta;
select count(*)
from atleta;


select max(salario), min(salario), avg(salario), sum(salario), count(*)
from atleta;


select max(salario)
from atleta
where id_clube = 24;


select count(*)
from atleta;
select count(id_clube)
from atleta;
select *
from atleta
where id_clube is null;


select sexo, count(sexo)
from atleta
group by sexo;
select id_clube, sum(salario)
from atleta
group by id_clube
order by id_clube;
select id_clube, avg(salario) as Media
from atleta
where id_clube in (12, 15, 24)
group by id_clube;
select id_clube, sexo, round(avg(salario), 2) as Media
from atleta
group by id_clube, sexo
order by id_clube;


/* IMPORTANTE
select
from
where
group by
having
order by
*/

select id_clube, sum(salario)
from atleta
group by id_clube
having sum(salario) > 200000
order by id_clube;
select count(*)
from centro_treinamento;
select id_clube, count(*)
from centro_treinamento
group by id_clube;
select id_clube
from centro_treinamento
group by id_clube
having count(*) = 1;


/* ================ Exercícios ================*/


/*1. Liste o valor total de premiação distribuída no campeonato de id 19;*/
SELECT SUM(valor_premiacao)
FROM participa
WHERE id_campeonato = 19;

/*2. Liste a media de valor de premiação por campeonato para os
campeonatos 2, 8, e 14. Arredonde para exibir com 1 casa decimal;*/
SELECT id_campeonato, ROUND(AVG(valor_premiacao), 1)
FROM participa
WHERE id_campeonato in (2, 8, 14)
GROUP BY id_campeonato;

/*3. Encontre a quantidade de atletas que pratica cada modalidade esportiva;*/


/*4. Para cada modalidade esportiva praticada, liste o maior e o menor tempo
de experiência. Ordene os resultados por id de modalidade.*/


/*5. Liste o id do campeonato e a quantidade de atletas que participaram
deles, exibindo somente os campeonatos com mais de 3 participantes.
Ordene os resultados por quantidade de participantes
decrescentemente;*/


/*6. Liste a média de colocação dos atletas participantes de campeonatos,
exibindo o número de registro do atleta e sua colocação media truncada
sem casas decimais. Descarte as tuplas em que não houve valor de
premiação. Deixe na listagem apenas os atletas com colocação média até
o décimo lugar. Ordene os resultados por colocação média.*/


/*=================================================== AULA 03 - INNER JOIN ===================================================*/

SELECT c.nome, a.nome
FROM atleta a
         join clube c
              ON a.id_clube = c.id
ORDER BY c.nome, a.nome;

SELECT c.nome, a.nome
FROM atleta a,
     clube c
WHERE a.id_clube = c.id
ORDER BY c.nome, a.nome;


SELECT a.id_clube, a.nome, o.incentivo_governo
FROM atleta a
         join olimpico o
              ON a.id = o.id_atleta
WHERE a.id_clube IN (24, 29)
ORDER BY 1, 2;


SELECT a.nome, m.descricao, p.data_inicio
FROM atleta a
         JOIN pratica p ON a.id = p.id_atleta
         JOIN modalidade m ON p.id_modalidade = m.id;


SELECT a.id as IdAtleta, a.nome as NomeAtleta, c.nome as NomeClube
FROM atleta a
         LEFT JOIN clube c
                   ON a.id_clube = c.id;

SELECT a.id, a.nome, c.nome
FROM atleta a,
     clube c
WHERE a.id_clube = c.id(+);


SELECT c.nome, p.nome
FROM clube c
         RIGHT JOIN presidente p
                    ON c.id_presidente = p.id;

SELECT c.nome, p.nome
FROM clube c,
     presidente p
WHERE c.id_presidente(+) = p.id;


SELECT c.nome, p.nome
FROM clube c
         FULL JOIN presidente p
                   ON c.id_presidente = p.id;


-- SUBCONSULTAS
-- ALL, ANY ou IN

SELECT cpf, nome, salario
FROM atleta;

SELECT cpf, nome, salario
FROM atleta
WHERE salario > ALL (SELECT salario
                     FROM atleta
                     WHERE nome IN ('Pernell Boorer', 'Yale Buttle'));

SELECT cpf, nome, salario
FROM atleta
WHERE salario > ANY (SELECT salario
                     FROM atleta
                     WHERE nome IN ('Pernell Boorer', 'Yale Buttle'));


SELECT nome, endereco
FROM atleta
WHERE id_clube IN (SELECT id
                   FROM clube
                   WHERE nome IN ('Tresom Club', 'Zamit Team'));

SELECT nome
FROM presidente
WHERE id NOT IN (SELECT NVL(id_presidente, 0)
                 FROM clube
                 WHERE nome IN ('Alpha Team', 'Temp Club', 'Monster Team'));

SELECT nome
FROM atleta a
WHERE EXISTS (SELECT 1
              FROM pratica p
              WHERE p.id_atleta = a.id);

SELECT nome
FROM atleta a
WHERE NOT EXISTS (SELECT 0
                  FROM pratica p
                  WHERE p.id_atleta = a.id);


SELECT id_atleta
FROM olimpico
UNION
SELECT id_atleta
FROM paraolimpico;

SELECT registro_atleta
FROM esporte
INTERSECT
SELECT registro_atleta
FROM participa;

SELECT id
FROM atleta
MINUS
(SELECT id_atleta
 FROM olimpico
 UNION
 SELECT id_atleta
 FROM paraolimpico);

SELECT id_atleta, incentivo_governo, NULL
FROM olimpico
UNION ALL
SELECT id_atleta, NULL, deficiencia
FROM paraolimpico;

-- VIEW

CREATE VIEW v_atleta26 AS
SELECT id, nome, cpf, salario, id_clube
FROM atleta
WHERE id_clube = 26;

CREATE VIEW v_atleta_modalidade (atleta, modalidade, experiencia) AS
SELECT a.nome, m.descricao, p.experiencia
FROM pratica p,
     atleta a,
     modalidade m
WHERE p.id_atleta = a.ID
  and p.id_modalidade = m.id;

DESC v_atleta_modalidade;
SELECT *
FROM v_atleta_modalidade;

CREATE VIEW v_clube_info (nome_clube, qtde_atletas, total_sal) AS
SELECT c.nome, COUNT(*), SUM(a.salario)
FROM clube c
         JOIN atleta a
              ON a.id_clube = c.id
GROUP BY c.nome;

DESC v_clube_info;
SELECT *
FROM v_clube_info;


CREATE OR REPLACE VIEW v_clube_info (nome_clube, qtde_atletas, total_sal, media_sal) AS
SELECT c.nome, COUNT(*), SUM(a.salario), round(AVG(a.salario), 2)
FROM clube c
         JOIN atleta a
              ON a.id_clube = c.id
GROUP BY c.nome;

DESC v_clube_info;
SELECT *
FROM v_clube_info;

INSERT INTO v_atleta26
VALUES (199, 'Neymar', '999-88-7777', 25000.00, 26);
SELECT *
FROM v_atleta26;
SELECT *
FROM atleta;

UPDATE v_atleta26
SET salario = 300000
WHERE id = 199;
SELECT *
FROM v_atleta26;
SELECT *
FROM atleta;

CREATE OR REPLACE VIEW v_atleta26 AS
SELECT id, nome, cpf, salario, id_clube
FROM atleta
WHERE id_clube = 26
WITH CHECK OPTION CONSTRAINT v_atl26_check_ck;

CREATE OR REPLACE VIEW v_atleta26 AS
SELECT id, nome, cpf, salario, id_clube
FROM atleta
WHERE id_clube = 26
WITH READ ONLY;

INSERT INTO v_atleta26
VALUES (200, 'Jase Barbosa', '111-22-3333', 45700.8, 26);

DROP VIEW v_atleta26;


/*---------------------- Materialized VIews ----------------------*/

CREATE MATERIALIZED VIEW mv_premiacao_modalidade_clube
    BUILD IMMEDIATE REFRESH COMPLETE ON DEMAND
AS
SELECT c.nome, m.descricao, NVL(SUM(p.valor_premiacao), 0) AS tot_premiacao
FROM atleta a,
     esporte e,
     participa p,
     clube c,
     modalidade m
WHERE a.id = e.id_atleta
  AND e.registro_atleta = p.registro_atleta
  AND a.id_clube = c.id
  AND e.id_modalidade = m.id
GROUP BY c.nome, m.descricao
ORDER BY c.nome, m.descricao;

SELECT *
FROM mv_premiacao_modalidade_clube
WHERE nome = 'Monster Team';

CREATE MATERIALIZED VIEW mv_atletas
    REFRESH COMPLETE START WITH SYSDATE NEXT SYSDATE + 7
AS
SELECT *
FROM atleta;

/*-------- Exercícios de Junçoes --------*/

/*1) Liste o id, nome e salário dos atletas, o id e nome do clube a que
pertencem e o id e nome do presidente de seu clube.*/

/*2) Liste o nome, CPF, salário, endereço, deficiência e o nível de deficiência
dos atletas paraolímpicos;*/

/*3) Liste os ids e descrições das modalidades e os nomes dos atletas que as
praticam;*/

/*4) Liste o registro do atleta, seu nome, a descrição da modalidade que
disputa e a melhor colocação dele em um campeonato;*/

/*5) Liste o nome, data de início e data de término dos campeonatos e o
registro de atletas que participaram dele, se houver (incluir na listagem
campeonatos que ninguém participou);*/

/*6) Liste o nome do atleta, o nome do clube a que pertence, a descrição da
modalidade que pratica, o tempo de experiência na modalidade, seu
registro de atleta, o nome do campeonato que disputou, a sua colocação
e valor da premiação recebida para todos os atletas olímpicos.*/


/*-------- Exercícios de Subconsultas e Operadores de junções --------*/

/*7) Mostre o nome, salário e data de nascimento dos atletas que
pertencem ao clube ?Tamplight Club?;*/
/*8) Liste o id, o nome, o total de atletas e a média salarial dos clubes
presididos por ?Diana Leamon?, ?Billie Dargavel? ou ?Shantee
Jouhning?;*/
/*9) Liste o id e o nome das modalidades esportivas que possuem mais de
2 atletas que a praticam;*/
/*10) Liste o nome e salário dos atletas de ?Soccer? que ganham mais do
que os atletas de ?Volleyball? e de ?Basketball?.*/
/*11) Liste o nome dos atletas que já receberam algum valor de premiação
em qualquer campeonato;*/
/*12) Liste a descrição da modalidade, o nome do atleta e a data de
nascimento do atleta mais velho que pratica a modalidade.*/

/*-------- Exercícios de VIEWS E Materialized View --------*/

/*1) Crie uma visão que liste o nome do clube e os nomes de todas as cidades
de seus centros de treinamentos, sendo que o clube deve ser presidido
por Billie Dargavel ou Conrado Dumbare.*/

/*2) Crie uma visão que contenha o nome do atleta, o seu salário e a
quantidade de modalidades que pratica. Depois, consulte esta visão
mostrando o nome do atleta e o valor da divisão de seu salário pela
quantidade de modalidades que pratica.*/

/*3) Crie uma visão que tenha o nome do atleta, seu id, o nome do
campeonato que disputou e o valor de premiação recebido para os
atletas paraolímpicos, com os resultados ordenados por nome de atleta.*/
/*4) Crie uma visão que tenha o nome do clube, o nome de seu presidente, a
quantidade total de atletas que nele treinem.*/

/*5) Crie a visão V_SOCCER que contenha o id do atleta, seu nome e
o id da modalidade que pratica, para todos os atletas que
praticam a modalidade Soccer. As colunas devem se chamar
ID_ATL, NOME_ATL e ID_MODALIDADE, respectivamente. Para
segurança, não permita que nenhum atleta seja realocado para
outra modalidade por meio da view criada. Chame a constraint
criada de v_soccer_ck.*/

/*6) Tente realocar o atleta Allie Tessier para a modalidade 5(Hockey)
por meio da visão criada no exercícioanterior.*/

/*7) Crie uma visão chamada V_ATL_OLIMP_PARAOLIMP que exiba o
nome do atleta, a letra O se for olímpico ou P se for paraolímpico,
e se possui incentivo do governo (se for olímpico) ou a deficiência
(se for paraolímpico). Ordene os resultados primeiramente pela
segunda coluna. As colunas da visão devem ter os nomes ATLETA,
TIPO e OBSERVACAO, respectivamente. Não permita operações
DML por meio da visão, ou seja, crie-a já com essa proteção.
Criada a visão, faça uma consulta utilizando-a.*/

/*8) Crie visões materializadas simples, modificando os tipos de
REFRESH e elabore consultas para testá-las.*/


/*=================================================== AULA 04 - Usuarios ===================================================*/

CREATE USER JOSE
    IDENTIFIED BY JOSE;

GRANT CREATE SESSION TO JOSE;
GRANT CREATE TABLE TO JOSE;

ALTER USER JOSE QUOTA UNLIMITED ON USERS;

GRANT CREATE SEQUENCE TO JOSE;
GRANT CREATE VIEW TO JOSE;


CREATE USER HR
    IDENTIFIED BY HR;

GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW TO HR;

ALTER USER HR QUOTA UNLIMITED ON USERS;

GRANT CREATE ANY TABLE TO JOSE;
GRANT DROP ANY TABLE TO JOSE;

GRANT CREATE ANY VIEW TO JOSE;
GRANT DROP ANY VIEW TO JOSE;


CREATE ROLE desenvolvedor;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO desenvolvedor;

CREATE USER MARIA IDENTIFIED BY MARIA;

GRANT desenvolvedor TO MARIA;

REVOKE CREATE SESSION, CREATE TABLE FROM JOSE;
GRANT CREATE SESSION, CREATE TABLE TO JOSE;

ALTER USER HR IDENTIFIED BY employ;

ALTER USER HR ACCOUNT LOCK;
ALTER USER HR ACCOUNT UNLOCK;

-- GRANT INSERT, SELECT ON HR.teste_priv2 TO JOSE;

GRANT select, insert
    ON HR.atleta
    TO JOSE;

GRANT update (nome, salario)
    ON HR.atleta
    TO jose, desenvolvedor;

GRANT select, insert
    ON HR.clube
    TO JOSE
    WITH GRANT OPTION;

GRANT select
    ON HR.presidente
    TO PUBLIC;

GRANT select, insert
    ON HR.v_teste_priv
    TO PUBLIC;

GRANT select
    ON JOSE.test_id_seq
    TO HR;

REVOKE select, insert
    ON HR.clube
    FROM JOSE;

/*=================================================== AULA 05 ===================================================*/

GRANT SELECT, INSERT, UPDATE, DELETE ON hr.atleta to JOSE;

-- AULA 06 --
SET SERVEROUTPUT ON;

DECLARE
    altura number := 3;
    base   number := 2;
    area   number;
BEGIN
    -- Calcula área do triângulo
    area = (base * altura) / 2;
    DBMS_OUTPUT.PUT_LINE('Area do triângulo=' || area);
END;


DECLARE
    v_saldo   number := 500;
    v_limite  number := 100;
    v_message VARCHAR(30);
BEGIN
    IF v_saldo > 0 THEN
        v_message := 'Saldo positivo';
        IF v_limite > 0 THEN
            v_message := 'Saldo e limite positivo';
        END IF;
        ELSEIF v_saldo = 0 THEN
        v_message := 'Saldo zero';
    ELSE
        v_message := 'Saldo negativo';
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_message);
END;


DECLARE
    estado_civil CHAR(1) := 'D';
    v_estcivil   VARCHAR(20);
BEGIN
    CASE estado_civil
        WHEN 'C' THEN v_estcivil := 'Casado';
        WHEN 'S' THEN v_estcivil := 'Solteiro';
        WHEN 'D' THEN v_estcivil := 'Divoriciado';
        ELSE v_estcivil := 'Nāo informado'; -- default case
        END CASE;
    DBMS_OUTPUT.PUT_LINE('Estado civil' || v_estcivil);
END;

DECLARE
    v_contador number := 0;
BEGIN
    LOOP
        v_contador := v_contador + 1;
        DBMS_OUTPUT.PUT_LINE(v_contador);
        EXIT WHEN v_contador = 5;
    END LOOP;
END;

-- incrementando o CONTINUE
DECLARE
    v_contador number := 0;
BEGIN
    LOOP
        v_contador := v_contador + 1;
        IF v_contador = 3 THEN
            CONTINUE; --termina a iteraçāo atual incondicionalmente
        END IF;;
        DBMS_OUTPUT.PUT_LINE(v_contador);
        EXIT WHEN v_contador = 5;
    END LOOP;
END;

-- incrementa o CONTINUE WHEN
DECLARE
    v_contador number := 0;
BEGIN
    LOOP
        v_contador := v_contador + 1;
        CONTINUE WHEN v_contador = 3; -- termina a iteraçāo atual quando for 3
        DBMS_OUTPUT.PUT_LINE(v_contador);
        EXIT WHEN v_contador = 5;
    END LOOP;
END;

-- WHILW condiçāo LOOP
DECLARE
    v_contador number := 0;
BEGIN
    WHILE v_contador < 5
        LOOP
            v_contador := v_contador + 1;
            DBMS_OUTPUT.PUT_LINE(v_contador);
        END LOOP;
END;


DECLARE
    v_contador number := 0;
BEGIN
    FOR v_contador IN 1..5
        LOOP
            DBMS_OUTPUT.PUT_LINE(v_contador);
        END LOOP;
END;

DECLARE
    v_contador number := 0;
BEGIN
    FOR v_contador IN REVERSE 1..5
        LOOP
            DBMS_OUTPUT.PUT_LINE(v_contador);
        END LOOP;
END;


DECLARE
    v_nome      clube.nome%type;
    v_data_fund clube.data_fundacao%type;
BEGIN
    SELECT nome, data_fundacao
    INTO v_nome, v_data_fund
    FROM clube
    WHERE id = 1;
    DBMS_OUTPUT.PUT_LINE('Id: 1' || ', Nome:' || v_nome || ',Data de fundaçāo:' || TO_CHAR(v_data_fund), 'DD/MM/YYYY');
END;

-- input box sera aberto para inserir o id que deseja buscar na tabela
DECLARE
    v_nome      clube.nome%type;
    v_data_fund clube.data_fundacao%type;
    v_id        clube.id%type;
BEGIN
    SELECT nome, data_fundacao
    INTO v_nome, v_data_fund
    FROM clube
    WHERE id = &v_id;
    DBMS_OUTPUT.PUT_LINE('Id: 1' || ', Nome:' || v_nome || ',Data de fundaçāo:' || TO_CHAR(v_data_fund),
                         'DD/MM/YYYY') );
END;

DECLARE
    v_nome      clube.nome%type;
    v_data_fund clube.data_fundacao%type;
    v_id        clube.id%type;
BEGIN
    SELECT NOME, DATA_FUNDACAO
    INTO v_nome, v_data_fund
    FROM CLUBE
    WHERE ID = &&v_id;
    DBMS_OUTPUT.PUT_LINE('Id: ' || &&v_id || ', Nome: ' || v_nome || ', Data de fundação: ' ||
                         TO_CHAR(v_data_fund, 'DD/MM/YYYY'));
END;

-- Tabuada do 5
DECLARE
    numero number := 5;
BEGIN
    FOR i IN 1..10
        LOOP
            DBMS_OUTPUT.PUT_LINE(numero || ' x ' || i || ' = ' || numero * i);
        END LOOP;
END;

-- Tabuada do 1 ao 10
DECLARE
    i number;
BEGIN
    FOR i IN 1..10
        LOOP
            DBMS_OUTPUT.PUT_LINE('Tabuada do ' || i);
            FOR j IN 1..10
                LOOP
                    DBMS_OUTPUT.PUT_LINE(j || ' x ' || i || ' = ' || i * j);
                END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
END;

-- Exercício 4
DECLARE
    v_nome     atleta.nome%type;
    v_datanasc atleta.datanasc%type;
    v_sexo     atleta.sexo%type;
    v_idade    number;
BEGIN
    SELECT nome, datanasc, sexo INTO v_nome, v_datanasc, v_sexo FROM atleta WHERE id = 1;
    v_idade := trunc((sysdate - v_datanasc) / 365);
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome || ', Data Nasc: ' || v_datanasc || ', Idade = ' || v_idade || ', sexo: ' ||
                         v_sexo);
    IF v_idade < 18 AND v_sexo = 'M' THEN
        DBMS_OUTPUT.PUT_LINE('Atleta masculino menor de idade');
    ELSIF v_idade < 18 AND v_sexo = 'F' THEN
        DBMS_OUTPUT.PUT_LINE('Atleta feminina menor de idade');
    ELSIF v_idade >= 18 AND v_sexo = 'M' THEN
        DBMS_OUTPUT.PUT_LINE('Atleta masculino maior de idade');
    ELSIF v_idade >= 18 AND v_sexo = 'F' THEN
        DBMS_OUTPUT.PUT_LINE('Atleta feminina maior de idade');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Informações desconhecidas');
    END IF;
END;

-- CURSORES
DECLARE
    v_idatleta atleta.id%type;
    v_nome     atleta.nome%type;
    v_salario  atleta.salario%type;
    CURSOR c_atleta IS SELECT id, nome, salario
                       from atleta
                       ORDER BY id;
BEGIN
    OPEN c_atleta;
    LOOP
        FETCH c_atleta INTO v_idatleta, v_nome, v_salario;
        EXIT WHEN c_atleta%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Id: ' || v_idatleta || ', nome: ' || v_nome || ', salário: ' || v_salario);
    END LOOP;
    CLOSE c_atleta;
END;

-- ROWTYPE
DECLARE
    v_atleta atleta%ROWTYPE;
    CURSOR c_atleta IS SELECT *
                       from atleta
                       ORDER BY id;
BEGIN
    OPEN c_atleta;
    LOOP
        FETCH c_atleta INTO v_atleta;
        EXIT WHEN c_atleta%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Id: ' || v_atleta.id || ', nome: ' || v_atleta.nome || ', salário: ' || v_atleta.salario);
    END LOOP;
    CLOSE c_atleta;
END;

-- forma mais simples de realizar cursor
DECLARE
    CURSOR c_atleta IS SELECT *
                       FROM atleta
                       ORDER BY id;
BEGIN
    FOR v_atleta IN c_atleta
        LOOP
            DBMS_OUTPUT.PUT_LINE('Id: ' || v_atleta.id || ', nome: ' || v_atleta.nome || ', salário: ' ||
                                 v_atleta.salario);
        END LOOP;
END;

-- tratando caso haja alguma exceçāo, nesse caso quando algum atleta nāo é encontrado
DECLARE
    v_atleta atleta%ROWTYPE;
    CURSOR c_atleta IS SELECT *
                       from atleta
                       WHERE nome = 'Royal Sallter';
BEGIN
    OPEN c_atleta;
    LOOP
        FETCH c_atleta INTO v_atleta;
        EXIT WHEN c_atleta%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_atleta.nome);
    END LOOP;
    CLOSE c_atleta;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Atleta não encontrado!');
END;

-- tratamento de exceçāo
DECLARE
    v_id atleta.id%TYPE;
BEGIN
    select id INTO v_id from atleta where id = 111;
    update atleta set nome = 'Maria das Vitórias' where id = 111;
    commit;
    DBMS_OUTPUT.PUT_LINE('Atleta atualizado com sucesso!');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO atleta (id, nome, cpf, datanasc, salario)
        VALUES (111, 'Maria das Vitórias', '777-11-3333', TO_CHAR('22/04/1990', 'dd/mm/yyy'), 1000);
        commit;
        DBMS_OUTPUT.PUT_LINE('Atleta cadastrado com sucesso!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || sqlerrm);
END;

-- Exercícios Cursores

/*1. Faça um bloco PL/SQL que liste a média salarial dos
atletas e, para cada atleta, liste o seu id, nome, cpf
e salário, e se ganha acima ou não da média salarial
dos atletas.*/


-- SOLUÇÃO 1:
DECLARE
    v_media   number;
    v_id      atleta.id%type;
    v_nome    atleta.nome%type;
    v_cpf     atleta.cpf%type;
    v_salario atleta.salario%type;
    CURSOR c_atleta IS select id, nome, cpf, salario
                       from atleta;
BEGIN
    SELECT avg(salario) INTO v_media FROM atleta;
    DBMS_OUTPUT.PUT_LINE('Média Salarial dos atletas: ' ||
                         round(v_media, 2));
    OPEN c_atleta;
    LOOP
        FETCH c_atleta INTO v_id, v_nome, v_cpf, v_salario;
        EXIT WHEN c_atleta%NOTFOUND;
        IF v_salario > v_media THEN
            DBMS_OUTPUT.PUT_LINE('Id: ' || v_id || ', Nome: ' || v_nome || ',
            CPF: ' || v_cpf || ', Salário: ' || v_salario || ', Ganha MAIS que a média');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Id: ' || v_id || ', Nome: ' || v_nome || ',
            CPF: ' || v_cpf || ', Salário: ' || v_salario || ', Ganha MENOS que a média');
        END IF;
    END LOOP;
    CLOSE c_atleta;
END;

-- SOLUÇÃO 2:
DECLARE
    v_media number;
    CURSOR c_atleta IS select id, nome, cpf, salario
                       from atleta;
BEGIN
    SELECT avg(salario) INTO v_media FROM atleta;
    DBMS_OUTPUT.PUT_LINE('Média Salarial dos atletas: ' || round(v_media, 2));
    FOR r_atleta IN c_atleta
        LOOP
            IF r_atleta.salario > v_media THEN
                DBMS_OUTPUT.PUT_LINE('Id: ' || r_atleta.id || ', Nome: ' || r_atleta.nome
                    || ', CPF: ' || r_atleta.cpf || ', Salário: ' || r_atleta.salario || ', Ganha MAIS que a
        média');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Id: ' || r_atleta.id || ', Nome: ' || r_atleta.nome
                    || ', CPF: ' || r_atleta.cpf || ', Salário: ' || r_atleta.salario || ', Ganha MENOS que a
        média');
            END IF;
        END LOOP;
END;

/*2. Adapte o exercício 1, só que agora verifique se os atletas
ganham acima ou não da média salarial do clube a que
pertencem.*/

DECLARE
    v_media number;
    CURSOR c_atl IS
        select id, nome, cpf, salario, id_clube
        from atleta
        where id_clube is not null;
BEGIN
    FOR r_atl IN c_atl
        LOOP
            SELECT avg(salario) INTO v_media FROM atleta WHERE id_clube = r_atl.id_clube;
            DBMS_OUTPUT.PUT_LINE('M?dia Salarial do Clube: ' || round(v_media, 2));

            IF r_atl.salario > v_media THEN
                DBMS_OUTPUT.PUT_LINE('ID: ' || r_atl.id || ', Nome: ' || r_atl.nome || ', CPF: '
                    || r_atl.cpf || ', Sal?rio: ' || r_atl.salario || ', Ganha MAIS que a m?dia do clube');
            ELSIF r_atl.salario < v_media THEN
                DBMS_OUTPUT.PUT_LINE('ID: ' || r_atl.id || ', Nome: ' || r_atl.nome || ', CPF: '
                    || r_atl.cpf || ', Sal?rio: ' || r_atl.salario || ', Ganha MENOS que a m?dia do clube');
            ELSE
                DBMS_OUTPUT.PUT_LINE('ID: ' || r_atl.id || ', Nome: ' || r_atl.nome || ', CPF: '
                    || r_atl.cpf || ', Sal?rio: ' || r_atl.salario || ', Ganha IGUAL ? m?dia do clube');
            END IF;
        END LOOP;
END;

/*3. Escreva um programa que inverta os salários dos atletas Ringo
Vidgeon e Merwyn Sivills. No final, exiba uma mensagem
informando que a troca foi feita.*/

DECLARE
    v_sal_a1 ATLETA.SALARIO%TYPE;
    v_sal_a2 ATLETA.SALARIO%TYPE;
BEGIN
    -- Recupera os sal?rios atuais
    SELECT salario INTO v_sal_a1 FROM atleta WHERE nome = 'Ringo Vidgeon';
    SELECT salario INTO v_sal_a2 FROM atleta WHERE nome = 'Merwyn Sivills';
    DBMS_OUTPUT.PUT_LINE('Salario de Ringo Vidgeon: ' || v_sal_a1);
    DBMS_OUTPUT.PUT_LINE('Salario de Merwyn Sivills: ' || v_sal_a2);
    -- Atualiza os sal?rios
    UPDATE atleta SET salario = v_sal_a2 WHERE nome = 'Ringo Vidgeon';
    UPDATE atleta SET salario = v_sal_a1 WHERE nome = 'Merwyn Sivills';
    DBMS_OUTPUT.PUT_LINE('Troca realizada com sucesso!');
    -- Lista os sal?rios atualizados
    SELECT salario INTO v_sal_a1 FROM atleta WHERE nome = 'Ringo Vidgeon';
    SELECT salario INTO v_sal_a2 FROM atleta WHERE nome = 'Merwyn Sivills';
    DBMS_OUTPUT.PUT_LINE('Salario de Ringo Vidgeon: ' || v_sal_a1);
    DBMS_OUTPUT.PUT_LINE('Salario de Merwyn Sivills: ' || v_sal_a2);
END;

/*4. Escreva um programa que atualize o salário e endereço do
atleta de ID 15 com os dados do atleta cujo nome comece com
Grace. Se não houver nenhuma Grace, o salário deve ser o
salário médio dos atletas, e o endereço deve ser nulo.*/

DECLARE
    CURSOR c_atl IS SELECT salario, endereco
                    FROM atleta
                    WHERE nome like 'Grace%';
    v_sal   atleta.salario%TYPE;
    v_end   atleta.endereco%TYPE;
    v_media NUMBER;
BEGIN
    OPEN c_atl;
    FETCH c_atl INTO v_sal, v_end;
    IF c_atl%NOTFOUND THEN
        SELECT avg(salario) INTO v_media FROM atleta;
        UPDATE atleta
        SET salario  = v_media,
            endereco = null
        WHERE id = 15;
    ELSE
        UPDATE atleta
        SET salario  = v_sal,
            endereco = v_end
        WHERE id = 15;
    END IF;
    CLOSE c_atl;
    DBMS_OUTPUT.PUT_LINE('Dados atualizados com sucesso!');
END;

select id, nome, salario, endereco
from atleta
where id = 15
   Or nome like 'Grace%';

-- Resolvendo sem cursor
DECLARE
    v_sal   atleta.salario%TYPE;
    v_end   atleta.endereco%TYPE;
    v_media NUMBER;
BEGIN
    SELECT salario, endereco
    INTO v_sal, v_end
    FROM atleta
    WHERE nome like 'Grace%';

    UPDATE atleta
    SET salario  = v_sal,
        endereco = v_end
    WHERE id = 15;
    DBMS_OUTPUT.PUT_LINE('Atleta encontrado. Dados atualizados com sucesso!');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        SELECT avg(salario) INTO v_media FROM atleta;

        UPDATE atleta
        SET salario  = v_media,
            endereco = null
        WHERE id = 15;

        DBMS_OUTPUT.PUT_LINE('Atleta n?o encontrado. Dados atualizados com sucesso!');

    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('H? mais de um atleta com o nome selecionado!');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro : ' || sqlerrm);
END;

/*5. Faça um programa que liste os centros de treinamento de cada clube,
conforme o modelo a seguir:
Centros de Treinamento do Clube 1 - Bigtax Team
Cidade: Littleton, UF: CO
Cidade: Boise, UF: ID
Centros de Treinamento do Clube 2 - Prodder Club
Cidade: Fargo, UF: ND
Centros de Treinamento do Clube 3 - Itil Club
Cidade: Fort Lauderdale, UF: FL
Centros de Treinamento do Clube 4 - Trippledex Club
Cidade: Anchorage, UF: AK
Cidade: Honolulu, UF: HI
Centros de Treinamento do Clube 5 - Jabbing Club
Cidade: Atlanta, UF: GA
Centros de Treinamento do Clube 6 - Bamity Team
Cidade: Atlanta, UF: GA
Cidade: Philadelphia, UF: PA*/

DECLARE
    v_aux NUMBER := -1;
    CURSOR c_clube IS
        SELECT c.id, c.nome, ct.*
        FROM clube c
                 JOIN centro_treinamento ct ON c.id = ct.id_clube
        ORDER BY c.id;
BEGIN
    FOR r_clube in c_clube
        LOOP
            if v_aux <> r_clube.id then
                DBMS_OUTPUT.PUT_LINE('CTs do clube: ' || r_clube.id || ' - ' || r_clube.nome);
            end if;
            DBMS_OUTPUT.PUT_LINE('  Cidade: ' || r_clube.cidade || ', UF: ' || r_clube.uf);
            v_aux := r_clube.id;
        END LOOP;
END;


/* Aula 07 - Procedures e Functions */

CREATE OR REPLACE PROCEDURE PR_ALTERA_ATLETA_END_CLUBE(
    p_id IN atleta.id%TYPE, p_end IN atleta.endereco%TYPE,
    p_clube atleta.id_clube%type) IS
    v_aux number;
BEGIN
    -- Verifica se o atleta existe
    SELECT count(*) INTO v_aux FROM atleta WHERE id = p_id;
    -- Se existir (v_aux > 0) então atualiza as informações
    IF v_aux > 0 THEN
        UPDATE atleta
        SET endereco = p_end,
            id_clube = p_clube
        WHERE id = p_id;
        DBMS_OUTPUT.PUT_LINE('Endereço do atleta atualizado com sucesso!');
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro:' || sqlerrm);
        ROLLBACK;
END PR_ALTERA_ATLETA_END_CLUBE;

/*PARA CHAMARMOS A PROCEDURE NA APLICAÇÃO:*/

EXEC PR_ALTERA_ATLETA_END_CLUBE(20, 'Rua do IFSP, 335', 14);
-- OU
CALL PR_ALTERA_ATLETA_END_CLUBE(20, 'Rua do IFSP, 325', 14);

select *
from atleta
where id = 20;

CALL PR_ALTERA_ATLETA_END_CLUBE(120, 'Rua do IFSP, 325', 14); /* ELE VAI ACEITAR */

EXEC PR_ALTERA_ATLETA_END_CLUBE(p_end => 'Rua do IFSP Novo', p_clube => 13, p_id => 20);

select *
from atleta
where id = 20;

EXEC PR_ALTERA_ATLETA_END_CLUBE(20, p_clube => 13, p_end => 'Rua do IFSP Novo');

select *
from atleta
where id = 20;

DROP PROCEDURE PR_ALTERA_ATLETA_END_CLUBE;

/*========================================================================================================*/

CREATE OR REPLACE PROCEDURE PR_SAL_CLUBE(p_clube IN atleta.id_clube%TYPE, p_media_sal OUT number) IS
BEGIN
    -- Retorna a média salarial dos atletas do clube informado
    SELECT avg(salario)
    INTO p_media_sal
    FROM atleta
    WHERE id_clube = p_clube;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || sqlerrm);
END PR_SAL_CLUBE;

DECLARE
    v_clube number := 10;
    v_media number;
BEGIN
    pr_sal_clube(v_clube, v_media);
    DBMS_OUTPUT.PUT_LINE('A média salarial do clube' || v_clube || 'é' || v_media);
END;

/*========================================================================================================*/

CREATE OR REPLACE PROCEDURE PR_TROCA_VAL(p_valor1 IN OUT number, p_valor2 IN OUT number) IS
    v_aux number;
BEGIN
    v_aux := p_valor1;
    p_valor1 := p_valor2;
    p_valor2 := v_aux;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || sqlerrm);
END PR_TROCA_VAL;

DECLARE
    v_val1 number := 5;
    v_val2 number := 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Valor de v_val1: ' || v_val1 || ', Valor de
    v_val2: ' || v_val2);
    DBMS_OUTPUT.PUT_LINE('Chamando a procedure PR_TROCA_VAL...');
    PR_TROCA_VAL(v_val1, v_val2);
    DBMS_OUTPUT.PUT_LINE('Valor de v_val1: ' || v_val1 || ', Valor de
    v_val2: ' || v_val2);
END;

/*========================================================================================================*/

CREATE OR REPLACE PROCEDURE pr_altera_dados(p_id IN atleta.id%TYPE,
                                            p_nome IN atleta.nome%TYPE, p_sal IN atleta.salario%TYPE default 1000,
                                            p_cpf IN atleta.cpf%TYPE, p_dtnasc atleta.datanasc%TYPE) IS
    v_aux number;
BEGIN
    SELECT count(*) INTO v_aux FROM atleta WHERE id = p_id;
    IF v_aux > 0 THEN
        UPDATE atleta
        SET nome     = p_nome,
            salario  = p_sal,
            datanasc = p_dtnasc,
            cpf      = p_cpf
        WHERE id = p_id;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Atleta atualizado com sucesso!');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro!');
END pr_altera_dados;

EXEC pr_altera_dados (18, 'Teste', p_cpf => '444', p_dtnasc=> to_date('10/02/1995','dd/mm/yyyy'));

/* ================================================ Exemplo de uma função: ================================================*/

CREATE FUNCTION area_circulo(p_raio IN NUMBER) RETURN NUMBER AS
    v_pi   NUMBER := 3.1415926;
    v_area NUMBER;
BEGIN
    -- cálculo da área
    v_area := v_pi * (p_raio * p_raio);
    RETURN v_area;
END area_circulo;

SELECT area_circulo(2)
FROM dual;
SELECT area_circulo(p_raio => 4)
FROM dual;

/* Para apagar uma função do banco Oracle, utilizamos o
comando DROP FUNCTION:*/
DROP FUNCTION area_circulo;

/* Outro exemplo de função:*/
-- Função que retorna a média salarial dos atletas de um clube
CREATE FUNCTION FU_GET_MEDIA_SAL(p_clube atleta.id_clube%type) RETURN number IS
    v_media number;
BEGIN
    SELECT AVG(salario) INTO v_media FROM atleta WHERE id_clube = p_clube;
    RETURN v_media;
END FU_GET_MEDIA_SAL;

-- Chamada para um clube específico
SELECT FU_GET_MEDIA_SAL(8) as MEDIA_SAL_CLUBE
FROM dual;

-- Chamada para todos os clubes da tabela
SELECT id, nome, round(fu_get_media_sal(id), 2) media_sal_atletas
FROM clube;

-- Exercícios da aula

/*
1. Crie uma função chamada FU_GET_PREMIACAO_ATLETA_PERIODO
que receba por parâmetros o nome de um atleta, uma data inicial e uma
data final, retornando o valor total (arredondado para 2 casas decimais)
de premiação ganho por ele nos campeonatos disputados no período
indicado. A data final poderá ser omitida na execução da função e, nesse
caso, o valor padrão deve ser sysdate. Depois de criada a função, faça
uma consulta para utilizá-la para um atleta já exista na tabela e um
período qualquer que desejar informando data inicial e data final, e uma
outra consulta para utilizá-la informando apenas o nome do atleta e uma
data inicial, omiƟndo a data final.
*/
CREATE OR REPLACE FUNCTION FU_GET_PREMIACAO_ATLETA_PERIODO(
    P_NOME_ATLETA VARCHAR2,
    P_DATA_INICIAL DATE,
    P_DATA_FINAL DATE DEFAULT SYSDATE
)
    RETURN NUMBER
    IS
    V_TOTAL_PREMIACAO NUMBER := 0;
BEGIN
    -- Consultar o valor total de premiação para o atleta e período
    SELECT ROUND(SUM(P.PREMIACAO), 2)
    INTO V_TOTAL_PREMIACAO
    FROM CAMPEONATO C
             JOIN ATLETA A ON C.ATLETA_ID = A.ID
             JOIN PREMIACOES P ON C.CAMPEONATO_ID = P.CAMPEONATO_ID
    WHERE A.NOME = P_NOME_ATLETA
      AND C.DATA_CAMPEONATO BETWEEN P_DATA_INICIAL AND P_DATA_FINAL;

    RETURN NVL(V_TOTAL_PREMIACAO, 0);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;

SELECT FU_GET_PREMIACAO_ATLETA_PERIODO('Nome do Atleta', TO_DATE('2023-01-01', 'YYYY-MM-DD'),
                                       TO_DATE('2023-12-31', 'YYYY-MM-DD'))
FROM DUAL;

SELECT FU_GET_PREMIACAO_ATLETA_PERIODO('Nome do Atleta', TO_DATE('2023-01-01', 'YYYY-MM-DD'))
FROM DUAL;

/*
 2. Crie uma procedure chamada PR_GET_INFO_CLUBE que, dado o nome
de um clube, devolva como saídas a média de idade dos atletas
pertencentes ao clube, a folha salarial desse clube e a quantidade de
atletas que possui. Depois, monte um bloco PL/SQL para executar essa
procedure para um clube específico. Por fim, faça um novo bloco PL/SQL
que chame a procedure para todos os clubes cadastrados.
*/

CREATE OR REPLACE PROCEDURE PR_GET_INFO_CLUBE(
    P_NOME_CLUBE IN VARCHAR2,
    P_MEDIA_IDADE OUT NUMBER,
    P_FOLHA_SALARIAL OUT NUMBER,
    P_QUANTIDADE_ATLETAS OUT NUMBER
)
    IS
BEGIN
    -- Média de idade dos atletas pertencentes ao clube
    SELECT ROUND(AVG(A.IDADE), 2)
    INTO P_MEDIA_IDADE
    FROM ATLETAS A
             JOIN CLUBES C ON A.CLUBE_ID = C.ID
    WHERE C.NOME = P_NOME_CLUBE;

    -- Folha salarial do clube (soma dos salários dos atletas)
    SELECT SUM(A.SALARIO)
    INTO P_FOLHA_SALARIAL
    FROM ATLETAS A
             JOIN CLUBES C ON A.CLUBE_ID = C.ID
    WHERE C.NOME = P_NOME_CLUBE;

    -- Quantidade de atletas no clube
    SELECT COUNT(A.ID)
    INTO P_QUANTIDADE_ATLETAS
    FROM ATLETAS A
             JOIN CLUBES C ON A.CLUBE_ID = C.ID
    WHERE C.NOME = P_NOME_CLUBE;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        P_MEDIA_IDADE := 0;
        P_FOLHA_SALARIAL := 0;
        P_QUANTIDADE_ATLETAS := 0;
END PR_GET_INFO_CLUBE;


DECLARE
    V_MEDIA_IDADE        NUMBER;
    V_FOLHA_SALARIAL     NUMBER;
    V_QUANTIDADE_ATLETAS NUMBER;
BEGIN
    PR_GET_INFO_CLUBE('Clube Exemplo', V_MEDIA_IDADE, V_FOLHA_SALARIAL, V_QUANTIDADE_ATLETAS);

    DBMS_OUTPUT.PUT_LINE('Média de Idade: ' || V_MEDIA_IDADE);
    DBMS_OUTPUT.PUT_LINE('Folha Salarial: ' || V_FOLHA_SALARIAL);
    DBMS_OUTPUT.PUT_LINE('Quantidade de Atletas: ' || V_QUANTIDADE_ATLETAS);
END;


DECLARE
    CURSOR C_CLUBES IS
        SELECT NOME
        FROM CLUBES;
    V_NOME_CLUBE         CLUBES.NOME%TYPE;
    V_MEDIA_IDADE        NUMBER;
    V_FOLHA_SALARIAL     NUMBER;
    V_QUANTIDADE_ATLETAS NUMBER;
BEGIN
    OPEN C_CLUBES;
    LOOP
        FETCH C_CLUBES INTO V_NOME_CLUBE;
        EXIT WHEN C_CLUBES%NOTFOUND;

        -- Chama a procedure para cada clube
        PR_GET_INFO_CLUBE(V_NOME_CLUBE, V_MEDIA_IDADE, V_FOLHA_SALARIAL, V_QUANTIDADE_ATLETAS);

        -- Exibe os resultados para cada clube
        DBMS_OUTPUT.PUT_LINE('Clube: ' || V_NOME_CLUBE);
        DBMS_OUTPUT.PUT_LINE('Média de Idade: ' || V_MEDIA_IDADE);
        DBMS_OUTPUT.PUT_LINE('Folha Salarial: ' || V_FOLHA_SALARIAL);
        DBMS_OUTPUT.PUT_LINE('Quantidade de Atletas: ' || V_QUANTIDADE_ATLETAS);
        DBMS_OUTPUT.PUT_LINE('-------------------------------');
    END LOOP;

    CLOSE C_CLUBES;
END;


/* ============================================ AULA 08 ============================================ */

set serveroutput on;
--==========================================================================================================================
/*1. Faça uma função chamada fu_calcula_reajuste que receba por parâmetro o ID de um atleta e o percentual de reajuste do salário.
--A função deve aplicar o percentual de reajuste ao salário e retornar o novo salário calculado do atleta.
Depois, atualize o salário de algum atleta utilizando a função criada.*/

CREATE OR REPLACE FUNCTION fu_calcula_reajuste(p_id IN
                                                   atleta.id%TYPE, p_percentual IN number) RETURN number IS
    v_salario        atleta.salario%TYPE;
    v_valor_reajuste atleta.salario%TYPE;
BEGIN
    SELECT salario
    INTO v_salario
    FROM atleta
    WHERE id = p_id;
    v_valor_reajuste := v_salario * (1 + p_percentual / 100);
    RETURN v_valor_reajuste;
END fu_calcula_reajuste;

SELECT id, salario, fu_calcula_reajuste(id, 10)
FROM atleta;

SELECT id, salario, fu_calcula_reajuste(id, 10)
FROM atleta
where id = 13;

desc atleta;
--==========================================================================================================================
/*2. Faça uma procedure chamada PR_REAJUSTA_SAL_CLUBE que receba por parâmetro o id de um clube e o percentual de reajuste.
Aplique e atualize na tabela o salário dos atletas do clube passado por parâmetro, aplicando o % de reajuste informado.
Utilize cursor para resolver o exercício e treinar sua utilização.
Depois, execute a procedure reajustando os salários dos atletas de algum clube.*/

create or replace procedure PR_REAJUSTA_SAL_CLUBE(p_id IN clube.id%TYPE, p_reajuste IN number) as

    cursor c_atletas is select *
                        from atleta
                        where id_clube = p_id;
begin
    for reg_atleta in c_atletas
        loop
            update atleta
            set salario= reg_atleta.salario + reg_atleta.salario * p_reajuste / 100
            where id = reg_atleta.id;
        end loop;
    commit;
exception
    when others then
        dbms_output.put_line('Erro: ' || sqlerrm);
        rollback;
end PR_REAJUSTA_SAL_CLUBE;

select *
from atleta
where id_clube = 1;
exec PR_REAJUSTA_SAL_CLUBE(1, 10);
--==========================================================================================================================
/*3. Faça uma procedure chamada pr_calcula_reajuste2 que transforme a função feita no exercício 1 em uma procedure.
Acrescente um parâmetro de saída que recebe o novo salário do atleta. Crie um bloco PL/SQL para chamar a procedure.*/

create or replace procedure pr_calcula_reajuste2(p_id IN atleta.id%TYPE, p_percentual IN number,
                                                 p_novosal OUT atleta.salario%TYPE) as
    v_salario atleta.salario%TYPE;
begin
    select salario into v_salario from atleta where id = p_id;
    p_novosal := v_salario * (1 + p_percentual / 100);
exception
    when no_data_found then
        dbms_output.put_line('Atleta não encontrado!');
    when others then
        dbms_output.put_line('Err:' || sqlerrm);
        rollback;
end pr_calcula_reajuste2;


select *
from atleta
where id = 20;

declare
    v_novo atleta.salario%TYPE;
begin
    pr_calcula_reajuste2(20, 5, v_novo);
    dbms_output.put_line('Novo salario:' || v_novo);
end;

--==========================================================================================================================
/*4. Faça uma procedure chamada PR_VAGAS_CLUBE que receba por parâmetro 3 IDs de clubes. A procedure deve retornar o número de vagas  para atletas paraolímpicos disponíveis em cada clube, conforme a regra abaixo:
Clubes de ID 1 a 10 podem ter até 3 atletas paraolímpicos;
Clubes de ID 11 a 20 podem ter até 4 atletas paraolímpicos;
Clubes de ID 21 a 30 podem ter até 5 atletas paraolímpicos;
A procedure deve permitir que o usuário a execute informando um, dois ou  três IDs de clubes, ou seja, o segundo e terceiro parâmetros devem ser opcionais. Execute a procedure várias vezes, informando 1, 2 e 3 IDs de clubes.
Exemplo de saída esperada:
Vagas paraolímpicas para o clube 11: 2*/

CREATE OR REPLACE PROCEDURE PR_VAGAS_PARAOL(p_clube1 IN atleta.id_clube%TYPE,
                                            p_clube2 IN atleta.id_clube%TYPE default 0,
                                            p_clube3 IN atleta.id_clube%TYPE default 0) IS
    CURSOR c_vagas IS
        SELECT id_clube, count(*) AS qtde
        FROM atleta a,
             paraolimpico p
        WHERE id_clube IN (p_clube1, p_clube2, p_clube3)
          and p.id_atleta = a.id
        GROUP BY id_clube
        ORDER BY id_clube;
BEGIN
    FOR r_vagas IN c_vagas
        LOOP
            IF r_vagas.id_clube BETWEEN 1 AND 10 THEN
                DBMS_OUTPUT.PUT_LINE('Vagas paraolímpicas para o clube ' || r_vagas.id_clube || ': ' ||
                                     to_char(3 - r_vagas.qtde));
            ELSIF r_vagas.id_clube BETWEEN 11 AND 20 THEN
                DBMS_OUTPUT.PUT_LINE('Vagas paraolímpicas para o clube ' || r_vagas.id_clube || ': ' ||
                                     to_char(4 - r_vagas.qtde));
            ELSIF r_vagas.id_clube BETWEEN 21 AND 30 THEN
                DBMS_OUTPUT.PUT_LINE('Vagas paraolímpicas para o clube ' || r_vagas.id_clube || ': ' ||
                                     to_char(5 - r_vagas.qtde));
            ELSE
                DBMS_OUTPUT.PUT_LINE('Clube ' || r_vagas.id_clube || ' não encontrado!');
            END IF;
        END LOOP;
END PR_VAGAS_PARAOL;

EXEC PR_VAGAS_PARAOL (4, 26);

--==========================================================================================================================
/*5. Modifique o exercício 4, criando agora uma função auxiliar chamada FU_VAGAS_PARAOL, que recebe por parâmetro o ID de um clube e a
quantidade de atletas paraolímpicos desse clube, retornando o número de vagas paraolímpicas disponíveis para o clube, seguindo a mesma regra do exercício anterior.
Modifique a procedure criada anteriormente, fazendo agora uso da função FU_VAGAS_PARAOL dentro da procedure para auxiliar no cálculo das vagas disponíveis.
Caso não queira substituir a procedure anterior, pode modificá-la e salvá-la como PR_VAGAS_CLUBE2.
Execute a procedure algumas vezes, informando IDs de clubes distintos, certificando-se que funciona.*/

create or replace function FU_VAGAS_PARAOL(p_id IN clube.id%TYPE, p_vagas IN number) return number is
BEGIN
    IF (p_id BETWEEN 1 AND 10) and (p_vagas <= 3) THEN
        return 3 - p_vagas;
    ELSIF (p_id BETWEEN 11 AND 20) and (p_vagas <= 4) THEN
        return 4 - p_vagas;
    ELSIF (p_vagas <= 5) THEN
        return 5 - p_vagas;
    END IF;
end FU_VAGAS_PARAOL;

CREATE OR REPLACE PROCEDURE PR_VAGAS_PARAOL2(p_clube1 IN atleta.id_clube%TYPE,
                                             p_clube2 IN atleta.id_clube%TYPE default 0,
                                             p_clube3 IN atleta.id_clube%TYPE default 0) IS
    CURSOR c_vagas IS
        SELECT id_clube, count(*) AS qtde
        FROM atleta a,
             paraolimpico p
        WHERE id_clube IN (p_clube1, p_clube2, p_clube3)
          and p.id_atleta = a.id
        GROUP BY id_clube
        ORDER BY id_clube;

BEGIN
    FOR r_vagas IN c_vagas
        LOOP
            DBMS_OUTPUT.PUT_LINE('Vagas paraolímpicas para o clube ' || r_vagas.id_clube || ': ' ||
                                 to_char(FU_VAGAS_PARAOL(r_vagas.id_clube, r_vagas.qtde)));
        END LOOP;
END PR_VAGAS_PARAOL2;

exec PR_VAGAS_PARAOL2(4);

--==========================================================================================================================
/*6. Faça uma procedure chamada PR_CLUBE_FONE_CT que recebe por parâmetro o ID de um clube e escreva na tela o seu nome e o(s) seu(s)
telefone(s) dos centro(s) de treinamento.
Um exemplo de execução ao informar o clube 17 seria:
Clube: Alpha Team
    Telefone 1: (212) 5469699
    Telefone 2: (314) 7800399*/

--Note que o nome do clube deve aparecer somente uma vez, ainda que ele possua várias telefones nos centros de treinamentos.
--Os telefones devem vir numerados sequencialmente, conforme o exemplo.

desc centro_treinamento;

create or replace procedure PR_CLUBE_FONE_CT(p_id IN clube.id%TYPE) is
    cursor c_centros is select fone
                        from centro_treinamento
                        where id_clube = p_id;
    v_cont     number;
    nome_clube clube.nome%TYPE;

begin
    select nome into nome_clube from clube where id = p_id;
    dbms_output.put_line('Clube: ' || nome_clube);
    v_cont := 1;
    for reg_centro in c_centros
        loop
            dbms_output.put_line('Telefone ' || to_char(v_cont) || ':' || reg_centro.fone);
            v_cont := v_cont + 1;
        end loop;
exception
    when no_data_found then
        dbms_output.put_line('Clube não encontrado!');
    when others then
        dbms_output.put_line('Erro:' || sqlerrm);
end PR_CLUBE_FONE_CT;

select *
from centro_treinamento
order by id_clube;
select nome
from clube
where id = 7;
select *
from centro_treinamento
where id_clube = 7
order by id_clube;
exec PR_CLUBE_FONE_CT(50);

--==========================================================================================================================
/*7. Faça uma procedure chamada PR_ATLETA_EXP que recebe por parâmetro a descrição de uma modalidade esportiva e um tempo de experiência.
--Então, liste os nomes dos atletas que praticam essa modalidade e que têm experiência maior ou igual à informada e os que a praticam e
--têm experiência menor que a informada. Utilize apenas um cursor.*/

--Um exemplo de execução ao informar a modalidade Swimming e 20 anos de experiência seria:
--Possuem mais ou igual a 20 anos de experiência:
--    Ringo Vidgeon - 30,6 anos
--    Shurwood Soan - 27,5 anos
--    Leandra Piner - 27,4 anos

--Possuem menos que 20 anos de experiência:
--    Lancelot Apdell - 19,2 anos
--    Averill Drogan - 13,7 anos

--Note que o cabeçalho deve aparecer somente uma vez para quem possui mais ou igual a 20 anos de experiência e uma vez apenas para quem possui até 20 anos de experiência na modalidade.
select a.nome, p.experiencia
from atleta a,
     modalidade m,
     pratica p
where a.id = p.id_atleta
  and m.id = p.id_modalidade
  and m.descricao like 'Swimming'
order by experiencia desc;

create or replace procedure PR_ATLETA_EXP(p_modalidade IN modalidade.descricao%TYPE,
                                          p_exp IN pratica.experiencia%TYPE) is
    cursor c_modalidade is select a.nome, p.experiencia
                           from atleta a,
                                modalidade m,
                                pratica p
                           where a.id = p.id_atleta
                             and m.id = p.id_modalidade
                             and m.descricao like p_modalidade
                           order by experiencia desc;
    v_flag number := 0;
begin
    for reg_mod in c_modalidade
        loop
            if reg_mod.experiencia >= p_exp and v_flag = 0 then
                dbms_output.put_line('Possuem mais ou igual a ' || to_char(p_exp) || ' anos de experiência:');
                v_flag := v_flag + 1;
            elsif reg_mod.experiencia < p_exp and v_flag >= 0 then
                dbms_output.put_line('Possuem menos que ' || to_char(p_exp) || ' anos de experiência:');
                v_flag := -1;
            end if;
            dbms_output.put_line(reg_mod.nome || '-' || to_char(reg_mod.experiencia) || ' anos');
        end loop;
end PR_ATLETA_EXP;

EXEC PR_ATLETA_EXP('Swimming', 20);
EXEC PR_ATLETA_EXP('Running', 18);

--==========================================================================================================================
/*8. Faça uma procedure chamada PR_PREMIO_CAMP que receba 1 parâmetro de entrada (número do campeonato) e 2 parâmetros de saída (nome do campeonato e total em premiação do campeonato).
Depois, monte um bloco PL/SQL que chame a procedure criada e imprima na tela o ID do campeonato, seu nome e o total em premiação dada no campeonato.*/


CREATE OR REPLACE PROCEDURE PR_PREMIO_CAMP(
    p_camp IN campeonato.id%type, p_nome OUT campeonato.nome%type,
    p_premiacao OUT number
) IS
BEGIN
    SELECT c.nome, SUM(p.valor_premiacao)
    INTO p_nome, p_premiacao
    FROM participa p
             JOIN campeonato c
                  ON p.id_campeonato = c.id AND c.id = p_camp
    GROUP BY c.nome;
END PR_PREMIO_CAMP;

DECLARE
    v_idcamp    campeonato.id%TYPE;
    v_nomecamp  campeonato.nome%TYPE;
    v_premiacao number;
BEGIN
    v_idcamp := 10;
    PR_PREMIO_CAMP(v_idcamp, v_nomecamp, v_premiacao);
    DBMS_OUTPUT.PUT_LINE(' ID do Campeonato: ' || v_idcamp || ', Nome: ' || v_nomecamp || ', Total em Premiação: ' ||
                         v_premiacao);
END;

--==========================================================================================================================

/*9. Faça uma procedure chamada PR_ATUALIZA_CLUBE que receba os parâmetros de entrada:
Modo de alteração: deve ser A para Atualizar e R para Remover
ID do clube: obrigatório
Nome do clube: opcional (pode ser usado no modo A)
Data de fundação: opcional (pode ser usado no modo A)
Id do presidente: opcional (pode ser usado no modo A)

Caso seja passado A no primeiro parâmetro, a procedure deve verificar se o clube existe (por meio do ID). Caso sim, atualize suas informações, caso não, insira o novo clube.
Se o parâmetro for R, o clube deve ser removido da tabela.*/


CREATE OR REPLACE PROCEDURE PR_ATUALIZA_CLUBE(
    p_modo IN char, p_clube IN clube.id%TYPE, p_nome IN clube.nome%TYPE default null,
    p_fundacao IN clube.data_fundacao%TYPE default null, p_presidente clube.id_presidente%TYPE default null) IS
    v_clube clube%ROWTYPE;
BEGIN
    IF upper(p_modo) = 'A' THEN
        BEGIN
            SELECT * INTO v_clube FROM clube WHERE id = p_clube; -- Seleciona a tupla toda referente ao clube
            UPDATE clube
            SET nome          = NVL(p_nome, v_clube.nome),
                data_fundacao = NVL(p_fundacao, v_clube.data_fundacao),
                id_presidente = NVL(p_presidente, v_clube.id_presidente)
            WHERE id = p_clube;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Clube atualizado com sucesso!');
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                INSERT INTO clube VALUES (p_clube, p_nome, p_fundacao, p_presidente);
                COMMIT;
                DBMS_OUTPUT.PUT_LINE('Clube inserido com sucesso!');
        END;
    ELSIF upper(p_modo) = 'R' THEN
        DELETE FROM clube WHERE id = p_clube;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Clube removido com sucesso!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Modo inválido! Informe A para Atualização ou R para Remoção de um clube');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || sqlerrm);
END PR_ATUALIZA_CLUBE;

EXEC PR_ATUALIZA_CLUBE('A',30,'Teste de nome');
EXEC PR_ATUALIZA_CLUBE('A',30,'Teste de nome','03/09/1981');
EXEC PR_ATUALIZA_CLUBE('A',30,'Teste de nome','03/09/1981',21);
EXEC PR_ATUALIZA_CLUBE('R',30);

--==========================================================================================================================
/*10. Faça uma função que receba o ID de um atleta por parâmetro e retorne o valor do imposto devido pelo atleta.
O valor do imposto é calculado com base no salário anual do atleta, seguindo as regras:
Se o salário anual for maior/igual a 500.000, o imposto é de 30%.
Se o salário anual for maior/igual a 250.000, o imposto é de 20%.
Se o salário anual for maior/igual a 100.000, o imposto é de 10%.
Se o salário anual for menor do que 100.000, o imposto é de 5%.

Depois, faça uma consulta SQL que retorne o ID, nome, salário, salário anual e o valor do imposto devido pelos atletas.*/


CREATE OR REPLACE FUNCTION FU_CALC_IMPOSTO_ATLETA(p_id IN atleta.id%TYPE)
    RETURN number IS
    v_sal number;
BEGIN
    SELECT salario * 12 INTO v_sal FROM atleta WHERE id = p_id;
    IF v_sal >= 500000 THEN
        RETURN v_sal * 0.3;
    ELSIF v_sal >= 250000 THEN
        RETURN v_sal * 0.2;
    ELSIF v_sal >= 100000 THEN
        RETURN v_sal * 0.1;
    ELSE
        RETURN v_sal * 0.05;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Atleta não encontrado!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro! ' || sqlerrm);
END FU_CALC_IMPOSTO_ATLETA;

-- Consulta para mostrar as informações solicitadas:
SELECT id,
       nome,
       salario,
       round(salario * 12, 2)     AS salario_anual,
       FU_CALC_IMPOSTO_ATLETA(id) as imposto
FROM atleta;


-- Solução alternativa criando uma procedure com apenas um parâmetro do tipo IN OUT:
CREATE OR REPLACE PROCEDURE PR_CALC_IMPOSTO_ATLETA(p_id_imp IN OUT number) IS
BEGIN
    SELECT salario * 12 INTO p_id_imp FROM atleta WHERE id = p_id_imp;
    IF p_id_imp >= 500000 THEN
        p_id_imp := p_id_imp * 0.3;
    ELSIF p_id_imp >= 250000 THEN
        p_id_imp := p_id_imp * 0.2;
    ELSIF p_id_imp >= 100000 THEN
        p_id_imp := p_id_imp * 0.1;
    ELSE
        p_id_imp := p_id_imp * 0.05;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Empregado não encontrado!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro! ' || sqlerrm);
END PR_CALC_IMPOSTO_ATLETA;


-- Chamando para o atleta de ID para verificar que funciona:
DECLARE
    v_aux number;
BEGIN
    v_aux := 1;
    DBMS_OUTPUT.PUT_LINE('Valor de v_aux: ' || v_aux);
    pr_calc_imposto_emp(v_aux);
    DBMS_OUTPUT.PUT_LINE('Valor de v_aux: ' || v_aux);
END;

/*----------------------------- Triggers -----------------------------*/

ALTER TABLE atleta
    ADD data_ult_alt DATE;
ALTER TABLE atleta
    ADD user_ult_alt VARCHAR2(20);

CREATE OR REPLACE TRIGGER tr_registra_alteracao
    BEFORE INSERT OR UPDATE
    ON atleta
    FOR EACH ROW
BEGIN
    :new.data_ult_alt := sysdate;
    :new.user_ult_alt := user;
END tr_registra_alteracao;

UPDATE atleta
SET endereco = '123 Lar Doce Lar'
WHERE id = 15;

SELECT *
FROM atleta
WHERE id = 15;

INSERT INTO atleta (id, nome, cpf, salario, datanasc)
VALUES (118, 'Rocky Balboa', '567-00-1234', 30000, to_date('12-04-1978', 'dd-mm-yyyy'));

SELECT *
FROM atleta
WHERE id = 188;

CREATE TABLE audit_atleta_sal
(
    id_atleta  NUMBER(4),
    sal_antigo NUMBER(8, 2),
    sal_novo   NUMBER(8, 2),
    usuario    VARCHAR2(20),
    data_alt   TIMESTAMP,
    CONSTRAINT audit_atl_sal_pk PRIMARY KEY (id_atleta, data_alt),
    CONSTRAINT audit_atl_sal_id_fk FOREIGN KEY (id_atleta)
        REFERENCES atleta (id)
)

CREATE OR REPLACE TRIGGER tr_audit_atleta_sal
    BEFORE UPDATE OF salario
    ON atleta
    FOR EACH ROW
    WHEN (new.salario <> old.salario)
BEGIN
    DBMS_OUTPUT.PUT_LINE('Salário antigo: ' || old.salario);
    DBMS_OUTPUT.PUT_LINE('Salário novo: ' || new.salario);
    INSERT INTO audit_atleta_sal VALUES (:new.id, :old.salario, :new.salario, user, sysdate);
END tr_audit_atleta_sal;

UPDATE atleta
SET salario = 9000
WHERE id = 1;

COMMIT;

SELECT *
FROM audit_atleta_sal;
/*-------------------*/
UPDATE atleta
SET salario = 9000
WHERE id = 1;

COMMIT;

SELECT *
FROM audit_atleta_sal;
/*-------------------*/
UPDATE atleta
SET salario = 10000
WHERE id = 1;

COMMIT;

SELECT *
FROM audit_atleta_sal;

ALTER TABLE clube
    ADD qtde_atletas NUMBER DEFAULT 0;

UPDATE clube c
SET c.qtde_atletas = (SELECT count(*)
                      FROM atleta a
                      WHERE a.id_clube = c.id);

COMMIT;

CREATE OR REPLACE TRIGGER tr_set_qtde_atletas_clube
    BEFORE INSERT OR DELETE
    ON atleta
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE clube
        SET qtde_atletas = qtde_atletas + 1
        WHERE id = :new.id_clube;
        ELSEIF DELETING THEN
        UPDATE clube
        SET qtde_atletas = qtde_atletas - 1
        WHERE id = :old.id_clube;
    END IF;
END tr_set_qtde_atletas_clube;

SELECT *
FROM clube;

INSERT INTO atleta (id, nome, cpf, salario, datanasc, id_clube)
VALUES (119, 'Fernanda Venturini', '111-22-9876', 20000, to_date('21-09-1981', 'dd-mm-yyyy'), 3);

SELECT *
FROM clube;

DELETE
FROM atleta
WHERE id = 119;

SELECT *
FROM clube;

INSERT INTO atleta (id, nome, cpf, salario, datanasc, id_clube)
VALUES (121, 'Myke Tyson', '888-22-3333', 60000, to_date('01-04-1975', 'dd-mm-yyyy'), 5);

INSERT INTO atleta (id, nome, cpf, salario, datanasc, id_clube)
VALUES (122, 'Xuxa', '999-11-4321', 10000, to_date('27-03-1963', 'dd-mm-yyyy'), 5);


CREATE TABLE modalidade_log
(
    usuario  VARCHAR2(20),
    data_alt TIMESTAMP,
    operacao VARCHAR2(30),
    CONSTRAINT modalidade_log_pk PRIMARY KEY (usuario, data_alt)
)

CREATE OR REPLACE TRIGGER tr_modalidade_log_op
    AFTER INSERT OR DELETE OR UPDATE
    ON modalidade
DECLARE
    v_oper modalidade_log.operacao%type;
BEGIN
    IF INSERTING THEN
        v_oper := 'Inserçāo realizada';
        ELSEIF UPDATING THEN
        v_oper := 'Atualizaçāo realizada';
        ELSEIF DELETING THEN
        v_oper := 'Remoçāo realizada';
    END IF;
    INSERT INTO modalidade_log VALUES (user, sysdate, v_oper);
END tr_modalidade_log_op;

INSERT INTO modalidade (id, descricao, olimpica)
VALUES (30, 'Levantamento de Copo', 'S');

COMMIT;

SELECT *
FROM modalidade_log;

UPDATE modalidade
SET olimpica = 'N'
WHERE id = 30;

SELECT user, to_char(data_alt, 'dd/mm/yyyy HH:mi:ss') as data_hora, operacao
FROM modalidade_log;

CREATE OR REPLACE VIEW v_atleta_clube as
SELECT c.nome         nome_clube,
       a.id,
       a.nome         nome_atleta,
       a.salario * 12 sal_anual
FROM clube c
         JOIN atleta a ON c.id = a.id_clube
ORDER BY c.nome, a.nome;

UPDATE v_atleta_clube
SET sal_anual = 72000
WHERE id = 21; -- nāo vai rodar pois nāo é possível atualizar por meio de uma visāo assim

CREATE OR REPLACE TRIGGER tr_clube_atleta_sal
    INSTEAD OF UPDATE
    ON v_atleta_clube
    FOR EACH ROW
BEGIN
    IF :new.sal_anual <> old.sal_anual THEN
        UPDATE atleta
        SET salario = :new.sal_anual / 12
        WHERE id = :new.id;
    END IF;
END tr_clube_atleta_sal;

UPDATE v_atleta_clube
SET sal_anual = 72000
WHERE id = 21; -- agora roda pois foi criada a trigger que faz isso

SELECT *
FROM v_atleta_clube
WHERE id = 21;
SELECT *
FROM atleta
WHERE id = 21;

-- Para habilitar ou desabilitar um trigger:
ALTER TRIGGER nome_trigger ENABLE;

-- Para desabilitar um trigger:
ALTER TRIGGER nome_trigger DISABLE;

-- Para habilitar todos os triggers de uma tabela:
ALTER TABLE nome_tabela
    ENABLE ALL TRIGGERS;

-- Para desabilitar todos os triggers de uma tabela:
ALTER TABLE nome_tabela
    DISABLE ALL TRIGGERS;

-- Para eliminar um trigger:
DROP TRIGGER nome_trigger;

/*------------ Exercícios ------------*/
/*1. Considere as seguintes tabelas de um banco de dados relacional:
Cliente (cod, nome, qtde_locacoes)
Aluguel (nro, cod_cli, cod_filme, data_hora_emp, data_hora_dev)
Filme (cod, Ɵtulo, classificacao, qtde_locacoes)


Crie as tabelas acima, definindo Ɵpos e constraints adequadas. Coloque o valor default
0 para qtde_locações nas tabelas e sysdate para data_hora_emp na tabela Aluguel.
Os atributos qtde_locacoes são atributos derivados e devem ser atualizados por meio
de triggers.

O valor do atributo data_hora_dev deve ser atualizado conforme a classificação do
filme - Lançamento (1 dia) ou Normal (2 dias). Desenvolva um gaƟlho para gerar
corretamente este valor.

Teste os gatilhos por meio de inserções de dados na tabela Aluguel. Consulte todas as
tabelas para saber se funcionou.*/


/*2. Considere as seguintes tabelas de um banco de dados relacional:
Conta (nro_conta, nome_cliente, saldo)
Movimentacao (nro_conta,data_mov, Ɵpo, valor)

Crie as tabelas acima, definindo Ɵpos e constraints adequadas. Faça
uma check que permita somente ‘D’ ou ‘C’ para o Ɵpo de
movimentação referente a débito ou crédito, além de outra check que
verifique se o valor da movimentação é maior do que 0.

Se a movimentação for um crédito, o valor deve ser adicionado ao
saldo da conta. Se for um débito, deve ser subtraído do saldo.

Teste os gaƟlhos por meio de inserções de dados na tabela
Movimentação. Consulte as tabelas para saber se funcionou.*/


/*---------------- Packages e índices ----------------*/

CREATE OR REPLACE PACKAGE Esporte_Pkg as
    FUNCTION Get_Atletas_Clube(p_id_clube IN NUMBER)
        RETURN SYS_REFCURSOR;

    FUNCTION Count_Modalidade_By_Atleta(p_id_atleta IN NUMBER)
        RETURN NUMBER;

    PROCEDURE Add_Atleta(P_id IN atleta.id%TYPE,
                         p_nome IN atleta.nome%TYPE, p_cpf IN atleta.cpf%TYPE,
                         p_salario IN atleta.salario%type,
                         p_id_clube IN atleta.id_clube%TYPE);

    PROCEDURE Add_Clube(p_id IN clube.id%TYPE,
                        p_nome IN clube.nome%TYPE,
                        p_id_presidente IN clube.id_presidente%TYPE);
END Esporte_Pkg;