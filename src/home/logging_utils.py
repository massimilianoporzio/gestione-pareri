"""
Configurazione per il logging colorato usando colorama.
Questo modulo fornisce un formatter personalizzato che aggiunge colori ai log
utilizzando la libreria colorama, che supporta i colori in modo cross-platform.
"""

import logging

from colorama import Fore, Style, init

# Inizializza colorama (necessario per Windows)
# Imposta autoreset=True per assicurare il reset dei colori dopo ogni output
init(autoreset=True)


class ColoramaFormatter(logging.Formatter):
    """
    Formatter per log colorati che usa colorama per la compatibilità cross-platform.
    Supporta Windows, Linux e macOS.
    """

    # Colori per ogni livello di log
    COLORS = {
        "DEBUG": Fore.CYAN,
        "INFO": Fore.GREEN,
        "WARNING": Fore.YELLOW,
        "ERROR": Fore.RED,
        "CRITICAL": Fore.RED + Style.BRIGHT,
    }

    def __init__(self, fmt=None, datefmt=None, style="%", use_colors=True):
        """
        Inizializza il formatter.

        Args:
            fmt (str, optional): Il formato del messaggio
            datefmt (str, optional): Il formato della data
            style (str, optional): Lo stile di formattazione ('%', '{', or '$')
            use_colors (bool, optional): Se usare i colori o no
        """
        super().__init__(fmt, datefmt, style)
        self.use_colors = use_colors

    def format(self, record):
        """
        Formatta il record aggiungendo colori in base al livello di log.

        Args:
            record (logging.LogRecord): Il record di log da formattare

        Returns:
            str: Il messaggio formattato con colori
        """
        # Formatta il messaggio con il formatter base
        formatted_message = super().format(record)

        # Aggiungi i colori se richiesto
        if self.use_colors:
            levelname = record.levelname
            color = self.COLORS.get(levelname, "")
            # Anche se autoreset=True in init(), assicuriamo che ci sia sempre un reset esplicito
            formatted_message = f"{color}{formatted_message}{Style.RESET_ALL}"

        return formatted_message


def get_colorama_console_handler(level=logging.DEBUG, use_colors=True):
    """
    Crea e restituisce un handler per la console con colori usando colorama.

    Args:
        level (int, optional): Il livello di log minimo da visualizzare
        use_colors (bool, optional): Se usare i colori o no

    Returns:
        logging.StreamHandler: Un handler per la console configurato
    """
    console_handler = logging.StreamHandler()
    console_handler.setLevel(level)

    # Formato del log: [LEVEL] timestamp module:line - message
    log_format = "%(levelname)-8s %(asctime)s %(name)s %(filename)s:%(lineno)d %(message)s"
    formatter = ColoramaFormatter(log_format, datefmt="%Y-%m-%d %H:%M:%S", use_colors=use_colors)

    console_handler.setFormatter(formatter)
    return console_handler
