#!/bin/bash
ollama serve &
wait -n
ollama pull $1 

ollama run $1 