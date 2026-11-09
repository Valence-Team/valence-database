// Relatórios do Valence no MongoDB e equivalentes SQL do oracle/08_relatorios.sql

// Correspondência: mesmos identificadores do Oracle
use('valence');
// select id from ocorrencia order by id; select id from alerta order by id
({
    ocorrencias: db.ocorrencias.distinct('_id'),
    alertas: db.alertas.distinct('_id')
});

// Correspondência: registros relacionais que viraram subdocumentos
use('valence');
// select (select count(*) from triagem), (select count(*) from laudo), (select count(*) from auditoria_ocorrencia) from dual
db.ocorrencias.aggregate([
    {
        $group: {
            _id: null,
            triagensEmbutidas: { $sum: { $cond: [{ $ne: ['$triagem', null] }, 1, 0] } },
            laudosEmbutidos: { $sum: { $size: '$laudos' } },
            historicoEmbutido: { $sum: { $size: '$historicoStatus' } }
        }
    },
    { $project: { _id: 0 } }
]);

// Relatório 1: fila de análise do agrônomo (ocorrências por status)
use('valence');
// select o.id, o.cultura, o.status, o.severidade, t.praga_provavel, p.municipio, p.uf, o.data_registro
//   from ocorrencia o join propriedade p on p.id = o.propriedade_id left join triagem t on t.ocorrencia_id = o.id
//  where o.status in ('TRIADA', 'EM_ANALISE')
//  order by o.severidade desc nulls last, o.data_registro
db.ocorrencias.find(
    { status: { $in: ['TRIADA', 'EM_ANALISE'] } },
    { cultura: 1, status: 1, severidade: 1, 'triagem.pragaProvavel': 1, local: 1, dataRegistro: 1 }
).sort({ severidade: -1, dataRegistro: 1 });

// Relatório 2: alertas ativos recebidos pela propriedade 12
use('valence');
// select a.id, a.ocorrencia_id, a.nivel, a.distancia_km, a.lido, a.criado_em
//   from alerta a
//  where a.propriedade_id = 12 and a.nivel <> 'ENCERRADO'
//  order by a.criado_em desc
db.alertas.find(
    { propriedadeId: 12, nivel: { $ne: 'ENCERRADO' } },
    { propriedadeId: 0 }
).sort({ criadoEm: -1 });

// Relatório 3: ocorrências por praga, município e mês (agregação)
use('valence');
// select nvl(l.praga_confirmada, t.praga_provavel) as praga, p.municipio, p.uf, to_char(o.data_registro, 'YYYY-MM') as mes,
//        count(*) as total, max(o.severidade) as maior_severidade, listagg(o.id, ', ') as ocorrencias
//   from ocorrencia o join propriedade p on p.id = o.propriedade_id
//   left join triagem t on t.ocorrencia_id = o.id
//   left join laudo l on l.ocorrencia_id = o.id and l.decisao = 'CONFIRMADA'
//  where o.status <> 'DESCARTADA' and nvl(l.praga_confirmada, t.praga_provavel) is not null
//  group by praga, p.municipio, p.uf, mes
//  order by total desc, praga, p.municipio, mes
db.ocorrencias.aggregate([
    { $match: { status: { $ne: 'DESCARTADA' } } },
    {
        $addFields: {
            praga: {
                $ifNull: [
                    {
                        $arrayElemAt: [
                            {
                                $map: {
                                    input: {
                                        $filter: {
                                            input: '$laudos',
                                            as: 'laudo',
                                            cond: { $eq: ['$$laudo.decisao', 'CONFIRMADA'] }
                                        }
                                    },
                                    as: 'laudo',
                                    in: '$$laudo.pragaConfirmada'
                                }
                            },
                            0
                        ]
                    },
                    '$triagem.pragaProvavel'
                ]
            }
        }
    },
    { $match: { praga: { $ne: null } } },
    { $sort: { _id: 1 } },
    {
        $group: {
            _id: {
                praga: '$praga',
                municipio: '$local.municipio',
                uf: '$local.uf',
                mes: { $dateToString: { format: '%Y-%m', date: '$dataRegistro' } }
            },
            total: { $sum: 1 },
            maiorSeveridade: { $max: '$severidade' },
            ocorrencias: { $push: '$_id' }
        }
    },
    {
        $project: {
            _id: 0,
            praga: '$_id.praga',
            municipio: '$_id.municipio',
            uf: '$_id.uf',
            mes: '$_id.mes',
            total: '$total',
            maiorSeveridade: '$maiorSeveridade',
            ocorrencias: '$ocorrencias'
        }
    },
    { $sort: { total: -1, praga: 1, municipio: 1, mes: 1 } }
]);