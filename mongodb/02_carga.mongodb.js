// Carga dos documentos do Valence
use('valence');

db.alertas.deleteMany({});
db.ocorrencias.deleteMany({});

// Ocorrências com triagem, laudos e histórico de status embutidos
db.ocorrencias.insertMany([
    {
        _id: 101,
        propriedadeId: 11,
        usuarioId: 1,
        local: { municipio: 'Chapecó', uf: 'SC' },
        cultura: 'MILHO',
        descricao: 'Folhas do cartucho com faixas amareladas e plantas menores que o normal. Muitos insetos pequenos e claros no cartucho.',
        status: 'CONFIRMADA',
        severidade: 4,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000101',
        dataRegistro: new Date('2026-09-08T07:42:00Z'),
        atualizadoEm: new Date('2026-09-09T16:30:00Z'),
        triagem: {
            pragaProvavel: 'Cigarrinha-do-milho',
            hipoteses: [
                { praga: 'Cigarrinha-do-milho', probabilidade: 0.86 },
                { praga: 'Enfezamento-pálido', probabilidade: 0.09 }
            ],
            confianca: 0.86,
            severidade: 4,
            cuidadosImediatos: [
                'Isolar e marcar a área com sintomas',
                'Avisar os vizinhos que plantam milho',
                'Aguardar a orientação do agrônomo antes de qualquer manejo'
            ],
            textoAlerta: 'Suspeita de cigarrinha-do-milho a poucos quilômetros. Verifique o cartucho das plantas.',
            encaminharAgronomo: false,
            explicacao: 'Faixas amareladas e insetos claros no cartucho são sinais típicos da cigarrinha-do-milho (Dalbulus maidis), vetor dos enfezamentos.',
            fontes: [
                { titulo: 'Cigarrinha-do-milho e enfezamentos', fonte: 'Embrapa Milho e Sorgo', url: 'https://www.embrapa.br/milho-e-sorgo' }
            ],
            motivoImagem: null,
            geradaEm: new Date('2026-09-08T07:43:00Z')
        },
        laudos: [
            {
                id: 401,
                agronomoId: 8,
                decisao: 'CONFIRMADA',
                pragaConfirmada: 'Cigarrinha-do-milho',
                parecer: 'Vistoria confirmou alta população de Dalbulus maidis no cartucho e sintomas iniciais de enfezamento. Recomendado monitoramento semanal na vizinhança.',
                emitidoEm: new Date('2026-09-09T16:30:00Z')
            }
        ],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-09-08T07:42:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'RECEBIDA', statusNovo: 'TRIADA', severidadeAnterior: null, severidadeNova: 4, em: new Date('2026-09-08T07:43:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'TRIADA', statusNovo: 'EM_ANALISE', severidadeAnterior: 4, severidadeNova: 4, em: new Date('2026-09-09T10:15:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'EM_ANALISE', statusNovo: 'CONFIRMADA', severidadeAnterior: 4, severidadeNova: 4, em: new Date('2026-09-09T16:30:00Z') }
        ]
    },
    {
        _id: 102,
        propriedadeId: 12,
        usuarioId: 2,
        local: { municipio: 'Guatambu', uf: 'SC' },
        cultura: 'MILHO',
        descricao: 'Folhas raspadas e furos no cartucho, com fezes de lagarta. Cerca de 20% das plantas da lavoura atingidas.',
        status: 'CONFIRMADA',
        severidade: 3,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000102',
        dataRegistro: new Date('2026-09-22T08:10:00Z'),
        atualizadoEm: new Date('2026-09-23T14:20:00Z'),
        triagem: {
            pragaProvavel: 'Lagarta-do-cartucho',
            hipoteses: [
                { praga: 'Lagarta-do-cartucho', probabilidade: 0.91 },
                { praga: 'Lagarta-da-espiga', probabilidade: 0.05 }
            ],
            confianca: 0.91,
            severidade: 3,
            cuidadosImediatos: [
                'Vistoriar plantas em pontos diferentes da lavoura',
                'Avisar os vizinhos que plantam milho',
                'Aguardar a orientação do agrônomo antes de qualquer manejo'
            ],
            textoAlerta: 'Suspeita de lagarta-do-cartucho na vizinhança. Confira as folhas do cartucho.',
            encaminharAgronomo: false,
            explicacao: 'Folhas raspadas e fezes no cartucho indicam a lagarta-do-cartucho (Spodoptera frugiperda).',
            fontes: [
                { titulo: 'Lagarta-do-cartucho no milho', fonte: 'Embrapa Milho e Sorgo', url: 'https://www.embrapa.br/milho-e-sorgo' }
            ],
            motivoImagem: null,
            geradaEm: new Date('2026-09-22T08:11:00Z')
        },
        laudos: [
            {
                id: 402,
                agronomoId: 8,
                decisao: 'CONFIRMADA',
                pragaConfirmada: 'Lagarta-do-cartucho',
                parecer: 'Lagartas de Spodoptera frugiperda encontradas em cerca de 20% das plantas, acima do nível de alerta para a fase da lavoura.',
                emitidoEm: new Date('2026-09-23T14:20:00Z')
            }
        ],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-09-22T08:10:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'RECEBIDA', statusNovo: 'TRIADA', severidadeAnterior: null, severidadeNova: 3, em: new Date('2026-09-22T08:11:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'TRIADA', statusNovo: 'EM_ANALISE', severidadeAnterior: 3, severidadeNova: 3, em: new Date('2026-09-23T09:00:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'EM_ANALISE', statusNovo: 'CONFIRMADA', severidadeAnterior: 3, severidadeNova: 3, em: new Date('2026-09-23T14:20:00Z') }
        ]
    },
    {
        _id: 103,
        propriedadeId: 13,
        usuarioId: 3,
        local: { municipio: 'Cordilheira Alta', uf: 'SC' },
        cultura: 'MILHO',
        descricao: 'Plantas com folhas avermelhadas nas pontas e espigas pequenas. Vi cigarrinhas nas folhas.',
        status: 'TRIADA',
        severidade: 3,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000103',
        dataRegistro: new Date('2026-10-06T16:05:00Z'),
        atualizadoEm: new Date('2026-10-06T16:06:00Z'),
        triagem: {
            pragaProvavel: 'Enfezamento-vermelho',
            hipoteses: [
                { praga: 'Enfezamento-vermelho', probabilidade: 0.71 },
                { praga: 'Cigarrinha-do-milho', probabilidade: 0.22 }
            ],
            confianca: 0.71,
            severidade: 3,
            cuidadosImediatos: [
                'Marcar as plantas com folhas avermelhadas',
                'Avisar os vizinhos que plantam milho',
                'Aguardar a orientação do agrônomo antes de qualquer manejo'
            ],
            textoAlerta: 'Suspeita de enfezamento no milho na região. Observe folhas avermelhadas.',
            encaminharAgronomo: false,
            explicacao: 'Folhas avermelhadas e espigas pequenas, com cigarrinhas presentes, indicam enfezamento-vermelho causado por fitoplasma.',
            fontes: [
                { titulo: 'Enfezamentos do milho', fonte: 'Embrapa Milho e Sorgo', url: 'https://www.embrapa.br/milho-e-sorgo' }
            ],
            motivoImagem: null,
            geradaEm: new Date('2026-10-06T16:06:00Z')
        },
        laudos: [],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-10-06T16:05:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'RECEBIDA', statusNovo: 'TRIADA', severidadeAnterior: null, severidadeNova: 3, em: new Date('2026-10-06T16:06:00Z') }
        ]
    },
    {
        _id: 104,
        propriedadeId: 11,
        usuarioId: 1,
        local: { municipio: 'Chapecó', uf: 'SC' },
        cultura: 'MILHO',
        descricao: 'Manchas alaranjadas nas folhas de baixo, parecidas com ferrugem, aparecendo depois das chuvas.',
        status: 'DESCARTADA',
        severidade: 2,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000104',
        dataRegistro: new Date('2026-10-20T07:30:00Z'),
        atualizadoEm: new Date('2026-10-22T15:40:00Z'),
        triagem: {
            pragaProvavel: 'Ferrugem-comum',
            hipoteses: [
                { praga: 'Ferrugem-comum', probabilidade: 0.64 },
                { praga: 'Ferrugem-polissora', probabilidade: 0.21 }
            ],
            confianca: 0.64,
            severidade: 2,
            cuidadosImediatos: [
                'Observar se as manchas avançam para as folhas de cima',
                'Avisar os vizinhos que plantam milho'
            ],
            textoAlerta: 'Suspeita de ferrugem no milho na região. Observe as folhas de baixo.',
            encaminharAgronomo: false,
            explicacao: 'Pústulas alaranjadas nas folhas inferiores após chuvas são compatíveis com ferrugem-comum (Puccinia sorghi).',
            fontes: [
                { titulo: 'Doenças foliares do milho', fonte: 'Embrapa Milho e Sorgo', url: 'https://www.embrapa.br/milho-e-sorgo' }
            ],
            motivoImagem: null,
            geradaEm: new Date('2026-10-20T07:31:00Z')
        },
        laudos: [
            {
                id: 404,
                agronomoId: 8,
                decisao: 'DESCARTADA',
                pragaConfirmada: null,
                parecer: 'As manchas vêm de deficiência de potássio nas folhas inferiores. Não há pústulas de ferrugem nas amostras analisadas.',
                emitidoEm: new Date('2026-10-22T15:40:00Z')
            }
        ],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-10-20T07:30:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'RECEBIDA', statusNovo: 'TRIADA', severidadeAnterior: null, severidadeNova: 2, em: new Date('2026-10-20T07:31:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'TRIADA', statusNovo: 'EM_ANALISE', severidadeAnterior: 2, severidadeNova: 2, em: new Date('2026-10-21T11:00:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'EM_ANALISE', statusNovo: 'DESCARTADA', severidadeAnterior: 2, severidadeNova: 2, em: new Date('2026-10-22T15:40:00Z') }
        ]
    },
    {
        _id: 105,
        propriedadeId: 15,
        usuarioId: 4,
        local: { municipio: 'Caçador', uf: 'SC' },
        cultura: 'TOMATE',
        descricao: 'Manchas escuras e encharcadas nas folhas e nos frutos, com mofo branco embaixo das folhas depois de dias úmidos.',
        status: 'CONFIRMADA',
        severidade: 5,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000105',
        dataRegistro: new Date('2026-09-15T06:50:00Z'),
        atualizadoEm: new Date('2026-09-15T17:10:00Z'),
        triagem: {
            pragaProvavel: 'Requeima',
            hipoteses: [
                { praga: 'Requeima', probabilidade: 0.93 },
                { praga: 'Pinta-preta', probabilidade: 0.04 }
            ],
            confianca: 0.93,
            severidade: 5,
            cuidadosImediatos: [
                'Retirar e separar as plantas mais atacadas',
                'Evitar molhar as folhas na irrigação',
                'Avisar os vizinhos que plantam tomate'
            ],
            textoAlerta: 'Suspeita grave de requeima no tomate a poucos quilômetros. Verifique folhas e frutos.',
            encaminharAgronomo: false,
            explicacao: 'Lesões encharcadas com mofo branco após dias úmidos são o sinal clássico da requeima (Phytophthora infestans).',
            fontes: [
                { titulo: 'Requeima do tomateiro', fonte: 'Embrapa Hortaliças', url: 'https://www.embrapa.br/hortalicas' }
            ],
            motivoImagem: null,
            geradaEm: new Date('2026-09-15T06:51:00Z')
        },
        laudos: [
            {
                id: 405,
                agronomoId: 8,
                decisao: 'CONFIRMADA',
                pragaConfirmada: 'Requeima',
                parecer: 'Lesões com esporulação branca típica de Phytophthora infestans em folhas e frutos. Alto risco de espalhamento com o tempo úmido.',
                emitidoEm: new Date('2026-09-15T17:10:00Z')
            }
        ],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-09-15T06:50:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'RECEBIDA', statusNovo: 'TRIADA', severidadeAnterior: null, severidadeNova: 5, em: new Date('2026-09-15T06:51:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'TRIADA', statusNovo: 'EM_ANALISE', severidadeAnterior: 5, severidadeNova: 5, em: new Date('2026-09-15T13:00:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'EM_ANALISE', statusNovo: 'CONFIRMADA', severidadeAnterior: 5, severidadeNova: 5, em: new Date('2026-09-15T17:10:00Z') }
        ]
    },
    {
        _id: 106,
        propriedadeId: 16,
        usuarioId: 5,
        local: { municipio: 'Caçador', uf: 'SC' },
        cultura: 'TOMATE',
        descricao: 'Folhas com minas transparentes e frutos com furos pequenos. Achei lagartinhas dentro dos frutos.',
        status: 'EM_ANALISE',
        severidade: 3,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000106',
        dataRegistro: new Date('2026-10-02T09:20:00Z'),
        atualizadoEm: new Date('2026-10-03T10:00:00Z'),
        triagem: {
            pragaProvavel: 'Traça-do-tomateiro',
            hipoteses: [
                { praga: 'Traça-do-tomateiro', probabilidade: 0.78 },
                { praga: 'Mosca-minadora', probabilidade: 0.15 }
            ],
            confianca: 0.78,
            severidade: 3,
            cuidadosImediatos: [
                'Retirar os frutos furados da lavoura',
                'Avisar os vizinhos que plantam tomate'
            ],
            textoAlerta: 'Suspeita de traça-do-tomateiro na região. Confira minas nas folhas e furos nos frutos.',
            encaminharAgronomo: false,
            explicacao: 'Minas nas folhas e lagartas dentro dos frutos indicam a traça-do-tomateiro (Tuta absoluta).',
            fontes: [
                { titulo: 'Traça-do-tomateiro', fonte: 'Embrapa Hortaliças', url: 'https://www.embrapa.br/hortalicas' }
            ],
            motivoImagem: null,
            geradaEm: new Date('2026-10-02T09:21:00Z')
        },
        laudos: [
            {
                id: 406,
                agronomoId: 8,
                decisao: 'MAIS_INFORMACOES',
                pragaConfirmada: null,
                parecer: 'Enviar fotos das folhas novas e dos frutos com galerias, de perto, para confirmar a presença da traça.',
                emitidoEm: new Date('2026-10-03T10:00:00Z')
            }
        ],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-10-02T09:20:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'RECEBIDA', statusNovo: 'TRIADA', severidadeAnterior: null, severidadeNova: 3, em: new Date('2026-10-02T09:21:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'TRIADA', statusNovo: 'EM_ANALISE', severidadeAnterior: 3, severidadeNova: 3, em: new Date('2026-10-03T10:00:00Z') }
        ]
    },
    {
        _id: 107,
        propriedadeId: 15,
        usuarioId: 4,
        local: { municipio: 'Caçador', uf: 'SC' },
        cultura: 'TOMATE',
        descricao: 'Muitos insetos brancos pequenos que voam quando mexo nas plantas, e folhas ficando amareladas.',
        status: 'RECEBIDA',
        severidade: null,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000107',
        dataRegistro: new Date('2026-11-03T18:15:00Z'),
        atualizadoEm: new Date('2026-11-03T18:15:00Z'),
        triagem: null,
        laudos: [],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-11-03T18:15:00Z') }
        ]
    },
    {
        _id: 108,
        propriedadeId: 18,
        usuarioId: 6,
        local: { municipio: 'Vargem Grande do Sul', uf: 'SP' },
        cultura: 'BATATA',
        descricao: 'Manchas marrom-escuras nas folhas e hastes, com cheiro forte, espalhando rápido depois da garoa.',
        status: 'CONFIRMADA',
        severidade: 4,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000108',
        dataRegistro: new Date('2026-09-10T07:05:00Z'),
        atualizadoEm: new Date('2026-09-11T09:45:00Z'),
        triagem: {
            pragaProvavel: 'Requeima',
            hipoteses: [
                { praga: 'Requeima', probabilidade: 0.88 },
                { praga: 'Pinta-preta', probabilidade: 0.08 }
            ],
            confianca: 0.88,
            severidade: 4,
            cuidadosImediatos: [
                'Separar as plantas com lesões',
                'Evitar irrigação por aspersão no fim do dia',
                'Avisar os vizinhos que plantam batata'
            ],
            textoAlerta: 'Suspeita de requeima na batata na vizinhança. Verifique folhas e hastes.',
            encaminharAgronomo: false,
            explicacao: 'Manchas escuras em folhas e hastes, com avanço rápido em tempo úmido, indicam requeima (Phytophthora infestans).',
            fontes: [
                { titulo: 'Requeima da batata', fonte: 'Embrapa Hortaliças', url: 'https://www.embrapa.br/hortalicas' }
            ],
            motivoImagem: null,
            geradaEm: new Date('2026-09-10T07:06:00Z')
        },
        laudos: [
            {
                id: 408,
                agronomoId: 9,
                decisao: 'CONFIRMADA',
                pragaConfirmada: 'Requeima',
                parecer: 'Lesões escuras em folhas e hastes com esporulação de Phytophthora infestans. Situação favorecida pela garoa da última semana.',
                emitidoEm: new Date('2026-09-11T09:45:00Z')
            }
        ],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-09-10T07:05:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'RECEBIDA', statusNovo: 'TRIADA', severidadeAnterior: null, severidadeNova: 4, em: new Date('2026-09-10T07:06:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'TRIADA', statusNovo: 'EM_ANALISE', severidadeAnterior: 4, severidadeNova: 4, em: new Date('2026-09-10T15:30:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'EM_ANALISE', statusNovo: 'CONFIRMADA', severidadeAnterior: 4, severidadeNova: 4, em: new Date('2026-09-11T09:45:00Z') }
        ]
    },
    {
        _id: 109,
        propriedadeId: 19,
        usuarioId: 7,
        local: { municipio: 'Vargem Grande do Sul', uf: 'SP' },
        cultura: 'BATATA',
        descricao: 'Manchas circulares escuras com anéis nas folhas mais velhas, que estão secando de baixo para cima.',
        status: 'CONFIRMADA',
        severidade: 3,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000109',
        dataRegistro: new Date('2026-10-12T08:40:00Z'),
        atualizadoEm: new Date('2026-10-13T16:00:00Z'),
        triagem: {
            pragaProvavel: 'Pinta-preta',
            hipoteses: [
                { praga: 'Pinta-preta', probabilidade: 0.84 },
                { praga: 'Requeima', probabilidade: 0.1 }
            ],
            confianca: 0.84,
            severidade: 3,
            cuidadosImediatos: [
                'Retirar as folhas velhas mais atacadas',
                'Avisar os vizinhos que plantam batata'
            ],
            textoAlerta: 'Suspeita de pinta-preta na batata na região. Observe manchas com anéis.',
            encaminharAgronomo: false,
            explicacao: 'Manchas circulares com anéis nas folhas velhas são típicas da pinta-preta (Alternaria solani).',
            fontes: [
                { titulo: 'Pinta-preta da batata', fonte: 'Embrapa Hortaliças', url: 'https://www.embrapa.br/hortalicas' }
            ],
            motivoImagem: null,
            geradaEm: new Date('2026-10-12T08:41:00Z')
        },
        laudos: [
            {
                id: 409,
                agronomoId: 9,
                decisao: 'CONFIRMADA',
                pragaConfirmada: 'Pinta-preta',
                parecer: 'Manchas com anéis concêntricos de Alternaria solani nas folhas velhas, com avanço moderado na lavoura.',
                emitidoEm: new Date('2026-10-13T16:00:00Z')
            }
        ],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-10-12T08:40:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'RECEBIDA', statusNovo: 'TRIADA', severidadeAnterior: null, severidadeNova: 3, em: new Date('2026-10-12T08:41:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'TRIADA', statusNovo: 'EM_ANALISE', severidadeAnterior: 3, severidadeNova: 3, em: new Date('2026-10-13T10:20:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'EM_ANALISE', statusNovo: 'CONFIRMADA', severidadeAnterior: 3, severidadeNova: 3, em: new Date('2026-10-13T16:00:00Z') }
        ]
    },
    {
        _id: 110,
        propriedadeId: 20,
        usuarioId: 6,
        local: { municipio: 'São João da Boa Vista', uf: 'SP' },
        cultura: 'BATATA',
        descricao: 'Tubérculos com furos finos e galerias por dentro, encontrados na colheita do talhão de baixo.',
        status: 'EM_ANALISE',
        severidade: null,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000110',
        dataRegistro: new Date('2026-10-28T17:30:00Z'),
        atualizadoEm: new Date('2026-10-28T17:31:00Z'),
        triagem: {
            pragaProvavel: null,
            hipoteses: null,
            confianca: null,
            severidade: null,
            cuidadosImediatos: null,
            textoAlerta: null,
            encaminharAgronomo: true,
            explicacao: null,
            fontes: null,
            motivoImagem: 'IMAGEM_BORRADA',
            geradaEm: new Date('2026-10-28T17:31:00Z')
        },
        laudos: [],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-10-28T17:30:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'RECEBIDA', statusNovo: 'EM_ANALISE', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-10-28T17:31:00Z') }
        ]
    },
    {
        _id: 111,
        propriedadeId: 19,
        usuarioId: 7,
        local: { municipio: 'Vargem Grande do Sul', uf: 'SP' },
        cultura: 'TOMATE',
        descricao: 'Folhas do tomate com manchas grandes e escuras e caule com lesões, depois de uma semana de chuva.',
        status: 'TRIADA',
        severidade: 4,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000111',
        dataRegistro: new Date('2026-11-04T07:55:00Z'),
        atualizadoEm: new Date('2026-11-04T07:56:00Z'),
        triagem: {
            pragaProvavel: 'Requeima',
            hipoteses: [
                { praga: 'Requeima', probabilidade: 0.9 },
                { praga: 'Pinta-preta', probabilidade: 0.06 }
            ],
            confianca: 0.9,
            severidade: 4,
            cuidadosImediatos: [
                'Retirar e separar as plantas mais atacadas',
                'Evitar molhar as folhas na irrigação',
                'Avisar os vizinhos que plantam tomate'
            ],
            textoAlerta: 'Suspeita de requeima no tomate na região. Verifique folhas e caules.',
            encaminharAgronomo: false,
            explicacao: 'Manchas grandes e escuras com lesões no caule após chuva contínua indicam requeima (Phytophthora infestans).',
            fontes: [
                { titulo: 'Requeima do tomateiro', fonte: 'Embrapa Hortaliças', url: 'https://www.embrapa.br/hortalicas' }
            ],
            motivoImagem: null,
            geradaEm: new Date('2026-11-04T07:56:00Z')
        },
        laudos: [],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-11-04T07:55:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'RECEBIDA', statusNovo: 'TRIADA', severidadeAnterior: null, severidadeNova: 4, em: new Date('2026-11-04T07:56:00Z') }
        ]
    },
    {
        _id: 112,
        propriedadeId: 11,
        usuarioId: 1,
        local: { municipio: 'Chapecó', uf: 'SC' },
        cultura: 'MILHO',
        descricao: 'Outro talhão com folhas amareladas e muitas cigarrinhas no cartucho, parecido com o caso anterior.',
        status: 'TRIADA',
        severidade: 4,
        idempotencyKey: '6f1c8a2e-1b3d-4e5f-9a10-000000000112',
        dataRegistro: new Date('2026-09-29T08:20:00Z'),
        atualizadoEm: new Date('2026-09-29T08:21:00Z'),
        triagem: {
            pragaProvavel: 'Cigarrinha-do-milho',
            hipoteses: [
                { praga: 'Cigarrinha-do-milho', probabilidade: 0.83 },
                { praga: 'Enfezamento-pálido', probabilidade: 0.12 }
            ],
            confianca: 0.83,
            severidade: 4,
            cuidadosImediatos: [
                'Isolar e marcar a área com sintomas',
                'Avisar os vizinhos que plantam milho',
                'Aguardar a orientação do agrônomo antes de qualquer manejo'
            ],
            textoAlerta: 'Nova suspeita de cigarrinha-do-milho a poucos quilômetros. Verifique o cartucho das plantas.',
            encaminharAgronomo: false,
            explicacao: 'Folhas amareladas e grande número de cigarrinhas no cartucho indicam a cigarrinha-do-milho (Dalbulus maidis).',
            fontes: [
                { titulo: 'Cigarrinha-do-milho e enfezamentos', fonte: 'Embrapa Milho e Sorgo', url: 'https://www.embrapa.br/milho-e-sorgo' }
            ],
            motivoImagem: null,
            geradaEm: new Date('2026-09-29T08:21:00Z')
        },
        laudos: [],
        historicoStatus: [
            { operacao: 'INSERT', statusAnterior: null, statusNovo: 'RECEBIDA', severidadeAnterior: null, severidadeNova: null, em: new Date('2026-09-29T08:20:00Z') },
            { operacao: 'UPDATE', statusAnterior: 'RECEBIDA', statusNovo: 'TRIADA', severidadeAnterior: null, severidadeNova: 4, em: new Date('2026-09-29T08:21:00Z') }
        ]
    }
]);

// Alertas com referência à ocorrência e à propriedade
db.alertas.insertMany([
    { _id: 301, ocorrenciaId: 101, propriedadeId: 12, nivel: 'CONFIRMADO', distanciaKm: 9, lido: true, criadoEm: new Date('2026-09-08T07:44:00Z') },
    { _id: 302, ocorrenciaId: 101, propriedadeId: 13, nivel: 'CONFIRMADO', distanciaKm: 7, lido: false, criadoEm: new Date('2026-09-08T07:44:00Z') },
    { _id: 303, ocorrenciaId: 102, propriedadeId: 11, nivel: 'CONFIRMADO', distanciaKm: 9, lido: true, criadoEm: new Date('2026-09-22T08:12:00Z') },
    { _id: 304, ocorrenciaId: 103, propriedadeId: 11, nivel: 'SUSPEITA', distanciaKm: 7, lido: false, criadoEm: new Date('2026-10-06T16:07:00Z') },
    { _id: 305, ocorrenciaId: 104, propriedadeId: 12, nivel: 'ENCERRADO', distanciaKm: 9, lido: true, criadoEm: new Date('2026-10-20T07:32:00Z') },
    { _id: 306, ocorrenciaId: 104, propriedadeId: 13, nivel: 'ENCERRADO', distanciaKm: 7, lido: true, criadoEm: new Date('2026-10-20T07:32:00Z') },
    { _id: 307, ocorrenciaId: 105, propriedadeId: 16, nivel: 'CONFIRMADO', distanciaKm: 5, lido: true, criadoEm: new Date('2026-09-15T06:52:00Z') },
    { _id: 308, ocorrenciaId: 106, propriedadeId: 15, nivel: 'SUSPEITA', distanciaKm: 5, lido: false, criadoEm: new Date('2026-10-02T09:22:00Z') },
    { _id: 309, ocorrenciaId: 108, propriedadeId: 19, nivel: 'CONFIRMADO', distanciaKm: 8, lido: true, criadoEm: new Date('2026-09-10T07:07:00Z') },
    { _id: 310, ocorrenciaId: 109, propriedadeId: 18, nivel: 'CONFIRMADO', distanciaKm: 8, lido: false, criadoEm: new Date('2026-10-12T08:42:00Z') },
    { _id: 311, ocorrenciaId: 112, propriedadeId: 12, nivel: 'SUSPEITA', distanciaKm: 9, lido: false, criadoEm: new Date('2026-09-29T08:22:00Z') },
    { _id: 312, ocorrenciaId: 112, propriedadeId: 13, nivel: 'SUSPEITA', distanciaKm: 7, lido: false, criadoEm: new Date('2026-09-29T08:22:00Z') }
]);

// Conferência da carga
({
    ocorrencias: db.ocorrencias.countDocuments(),
    alertas: db.alertas.countDocuments(),
    totalDocumentos: db.ocorrencias.countDocuments() + db.alertas.countDocuments(),
    triagensEmbutidas: db.ocorrencias.countDocuments({ triagem: { $ne: null } }),
    laudosEmbutidos: db.ocorrencias.aggregate([{ $group: { _id: null, total: { $sum: { $size: '$laudos' } } } }]).toArray()[0].total,
    historicoEmbutido: db.ocorrencias.aggregate([{ $group: { _id: null, total: { $sum: { $size: '$historicoStatus' } } } }]).toArray()[0].total
});