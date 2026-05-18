import tomllib
import sys
from pathlib import Path

groups_dir = Path.home() / '.config/metapac/groups'

if not groups_dir.exists():
    print(f"error: {groups_dir} not found", file=sys.stderr)
    sys.exit(1)

for toml_file in sorted(groups_dir.glob('*.toml')):
    with open(toml_file, 'rb') as f:
        data = tomllib.load(f)

    packages = data.get('arch', {}).get('packages', [])
    deduped = sorted(set(packages), key=str.lower)
    pkg_lines = ''.join(f'  "{p}",\n' for p in deduped)
    new_text = f'[arch]\npackages = [\n{pkg_lines}]\n'

    old_text = toml_file.read_text()
    if new_text != old_text:
        toml_file.write_text(new_text)
        print(f"formatted: {toml_file.name}")
    else:
        print(f"ok:        {toml_file.name}")
