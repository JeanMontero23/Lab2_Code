#!/bin/bash

# Verifica que se haya proporcionado un ejecutable como argumento
if [ $# -eq 0 ]; then
    echo "Por favor, proporcione el nombre del ejecutable como argumento."
    exit 1
fi

# Verificar la existencia del archivo cpu_mem_log.txt
if [ ! -f "cpu_mem_log.txt" ]; then
    echo "El archivo cpu_mem_log.txt no existe."
    exit 1
fi

# Imprimir el contenido del archivo cpu_mem_log.txt
cat cpu_mem_log.txt

# Nombre del ejecutable
executable="$1"

# Nombre del archivo de registro
log_file="cpu_mem_log.txt"

# Intervalo de muestreo en segundos
interval=1

# Función para registrar el consumo de CPU y memoria
monitor_process() {
    while ps -p $pid &>/dev/null; do
        # Obtener el uso de CPU y memoria del proceso
        cpu_usage=$(ps -p $pid -o %cpu | tail -n 1)
        mem_usage=$(ps -p $pid -o %mem | tail -n 1)
        # Obtener la fecha y hora actual
        timestamp=$(date +"%Y-%m-%d %H:%M:%S")
        # Registrar en el archivo de log
        echo "$timestamp CPU: $cpu_usage% MEM: $mem_usage%" >> $log_file
        # Esperar el intervalo especificado
        sleep $interval
    done
}

# Ejecutar el ejecutable proporcionado como argumento en segundo plano
./$executable &

# Obtener el ID del proceso del último proceso en segundo plano
pid=$!

# Monitorizar el proceso
monitor_process

# Graficar los datos utilizando gnuplot
gnuplot << EOF
set xlabel "Tiempo"
set ylabel "Uso (%)"
set title "Consumo de CPU"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%H:%M:%S"
plot "cpu_mem_log.txt" using 1:4 with lines title "CPU"
EOF
