#!/bin/bash
PORT="2022"
echo "Cliente de Dragón magia Abuelita Miedo 2022"
echo "1. ENVÍO DE CABECERA"

echo "DMAM" | nc 127.0.0.1 $PORT
DATA=`nc -l $PORT`
# SI DATA ES DIFERENTE A OK_HEADER, MENSAJE
# DE ERROR Y EXIT 1
if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: el header  se envio incorrectamente"
	exit 1
fi
echo "3. ENVIO DE ARCHIVO"
echo "FILE_NAME dragon.txt" | nc localhost $PORT
DATA=`nc -l $PORT`
if [ "$DATA" != "OK_FILE_NAME" ]
then 
	echo "ERROR 2: el archivo se envió incorrectamente"
	exit 2
fi
