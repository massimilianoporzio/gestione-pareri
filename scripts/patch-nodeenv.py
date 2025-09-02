import sys
import os
import subprocess
import shutil

def patch_nodeenv():
    '''Patch nodeenv per usare Node.js di sistema invece di scaricarlo'''
    
    # Trova il percorso del modulo nodeenv
    try:
        import nodeenv
        nodeenv_path = nodeenv.__file__
        print(f'Nodeenv trovato in: {nodeenv_path}')
        
        # Leggi il file nodeenv
        with open(nodeenv_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Trova la funzione che scarica Node.js e patchala
        original_download = 'def get_last_stable_node_version():'
        
        if original_download in content:
            print('Applicando patch nodeenv...')
            
            # Sostituisce la funzione con una che usa la versione di sistema
            patched_function = '''def get_last_stable_node_version():
    """Usa Node.js di sistema invece di scaricare"""
    try:
        result = subprocess.run(['node', '--version'], capture_output=True, text=True)
        if result.returncode == 0:
            version = result.stdout.strip().lstrip('v')
            print(f'Usando Node.js di sistema: v{version}')
            return version
    except:
        pass
    
    # Fallback alla versione predefinita se Node.js non è trovato
    return '22.17.0'  # Versione che sappiamo essere installata
'''
            
            # Trova l'intera funzione originale e sostituiscila
            import re
            
            # Pattern per trovare l'intera funzione
            pattern = r'def get_last_stable_node_version\(\):.*?(?=\n\ndef|\n\nclass|\n\nif|$)'
            
            new_content = re.sub(pattern, patched_function, content, flags=re.DOTALL)
            
            # Backup del file originale
            backup_path = nodeenv_path + '.backup'
            if not os.path.exists(backup_path):
                shutil.copy2(nodeenv_path, backup_path)
                print(f'Backup creato: {backup_path}')
            
            # Scrivi il file patchato
            with open(nodeenv_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            
            print('✅ Patch nodeenv applicata con successo')
            return True
        else:
            print('⚠️ Funzione target non trovata in nodeenv')
            return False
            
    except Exception as e:
        print(f'❌ Errore durante il patching di nodeenv: {e}')
        return False

if __name__ == '__main__':
    success = patch_nodeenv()
    sys.exit(0 if success else 1)
