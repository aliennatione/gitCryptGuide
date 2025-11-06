# 4. Integrazione CI/CD: Sblocco Sicuro in Pipeline

L'uso della Chiave Simmetrica (`export-key`) è lo standard di sicurezza per sbloccare i segreti nelle pipeline automatiche (GitLab CI, GitHub Actions, Jenkins, ecc.).

### Workflow Standard

1.  **Esporta la Chiave Master** (locale, una tantum):
    ```bash
git-crypt export-key git-crypt-ci.key
```
2.  **Codifica in Base64** per l'archiviazione:
    ```bash
cat git-crypt-ci.key | base64 -w 0 # Usa -w 0 per Linux o base64 per macOS
```
3.  **Salva la stringa Base64** come variabile Segreta (es. `GITCRYPT_KEY_SECRET`) nella piattaforma CI/CD.
4.  **Nel pipeline script**, decodifica il Secret e usa `git-crypt unlock`.

### Esempio GitLab CI

Vedi il file di configurazione in [`ci-examples/.gitlab-ci.yml`](../ci-examples/.gitlab-ci.yml).

### Esempio GitHub Actions

Vedi il file di configurazione in [`ci-examples/.github/workflows/main.yml`](../ci-examples/.github/workflows/main.yml).

### Script di Sblocco Riutilizzabile

È buona pratica usare uno script wrapper per la decodifica e la pulizia. Vedi l'esempio in [`ci-examples/decrypt.sh`](../ci-examples/decrypt.sh).
