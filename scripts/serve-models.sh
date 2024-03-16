#!/bin/bash

echo "Starting Ollama..."
ollama serve &

echo "Waiting for Ollama to start..."
sleep 10

IFS=',' read -ra MODELS <<< "$1"

index=0

for i in "${MODELS[@]}"; do
    echo "Running model $i..."
    ollama run $i &

    echo "Serving model $i on port $((8000+index))..."
    litellm --port $((8000+index)) --api_base http://localhost:11434 --model ollama/$i &

    let index=index+1
done

wait