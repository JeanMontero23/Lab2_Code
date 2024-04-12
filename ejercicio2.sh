#!/bin/bash

# Se revisa si se reciben los argumentos requeridos
if [ $# -ne 2 ]; then
    echo "Uso: $0 <nombre_del_proceso> <comando_para_ejecutar>"
    exit 1
fi

# Se guardan los argumentos que se recibieron antes, en dos variables
proceso=$1
comando=$2

# Se hace un bucle que no acaba para as√≠ monitorear el proceso continuamente
while true; do
    # Verificando si el proceso est√°activo
    pgrep -x "$proceso" > /dev/null
    
    # Si el proceso no est√ activo, hay que volver a levantarlo
    if [ $? -ne 0 ]; then
        echo "El proceso '$proceso' no se est√ ejecutando. Volviendo a levantarlo..."
        # Se ejecuta el comando para levantar de nuevo el proceso
        $comando &
    fi
    
    # Se espera un poco antes de revisar el estado del proceso
    sleep 5
done
