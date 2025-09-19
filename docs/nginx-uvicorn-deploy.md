# Deploy Django/Uvicorn con Nginx (cross-platform)

Questa guida spiega come generare, copiare e attivare la configurazione Nginx per il progetto Django/Uvicorn usando le ricette del justfile, su macOS, Linux e Windows.

---


## Ricette disponibili

- `just nginx-generate-conf` — Genera il file di configurazione Nginx tramite script Python in `scripts/deployment/nginx_<DJANGO_SUBPATH>.conf` (nome dinamico)
- `just nginx-copy-conf` — Copia il file generato nella directory corretta (in base al sistema)
- `just nginx-reload` — Riavvia o ricarica Nginx
- `just run-uvicorn-prod` — Avvia Uvicorn in modalità produzione
- `just deploy-nginx-steps` — Esegue tutti i passi sopra in sequenza

---

## macOS (Homebrew)

1. **Genera la configurazione**
   ```sh
   just nginx-generate-conf
   # Genera scripts/deployment/nginx_<DJANGO_SUBPATH>.conf
   ```
2. **Copia la configurazione**
   ```sh
   just nginx-copy-conf
   # Copia scripts/deployment/nginx_<DJANGO_SUBPATH>.conf in /opt/homebrew/etc/nginx/gestione-pareri.conf
   ```
3. **Ricarica Nginx**
   ```sh
   just nginx-reload
   # Usa brew services restart nginx
   ```
4. **Avvia Uvicorn**
   ```sh
   just run-uvicorn-prod
   ```
5. **Tutto in uno**
   ```sh
   just deploy-nginx-steps
   ```

---

## Linux (Debian/Ubuntu)

1. **Genera la configurazione**
   ```sh
   just nginx-generate-conf
   # Genera scripts/deployment/nginx_<DJANGO_SUBPATH>.conf
   ```
2. **Copia la configurazione**
   ```sh
   just nginx-copy-conf
   # Copia scripts/deployment/nginx_<DJANGO_SUBPATH>.conf in /etc/nginx/sites-available/gestione-pareri e crea symlink
   ```
3. **Ricarica Nginx**
   ```sh
   just nginx-reload
   # Usa sudo systemctl reload nginx
   ```
4. **Avvia Uvicorn**
   ```sh
   just run-uvicorn-prod
   ```
5. **Tutto in uno**
   ```sh
   just deploy-nginx-steps
   ```

---

## Windows

1. **Genera la configurazione**
   ```powershell
   just nginx-generate-conf
   # Genera scripts/deployment/nginx_<DJANGO_SUBPATH>.conf
   ```
2. **Copia la configurazione**
   ```powershell
   just nginx-copy-conf
   # Copia scripts/deployment/nginx_<DJANGO_SUBPATH>.conf in C:\nginx\conf\gestione-pareri.conf
   ```
3. **Riavvia Nginx**
   ```powershell
   just nginx-reload
   # Stop e start del processo nginx.exe
   ```
4. **Avvia Uvicorn**
   ```powershell
   just run-uvicorn-prod
   ```
5. **Tutto in uno**
   ```powershell
   just deploy-nginx-steps
   ```

---

## Note
- Il file di configurazione viene generato come `scripts/deployment/nginx_<DJANGO_SUBPATH>.conf` dove `<DJANGO_SUBPATH>` è la variabile d'ambiente (senza slash iniziale).
- Assicurati che i path di destinazione corrispondano alla tua installazione di Nginx.
- Su Linux/macOS può essere richiesto sudo per alcune operazioni.
- Su Windows, nginx deve essere installato in C:\nginx\ e avviabile come processo.
- Personalizza la configurazione generata se necessario.

---

Per dettagli sulle singole ricette, consulta il justfile o chiedi aiuto con `just --list`.
