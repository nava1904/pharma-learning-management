# S3/MinIO Object Storage Setup

Pharma LMS can use S3-compatible object storage (AWS S3 or MinIO) for documents, training materials, and file uploads.

## Configuration

Add the `storage.s3` section to `config/production.yaml` (or your environment config):

```yaml
storage:
  s3:
    enabled: true
    endpoint: https://s3.amazonaws.com   # For MinIO: http://minio:9000
    region: us-east-1
    bucket: pharma-lms-storage
    accessKey: ${S3_ACCESS_KEY}
    secretKey: ${S3_SECRET_KEY}
```

### AWS S3

- **endpoint:** `https://s3.amazonaws.com` or leave empty for default
- **region:** Your AWS region (e.g. `us-east-1`, `eu-west-1`)
- **bucket:** Create a dedicated bucket (e.g. `pharma-lms-storage`)
- **Credentials:** Set `S3_ACCESS_KEY` and `S3_SECRET_KEY` environment variables, or use IAM roles when running on AWS (EC2, ECS, Lambda)

### MinIO (On-Prem / Development)

MinIO is S3-compatible and suitable for on-premises or development environments.

1. **Run MinIO via Docker:**
   ```bash
   docker run -d -p 9000:9000 -p 9001:9001 \
     -e MINIO_ROOT_USER=minioadmin \
     -e MINIO_ROOT_PASSWORD=minioadmin \
     minio/minio server /data --console-address ":9001"
   ```

2. **Create a bucket:**
   - Open http://localhost:9001
   - Login with minioadmin/minioadmin
   - Create bucket `pharma-lms-storage`

3. **Config for MinIO:**
   ```yaml
   storage:
     s3:
       enabled: true
       endpoint: http://minio:9000   # Use hostname that resolves to MinIO
       region: us-east-1
       bucket: pharma-lms-storage
       accessKey: minioadmin
       secretKey: minioadmin
       pathStyle: true   # Required for MinIO
   ```

## Environment Variables

| Variable        | Description                    | Example                    |
|----------------|--------------------------------|----------------------------|
| S3_ACCESS_KEY  | Access key for S3/MinIO        | `AKIA...` or `minioadmin` |
| S3_SECRET_KEY  | Secret key for S3/MinIO        | (secret)                   |
| S3_BUCKET      | Override bucket name (optional)| `pharma-lms-storage`       |
| S3_ENDPOINT    | Override endpoint (optional)   | `http://minio:9000`        |

## Security

- **Never commit** access keys or secrets to version control.
- Use environment variables or a secrets manager (e.g. AWS Secrets Manager, HashiCorp Vault).
- For production, use IAM roles when running on AWS.
- Enable bucket versioning for audit and recovery.
- Configure bucket policies to restrict access.

## Storage Paths

Pharma LMS uses the following logical paths:

- `materials/{orgId}/{materialId}/` – Course materials (PDFs, videos)
- `documents/{orgId}/{documentId}/{version}/` – Document versions
- `waivers/{waiverId}/` – Training waiver evidence files

## Integration Notes

The storage config is read from the Serverpod config. Implement a storage service that:

1. Reads `storage.s3` from `session.serverpod.config`
2. Uses `dart:io` HttpClient or an S3 client package (e.g. `aws_s3_upload`) for uploads
3. Generates presigned URLs for secure, time-limited downloads
4. Falls back to local filesystem or Serverpod storage when S3 is disabled
