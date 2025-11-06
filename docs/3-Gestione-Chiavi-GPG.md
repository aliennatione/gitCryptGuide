# 3. Gestione della Chiave GPG: Sicurezza e Responsabilità

La chiave GPG è la tua identità di sicurezza. Gestirla correttamente è fondamentale.

### Creazione di una Chiave Robusta
Usa `gpg --full-generate-key`.

1.  **Dimensione:** 4096 bit.
2.  **Scadenza:** Imposta una scadenza (es. 1 anno) per forzare una rotazione periodica della chiave.
3.  **Passphrase:** **DEVE essere forte e unica.**

### 📤 Backup e Revoca (I Due Fogli di Carta)

Questi due file devono essere conservati in luoghi separati e sicuri.

1.  **Backup Chiave Privata:** Serve per ripristinare la tua chiave su un nuovo computer.
    ```bash
gpg --export-secret-keys --armor TUO_ID > chiave-privata-backup.asc
```
2.  **Certificato di Revoca:** Serve per dichiarare la chiave compromessa o persa.
    ```bash
gpg --gen-revoke --armor TUO_ID > certificato-revoca.asc
```

### Gestione della Fiducia (Trust)
Quando importi la chiave pubblica di un collaboratore, devi "firmarla" per indicare che ti fidi che quella chiave appartenga davvero a quella persona.

1.  **Importa la chiave pubblica del collega:** `gpg --import collega.asc`
2.  **Firma la chiave:
    ```bash
gpg --edit-key COLLEGA_ID
# Nel menu: sign
# Segui le istruzioni e salva.
```

### Rotazione e Revoca dell'Accesso
Se un collaboratore lascia il team o la sua chiave viene compromessa:

1.  **Revoca l'Autorizzazione Git-crypt:
    ```bash
git-crypt remove-gpg-user COLLEGA_ID
```
2.  **Committa e push:** Questo aggiorna i metadati e impedisce ai *nuovi* cloni di decifrare i file con quella chiave.
3.  **Per una Sicurezza Totale:** Dopo la revoca, è consigliato **rigenerare la master key** (`git-crypt export-key`) e aggiornare tutti i Secrets CI/CD.
