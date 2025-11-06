# 2. Quick Start: Repository Funzionante in 5 Passaggi

Utilizza questa sequenza per abilitare Git-crypt in un repository nuovo o esistente.

### Passo 1: Inizializzazione
Entra nel repository e abilita la funzionalità Git-crypt:
```bash
git-crypt init
```
Questo crea i metadati di crittografia essenziali.

### Passo 2: Trova il Tuo ID GPG
Git-crypt deve sapere chi sei per autorizzarti a decifrare i file.
```bash
gpg --list-secret-keys --keyid-format LONG
```
Copia l'**ID della chiave lunga** o l'**indirizzo email** associato.

### Passo 3: Aggiungi Utenti Autorizzati
Aggiungi te stesso (e i tuoi collaboratori) come utenti che possono decifrare i file:
```bash
# Usa l'ID o l'email
git-crypt add-gpg-user F1E2D3C4567890AB
# Oppure, per gli altri:
# gpg --import chiave-pubblica-collega.asc
# git-crypt add-gpg-user collega@dominio.com
```

### Passo 4: Definisci i Segreti (`.gitattributes`)
Crea il file `.gitattributes` e usa il pattern per marcare i file sensibili.
```bash
# Esempio:
secrets/*.env filter=git-crypt diff=git-crypt
```
*Vedi il file base `.gitattributes` nella root per i pattern usati in questa guida.*

### Passo 5: Committa e Decifra
Aggiungi e committa il file `.gitattributes` e i tuoi file segreti.

```bash
git add .gitattributes examples/secrets/api_keys.json
git commit -m "Configura git-crypt e aggiunge i segreti iniziali"
git push
```
I file sono ora crittografati nel repository remoto.
