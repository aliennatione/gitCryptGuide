# 5. Best Practice e Manutenzione

### 1. Master Key di Backup
**Esporta sempre la Chiave Simmetrica** come "Master Key" di recupero e archiviala in un luogo sicuro (es. vault aziendale, password manager crittografato).

```bash
git-crypt export-key vault-master-key.bin
```
*Motivazione:* Se tutti gli utenti GPG autorizzati perdono la loro chiave privata, questa master key è l'unico modo per recuperare i dati.

### 2. Sii Selettivo con i File
Cripta solo i file che contengono segreti. La crittografia ha un piccolo overhead:

* **CRIPTARE:** `.env`, `.yml` con credenziali, `.json` con chiavi API, file `.key`, file `.pem`.
* **NON CRIPTARE:** File binari, dipendenze (`package-lock.json`), file di log, `README.md`.

### 3. Rotazione Periodica della Chiave GPG
Imposta una scadenza annuale sulla tua chiave GPG. Questo costringe te e i tuoi collaboratori a generare nuove coppie di chiavi, mitigando il rischio di chiavi private obsolete e potenzialmente esposte.

### 4. Gestione del Trust GPG
Non firmare mai una chiave pubblica se non hai verificato l'identità del proprietario (ad esempio, con verifica out-of-band o in persona). Nel contesto professionale, la fiducia è gestita tramite i sistemi di identità aziendali (LDAP, AD).

### 5. Verifica Lo Stato Prima del Commit
Usa sempre `git-crypt status` per assicurarti che un nuovo file segreto sia stato intercettato dal `.gitattributes` prima di eseguire il `git push`.
