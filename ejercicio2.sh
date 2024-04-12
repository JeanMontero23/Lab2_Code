#!/bin/bash

# Verificando que se reciban los argumentos necesarios
if [ $# -ne 2 ]; then
    echo "Uso: $0 <nombre_del_proceso> <comando_para_ejecutar>"
    exit 1
fi

nombre_proceso=$1
comando=$2

# Se hace una funcion para poder verificar si el proceso esta activo
verificar_proceso() {
    if pgrep -x "$nombre_proceso" > /dev/null; then
        return 0 # Proceso en funcionamiento
    else
        return 1 # Proceso no esta activo
    fi
}

# Se hace un bucle que sea infinito para monitorear el proceso
while true; do
    if verificar_proceso; then
        echo "El proceso $nombre_proceso está en ejecución."
    else
        echo "El proceso $nombre_proceso no está en ejecución. Iniciando..."
        # Ejecutar el comando para iniciar el proceso usando eval
        eval "$comando" &
    fi
    sleep 5 # Se esperan 5 segundos antes de realizar otra revision
done


