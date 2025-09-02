#!/usr/bin/env python3
"""Script Python per mostrare l'help colorato con emoji.

Python gestisce Unicode molto meglio di PowerShell su Windows.
"""

import sys

from colorama import Fore, Style, init

# Inizializza colorama per supporto colori su Windows
init(autoreset=True)


def print_help():
    """Stampa l'help colorato con emoji."""
    print(f"{Fore.CYAN}Deploy Django Template - Comandi disponibili:{Style.RESET_ALL}")
    print(f"{Fore.GREEN}make run-server     {Style.RESET_ALL}Avvia il server di sviluppo Django")
    print(f"{Fore.GREEN}make run-dev        {Style.RESET_ALL}Avvia il server di sviluppo in ambiente DEV")
    print(f"{Fore.GREEN}make run-test       {Style.RESET_ALL}Avvia il server di sviluppo in ambiente TEST")
    print(f"{Fore.GREEN}make run-prod       {Style.RESET_ALL}Avvia il server di sviluppo in ambiente PROD")
    print(f"{Fore.GREEN}make test           {Style.RESET_ALL}Esegue i test del progetto")
    print(f"{Fore.GREEN}make add-docstrings {Style.RESET_ALL}📝 Aggiunge docstring mancanti ai file Python")
    print(
        f"{Fore.GREEN}make fix-all        {Style.RESET_ALL}⭐ CORREZIONE GLOBALE: "
        "Risolve tutti i problemi di qualità del codice"
    )
    print(
        f"{Fore.GREEN}make test-precommit {Style.RESET_ALL}🔍 TEST PRE-COMMIT: "
        "Verifica tutti i controlli senza modifiche"
    )
    print(
        f"{Fore.GREEN}make quality-corporate {Style.RESET_ALL}🏢 Controlli qualità per ambiente aziendale "
        "(alternativa a pre-commit)"
    )
    print(f"{Fore.GREEN}make fix-markdown   {Style.RESET_ALL}📝 Corregge problemi di linting Markdown")
    print(f"{Fore.GREEN}make lint-codacy    {Style.RESET_ALL}🔍 Controlli qualità stile Codacy (senza correzioni)")
    print(f"{Fore.GREEN}make stats          {Style.RESET_ALL}🔍 Genera statistiche complete del progetto")
    print(f"{Fore.YELLOW}make quality-corporate{Style.RESET_ALL} 🏢 Controlli qualità ambiente aziendale (Python-only)")
    print(
        f"{Fore.CYAN}make precommit-corporate{Style.RESET_ALL} 🏢 Pre-commit completo aziendale "
        f"(tutti gli hook inclusi Node.js)"
    )
    print(f"{Fore.MAGENTA}== DEPLOYMENT =={Style.RESET_ALL}")
    print(f"{Fore.GREEN}make deploy-dev     {Style.RESET_ALL}🔧 Avvia server di sviluppo")
    print(f"{Fore.GREEN}make deploy-staging {Style.RESET_ALL}🧪 Deploy in modalità staging/test")
    print(f"{Fore.GREEN}make deploy-prod    {Style.RESET_ALL}🚀 Deploy in produzione")
    print(f"{Fore.GREEN}make deploy         {Style.RESET_ALL}🎯 Deploy automatico (rileva OS e usa il server ottimale)")
    print(f"{Fore.GREEN}make waitress       {Style.RESET_ALL}🪟 Avvia con Waitress (Windows/Cross-platform)")
    print(f"{Fore.GREEN}make gunicorn       {Style.RESET_ALL}🐧 Avvia con Gunicorn (Unix/Linux/macOS)")
    print(f"{Fore.GREEN}make run-uvicorn    {Style.RESET_ALL}⚡ Avvia con Uvicorn ASGI (Tutti gli OS) - RACCOMANDATO")
    print(f"{Fore.GREEN}make test-uvicorn-local {Style.RESET_ALL}Test locale Uvicorn ASGI (debug, singolo worker)")
    print(f"{Fore.GREEN}make open-home      {Style.RESET_ALL}🌐 Apre la pagina home nel browser")
    print(f"{Fore.GREEN}make collectstatic  {Style.RESET_ALL}📦 Raccoglie i file statici")
    print(f"{Fore.YELLOW}make stop-servers   {Style.RESET_ALL}🛑 Ferma tutti i server Django")
    print(f"{Fore.RED}make kill-port      {Style.RESET_ALL}🔪 Termina i processi sulla porta 8000")
    print(f"{Fore.GREEN}make help           {Style.RESET_ALL}Mostra questo messaggio di aiuto")


if __name__ == "__main__":
    # Imposta encoding UTF-8 per stdout
    if sys.stdout.encoding != "utf-8":
        sys.stdout.reconfigure(encoding="utf-8")

    print_help()
