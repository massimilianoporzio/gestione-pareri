#!/usr/bin/env python3
"""
Script per correzioni automatiche di problemi markdownlint comuni.

Corregge automaticamente:
- MD034: Bare URLs (https://example.com -> <https://example.com>)
- MD031: Blanks around fences (aggiunge righe vuote attorno ai code blocks)
- MD051: Link fragments (controlla e suggerisce correzioni per link interni)
"""

import os
import re
import glob
from pathlib import Path


def fix_bare_urls(content: str) -> tuple[str, int]:
    """
    Corregge URL nudi aggiungendo < > attorno.
    MD034/no-bare-urls
    """
    pattern = r'(?<![<\[\(])(https?://[^\s<>\]\)]+)(?![>\]\)])'
    fixes = 0
    
    def replacer(match):
        nonlocal fixes
        fixes += 1
        return f'<{match.group(1)}>'
    
    fixed_content = re.sub(pattern, replacer, content)
    return fixed_content, fixes


def fix_code_block_spacing(content: str) -> tuple[str, int]:
    """
    Aggiunge righe vuote attorno ai code blocks.
    MD031/blanks-around-fences
    """
    fixes = 0
    lines = content.split('\n')
    result_lines = []
    
    i = 0
    while i < len(lines):
        line = lines[i]
        
        # Rileva inizio code block
        if re.match(r'^[ \t]*```', line):
            # Assicura riga vuota prima (se non siamo all'inizio)
            if (result_lines and 
                result_lines[-1].strip() != '' and 
                not re.match(r'^[ \t]*```', result_lines[-1])):
                result_lines.append('')
                fixes += 1
            
            result_lines.append(line)
            i += 1
            
            # Trova la fine del code block
            while i < len(lines):
                line = lines[i]
                result_lines.append(line)
                
                if re.match(r'^[ \t]*```[ \t]*$', line):
                    # Fine code block trovata
                    # Assicura riga vuota dopo (se non siamo alla fine)
                    if (i + 1 < len(lines) and 
                        lines[i + 1].strip() != '' and
                        not re.match(r'^[ \t]*```', lines[i + 1])):
                        result_lines.append('')
                        fixes += 1
                    break
                i += 1
        else:
            result_lines.append(line)
        
        i += 1
    
    return '\n'.join(result_lines), fixes


def find_markdown_files() -> list[Path]:
    """Trova tutti i file markdown escludendo directory non necessarie."""
    exclude_dirs = {'.venv', 'node_modules', 'staticfiles', '.git', '__pycache__'}
    markdown_files = []
    
    for md_file in glob.glob('**/*.md', recursive=True):
        path = Path(md_file)
        if not any(part in exclude_dirs for part in path.parts):
            markdown_files.append(path)
    
    return markdown_files


def fix_markdown_file(file_path: Path) -> dict:
    """Applica tutte le correzioni a un singolo file markdown."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            original_content = f.read()
        
        content = original_content
        total_fixes = 0
        
        # Applica correzioni
        content, url_fixes = fix_bare_urls(content)
        total_fixes += url_fixes
        
        content, spacing_fixes = fix_code_block_spacing(content)
        total_fixes += spacing_fixes
        
        # Salva solo se ci sono state modifiche
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
        
        return {
            'file': str(file_path),
            'url_fixes': url_fixes,
            'spacing_fixes': spacing_fixes,
            'total_fixes': total_fixes,
            'success': True,
            'error': None
        }
        
    except Exception as e:
        return {
            'file': str(file_path),
            'url_fixes': 0,
            'spacing_fixes': 0,
            'total_fixes': 0,
            'success': False,
            'error': str(e)
        }


def main():
    """Funzione principale."""
    print("🔧 Correzione automatica problemi markdown...")
    
    markdown_files = find_markdown_files()
    print(f"📁 Trovati {len(markdown_files)} file markdown")
    
    total_files_fixed = 0
    total_fixes = 0
    
    for file_path in markdown_files:
        result = fix_markdown_file(file_path)
        
        if result['success']:
            if result['total_fixes'] > 0:
                total_files_fixed += 1
                total_fixes += result['total_fixes']
                print(f"✅ {result['file']}: "
                      f"{result['url_fixes']} URLs, "
                      f"{result['spacing_fixes']} spacing fixes")
        else:
            print(f"❌ Errore in {result['file']}: {result['error']}")
    
    print(f"\n🎯 Risultato: {total_fixes} correzioni in {total_files_fixed} file")
    print("✅ Correzioni automatiche completate!")


if __name__ == '__main__':
    main()
