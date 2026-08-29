CREATE TABLE IF NOT EXISTS api_keys (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    
    -- key_hash armazena o hash SHA-256 da chave, que tem 64 caracteres hexadecimais
    key_hash VARCHAR(64) NOT NULL UNIQUE, 
    
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Chave exclusiva do ambiente local: local-service-key
INSERT INTO api_keys (name, key_hash)
VALUES ('local-services', '8f2e895eb556e60f9ccfd8cd8e754d5379ef320570fd47a8307e73968a10c3eb')
ON CONFLICT (key_hash) DO NOTHING;
