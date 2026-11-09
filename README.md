# Valence · Do Oracle ao MongoDB, dados a serviço do cidadão

Global Solution FIAP 2026/2 · Tema CitizenTech · Mastering Relational and Non-Relational Database

## Integrantes

| RM | Nome |
| --- | --- |
| 563620 | Henrique Martins |
| 562396 | Guilherme Macedo |
| 563405 | Pedro Henrique |

## O problema

Comunidades rurais isoladas descobrem pragas tarde, sem técnico por perto e sem um canal rápido entre vizinhos e poder público. Quando o dano aparece, a praga já se espalhou pelas lavouras próximas, e a perda chega ao produtor e ao consumidor, no preço e na oferta.

- A FAO estima que cerca de 40% da produção agrícola global é perdida para pragas.
- A Embrapa (2026) estima que a cigarrinha-do-milho causa prejuízo de US$ 6,5 bilhões por ano no Brasil, com perda média de 22,7% da produção entre 2020 e 2024.

## A solução

O Valence é uma rede pública e colaborativa de vigilância fitossanitária para pequenos produtores de milho, tomate e batata.

1. O produtor registra o dano na lavoura com foto e descrição.
2. A triagem automática aponta a praga provável e a severidade.
3. As propriedades vizinhas com a mesma cultura recebem um alerta de suspeita.
4. Um agrônomo da extensão rural confirma ou descarta o caso.
5. Os focos confirmados viram dados abertos e anonimizados para o poder público.

| Quem | Benefício |
| --- | --- |
| Agricultor familiar e pequeno produtor | Aviso precoce de pragas na vizinhança e acesso a um agrônomo |
| Agrônomos da extensão rural e defesa agropecuária | Casos estruturados, priorizados por severidade |
| Poder público e sociedade | Dados abertos para política pública |

### ODS

| ODS | Contribuição |
| --- | --- |
| 2 · Fome zero e agricultura sustentável | Reduz perdas de safra com detecção precoce |
| 9 · Indústria, inovação e infraestrutura | Leva dados ao campo com baixo custo |
| 10 · Redução das desigualdades | Dá ao pequeno produtor isolado acesso a técnico |
| 13 · Ação contra a mudança do clima | Monitora pragas que se espalham com o clima |

## O papel do banco de dados

- **Oracle:** guarda o modelo relacional do Valence e implementa as regras de negócio em PL/SQL: registro de ocorrência, cálculo de distância entre propriedades, emissão de alertas no raio, nível de risco e trilha de auditoria.
- **MongoDB:** representa parte dos mesmos dados (ocorrências e alertas) como documentos, com os mesmos identificadores do Oracle.
- **Transição:** não há integração automática entre os bancos. A correspondência é demonstrada por scripts e pela comparação dos resultados das mesmas consultas nos dois modelos.

## Estrutura do repositório

```
valence-database/
  oracle/
    01_ddl.sql
    02_gatilhos.sql
    03_dados.sql
    04_blocos.sql
    05_funcoes_procedimentos.sql
    06_pacotes.sql
    07_testes.sql
    08_relatorios.sql
  mongodb/
    01_setup.js
    02_carga.js
    03_relatorios.js
  evidencias/
  README.md
```

## Pré-requisitos

- **Oracle:** SQL Developer conectado ao Oracle FIAP. Os scripts criam e apagam somente os objetos do Valence; tabelas de outras disciplinas no mesmo schema não são alteradas.
- **MongoDB:** servidor local ou cluster Atlas, VS Code com a extensão MongoDB for VS Code (Playground). O MongoDB Compass é opcional, para conferir os documentos.

## Uso de IA generativa

| Ferramenta | Uso |
| --- | --- |
| Claude (Anthropic) | Planejamento das etapas, revisão dos scripts SQL, PL/SQL e MongoDB, explicação de mensagens de erro do Oracle e do MongoDB e sugestão de cenários de dados de teste |

Todo script foi revisado, executado e entendido pelo integrante responsável antes da entrega. As decisões de modelagem e de regra de negócio seguem o modelo de dados do Valence e o material das aulas da disciplina.
