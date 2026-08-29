# Manifestos Kubernetes - ToggleMaster

Esta pasta contém os manifestos básicos dos cinco microsserviços, conforme os requisitos da Fase 2.

## Pré-requisitos no cluster

Antes das aplicações, o cluster precisa ter:

1. Metrics Server.
2. Nginx Ingress Controller.
3. As imagens dos cinco serviços publicadas no ECR.
4. As roles IAM do `evaluation-service` e do `analytics-service`.
5. Os três RDS PostgreSQL, o ElastiCache Redis, a fila SQS e a tabela DynamoDB.

## Valores que serão substituídos

Antes do deploy, substitua `000000000000` pelo ID da conta AWS nos Deployments e ServiceAccounts.

As imagens estão configuradas inicialmente com a tag `latest` e na região `us-east-1`.

## Secrets

Os arquivos `secret.yaml` serão criados em uma etapa posterior e estão ignorados pelo Git.

Os Deployments esperam os seguintes Secrets:

- `auth-service-secret`: `DATABASE_URL` e `MASTER_KEY`.
- `flag-service-secret`: `DATABASE_URL`.
- `targeting-service-secret`: `DATABASE_URL`.
- `evaluation-service-secret`: `REDIS_URL`, `SERVICE_API_KEY` e `AWS_SQS_URL`.
- `analytics-service-secret`: `AWS_SQS_URL`.

Todos os valores do campo `data` dos Secrets deverão estar codificados em Base64.

## Ordem de aplicação

1. Namespaces.
2. ServiceAccounts.
3. ConfigMaps.
4. Secrets.
5. Deployments.
6. Services.
7. Ingresses.
8. HPAs.

Os serviços estão separados nos namespaces `auth`, `flags`, `targeting`, `evaluation` e `analytics`.

## Rotas externas

- `/auth` encaminha para o `auth-service` e remove o prefixo antes de chegar à aplicação.
- `/flags` encaminha para o `flag-service`.
- `/rules` encaminha para o `targeting-service`.
- `/evaluate` encaminha para o `evaluation-service`.

O `analytics-service` é um worker interno e não possui Ingress público.
