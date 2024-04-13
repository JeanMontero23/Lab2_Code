#!/bin/bash

# Directorio a monitorear
DIRECTORIO="/tmp/"

# Loop infinito para monitorear continuamente
while true; do
    # Espera por eventos en el directorio
    cambio=$(/usr/bin/inotifywait -r -e create,modify,delete "$DIRECTORIO" 2>/dev/null)
    
    # Obtener la fecha y hora del cambio
    fecha_hora=$(date +"%Y-%m-%d %H:%M:%S")
    
    # Escribir el mensaje de log
    echo "$fecha_hora - Cambio detectado: $cambio" >> /tmp/ejercicio4.log
done

