# 🔒 Git-crypt: Guida Completa alla Crittografia Trasparente per Git

Benvenuto nella guida definitiva all'uso di **Git-crypt**, lo strumento essenziale per criptare selettivamente file sensibili all'interno dei repository Git, mantenendoli in chiaro per gli utenti autorizzati.

Questa repository funge sia da documentazione completa che da **template pratico** per l'implementazione immediata.

## 🚀 Cos'è Git-crypt?

Git-crypt è un filtro Git che permette la **crittografia trasparente**. I file marcati come segreti vengono crittografati automaticamente al momento del `commit` e decrittografati al `checkout` solo se l'utente possiede la chiave GPG (o simmetrica) corretta. Ciò ti permette di ospitare codice anche su repository pubblici (come GitHub, GitLab) senza esporre credenziali, chiavi API o dati sensibili.

## 📚 Indice della Documentazione

Inizia da qui per configurare Git-crypt in qualsiasi progetto.

1.  [**Installazione**](./docs/1-Installazione.md): Setup iniziale degli strumenti necessari (Git, GPG, Git-crypt).
1.  [**Quick Start**](./docs/2-Quick-Start.md): La guida essenziale per rendere operativo un repository.
1.  [**Modalità di Sblocco**](./docs/2b-Modalita-di-Sblocco.md): Tutte le opzioni per decifrare i file (GPG, Chiave Simmetrica, Passphrase).
1.  [**Gestione Chiavi GPG**](./docs/3-Gestione-Chiavi-GPG.md): Creazione, backup, revoca e gestione della fiducia.
1.  [**Integrazione CI/CD**](./docs/4-Integrazione-CI-CD.md): Sblocco sicuro in pipeline automatiche (GitLab, GitHub Actions).
1. [**Integrazione Docker**](./docs/4b-Integrazione-Docker.md): Strategie per decifrare segreti durante il build o l'esecuzione di container.
1.  [**Best Practice**](./docs/5-Best-Practice.md): Consigli di sicurezza e manutenzione.

---

## 🧪 Template Pratici e Esempi

* **File d'Esempio**: Vedi la directory [`/examples`](./examples) per i file usati nei test (es. `api_keys.json`, `prod.env`).
* **Configurazioni CI/CD**: La directory [`/ci-examples`](./ci-examples) contiene template di pipeline pronti.
* **Template `.gitattributes`**: La directory [`/templates`](./templates) offre configurazioni specifiche per diversi ambienti di sviluppo.

---

## 💡 Guida Veloce: Verifica e Stato

Per verificare se Git-crypt è attivo e quali file sono protetti nel tuo repository:

```bash
git-crypt status
```

* `plaintext`: Il file è in chiaro (corretto per la documentazione e i binari).
* `encrypted`: Il file è crittografato (corretto per i segreti).
