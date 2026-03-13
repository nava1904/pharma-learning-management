ALTER TABLE course_version
ADD COLUMN esignature_id INT REFERENCES electronic_signature(id) ON DELETE SET NULL;
