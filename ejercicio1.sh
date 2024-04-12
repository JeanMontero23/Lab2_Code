#!/bin/bash

# Se revisa si lo recibido es un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ID del proceso>"
    exit 1
fi

# Se va a obtener el ID del proceso proporcionado como argumento
pid=$1

# Hay que revisar si el proceso existe
if ! ps -p $pid > /dev/null; then
    echo "El proceso con ID $pid no existe."
    exit 1
fi

# 1) Nombre del proceso
name=$(ps -o comm= -p $pid)

# 2) ID del proceso
pid=$(ps -o pid= -p $pid)

# 3) Parent process ID
ppid=$(ps -o ppid= -p $pid)

# 4) Usuario al que le pertenece
user=$(ps -o user= -p $pid)

# 5) Porcentaje de uso de CPU al momento de correr el script
cpu_usage=$(ps -o %cpu= -p $pid)

# 6) Consumo de memoria
memory_usage=$(ps -o %mem= -p $pid)

# 7) Estado (status)
status=$(ps -o state= -p $pid)

# 8) Path del ejecutable
executable=$(readlink /proc/$pid/exe)

# Se muestra la informacion que se obtuvo
echo "a) Nombre del proceso: $name"
echo "b) ID del proceso: $pid"
echo "c) Parent process ID: $ppid"
echo "d) Usuario propietario: $user"
echo "e) Porcentaje de uso de CPU: $cpu_usage"
echo "f) Consumo de memoria: $memory_usage"
echo "g) Estado: $status"
echo "h) Path del ejecutable: $executable"

