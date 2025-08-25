# File di Test per i Hook Markdown

Questo è un file di test per verificare il funzionamento dei hook pre-commit per i file Markdown.

## Formattazione con Prettier

Prettier sistemerà automaticamente:

- La spaziatura inconsistente
- L'indentazione irregolare
- Le liste non allineate correttamente
  - Con vari livelli di indentazione

## Controllo con Markdownlint

Markdownlint controllerà:

1. La struttura degli heading (non saltare livelli)
2. La presenza di spazi alla fine delle righe
3. Le righe vuote all'inizio e alla fine dei blocchi di codice

```python
# Blocco di codice
def esempio():
    print("Hello world")

```

## Tabella non formattata correttamente

| Colonna 1 | Colonna 2              | Colonna 3    |
| --------- | ---------------------- | ------------ |
| Riga 1    | Valore                 | Altro valore |
| Riga 2    | Valore non allineato   | Altro valore |
| Riga 3    | Valore con spazi extra | Altro valore |
