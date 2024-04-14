#!/bin/bash

# Script de prueba para el monitoreo de CPU y memoria

# Consumo de CPU
echo "Consumiendo CPU..."
for (( i=0; i<100000000; i++ )); do
    :
done

# Consumo de memoria
echo "Consumiendo memoria..."
arr=()
for (( i=0; i<1000000; i++ )); do
    arr+=($i)
done

exit 0

echo "Proceso de prueba completado."

