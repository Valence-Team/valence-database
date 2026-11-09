SET SERVEROUTPUT ON SIZE UNLIMITED
SET VERIFY OFF

-- Chamadas diretas no padrão da aula
SELECT FN_DISTANCIA_KM(-27.085, -52.64, -27.11, -52.73) AS DISTANCIA_AVULSA,
       PKG_ALERTA.FN_DISTANCIA_KM(-27.085, -52.64, -27.11, -52.73) AS DISTANCIA_PACOTE
  FROM DUAL;

SELECT FN_NIVEL_RISCO(4, 'Vargem Grande do Sul', 'SP') AS RISCO_AVULSA,
       PKG_OCORRENCIA.FN_NIVEL_RISCO(4, 'Vargem Grande do Sul', 'SP') AS RISCO_PACOTE
  FROM DUAL;

-- Bateria de testes
DECLARE
    V_OK            NUMBER := 0;
    V_FALHAS        NUMBER := 0;
    V_KM            NUMBER;
    V_TEXTO         VARCHAR2(30);
    V_ID            OCORRENCIA.ID%TYPE;
    V_ID_REPETIDO   OCORRENCIA.ID%TYPE;
    V_QTD           NUMBER;
    V_CONTAGEM      NUMBER;
    V_STATUS        OCORRENCIA.STATUS%TYPE;
    V_SEVERIDADE    OCORRENCIA.SEVERIDADE%TYPE;
    V_CULTURA       OCORRENCIA.CULTURA%TYPE;
    V_NIVEL         ALERTA.NIVEL%TYPE;
    V_LIDO          ALERTA.LIDO%TYPE;
    V_DISTANCIA     ALERTA.DISTANCIA_KM%TYPE;
    V_AUD_ANTES     NUMBER;
    V_AUD           AUDITORIA_OCORRENCIA%ROWTYPE;

    PROCEDURE TITULO (P_TEXTO IN VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(' ');
        DBMS_OUTPUT.PUT_LINE(P_TEXTO);
        DBMS_OUTPUT.PUT_LINE(RPAD('=', LENGTH(P_TEXTO), '='));
    END TITULO;

    PROCEDURE VERIFICAR (P_DESCRICAO IN VARCHAR2, P_CONDICAO IN BOOLEAN) IS
    BEGIN
        IF P_CONDICAO THEN
            V_OK := V_OK + 1;
            DBMS_OUTPUT.PUT_LINE('[OK] ' || P_DESCRICAO);
        ELSE
            V_FALHAS := V_FALHAS + 1;
            DBMS_OUTPUT.PUT_LINE('[FALHOU] ' || P_DESCRICAO);
        END IF;
    END VERIFICAR;

    PROCEDURE ERRO_ESPERADO (
        P_DESCRICAO         IN VARCHAR2,
        P_CODIGO_ESPERADO   IN NUMBER,
        P_CODIGO_OBTIDO     IN NUMBER,
        P_MENSAGEM          IN VARCHAR2
    ) IS
    BEGIN
        VERIFICAR(P_DESCRICAO || ' -> ' || SUBSTR(P_MENSAGEM, 1, 150),
                  P_CODIGO_OBTIDO = P_CODIGO_ESPERADO);
    END ERRO_ESPERADO;
BEGIN
    TITULO('A. Funções e procedimentos avulsos (requisito 02)');

    V_KM := FN_DISTANCIA_KM(-27.085, -52.64, -27.11, -52.73);
    VERIFICAR('A01 FN_DISTANCIA_KM Linha Faxinal até Dalla Costa = 9,333 km (veio ' || V_KM || ')',
              V_KM = 9.333);

    V_KM := FN_DISTANCIA_KM(-27.085, -52.64, -27.085, -52.64);
    VERIFICAR('A02 FN_DISTANCIA_KM do ponto para ele mesmo = 0 km (veio ' || V_KM || ')', V_KM = 0);

    BEGIN
        V_KM := FN_DISTANCIA_KM(-95, -52.64, -27.11, -52.73);
        VERIFICAR('A03 FN_DISTANCIA_KM recusa latitude -95 -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A03 FN_DISTANCIA_KM recusa latitude -95', -20010, SQLCODE, SQLERRM);
    END;

    V_TEXTO := FN_NIVEL_RISCO(4, 'Vargem Grande do Sul', 'SP');
    VERIFICAR('A04 FN_NIVEL_RISCO severidade 4 com 3 ativas no município = CRITICO (veio ' || V_TEXTO || ')',
              V_TEXTO = 'CRITICO');

    V_TEXTO := FN_NIVEL_RISCO(3, 'Cordilheira Alta', 'SC');
    VERIFICAR('A05 FN_NIVEL_RISCO severidade 3 com 1 ativa no município = MEDIO (veio ' || V_TEXTO || ')',
              V_TEXTO = 'MEDIO');

    V_TEXTO := FN_NIVEL_RISCO(1, 'Guatambu', 'SC');
    VERIFICAR('A06 FN_NIVEL_RISCO severidade 1 = BAIXO (veio ' || V_TEXTO || ')', V_TEXTO = 'BAIXO');

    V_TEXTO := FN_NIVEL_RISCO(3, 'chapecó', 'sc');
    VERIFICAR('A07 FN_NIVEL_RISCO ignora maiúsculas no município e na UF = ALTO (veio ' || V_TEXTO || ')',
              V_TEXTO = 'ALTO');

    BEGIN
        V_TEXTO := FN_NIVEL_RISCO(7, 'Chapecó', 'SC');
        VERIFICAR('A08 FN_NIVEL_RISCO recusa severidade 7 -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A08 FN_NIVEL_RISCO recusa severidade 7', -20020, SQLCODE, SQLERRM);
    END;

    BEGIN
        V_TEXTO := FN_NIVEL_RISCO(3, NULL, 'SC');
        VERIFICAR('A09 FN_NIVEL_RISCO exige município -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A09 FN_NIVEL_RISCO exige município', -20021, SQLCODE, SQLERRM);
    END;

    PRC_REGISTRAR_OCORRENCIA(2, 14, 'milho',
        'Plantas com folhas amareladas e cigarrinhas no cartucho perto da estrada.',
        'a0000000-0000-4000-8000-000000000001', V_ID);
    SELECT STATUS, CULTURA INTO V_STATUS, V_CULTURA FROM OCORRENCIA WHERE ID = V_ID;
    VERIFICAR('A10 PRC_REGISTRAR_OCORRENCIA criou a ocorrência ' || V_ID || ' como RECEBIDA e cultura MILHO',
              V_STATUS = 'RECEBIDA' AND V_CULTURA = 'MILHO');

    PRC_REGISTRAR_OCORRENCIA(2, 14, 'MILHO',
        'Plantas com folhas amareladas e cigarrinhas no cartucho perto da estrada.',
        'a0000000-0000-4000-8000-000000000001', V_ID_REPETIDO);
    SELECT COUNT(*) INTO V_CONTAGEM FROM OCORRENCIA
     WHERE IDEMPOTENCY_KEY = 'a0000000-0000-4000-8000-000000000001';
    VERIFICAR('A11 PRC_REGISTRAR_OCORRENCIA com a mesma chave devolve a mesma ocorrência sem duplicar',
              V_ID_REPETIDO = V_ID AND V_CONTAGEM = 1);

    BEGIN
        PRC_REGISTRAR_OCORRENCIA(2, 14, 'MILHO', 'Outro texto completamente diferente do primeiro.',
            'a0000000-0000-4000-8000-000000000001', V_ID_REPETIDO);
        VERIFICAR('A12 chave reutilizada com outro conteúdo -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A12 chave reutilizada com outro conteúdo', -20036, SQLCODE, SQLERRM);
    END;

    BEGIN
        PRC_REGISTRAR_OCORRENCIA(2, 11, 'MILHO', 'Tentando registrar na propriedade de outra pessoa.',
            'a0000000-0000-4000-8000-000000000002', V_ID_REPETIDO);
        VERIFICAR('A13 propriedade de outro produtor -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A13 propriedade de outro produtor', -20032, SQLCODE, SQLERRM);
    END;

    BEGIN
        PRC_REGISTRAR_OCORRENCIA(2, 14, 'TOMATE', 'Manchas nas folhas do tomate depois da chuva.',
            'a0000000-0000-4000-8000-000000000003', V_ID_REPETIDO);
        VERIFICAR('A14 cultura não cultivada na propriedade -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A14 cultura não cultivada na propriedade', -20033, SQLCODE, SQLERRM);
    END;

    BEGIN
        PRC_REGISTRAR_OCORRENCIA(8, 11, 'MILHO', 'Agrônomo tentando registrar uma ocorrência.',
            'a0000000-0000-4000-8000-000000000004', V_ID_REPETIDO);
        VERIFICAR('A15 usuário que não é produtor -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A15 usuário que não é produtor', -20031, SQLCODE, SQLERRM);
    END;

    BEGIN
        PRC_REGISTRAR_OCORRENCIA(999, 14, 'MILHO', 'Usuário que não existe no cadastro.',
            'a0000000-0000-4000-8000-000000000005', V_ID_REPETIDO);
        VERIFICAR('A16 usuário inexistente -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A16 usuário inexistente', -20030, SQLCODE, SQLERRM);
    END;

    BEGIN
        PRC_REGISTRAR_OCORRENCIA(2, 14, 'MILHO', 'Curta',
            'a0000000-0000-4000-8000-000000000006', V_ID_REPETIDO);
        VERIFICAR('A17 descrição com menos de 10 caracteres -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A17 descrição com menos de 10 caracteres', -20034, SQLCODE, SQLERRM);
    END;

    BEGIN
        PRC_REGISTRAR_OCORRENCIA(2, 14, 'MILHO', 'Chave de idempotência fora do formato UUID.',
            'abc', V_ID_REPETIDO);
        VERIFICAR('A18 chave fora do formato UUID -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A18 chave fora do formato UUID', -20035, SQLCODE, SQLERRM);
    END;

    UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 2 WHERE ID = 107;
    PRC_EMITIR_ALERTAS_RAIO(107, 10, V_QTD);
    SELECT NIVEL, DISTANCIA_KM INTO V_NIVEL, V_DISTANCIA
      FROM ALERTA WHERE OCORRENCIA_ID = 107 AND PROPRIEDADE_ID = 16;
    VERIFICAR('A19 PRC_EMITIR_ALERTAS_RAIO na 107 criou 1 alerta SUSPEITA de 5 km para o Sítio Rech',
              V_QTD = 1 AND V_NIVEL = 'SUSPEITA' AND V_DISTANCIA = 5);

    PRC_EMITIR_ALERTAS_RAIO(107, 10, V_QTD);
    VERIFICAR('A20 PRC_EMITIR_ALERTAS_RAIO executado de novo não repete alerta (veio ' || V_QTD || ')',
              V_QTD = 0);

    UPDATE OCORRENCIA SET STATUS = 'TRIADA', SEVERIDADE = 3 WHERE ID = V_ID;
    PRC_EMITIR_ALERTAS_RAIO(V_ID, 11, V_QTD);
    VERIFICAR('A21 raio de 11 km não alcança a Chácara Bertuol a 11,109 km (veio ' || V_QTD || ')',
              V_QTD = 0);

    PRC_EMITIR_ALERTAS_RAIO(V_ID, 11.109, V_QTD);
    VERIFICAR('A22 raio de 11,109 km alcança a Chácara Bertuol: limite inclusivo (veio ' || V_QTD || ')',
              V_QTD = 1);

    BEGIN
        PRC_EMITIR_ALERTAS_RAIO(104, 10, V_QTD);
        VERIFICAR('A23 ocorrência descartada não emite alerta -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A23 ocorrência descartada não emite alerta', -20041, SQLCODE, SQLERRM);
    END;

    BEGIN
        PRC_EMITIR_ALERTAS_RAIO(103, 0, V_QTD);
        VERIFICAR('A24 raio zero -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A24 raio zero', -20042, SQLCODE, SQLERRM);
    END;

    BEGIN
        PRC_EMITIR_ALERTAS_RAIO(9999, 10, V_QTD);
        VERIFICAR('A25 ocorrência inexistente -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('A25 ocorrência inexistente', -20040, SQLCODE, SQLERRM);
    END;

    ROLLBACK;

    TITULO('B. Pacotes PKG_ALERTA e PKG_OCORRENCIA (requisito 04)');

    V_KM := PKG_ALERTA.FN_DISTANCIA_KM(-26.76, -51.03, -26.80, -51.00);
    VERIFICAR('B01 PKG_ALERTA.FN_DISTANCIA_KM Sítio Fantin até Sítio Rech = 5,353 km (veio ' || V_KM || ')',
              V_KM = 5.353);

    V_KM := PKG_ALERTA.FN_DISTANCIA_KM(-21.82, -46.88, -21.87, -46.93);
    VERIFICAR('B02 PKG_ALERTA.FN_DISTANCIA_KM dá o mesmo resultado da função avulsa = 7,586 km (veio '
              || V_KM || ')',
              V_KM = 7.586 AND V_KM = FN_DISTANCIA_KM(-21.82, -46.88, -21.87, -46.93));

    V_TEXTO := PKG_OCORRENCIA.FN_NIVEL_RISCO(5, 'Caçador', 'SC');
    VERIFICAR('B03 PKG_OCORRENCIA.FN_NIVEL_RISCO severidade 5 = CRITICO (veio ' || V_TEXTO || ')',
              V_TEXTO = 'CRITICO');

    PKG_OCORRENCIA.PRC_REGISTRAR_OCORRENCIA(6, 20, 'BATATA',
        'Tubérculos com furos finos em outro talhão da propriedade.',
        'b0000000-0000-4000-8000-000000000001', V_ID);
    SELECT STATUS INTO V_STATUS FROM OCORRENCIA WHERE ID = V_ID;
    VERIFICAR('B04 PKG_OCORRENCIA.PRC_REGISTRAR_OCORRENCIA criou a ocorrência ' || V_ID || ' como RECEBIDA',
              V_STATUS = 'RECEBIDA');

    BEGIN
        PKG_OCORRENCIA.PRC_ATUALIZAR_STATUS(V_ID, 'TRIADA');
        VERIFICAR('B05 triagem sem severidade -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('B05 triagem sem severidade', -20053, SQLCODE, SQLERRM);
    END;

    PKG_OCORRENCIA.PRC_ATUALIZAR_STATUS(107, 'TRIADA', 2);
    SELECT STATUS, SEVERIDADE INTO V_STATUS, V_SEVERIDADE FROM OCORRENCIA WHERE ID = 107;
    SELECT COUNT(*) INTO V_CONTAGEM FROM ALERTA WHERE OCORRENCIA_ID = 107 AND NIVEL = 'SUSPEITA';
    VERIFICAR('B06 PRC_ATUALIZAR_STATUS 107 RECEBIDA -> TRIADA grava severidade 2 e emite 1 alerta SUSPEITA',
              V_STATUS = 'TRIADA' AND V_SEVERIDADE = 2 AND V_CONTAGEM = 1);

    PKG_OCORRENCIA.PRC_ATUALIZAR_STATUS(107, 'EM_ANALISE');
    SELECT STATUS INTO V_STATUS FROM OCORRENCIA WHERE ID = 107;
    VERIFICAR('B07 PRC_ATUALIZAR_STATUS 107 TRIADA -> EM_ANALISE', V_STATUS = 'EM_ANALISE');

    PKG_OCORRENCIA.PRC_ATUALIZAR_STATUS(107, 'CONFIRMADA');
    SELECT STATUS INTO V_STATUS FROM OCORRENCIA WHERE ID = 107;
    SELECT NIVEL, LIDO INTO V_NIVEL, V_LIDO FROM ALERTA WHERE OCORRENCIA_ID = 107 AND PROPRIEDADE_ID = 16;
    VERIFICAR('B08 PRC_ATUALIZAR_STATUS 107 EM_ANALISE -> CONFIRMADA muda o alerta para CONFIRMADO e não lido',
              V_STATUS = 'CONFIRMADA' AND V_NIVEL = 'CONFIRMADO' AND V_LIDO = 'N');

    PKG_ALERTA.PRC_EMITIR_ALERTAS_RAIO(P_OCORRENCIA_ID => 107, P_QTD_ALERTAS => V_QTD);
    VERIFICAR('B09 PKG_ALERTA.PRC_EMITIR_ALERTAS_RAIO com o raio padrão do pacote não repete alerta (veio '
              || V_QTD || ')', V_QTD = 0);

    PKG_OCORRENCIA.PRC_ATUALIZAR_STATUS(112, 'EM_ANALISE');
    PKG_OCORRENCIA.PRC_ATUALIZAR_STATUS(112, 'DESCARTADA');
    SELECT STATUS INTO V_STATUS FROM OCORRENCIA WHERE ID = 112;
    SELECT COUNT(*) INTO V_CONTAGEM FROM ALERTA WHERE OCORRENCIA_ID = 112 AND NIVEL = 'ENCERRADO';
    VERIFICAR('B10 PRC_ATUALIZAR_STATUS 112 até DESCARTADA encerra os 2 alertas da ocorrência',
              V_STATUS = 'DESCARTADA' AND V_CONTAGEM = 2);

    BEGIN
        PKG_OCORRENCIA.PRC_ATUALIZAR_STATUS(103, 'DESCARTADA');
        VERIFICAR('B11 TRIADA -> DESCARTADA sem passar pelo agrônomo -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN PKG_OCORRENCIA.E_TRANSICAO_INVALIDA THEN
            VERIFICAR('B11 TRIADA -> DESCARTADA tratada pela exceção nomeada PKG_OCORRENCIA.E_TRANSICAO_INVALIDA -> '
                      || SUBSTR(SQLERRM, 1, 150), TRUE);
        WHEN OTHERS THEN
            VERIFICAR('B11 exceção nomeada esperada, veio ' || SQLERRM, FALSE);
    END;

    BEGIN
        PKG_OCORRENCIA.PRC_ATUALIZAR_STATUS(107, 'RECEBIDA');
        VERIFICAR('B12 CONFIRMADA não volta para RECEBIDA -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('B12 CONFIRMADA não volta para RECEBIDA', -20052, SQLCODE, SQLERRM);
    END;

    BEGIN
        PKG_OCORRENCIA.PRC_ATUALIZAR_STATUS(103, 'APROVADA');
        VERIFICAR('B13 status fora do domínio -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('B13 status fora do domínio', -20051, SQLCODE, SQLERRM);
    END;

    BEGIN
        PKG_OCORRENCIA.PRC_ATUALIZAR_STATUS(9999, 'TRIADA', 3);
        VERIFICAR('B14 ocorrência inexistente -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('B14 ocorrência inexistente', -20050, SQLCODE, SQLERRM);
    END;

    BEGIN
        PKG_ALERTA.PRC_EMITIR_ALERTAS_RAIO(104, 10, V_QTD);
        VERIFICAR('B15 ocorrência descartada não emite alerta -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN PKG_ALERTA.E_STATUS_SEM_ALERTA THEN
            VERIFICAR('B15 ocorrência descartada tratada pela exceção nomeada PKG_ALERTA.E_STATUS_SEM_ALERTA -> '
                      || SUBSTR(SQLERRM, 1, 150), TRUE);
        WHEN OTHERS THEN
            VERIFICAR('B15 exceção nomeada esperada, veio ' || SQLERRM, FALSE);
    END;

    BEGIN
        PKG_ALERTA.PRC_ATUALIZAR_NIVEL(101, 'PERDIDO', V_QTD);
        VERIFICAR('B16 nível de alerta fora do domínio -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('B16 nível de alerta fora do domínio', -20043, SQLCODE, SQLERRM);
    END;

    ROLLBACK;

    TITULO('C. Gatilhos e trilha de auditoria (requisito 03)');

    BEGIN
        UPDATE OCORRENCIA SET SEVERIDADE = 6 WHERE ID = 103;
        VERIFICAR('C01 TRG_VALIDA_SEVERIDADE recusa severidade 6 -> nenhum erro foi lançado', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('C01 TRG_VALIDA_SEVERIDADE recusa severidade 6', -20001, SQLCODE, SQLERRM);
    END;

    BEGIN
        UPDATE OCORRENCIA SET SEVERIDADE = 2 WHERE ID = 107;
        VERIFICAR('C02 TRG_VALIDA_SEVERIDADE recusa severidade em ocorrência RECEBIDA -> nenhum erro foi lançado',
                  FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            ERRO_ESPERADO('C02 TRG_VALIDA_SEVERIDADE recusa severidade em ocorrência RECEBIDA', -20002,
                          SQLCODE, SQLERRM);
    END;

    SELECT COUNT(*) INTO V_AUD_ANTES FROM AUDITORIA_OCORRENCIA WHERE OCORRENCIA_ID = 103;
    UPDATE OCORRENCIA SET SEVERIDADE = 5 WHERE ID = 103;
    SELECT COUNT(*) INTO V_CONTAGEM FROM AUDITORIA_OCORRENCIA WHERE OCORRENCIA_ID = 103;
    VERIFICAR('C03 TRG_AUDIT_OCORRENCIA gravou 1 linha a mais no UPDATE de severidade ('
              || V_AUD_ANTES || ' -> ' || V_CONTAGEM || ')', V_CONTAGEM = V_AUD_ANTES + 1);

    SELECT * INTO V_AUD
      FROM AUDITORIA_OCORRENCIA
     WHERE ID = (SELECT MAX(ID) FROM AUDITORIA_OCORRENCIA WHERE OCORRENCIA_ID = 103);
    VERIFICAR('C04 auditoria do UPDATE: operação UPDATE, severidade 3 -> 5, status TRIADA, usuário '
              || V_AUD.USUARIO_BANCO || ' e data ' || TO_CHAR(V_AUD.DATA_OPERACAO, 'DD/MM/YYYY HH24:MI:SS'),
              V_AUD.OPERACAO = 'UPDATE' AND V_AUD.SEVERIDADE_ANTERIOR = 3 AND V_AUD.SEVERIDADE_NOVA = 5
              AND V_AUD.STATUS_ANTERIOR = 'TRIADA' AND V_AUD.STATUS_NOVO = 'TRIADA'
              AND V_AUD.USUARIO_BANCO = USER AND V_AUD.DATA_OPERACAO IS NOT NULL);

    PKG_OCORRENCIA.PRC_REGISTRAR_OCORRENCIA(7, 19, 'TOMATE',
        'Folhas do tomate com manchas pequenas e amareladas nas bordas.',
        'c0000000-0000-4000-8000-000000000001', V_ID);
    SELECT * INTO V_AUD
      FROM AUDITORIA_OCORRENCIA
     WHERE OCORRENCIA_ID = V_ID AND OPERACAO = 'INSERT';
    VERIFICAR('C05 auditoria do INSERT da ocorrência ' || V_ID || ': status anterior vazio e novo RECEBIDA',
              V_AUD.STATUS_ANTERIOR IS NULL AND V_AUD.STATUS_NOVO = 'RECEBIDA');

    DELETE FROM OCORRENCIA WHERE ID = V_ID;
    SELECT * INTO V_AUD
      FROM AUDITORIA_OCORRENCIA
     WHERE OCORRENCIA_ID = V_ID AND OPERACAO = 'DELETE';
    SELECT COUNT(*) INTO V_CONTAGEM FROM OCORRENCIA WHERE ID = V_ID;
    VERIFICAR('C06 auditoria do DELETE: status anterior RECEBIDA, novo vazio, e a trilha continua após a exclusão',
              V_AUD.STATUS_ANTERIOR = 'RECEBIDA' AND V_AUD.STATUS_NOVO IS NULL AND V_CONTAGEM = 0);

    SELECT COUNT(*) INTO V_AUD_ANTES FROM AUDITORIA_OCORRENCIA WHERE OCORRENCIA_ID = 103;
    UPDATE OCORRENCIA SET DESCRICAO = DESCRICAO || ' Atualizado pelo produtor.' WHERE ID = 103;
    SELECT COUNT(*) INTO V_CONTAGEM FROM AUDITORIA_OCORRENCIA WHERE OCORRENCIA_ID = 103;
    VERIFICAR('C07 alterar só a descrição não gera auditoria (UPDATE OF STATUS, SEVERIDADE)',
              V_CONTAGEM = V_AUD_ANTES);

    ROLLBACK;

    TITULO('Resumo');
    DBMS_OUTPUT.PUT_LINE('Testes aprovados: ' || V_OK);
    DBMS_OUTPUT.PUT_LINE('Testes com falha: ' || V_FALHAS);
    DBMS_OUTPUT.PUT_LINE('Cada grupo termina com ROLLBACK: a base continua igual à carga do 03_dados.sql.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Erro inesperado na bateria de testes: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Testes aprovados até aqui: ' || V_OK || ' | com falha: ' || V_FALHAS);
        RAISE;
END;
/

-- Conferência da base depois dos testes
SELECT 'OCORRENCIA' AS TABELA, COUNT(*) AS TOTAL FROM OCORRENCIA
UNION ALL SELECT 'ALERTA', COUNT(*) FROM ALERTA
UNION ALL SELECT 'AUDITORIA_OCORRENCIA', COUNT(*) FROM AUDITORIA_OCORRENCIA;
