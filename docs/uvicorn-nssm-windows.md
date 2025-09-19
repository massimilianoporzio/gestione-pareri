# Eseguire Uvicorn come servizio su Windows con NSSM

Questa guida spiega come configurare Uvicorn come servizio di Windows tramite NSSM (Non-Sucking Service Manager), utile per ambienti di produzione o server aziendali.

## 1. Scarica NSSM
Scarica l'ultima versione di NSSM da: https://nssm.cc/download
Estrai l'eseguibile in una cartella a piacere (es: `C:\nssm`)

## 2. Installa il servizio Uvicorn
Apri il prompt dei comandi come amministratore e lancia:

```
C:\nssm\nssm.exe install gestione-pareri
```

Si aprirà una finestra di configurazione:
- **Path**: percorso completo di `python.exe` della tua virtualenv (es: `C:\Users\utente\progetto\.venv\Scripts\python.exe`)
- **Arguments**: `-m uvicorn home.asgi:application --host 0.0.0.0 --port 8000 --workers 4 --env-file .env`
- **Start directory**: la cartella principale del tuo progetto (es: `C:\Users\utente\progetto`)

Clicca OK per salvare.

## 3. Avvia e gestisci il servizio

Per avviare:
```
nssm start gestione-pareri
```
Per fermare:
```
nssm stop gestione-pareri
```
Per rimuovere:
```
nssm remove gestione-pareri confirm
```

## 4. Note aggiuntive
- Il servizio partirà automaticamente al riavvio di Windows.
- Puoi configurare restart automatico, log file, variabili d'ambiente dalla finestra NSSM.
- Se usi una virtualenv, assicurati che tutte le dipendenze siano installate.

---

Per domande o problemi, consulta https://nssm.cc/usage oppure chiedi supporto al team di sviluppo.
