// Database e coleções do Valence
use('valence');

db.alertas.drop();
db.ocorrencias.drop();

// Coleção de ocorrências: triagem, laudos e histórico de status embutidos
db.createCollection('ocorrencias', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            required: ['_id', 'propriedadeId', 'usuarioId', 'local', 'cultura', 'descricao', 'status',
                       'idempotencyKey', 'dataRegistro', 'laudos', 'historicoStatus'],
            properties: {
                _id: { bsonType: 'number' },
                propriedadeId: { bsonType: 'number' },
                usuarioId: { bsonType: 'number' },
                local: {
                    bsonType: 'object',
                    required: ['municipio', 'uf'],
                    properties: {
                        municipio: { bsonType: 'string', maxLength: 100 },
                        uf: { bsonType: 'string', pattern: '^[A-Z]{2}$' }
                    }
                },
                cultura: { enum: ['MILHO', 'TOMATE', 'BATATA'] },
                descricao: { bsonType: 'string', minLength: 10, maxLength: 1000 },
                status: { enum: ['RECEBIDA', 'TRIADA', 'EM_ANALISE', 'CONFIRMADA', 'DESCARTADA'] },
                severidade: { bsonType: ['number', 'null'], minimum: 1, maximum: 5 },
                idempotencyKey: {
                    bsonType: 'string',
                    pattern: '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
                },
                dataRegistro: { bsonType: 'date' },
                atualizadoEm: { bsonType: ['date', 'null'] },
                triagem: {
                    bsonType: ['object', 'null'],
                    required: ['encaminharAgronomo', 'geradaEm'],
                    properties: {
                        pragaProvavel: { bsonType: ['string', 'null'] },
                        hipoteses: { bsonType: ['array', 'null'] },
                        confianca: { bsonType: ['number', 'null'], minimum: 0, maximum: 1 },
                        severidade: { bsonType: ['number', 'null'], minimum: 1, maximum: 5 },
                        cuidadosImediatos: { bsonType: ['array', 'null'] },
                        encaminharAgronomo: { bsonType: 'bool' },
                        fontes: { bsonType: ['array', 'null'] },
                        motivoImagem: {
                            enum: ['RESOLUCAO_BAIXA', 'IMAGEM_ESCURA', 'IMAGEM_CLARA', 'IMAGEM_BORRADA',
                                   'NAO_E_PLANTA', 'CULTURA_FORA_DO_ESCOPO', 'CULTURA_DIVERGENTE', null]
                        },
                        geradaEm: { bsonType: 'date' }
                    }
                },
                laudos: {
                    bsonType: 'array',
                    items: {
                        bsonType: 'object',
                        required: ['id', 'agronomoId', 'decisao', 'parecer', 'emitidoEm'],
                        properties: {
                            decisao: { enum: ['CONFIRMADA', 'DESCARTADA', 'MAIS_INFORMACOES'] },
                            parecer: { bsonType: 'string', minLength: 20, maxLength: 2000 },
                            emitidoEm: { bsonType: 'date' }
                        }
                    }
                },
                historicoStatus: {
                    bsonType: 'array',
                    minItems: 1,
                    items: {
                        bsonType: 'object',
                        required: ['operacao', 'em'],
                        properties: {
                            operacao: { enum: ['INSERT', 'UPDATE', 'DELETE'] },
                            em: { bsonType: 'date' }
                        }
                    }
                }
            }
        }
    },
    validationLevel: 'strict',
    validationAction: 'error'
});

// Coleção de alertas: referência à ocorrência e à propriedade
db.createCollection('alertas', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            required: ['_id', 'ocorrenciaId', 'propriedadeId', 'nivel', 'distanciaKm', 'lido', 'criadoEm'],
            properties: {
                _id: { bsonType: 'number' },
                ocorrenciaId: { bsonType: 'number' },
                propriedadeId: { bsonType: 'number' },
                nivel: { enum: ['SUSPEITA', 'CONFIRMADO', 'ENCERRADO'] },
                distanciaKm: { bsonType: 'number', minimum: 1 },
                lido: { bsonType: 'bool' },
                criadoEm: { bsonType: 'date' }
            }
        }
    },
    validationLevel: 'strict',
    validationAction: 'error'
});

// Índices
db.ocorrencias.createIndex({ status: 1, severidade: -1, dataRegistro: 1 }, { name: 'ix_ocorrencias_fila' });
db.ocorrencias.createIndex({ 'local.uf': 1, 'local.municipio': 1 }, { name: 'ix_ocorrencias_local' });
db.ocorrencias.createIndex({ usuarioId: 1, idempotencyKey: 1 }, { name: 'ux_ocorrencias_idempotencia', unique: true });
db.alertas.createIndex({ propriedadeId: 1, criadoEm: -1 }, { name: 'ix_alertas_propriedade' });
db.alertas.createIndex({ ocorrenciaId: 1, propriedadeId: 1 }, { name: 'ux_alertas_ocorrencia_propriedade', unique: true });

// Conferência da estrutura
({
    database: db.getName(),
    colecoes: db.getCollectionNames().sort(),
    indicesOcorrencias: db.ocorrencias.getIndexes().map(indice => indice.name),
    indicesAlertas: db.alertas.getIndexes().map(indice => indice.name)
});