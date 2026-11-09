SET SERVEROUTPUT ON
SET VERIFY OFF

-- Bloco 1: ocorrências por município com cursor explícito
DECLARE
    CURSOR C_OCORRENCIAS IS
        SELECT P.UF, P.MUNICIPIO, O.ID, O.CULTURA, O.STATUS, O.SEVERIDADE, O.DATA_REGISTRO
          FROM OCORRENCIA O
          JOIN PROPRIEDADE P ON P.ID = O.PROPRIEDADE_ID
         ORDER BY P.UF, P.MUNICIPIO, O.DATA_REGISTRO;

    V_REG                   C_OCORRENCIAS%ROWTYPE;
    V_MUNICIPIO_ATUAL       VARCHAR2(110);
    V_TOTAL_MUNICIPIO       NUMBER := 0;
    V_CONFIRMADAS_MUNICIPIO NUMBER := 0;
    V_TOTAL_MUNICIPIOS      NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('OCORRÊNCIAS POR MUNICÍPIO');
    DBMS_OUTPUT.PUT_LINE('=========================');

    OPEN C_OCORRENCIAS;
    LOOP
        FETCH C_OCORRENCIAS INTO V_REG;
        EXIT WHEN C_OCORRENCIAS%NOTFOUND;

        IF V_MUNICIPIO_ATUAL IS NULL OR V_MUNICIPIO_ATUAL <> V_REG.MUNICIPIO || '/' || V_REG.UF THEN
            IF V_MUNICIPIO_ATUAL IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE('  Subtotal: ' || V_TOTAL_MUNICIPIO || ' ocorrência(s), '
                                     || V_CONFIRMADAS_MUNICIPIO || ' confirmada(s)');
            END IF;
            V_MUNICIPIO_ATUAL := V_REG.MUNICIPIO || '/' || V_REG.UF;
            V_TOTAL_MUNICIPIO := 0;
            V_CONFIRMADAS_MUNICIPIO := 0;
            V_TOTAL_MUNICIPIOS := V_TOTAL_MUNICIPIOS + 1;
            DBMS_OUTPUT.PUT_LINE(' ');
            DBMS_OUTPUT.PUT_LINE(V_MUNICIPIO_ATUAL);
        END IF;

        DBMS_OUTPUT.PUT_LINE('  Ocorrência ' || V_REG.ID
                             || ' | ' || V_REG.CULTURA
                             || ' | ' || V_REG.STATUS
                             || ' | severidade ' || NVL(TO_CHAR(V_REG.SEVERIDADE), '-')
                             || ' | ' || TO_CHAR(V_REG.DATA_REGISTRO, 'DD/MM/YYYY'));

        V_TOTAL_MUNICIPIO := V_TOTAL_MUNICIPIO + 1;
        IF V_REG.STATUS = 'CONFIRMADA' THEN
            V_CONFIRMADAS_MUNICIPIO := V_CONFIRMADAS_MUNICIPIO + 1;
        END IF;
    END LOOP;

    IF V_MUNICIPIO_ATUAL IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('  Subtotal: ' || V_TOTAL_MUNICIPIO || ' ocorrência(s), '
                             || V_CONFIRMADAS_MUNICIPIO || ' confirmada(s)');
    END IF;

    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Total: ' || C_OCORRENCIAS%ROWCOUNT || ' ocorrência(s) em '
                         || V_TOTAL_MUNICIPIOS || ' município(s)');
    CLOSE C_OCORRENCIAS;
EXCEPTION
    WHEN OTHERS THEN
        IF C_OCORRENCIAS%ISOPEN THEN
            CLOSE C_OCORRENCIAS;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Erro no bloco de ocorrências por município: ' || SQLERRM);
        RAISE;
END;
/

-- Bloco 2: risco de cada propriedade a partir dos alertas recebidos
DECLARE
    V_ALERTAS_ATIVOS        NUMBER;
    V_MAIOR_SEV_CONFIRMADA  NUMBER;
    V_RISCO                 VARCHAR2(5);
    V_QTD_ALTO              NUMBER := 0;
    V_QTD_MEDIO             NUMBER := 0;
    V_QTD_BAIXO             NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('RISCO DAS PROPRIEDADES PELOS ALERTAS RECEBIDOS');
    DBMS_OUTPUT.PUT_LINE('==============================================');

    FOR P IN (SELECT ID, NOME, MUNICIPIO, UF FROM PROPRIEDADE ORDER BY ID) LOOP
        SELECT COUNT(*),
               NVL(MAX(CASE WHEN A.NIVEL = 'CONFIRMADO' THEN O.SEVERIDADE END), 0)
          INTO V_ALERTAS_ATIVOS, V_MAIOR_SEV_CONFIRMADA
          FROM ALERTA A
          JOIN OCORRENCIA O ON O.ID = A.OCORRENCIA_ID
         WHERE A.PROPRIEDADE_ID = P.ID
           AND A.NIVEL IN ('SUSPEITA', 'CONFIRMADO');

        IF V_MAIOR_SEV_CONFIRMADA >= 4 THEN
            V_RISCO := 'ALTO';
            V_QTD_ALTO := V_QTD_ALTO + 1;
        ELSIF V_ALERTAS_ATIVOS > 0 THEN
            V_RISCO := 'MEDIO';
            V_QTD_MEDIO := V_QTD_MEDIO + 1;
        ELSE
            V_RISCO := 'BAIXO';
            V_QTD_BAIXO := V_QTD_BAIXO + 1;
        END IF;

        DBMS_OUTPUT.PUT_LINE(P.ID || ' ' || P.NOME || ' (' || P.MUNICIPIO || '/' || P.UF || ')'
                             || ' | alertas ativos: ' || V_ALERTAS_ATIVOS
                             || ' | risco ' || V_RISCO);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Resumo: ' || V_QTD_ALTO || ' ALTO, ' || V_QTD_MEDIO || ' MEDIO, '
                         || V_QTD_BAIXO || ' BAIXO');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro no bloco de risco das propriedades: ' || SQLERRM);
        RAISE;
END;
/
