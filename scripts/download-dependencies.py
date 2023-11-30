import shutil
from pathlib import Path
import requests
from zipfile import ZipFile

SCRIPT_DIR = Path(__file__).parent.resolve()
DOWNLOADS_DIR = SCRIPT_DIR / 'downloads'
DOWNLOADS_DIR.mkdir(exist_ok=True)
PROJECT_ROOT = SCRIPT_DIR.parent.resolve()
base_url = 'https://github.com/alphacep/vosk-api/releases/download/v'
release_tag = '0.3.42'

os_versions = [
    'win32',
    'win64',
    'osx',
    'linux-aarch64',
    'linux-armv7l',
    'linux-x86',
    'linux-x86_64',
]

# for os in os_versions:
#     # Sample url: https://github.com/alphacep/vosk-api/releases/download/v0.3.42/vosk-win32-0.3.42.zip
#     file_name = f"vosk-{os}-{release_tag}.zip"
#     response = requests.get(f"{base_url}{release_tag}/{file_name}")
#     path = DOWNLOADS_DIR / file_name
#     with open(path, mode="wb") as f:
#         f.write(response.content)

#     with ZipFile(path) as zip:
#         zip.extractall(DOWNLOADS_DIR)

#     for file in (DOWNLOADS_DIR / path.stem).iterdir():
#         shutil.copyfile(file, PROJECT_ROOT / f"{file.stem}_{os}{file.suffix}")


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description="Downloads vosk binaries")
    parser.add_argument('-t', '--tag', help="The version number of the vosk release. Defaults to 0.3.42")
    parser.add_argument('-s', '--os', help="The os version to download. "
                        "For multiple ones, type them separated by spaces.", choices=os_versions, required=True)
    args = parser.parse_args()


