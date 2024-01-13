#!/bin/bash
ollama serve &
ollama pull $1 
ollama run $1 

wait
