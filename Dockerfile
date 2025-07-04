# Use uma imagem base oficial do Python.
# Usar uma imagem 'alpine' mantém o tamanho da imagem final pequeno.
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho no container para /app
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Desta forma, as dependências só são reinstaladas se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências do projeto.
# --no-cache-dir reduz o tamanho final da imagem.
# --upgrade pip é uma boa prática de segurança e estabilidade.
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta em que o Uvicorn será executado.
EXPOSE 8000

# Comando para iniciar a aplicação quando o container for executado.
# Usamos --host 0.0.0.0 para que a API seja acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
