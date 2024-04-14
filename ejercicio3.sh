#!/bin/bash

# Verifica que se haya proporcionado un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ejecutable>"
    exit 1
fi

# Nombre del ejecutable proporcionado como argumento
ejecutable=$1

# Nombre del archivo de registro
log_file="registro.txt"

# Tiempo de espera entre las lecturas de CPU y memoria (en segundos)
intervalo=5

# Función para obtener el PID del proceso
get_pid() {
    pid=$(pgrep -f "./$1")
    echo "$pid"
}

# Función para obtener el consumo de CPU y memoria
get_cpu_memory() {
    pid=$1
    ps -p $pid -o %cpu,%mem | tail -n 1
}

# Función para graficar los valores sobre el tiempo
graficar() {
    gnuplot << EOF
    set xlabel "Tiempo (segundos)"
    set ylabel "Porcentaje"
    set title "Consumo de CPU y Memoria"
    set terminal png
    set output "grafica.png"
    plot "$log_file" using 1:2 with lines title "CPU", \
         "$log_file" using 1:3 with lines title "Memoria"
EOF
}

# Se realiza la ejecucion del binario recibido
./$ejecutable &

# Hay que esperar un breve momento para asegurarse de que el proceso esté en ejecución
sleep 1

# Se obtiene el PID del proceso ejecutado
pid=$(get_pid "$ejecutable")

# Se limpia el archivo de registro
> "$log_file"

# Se quiere hace el monitoreo el consumo de CPU y memoria periódicamente
while ps -p $pid > /dev/null; do
    timestamp=$(date +%s)
    consumo=$(get_cpu_memory $pid)
    echo "$timestamp ${consumo:-0}" >> "$log_file"
    sleep $intervalo
done

# Se van a graficar los valores sobre el tiempo al finalizar el proceso
graficar

exit 0
