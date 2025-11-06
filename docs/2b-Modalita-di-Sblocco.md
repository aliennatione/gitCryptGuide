# 2b. Modalità di Sblocco e Accesso ai Segreti

Git-crypt offre diverse modalità per sbloccare i file crittografati, adatte a diversi scenari: utenti umani, script CI/CD o container.

| Modalità di Sblocco | Scenario Tipico | Requisiti |
| :--- | :--- | :--- |
| **GPG (Default)** | Utenti umani, sviluppo locale. | Chiave Privata GPG sul sistema, passphrase. |
| **Chiave Simmetrica** | Pipeline CI/CD, script di deploy automatici. | File binario chiave esportato (`export-key`). |
| **Passphrase** | Script rapidi, chiavi usa e getta (sconsigliato in produzione). | Passphrase simmetrica stabilita. |

---

### Sblocco 1: GPG (Per Utenti)

Questa è la modalità standard. Git-crypt tenta automaticamente lo sblocco se sei un utente autorizzato al `checkout`. Per forzare o per verificare l'accesso:

```bash
git-crypt unlock
# Ti verrà chiesto di inserire la passphrase della tua chiave GPG privata.
```

### Sblocco 2: Chiave Simmetrica (Master Key)

Ideale per ambienti automatizzati o come backup di emergenza.

1.  **Esportazione (una tantum):**
    ```bash
git-crypt export-key master-backup.key
# Proteggi il file master-backup.key in modo ESTREMO.
```
2.  **Sblocco (uso runtime):**
    ```bash
# Se il file chiave è stato scaricato in locale:
git-crypt unlock /percorso/della/chiave/master-backup.key
```
    *Vedi la sezione [Integrazione CI/CD](./4-Integrazione-CI-CD.md) per l'uso pratico di questa modalità.*

### Sblocco 3: Passphrase (Metodo Legacy)

Se non vuoi usare GPG, puoi inizializzare Git-crypt con una semplice passphrase (non consigliato per la maggior parte dei casi d'uso moderni e sicuri).

1.  **Inizializzazione con Passphrase (solo all'inizio):**
    ```bash
git-crypt init --shared-secret /percorso/della/passphrase.txt
```
2.  **Sblocco:
    ```bash
git-crypt unlock /percorso/della/passphrase.txt
```
