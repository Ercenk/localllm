#!/bin/bash

echo "Starting Ollama..."
ollama serve &

echo "Waiting for Ollama to start..."
sleep 10

IFS=',' read -ra MODELS <<< "$1"
for i in "${MODELS[@]}"; do
    echo "Pulling model $i..." 
    ollama pull $i
done
