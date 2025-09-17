-- Create n8n database
CREATE DATABASE n8n_db;

-- Grant privileges to postgres user for n8n database
GRANT ALL PRIVILEGES ON DATABASE n8n_db TO postgres;