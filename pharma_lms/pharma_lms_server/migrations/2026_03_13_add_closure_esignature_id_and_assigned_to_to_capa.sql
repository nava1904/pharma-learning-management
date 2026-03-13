ALTER TABLE capa
ADD COLUMN closure_esignature_id INT REFERENCES electronic_signature(id) ON DELETE SET NULL,
ADD COLUMN assigned_to INT REFERENCES user(id) ON DELETE SET NULL;
