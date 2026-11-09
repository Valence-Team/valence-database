SET SERVEROUTPUT ON
SET VERIFY OFF

-- Limpeza dos dados de teste
DELETE FROM ALERTA;
DELETE FROM LAUDO;
DELETE FROM POST_MURAL;
DELETE FROM TRIAGEM;
DELETE FROM OCORRENCIA;
DELETE FROM PROPRIEDADE_CULTURA;
DELETE FROM PROPRIEDADE;
DELETE FROM USUARIO;
DELETE FROM AUDITORIA_OCORRENCIA;

-- Usuários
INSERT INTO USUARIO (ID, NOME, EMAIL, SENHA_HASH, PAPEL, TELEFONE, MUNICIPIO, UF, CRIADO_EM)
VALUES (1, 'Ana Zanella', 'ana.zanella@valence.local', '$2a$10$hash.ficticio.de.teste.valence.usuario.01', 'PRODUTOR', '(49) 90000-0001', 'Chapecó', 'SC', TIMESTAMP '2026-08-03 09:00:00');
INSERT INTO USUARIO (ID, NOME, EMAIL, SENHA_HASH, PAPEL, TELEFONE, MUNICIPIO, UF, CRIADO_EM)
VALUES (2, 'Bruno Dalla Costa', 'bruno.dallacosta@valence.local', '$2a$10$hash.ficticio.de.teste.valence.usuario.02', 'PRODUTOR', '(49) 90000-0002', 'Guatambu', 'SC', TIMESTAMP '2026-08-03 10:15:00');
INSERT INTO USUARIO (ID, NOME, EMAIL, SENHA_HASH, PAPEL, TELEFONE, MUNICIPIO, UF, CRIADO_EM)
VALUES (3, 'Carla Bertuol', 'carla.bertuol@valence.local', '$2a$10$hash.ficticio.de.teste.valence.usuario.03', 'PRODUTOR', '(49) 90000-0003', 'Cordilheira Alta', 'SC', TIMESTAMP '2026-08-05 14:20:00');
INSERT INTO USUARIO (ID, NOME, EMAIL, SENHA_HASH, PAPEL, TELEFONE, MUNICIPIO, UF, CRIADO_EM)
VALUES (4, 'Diego Fantin', 'diego.fantin@valence.local', '$2a$10$hash.ficticio.de.teste.valence.usuario.04', 'PRODUTOR', '(49) 90000-0004', 'Caçador', 'SC', TIMESTAMP '2026-08-10 08:30:00');
INSERT INTO USUARIO (ID, NOME, EMAIL, SENHA_HASH, PAPEL, TELEFONE, MUNICIPIO, UF, CRIADO_EM)
VALUES (5, 'Elisa Rech', 'elisa.rech@valence.local', '$2a$10$hash.ficticio.de.teste.valence.usuario.05', 'PRODUTOR', NULL, 'Caçador', 'SC', TIMESTAMP '2026-08-11 16:45:00');
INSERT INTO USUARIO (ID, NOME, EMAIL, SENHA_HASH, PAPEL, TELEFONE, MUNICIPIO, UF, CRIADO_EM)
VALUES (6, 'Fábio Mantovani', 'fabio.mantovani@valence.local', '$2a$10$hash.ficticio.de.teste.valence.usuario.06', 'PRODUTOR', '(19) 90000-0006', 'Vargem Grande do Sul', 'SP', TIMESTAMP '2026-08-12 07:50:00');
INSERT INTO USUARIO (ID, NOME, EMAIL, SENHA_HASH, PAPEL, TELEFONE, MUNICIPIO, UF, CRIADO_EM)
VALUES (7, 'Gabriela Prado', 'gabriela.prado@valence.local', '$2a$10$hash.ficticio.de.teste.valence.usuario.07', 'PRODUTOR', '(19) 90000-0007', 'Vargem Grande do Sul', 'SP', TIMESTAMP '2026-08-14 11:05:00');
INSERT INTO USUARIO (ID, NOME, EMAIL, SENHA_HASH, PAPEL, TELEFONE, MUNICIPIO, UF, CRIADO_EM)
VALUES (8, 'Helena Sartori', 'helena.sartori@valence.local', '$2a$10$hash.ficticio.de.teste.valence.usuario.08', 'AGRONOMO', '(49) 90000-0008', 'Chapecó', 'SC', TIMESTAMP '2026-08-01 08:00:00');
INSERT INTO USUARIO (ID, NOME, EMAIL, SENHA_HASH, PAPEL, TELEFONE, MUNICIPIO, UF, CRIADO_EM)
VALUES (9, 'Igor Teixeira', 'igor.teixeira@valence.local', '$2a$10$hash.ficticio.de.teste.valence.usuario.09', 'AGRONOMO', '(19) 90000-0009', 'Vargem Grande do Sul', 'SP', TIMESTAMP '2026-08-01 08:10:00');
INSERT INTO USUARIO (ID, NOME, EMAIL, SENHA_HASH, PAPEL, TELEFONE, MUNICIPIO, UF, CRIADO_EM)
VALUES (10, 'Juliana Moreira', 'juliana.moreira@valence.local', '$2a$10$hash.ficticio.de.teste.valence.usuario.10', 'GESTOR', NULL, 'Florianópolis', 'SC', TIMESTAMP '2026-08-01 08:20:00');

-- Propriedades
INSERT INTO PROPRIEDADE (ID, USUARIO_ID, NOME, MUNICIPIO, UF, LATITUDE, LONGITUDE, AREA_HECTARES, CRIADO_EM)
VALUES (11, 1, 'Sítio Linha Faxinal', 'Chapecó', 'SC', -27.085000, -52.640000, 18.50, TIMESTAMP '2026-08-03 09:10:00');
INSERT INTO PROPRIEDADE (ID, USUARIO_ID, NOME, MUNICIPIO, UF, LATITUDE, LONGITUDE, AREA_HECTARES, CRIADO_EM)
VALUES (12, 2, 'Sítio Dalla Costa', 'Guatambu', 'SC', -27.110000, -52.730000, 24.00, TIMESTAMP '2026-08-03 10:30:00');
INSERT INTO PROPRIEDADE (ID, USUARIO_ID, NOME, MUNICIPIO, UF, LATITUDE, LONGITUDE, AREA_HECTARES, CRIADO_EM)
VALUES (13, 3, 'Chácara Bertuol', 'Cordilheira Alta', 'SC', -27.030000, -52.610000, 12.30, TIMESTAMP '2026-08-05 14:40:00');
INSERT INTO PROPRIEDADE (ID, USUARIO_ID, NOME, MUNICIPIO, UF, LATITUDE, LONGITUDE, AREA_HECTARES, CRIADO_EM)
VALUES (14, 2, 'Sítio Serra Alta', 'Xaxim', 'SC', -26.960000, -52.530000, 9.80, TIMESTAMP '2026-08-04 15:00:00');
INSERT INTO PROPRIEDADE (ID, USUARIO_ID, NOME, MUNICIPIO, UF, LATITUDE, LONGITUDE, AREA_HECTARES, CRIADO_EM)
VALUES (15, 4, 'Sítio Fantin', 'Caçador', 'SC', -26.760000, -51.030000, 8.00, TIMESTAMP '2026-08-10 08:45:00');
INSERT INTO PROPRIEDADE (ID, USUARIO_ID, NOME, MUNICIPIO, UF, LATITUDE, LONGITUDE, AREA_HECTARES, CRIADO_EM)
VALUES (16, 5, 'Sítio Rech', 'Caçador', 'SC', -26.800000, -51.000000, 6.50, TIMESTAMP '2026-08-11 17:00:00');
INSERT INTO PROPRIEDADE (ID, USUARIO_ID, NOME, MUNICIPIO, UF, LATITUDE, LONGITUDE, AREA_HECTARES, CRIADO_EM)
VALUES (17, 5, 'Chácara Rio do Peixe', 'Caçador', 'SC', -26.780000, -51.045000, 4.20, TIMESTAMP '2026-08-11 17:20:00');
INSERT INTO PROPRIEDADE (ID, USUARIO_ID, NOME, MUNICIPIO, UF, LATITUDE, LONGITUDE, AREA_HECTARES, CRIADO_EM)
VALUES (18, 6, 'Fazenda Mantovani', 'Vargem Grande do Sul', 'SP', -21.820000, -46.880000, 32.00, TIMESTAMP '2026-08-12 08:05:00');
INSERT INTO PROPRIEDADE (ID, USUARIO_ID, NOME, MUNICIPIO, UF, LATITUDE, LONGITUDE, AREA_HECTARES, CRIADO_EM)
VALUES (19, 7, 'Sítio Prado', 'Vargem Grande do Sul', 'SP', -21.870000, -46.930000, 15.00, TIMESTAMP '2026-08-14 11:20:00');
INSERT INTO PROPRIEDADE (ID, USUARIO_ID, NOME, MUNICIPIO, UF, LATITUDE, LONGITUDE, AREA_HECTARES, CRIADO_EM)
VALUES (20, 6, 'Sítio Boa Vista', 'São João da Boa Vista', 'SP', -21.969000, -46.798000, 20.00, TIMESTAMP '2026-08-12 08:30:00');

-- Culturas das propriedades
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (11, 'MILHO');
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (12, 'MILHO');
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (13, 'MILHO');
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (14, 'MILHO');
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (15, 'TOMATE');
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (15, 'MILHO');
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (16, 'TOMATE');
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (17, 'MILHO');
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (18, 'BATATA');
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (19, 'BATATA');
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (19, 'TOMATE');
INSERT INTO PROPRIEDADE_CULTURA (PROPRIEDADE_ID, CULTURA) VALUES (20, 'BATATA');

-- Ocorrências registradas
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (101, 11, 1, 'MILHO', 'Folhas do cartucho com faixas amareladas e plantas menores que o normal. Muitos insetos pequenos e claros no cartucho.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000101', TIMESTAMP '2026-09-08 07:42:00', TIMESTAMP '2026-09-08 07:42:00');
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (102, 12, 2, 'MILHO', 'Folhas raspadas e furos no cartucho, com fezes de lagarta. Cerca de 20% das plantas da lavoura atingidas.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000102', TIMESTAMP '2026-09-22 08:10:00', TIMESTAMP '2026-09-22 08:10:00');
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (103, 13, 3, 'MILHO', 'Plantas com folhas avermelhadas nas pontas e espigas pequenas. Vi cigarrinhas nas folhas.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000103', TIMESTAMP '2026-10-06 16:05:00', TIMESTAMP '2026-10-06 16:05:00');
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (104, 11, 1, 'MILHO', 'Manchas alaranjadas nas folhas de baixo, parecidas com ferrugem, aparecendo depois das chuvas.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000104', TIMESTAMP '2026-10-20 07:30:00', TIMESTAMP '2026-10-20 07:30:00');
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (105, 15, 4, 'TOMATE', 'Manchas escuras e encharcadas nas folhas e nos frutos, com mofo branco embaixo das folhas depois de dias úmidos.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000105', TIMESTAMP '2026-09-15 06:50:00', TIMESTAMP '2026-09-15 06:50:00');
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (106, 16, 5, 'TOMATE', 'Folhas com minas transparentes e frutos com furos pequenos. Achei lagartinhas dentro dos frutos.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000106', TIMESTAMP '2026-10-02 09:20:00', TIMESTAMP '2026-10-02 09:20:00');
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (107, 15, 4, 'TOMATE', 'Muitos insetos brancos pequenos que voam quando mexo nas plantas, e folhas ficando amareladas.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000107', TIMESTAMP '2026-11-03 18:15:00', TIMESTAMP '2026-11-03 18:15:00');
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (108, 18, 6, 'BATATA', 'Manchas marrom-escuras nas folhas e hastes, com cheiro forte, espalhando rápido depois da garoa.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000108', TIMESTAMP '2026-09-10 07:05:00', TIMESTAMP '2026-09-10 07:05:00');
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (109, 19, 7, 'BATATA', 'Manchas circulares escuras com anéis nas folhas mais velhas, que estão secando de baixo para cima.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000109', TIMESTAMP '2026-10-12 08:40:00', TIMESTAMP '2026-10-12 08:40:00');
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (110, 20, 6, 'BATATA', 'Tubérculos com furos finos e galerias por dentro, encontrados na colheita do talhão de baixo.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000110', TIMESTAMP '2026-10-28 17:30:00', TIMESTAMP '2026-10-28 17:30:00');
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (111, 19, 7, 'TOMATE', 'Folhas do tomate com manchas grandes e escuras e caule com lesões, depois de uma semana de chuva.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000111', TIMESTAMP '2026-11-04 07:55:00', TIMESTAMP '2026-11-04 07:55:00');
INSERT INTO OCORRENCIA (ID, PROPRIEDADE_ID, USUARIO_ID, CULTURA, DESCRICAO, STATUS, SEVERIDADE, IDEMPOTENCY_KEY, DATA_REGISTRO, ATUALIZADO_EM)
VALUES (112, 11, 1, 'MILHO', 'Outro talhão com folhas amareladas e muitas cigarrinhas no cartucho, parecido com o caso anterior.', 'RECEBIDA', NULL, '6f1c8a2e-1b3d-4e5f-9a10-000000000112', TIMESTAMP '2026-09-29 08:20:00', TIMESTAMP '2026-09-29 08:20:00');

-- Triagens
INSERT INTO TRIAGEM (ID, OCORRENCIA_ID, PRAGA_PROVAVEL, HIPOTESES, CONFIANCA, SEVERIDADE, CUIDADOS_IMEDIATOS, TEXTO_ALERTA, ENCAMINHAR_AGRONOMO, EXPLICACAO, FONTES, MOTIVO_IMAGEM, GERADA_EM)
VALUES (201, 101, 'Cigarrinha-do-milho',
        '[{"praga":"Cigarrinha-do-milho","probabilidade":0.86},{"praga":"Enfezamento-pálido","probabilidade":0.09}]',
        0.86, 4,
        '["Isolar e marcar a área com sintomas","Avisar os vizinhos que plantam milho","Aguardar a orientação do agrônomo antes de qualquer manejo"]',
        'Suspeita de cigarrinha-do-milho a poucos quilômetros. Verifique o cartucho das plantas.', 'N',
        'Faixas amareladas e insetos claros no cartucho são sinais típicos da cigarrinha-do-milho (Dalbulus maidis), vetor dos enfezamentos.',
        '[{"titulo":"Cigarrinha-do-milho e enfezamentos","fonte":"Embrapa Milho e Sorgo","url":"https://www.embrapa.br/milho-e-sorgo"}]',
        NULL, TIMESTAMP '2026-09-08 07:43:00');
INSERT INTO TRIAGEM (ID, OCORRENCIA_ID, PRAGA_PROVAVEL, HIPOTESES, CONFIANCA, SEVERIDADE, CUIDADOS_IMEDIATOS, TEXTO_ALERTA, ENCAMINHAR_AGRONOMO, EXPLICACAO, FONTES, MOTIVO_IMAGEM, GERADA_EM)
VALUES (202, 102, 'Lagarta-do-cartucho',
        '[{"praga":"Lagarta-do-cartucho","probabilidade":0.91},{"praga":"Lagarta-da-espiga","probabilidade":0.05}]',
        0.91, 3,
        '["Vistoriar plantas em pontos diferentes da lavoura","Avisar os vizinhos que plantam milho","Aguardar a orientação do agrônomo antes de qualquer manejo"]',
        'Suspeita de lagarta-do-cartucho na vizinhança. Confira as folhas do cartucho.', 'N',
        'Folhas raspadas e fezes no cartucho indicam a lagarta-do-cartucho (Spodoptera frugiperda).',
        '[{"titulo":"Lagarta-do-cartucho no milho","fonte":"Embrapa Milho e Sorgo","url":"https://www.embrapa.br/milho-e-sorgo"}]',
        NULL, TIMESTAMP '2026-09-22 08:11:00');
INSERT INTO TRIAGEM (ID, OCORRENCIA_ID, PRAGA_PROVAVEL, HIPOTESES, CONFIANCA, SEVERIDADE, CUIDADOS_IMEDIATOS, TEXTO_ALERTA, ENCAMINHAR_AGRONOMO, EXPLICACAO, FONTES, MOTIVO_IMAGEM, GERADA_EM)
VALUES (203, 103, 'Enfezamento-vermelho',
        '[{"praga":"Enfezamento-vermelho","probabilidade":0.71},{"praga":"Cigarrinha-do-milho","probabilidade":0.22}]',
        0.71, 3,
        '["Marcar as plantas com folhas avermelhadas","Avisar os vizinhos que plantam milho","Aguardar a orientação do agrônomo antes de qualquer manejo"]',
        'Suspeita de enfezamento no milho na região. Observe folhas avermelhadas.', 'N',
        'Folhas avermelhadas e espigas pequenas, com cigarrinhas presentes, indicam enfezamento-vermelho causado por fitoplasma.',
        '[{"titulo":"Enfezamentos do milho","fonte":"Embrapa Milho e Sorgo","url":"https://www.embrapa.br/milho-e-sorgo"}]',
        NULL, TIMESTAMP '2026-10-06 16:06:00');
INSERT INTO TRIAGEM (ID, OCORRENCIA_ID, PRAGA_PROVAVEL, HIPOTESES, CONFIANCA, SEVERIDADE, CUIDADOS_IMEDIATOS, TEXTO_ALERTA, ENCAMINHAR_AGRONOMO, EXPLICACAO, FONTES, MOTIVO_IMAGEM, GERADA_EM)
VALUES (204, 104, 'Ferrugem-comum',
        '[{"praga":"Ferrugem-comum","probabilidade":0.64},{"praga":"Ferrugem-polissora","probabilidade":0.21}]',
        0.64, 2,
        '["Observar se as manchas avançam para as folhas de cima","Avisar os vizinhos que plantam milho"]',
        'Suspeita de ferrugem no milho na região. Observe as folhas de baixo.', 'N',
        'Pústulas alaranjadas nas folhas inferiores após chuvas são compatíveis com ferrugem-comum (Puccinia sorghi).',
        '[{"titulo":"Doenças foliares do milho","fonte":"Embrapa Milho e Sorgo","url":"https://www.embrapa.br/milho-e-sorgo"}]',
        NULL, TIMESTAMP '2026-10-20 07:31:00');
INSERT INTO TRIAGEM (ID, OCORRENCIA_ID, PRAGA_PROVAVEL, HIPOTESES, CONFIANCA, SEVERIDADE, CUIDADOS_IMEDIATOS, TEXTO_ALERTA, ENCAMINHAR_AGRONOMO, EXPLICACAO, FONTES, MOTIVO_IMAGEM, GERADA_EM)
VALUES (205, 105, 'Requeima',
        '[{"praga":"Requeima","probabilidade":0.93},{"praga":"Pinta-preta","probabilidade":0.04}]',
        0.93, 5,
        '["Retirar e separar as plantas mais atacadas","Evitar molhar as folhas na irrigação","Avisar os vizinhos que plantam tomate"]',
        'Suspeita grave de requeima no tomate a poucos quilômetros. Verifique folhas e frutos.', 'N',
        'Lesões encharcadas com mofo branco após dias úmidos são o sinal clássico da requeima (Phytophthora infestans).',
        '[{"titulo":"Requeima do tomateiro","fonte":"Embrapa Hortaliças","url":"https://www.embrapa.br/hortalicas"}]',
        NULL, TIMESTAMP '2026-09-15 06:51:00');
INSERT INTO TRIAGEM (ID, OCORRENCIA_ID, PRAGA_PROVAVEL, HIPOTESES, CONFIANCA, SEVERIDADE, CUIDADOS_IMEDIATOS, TEXTO_ALERTA, ENCAMINHAR_AGRONOMO, EXPLICACAO, FONTES, MOTIVO_IMAGEM, GERADA_EM)
VALUES (206, 106, 'Traça-do-tomateiro',
        '[{"praga":"Traça-do-tomateiro","probabilidade":0.78},{"praga":"Mosca-minadora","probabilidade":0.15}]',
        0.78, 3,
        '["Retirar os frutos furados da lavoura","Avisar os vizinhos que plantam tomate"]',
        'Suspeita de traça-do-tomateiro na região. Confira minas nas folhas e furos nos frutos.', 'N',
        'Minas nas folhas e lagartas dentro dos frutos indicam a traça-do-tomateiro (Tuta absoluta).',
        '[{"titulo":"Traça-do-tomateiro","fonte":"Embrapa Hortaliças","url":"https://www.embrapa.br/hortalicas"}]',
        NULL, TIMESTAMP '2026-10-02 09:21:00');
INSERT INTO TRIAGEM (ID, OCORRENCIA_ID, PRAGA_PROVAVEL, HIPOTESES, CONFIANCA, SEVERIDADE, CUIDADOS_IMEDIATOS, TEXTO_ALERTA, ENCAMINHAR_AGRONOMO, EXPLICACAO, FONTES, MOTIVO_IMAGEM, GERADA_EM)
VALUES (208, 108, 'Requeima',
        '[{"praga":"Requeima","probabilidade":0.88},{"praga":"Pinta-preta","probabilidade":0.08}]',
        0.88, 4,
        '["Separar as plantas com lesões","Evitar irrigação por aspersão no fim do dia","Avisar os vizinhos que plantam batata"]',
        'Suspeita de requeima na batata na vizinhança. Verifique folhas e hastes.', 'N',
        'Manchas escuras em folhas e hastes, com avanço rápido em tempo úmido, indicam requeima (Phytophthora infestans).',
        '[{"titulo":"Requeima da batata","fonte":"Embrapa Hortaliças","url":"https://www.embrapa.br/hortalicas"}]',
        NULL, TIMESTAMP '2026-09-10 07:06:00');
INSERT INTO TRIAGEM (ID, OCORRENCIA_ID, PRAGA_PROVAVEL, HIPOTESES, CONFIANCA, SEVERIDADE, CUIDADOS_IMEDIATOS, TEXTO_ALERTA, ENCAMINHAR_AGRONOMO, EXPLICACAO, FONTES, MOTIVO_IMAGEM, GERADA_EM)
VALUES (209, 109, 'Pinta-preta',
        '[{"praga":"Pinta-preta","probabilidade":0.84},{"praga":"Requeima","probabilidade":0.10}]',
        0.84, 3,
        '["Retirar as folhas velhas mais atacadas","Avisar os vizinhos que plantam batata"]',
        'Suspeita de pinta-preta na batata na região. Observe manchas com anéis.', 'N',
        'Manchas circulares com anéis nas folhas velhas são típicas da pinta-preta (Alternaria solani).',
        '[{"titulo":"Pinta-preta da batata","fonte":"Embrapa Hortaliças","url":"https://www.embrapa.br/hortalicas"}]',
        NULL, TIMESTAMP '2026-10-12 08:41:00');
INSERT INTO TRIAGEM (ID, OCORRENCIA_ID, PRAGA_PROVAVEL, HIPOTESES, CONFIANCA, SEVERIDADE, CUIDADOS_IMEDIATOS, TEXTO_ALERTA, ENCAMINHAR_AGRONOMO, EXPLICACAO, FONTES, MOTIVO_IMAGEM, GERADA_EM)
VALUES (210, 110, NULL, NULL, NULL, NULL, NULL, NULL, 'S', NULL, NULL, 'IMAGEM_BORRADA', TIMESTAMP '2026-10-28 17:31:00');
INSERT INTO TRIAGEM (ID, OCORRENCIA_ID, PRAGA_PROVAVEL, HIPOTESES, CONFIANCA, SEVERIDADE, CUIDADOS_IMEDIATOS, TEXTO_ALERTA, ENCAMINHAR_AGRONOMO, EXPLICACAO, FONTES, MOTIVO_IMAGEM, GERADA_EM)
VALUES (211, 111, 'Requeima',
        '[{"praga":"Requeima","probabilidade":0.90},{"praga":"Pinta-preta","probabilidade":0.06}]',
        0.90, 4,
        '["Retirar e separar as plantas mais atacadas","Evitar molhar as folhas na irrigação","Avisar os vizinhos que plantam tomate"]',
        'Suspeita de requeima no tomate na região. Verifique folhas e caules.', 'N',
        'Manchas grandes e escuras com lesões no caule após chuva contínua indicam requeima (Phytophthora infestans).',
        '[{"titulo":"Requeima do tomateiro","fonte":"Embrapa Hortaliças","url":"https://www.embrapa.br/hortalicas"}]',
        NULL, TIMESTAMP '2026-11-04 07:56:00');
INSERT INTO TRIAGEM (ID, OCORRENCIA_ID, PRAGA_PROVAVEL, HIPOTESES, CONFIANCA, SEVERIDADE, CUIDADOS_IMEDIATOS, TEXTO_ALERTA, ENCAMINHAR_AGRONOMO, EXPLICACAO, FONTES, MOTIVO_IMAGEM, GERADA_EM)
VALUES (212, 112, 'Cigarrinha-do-milho',
        '[{"praga":"Cigarrinha-do-milho","probabilidade":0.83},{"praga":"Enfezamento-pálido","probabilidade":0.12}]',
        0.83, 4,
        '["Isolar e marcar a área com sintomas","Avisar os vizinhos que plantam milho","Aguardar a orientação do agrônomo antes de qualquer manejo"]',
        'Nova suspeita de cigarrinha-do-milho a poucos quilômetros. Verifique o cartucho das plantas.', 'N',
        'Folhas amareladas e grande número de cigarrinhas no cartucho indicam a cigarrinha-do-milho (Dalbulus maidis).',
        '[{"titulo":"Cigarrinha-do-milho e enfezamentos","fonte":"Embrapa Milho e Sorgo","url":"https://www.embrapa.br/milho-e-sorgo"}]',
        NULL, TIMESTAMP '2026-09-29 08:21:00');

-- Ciclo de vida das ocorrências
UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 4, ATUALIZADO_EM = TIMESTAMP '2026-09-08 07:43:00' WHERE ID = 101;
UPDATE OCORRENCIA SET STATUS = 'EM_ANALISE', ATUALIZADO_EM = TIMESTAMP '2026-09-09 10:15:00' WHERE ID = 101;
UPDATE OCORRENCIA SET STATUS = 'CONFIRMADA', ATUALIZADO_EM = TIMESTAMP '2026-09-09 16:30:00' WHERE ID = 101;

UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 3, ATUALIZADO_EM = TIMESTAMP '2026-09-22 08:11:00' WHERE ID = 102;
UPDATE OCORRENCIA SET STATUS = 'EM_ANALISE', ATUALIZADO_EM = TIMESTAMP '2026-09-23 09:00:00' WHERE ID = 102;
UPDATE OCORRENCIA SET STATUS = 'CONFIRMADA', ATUALIZADO_EM = TIMESTAMP '2026-09-23 14:20:00' WHERE ID = 102;

UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 3, ATUALIZADO_EM = TIMESTAMP '2026-10-06 16:06:00' WHERE ID = 103;

UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 2, ATUALIZADO_EM = TIMESTAMP '2026-10-20 07:31:00' WHERE ID = 104;
UPDATE OCORRENCIA SET STATUS = 'EM_ANALISE', ATUALIZADO_EM = TIMESTAMP '2026-10-21 11:00:00' WHERE ID = 104;
UPDATE OCORRENCIA SET STATUS = 'DESCARTADA', ATUALIZADO_EM = TIMESTAMP '2026-10-22 15:40:00' WHERE ID = 104;

UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 5, ATUALIZADO_EM = TIMESTAMP '2026-09-15 06:51:00' WHERE ID = 105;
UPDATE OCORRENCIA SET STATUS = 'EM_ANALISE', ATUALIZADO_EM = TIMESTAMP '2026-09-15 13:00:00' WHERE ID = 105;
UPDATE OCORRENCIA SET STATUS = 'CONFIRMADA', ATUALIZADO_EM = TIMESTAMP '2026-09-15 17:10:00' WHERE ID = 105;

UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 3, ATUALIZADO_EM = TIMESTAMP '2026-10-02 09:21:00' WHERE ID = 106;
UPDATE OCORRENCIA SET STATUS = 'EM_ANALISE', ATUALIZADO_EM = TIMESTAMP '2026-10-03 10:00:00' WHERE ID = 106;

UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 4, ATUALIZADO_EM = TIMESTAMP '2026-09-10 07:06:00' WHERE ID = 108;
UPDATE OCORRENCIA SET STATUS = 'EM_ANALISE', ATUALIZADO_EM = TIMESTAMP '2026-09-10 15:30:00' WHERE ID = 108;
UPDATE OCORRENCIA SET STATUS = 'CONFIRMADA', ATUALIZADO_EM = TIMESTAMP '2026-09-11 09:45:00' WHERE ID = 108;

UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 3, ATUALIZADO_EM = TIMESTAMP '2026-10-12 08:41:00' WHERE ID = 109;
UPDATE OCORRENCIA SET STATUS = 'EM_ANALISE', ATUALIZADO_EM = TIMESTAMP '2026-10-13 10:20:00' WHERE ID = 109;
UPDATE OCORRENCIA SET STATUS = 'CONFIRMADA', ATUALIZADO_EM = TIMESTAMP '2026-10-13 16:00:00' WHERE ID = 109;

UPDATE OCORRENCIA SET STATUS = 'EM_ANALISE', ATUALIZADO_EM = TIMESTAMP '2026-10-28 17:31:00' WHERE ID = 110;

UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 4, ATUALIZADO_EM = TIMESTAMP '2026-11-04 07:56:00' WHERE ID = 111;

UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 4, ATUALIZADO_EM = TIMESTAMP '2026-09-29 08:21:00' WHERE ID = 112;

-- Laudos
INSERT INTO LAUDO (ID, OCORRENCIA_ID, AGRONOMO_ID, DECISAO, PRAGA_CONFIRMADA, PARECER, EMITIDO_EM)
VALUES (401, 101, 8, 'CONFIRMADA', 'Cigarrinha-do-milho', 'Vistoria confirmou alta população de Dalbulus maidis no cartucho e sintomas iniciais de enfezamento. Recomendado monitoramento semanal na vizinhança.', TIMESTAMP '2026-09-09 16:30:00');
INSERT INTO LAUDO (ID, OCORRENCIA_ID, AGRONOMO_ID, DECISAO, PRAGA_CONFIRMADA, PARECER, EMITIDO_EM)
VALUES (402, 102, 8, 'CONFIRMADA', 'Lagarta-do-cartucho', 'Lagartas de Spodoptera frugiperda encontradas em cerca de 20% das plantas, acima do nível de alerta para a fase da lavoura.', TIMESTAMP '2026-09-23 14:20:00');
INSERT INTO LAUDO (ID, OCORRENCIA_ID, AGRONOMO_ID, DECISAO, PRAGA_CONFIRMADA, PARECER, EMITIDO_EM)
VALUES (404, 104, 8, 'DESCARTADA', NULL, 'As manchas vêm de deficiência de potássio nas folhas inferiores. Não há pústulas de ferrugem nas amostras analisadas.', TIMESTAMP '2026-10-22 15:40:00');
INSERT INTO LAUDO (ID, OCORRENCIA_ID, AGRONOMO_ID, DECISAO, PRAGA_CONFIRMADA, PARECER, EMITIDO_EM)
VALUES (405, 105, 8, 'CONFIRMADA', 'Requeima', 'Lesões com esporulação branca típica de Phytophthora infestans em folhas e frutos. Alto risco de espalhamento com o tempo úmido.', TIMESTAMP '2026-09-15 17:10:00');
INSERT INTO LAUDO (ID, OCORRENCIA_ID, AGRONOMO_ID, DECISAO, PRAGA_CONFIRMADA, PARECER, EMITIDO_EM)
VALUES (406, 106, 8, 'MAIS_INFORMACOES', NULL, 'Enviar fotos das folhas novas e dos frutos com galerias, de perto, para confirmar a presença da traça.', TIMESTAMP '2026-10-03 10:00:00');
INSERT INTO LAUDO (ID, OCORRENCIA_ID, AGRONOMO_ID, DECISAO, PRAGA_CONFIRMADA, PARECER, EMITIDO_EM)
VALUES (408, 108, 9, 'CONFIRMADA', 'Requeima', 'Lesões escuras em folhas e hastes com esporulação de Phytophthora infestans. Situação favorecida pela garoa da última semana.', TIMESTAMP '2026-09-11 09:45:00');
INSERT INTO LAUDO (ID, OCORRENCIA_ID, AGRONOMO_ID, DECISAO, PRAGA_CONFIRMADA, PARECER, EMITIDO_EM)
VALUES (409, 109, 9, 'CONFIRMADA', 'Pinta-preta', 'Manchas com anéis concêntricos de Alternaria solani nas folhas velhas, com avanço moderado na lavoura.', TIMESTAMP '2026-10-13 16:00:00');

-- Alertas para as propriedades vizinhas
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (301, 101, 12, 'CONFIRMADO', 9, 'S', TIMESTAMP '2026-09-08 07:44:00');
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (302, 101, 13, 'CONFIRMADO', 7, 'N', TIMESTAMP '2026-09-08 07:44:00');
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (303, 102, 11, 'CONFIRMADO', 9, 'S', TIMESTAMP '2026-09-22 08:12:00');
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (304, 103, 11, 'SUSPEITA', 7, 'N', TIMESTAMP '2026-10-06 16:07:00');
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (305, 104, 12, 'ENCERRADO', 9, 'S', TIMESTAMP '2026-10-20 07:32:00');
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (306, 104, 13, 'ENCERRADO', 7, 'S', TIMESTAMP '2026-10-20 07:32:00');
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (307, 105, 16, 'CONFIRMADO', 5, 'S', TIMESTAMP '2026-09-15 06:52:00');
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (308, 106, 15, 'SUSPEITA', 5, 'N', TIMESTAMP '2026-10-02 09:22:00');
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (309, 108, 19, 'CONFIRMADO', 8, 'S', TIMESTAMP '2026-09-10 07:07:00');
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (310, 109, 18, 'CONFIRMADO', 8, 'N', TIMESTAMP '2026-10-12 08:42:00');
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (311, 112, 12, 'SUSPEITA', 9, 'N', TIMESTAMP '2026-09-29 08:22:00');
INSERT INTO ALERTA (ID, OCORRENCIA_ID, PROPRIEDADE_ID, NIVEL, DISTANCIA_KM, LIDO, CRIADO_EM)
VALUES (312, 112, 13, 'SUSPEITA', 7, 'N', TIMESTAMP '2026-09-29 08:22:00');

-- Mural da região
INSERT INTO POST_MURAL (ID, USUARIO_ID, OCORRENCIA_ID, MUNICIPIO, UF, TEXTO, STATUS, CRIADO_EM)
VALUES (501, 8, 101, 'Chapecó', 'SC', 'Caso confirmado pelo agrônomo: cigarrinha-do-milho em Chapecó. Produtores da região, verifiquem o cartucho das plantas e registrem no Valence.', 'ATIVO', TIMESTAMP '2026-09-09 17:00:00');
INSERT INTO POST_MURAL (ID, USUARIO_ID, OCORRENCIA_ID, MUNICIPIO, UF, TEXTO, STATUS, CRIADO_EM)
VALUES (502, 2, NULL, 'Guatambu', 'SC', 'Alguém mais notou lagarta no cartucho nesta semana? Aqui pegou parte da lavoura.', 'ATIVO', TIMESTAMP '2026-09-22 19:00:00');
INSERT INTO POST_MURAL (ID, USUARIO_ID, OCORRENCIA_ID, MUNICIPIO, UF, TEXTO, STATUS, CRIADO_EM)
VALUES (503, 9, 108, 'Vargem Grande do Sul', 'SP', 'Caso confirmado pelo agrônomo: requeima na batata em Vargem Grande do Sul. Com a garoa dos próximos dias, redobrem a atenção.', 'ATIVO', TIMESTAMP '2026-09-11 10:30:00');
INSERT INTO POST_MURAL (ID, USUARIO_ID, OCORRENCIA_ID, MUNICIPIO, UF, TEXTO, STATUS, CRIADO_EM)
VALUES (504, 7, NULL, 'Vargem Grande do Sul', 'SP', 'Vendo adubo barato, chama no privado.', 'OCULTO', TIMESTAMP '2026-10-15 12:00:00');

COMMIT;

-- Conferência da carga
SELECT 'USUARIO' AS TABELA, COUNT(*) AS TOTAL FROM USUARIO
UNION ALL SELECT 'PROPRIEDADE', COUNT(*) FROM PROPRIEDADE
UNION ALL SELECT 'PROPRIEDADE_CULTURA', COUNT(*) FROM PROPRIEDADE_CULTURA
UNION ALL SELECT 'OCORRENCIA', COUNT(*) FROM OCORRENCIA
UNION ALL SELECT 'TRIAGEM', COUNT(*) FROM TRIAGEM
UNION ALL SELECT 'LAUDO', COUNT(*) FROM LAUDO
UNION ALL SELECT 'ALERTA', COUNT(*) FROM ALERTA
UNION ALL SELECT 'POST_MURAL', COUNT(*) FROM POST_MURAL
UNION ALL SELECT 'AUDITORIA_OCORRENCIA', COUNT(*) FROM AUDITORIA_OCORRENCIA;
