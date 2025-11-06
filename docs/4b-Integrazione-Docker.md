# 4b. Integrazione Docker: Segreti nel Contenitore

Integrare Git-crypt in un workflow Docker è cruciale per evitare che i segreti rimangano nel filesystem del container (livelli di build).

### Strategia A: Sblocco in Build (BuildKit Mount)

Il modo più sicuro per decifrare i file durante la fase di `docker build` è usare BuildKit e i Secret Mount.

1.  **Prepara la Chiave:** Devi avere il file `git-crypt-ci.key` disponibile in locale.
2.  **Dockerfile:** Utilizza l'opzione `--secret` durante la fase di build.

```dockerfile
# Usa BuildKit
# syntax=docker/dockerfile:1.4

FROM ubuntu:latest AS decrypt-stage
RUN apt-get update && apt-get install -y git-crypt

# Il secret è iniettato solo in questa fase e non rimane nel livello del build finale.
# ID 'gitcrypt_key' deve corrispondere al flag --secret nel comando build
RUN --mount=type=secret,id=gitcrypt_key,target=/tmp/git-crypt-key \
    git-crypt unlock /tmp/git-crypt-key

# COPIA SOLO I FILE NECESSARI DOPO LO SBLOCCO
# I segreti ora sono in chiaro nel layer corrente
COPY examples/secrets/prod.env /app/.env

# ... Successive istruzioni di build ...

# Fase finale (per rimuovere tutti i dati di sblocco e la chiave)
FROM alpine:latest
# Esempio: Copia solo l'applicazione finale e il file .env dal layer precedente
COPY --from=decrypt-stage /app/.env /usr/src/app/.env
```

3.  **Comando Docker Build:
    ```bash
docker build . --secret id=gitcrypt_key,src=git-crypt-ci.key
```
    *Questo assicura che il file `git-crypt-ci.key` non sia visibile all'interno del container finale.*

### Strategia B: Sblocco in Runtime (Volume Mount)

Se i file devono essere decifrati solo all'avvio (es. per un servizio che li legge), monta la chiave al runtime.

* **Dockerfile (semplice):** Il Dockerfile si limita a installare `git-crypt`.
* **docker-compose.yml:
    ```yaml
version: '3.8'
services:
  app:
    image: my-app:latest
    command: sh -c "git-crypt unlock /run/secrets/key && python app.py"
    volumes:
      # Monta la chiave segreta solo in memoria o su un percorso sicuro
      - /percorso/della/chiave/git-crypt-ci.key:/run/secrets/key:ro
```
