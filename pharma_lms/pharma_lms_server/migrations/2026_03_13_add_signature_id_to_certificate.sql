ALTER TABLE certificate
ADD COLUMN signature_id INT REFERENCES electronic_signature(id) ON DELETE SET NULL;
