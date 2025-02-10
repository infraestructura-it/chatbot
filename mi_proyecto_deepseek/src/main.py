from api.deepseek_client import DeepSeekClient

client = DeepSeekClient()
response = client.generate_text("Explica la teoría de la relatividad en una frase.")
print(response["choices"][0]["message"]["content"])
