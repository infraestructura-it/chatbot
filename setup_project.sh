#!/bin/bash

# Crear estructura de carpetas
mkdir -p mi_proyecto_deepseek/{.vscode,src/{api,utils,tests},config,docs}

# Crear archivos
touch mi_proyecto_deepseek/.vscode/{settings.json,launch.json}
touch mi_proyecto_deepseek/src/{main.py,api/deepseek_client.py,api/constants.py,utils/helpers.py,tests/test_api.py}
touch mi_proyecto_deepseek/config/{.env,.env.example}
touch mi_proyecto_deepseek/docs/README.md
touch mi_proyecto_deepseek/{requirements.txt,.gitignore}

# Llenar archivos con contenido básico

# .vscode/settings.json
cat << EOF > mi_proyecto_deepseek/.vscode/settings.json
{
  "python.defaultInterpreterPath": "venv/bin/python",
  "editor.formatOnSave": true,
  "python.testing.pytestEnabled": true
}
EOF

# src/api/deepseek_client.py
cat << EOF > mi_proyecto_deepseek/src/api/deepseek_client.py
import requests
import os
from dotenv import load_dotenv

load_dotenv("config/.env")

class DeepSeekClient:
    def __init__(self):
        self.api_key = os.getenv("DEEPSEEK_API_KEY")
        self.base_url = "https://api.deepseek.com/v1"

    def generate_text(self, prompt):
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
        data = {
            "model": "deepseek-chat",
            "messages": [{"role": "user", "content": prompt}],
            "temperature": 0.7
        }
        response = requests.post(f"{self.base_url}/chat/completions", headers=headers, json=data)
        return response.json()
EOF

# config/.env
cat << EOF > mi_proyecto_deepseek/config/.env
DEEPSEEK_API_KEY="tu_clave_secreta_aqui"
EOF

# requirements.txt
cat << EOF > mi_proyecto_deepseek/requirements.txt
requests==2.31.0
python-dotenv==1.0.0
pytest==7.4.0
EOF

# .gitignore
cat << EOF > mi_proyecto_deepseek/.gitignore
# Python
__pycache__/
*.pyc
venv/

# Environment variables
config/.env

# VS Code
.vscode/
EOF

# main.py
cat << EOF > mi_proyecto_deepseek/src/main.py
from api.deepseek_client import DeepSeekClient

client = DeepSeekClient()
response = client.generate_text("Explica la teoría de la relatividad en una frase.")
print(response["choices"][0]["message"]["content"])
EOF

echo "¡Estructura creada! Reemplaza 'tu_clave_secreta_aqui' en config/.env con tu API Key."