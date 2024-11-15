#!/bin/bash
PORT="2022"
echo "Cliente de Dragón magia Abuelita Miedo 2022"
echo "1. ENVÍO DE CABECERA"

echo "DMAM" | nc 127.0.0.1 $PORT
DATA=`nc -l $PORT`
# SI DATA ES DIFERENTE A OK_HEADER, MENSAJE
# DE ERROR Y EXIT 1
echo "4.COMPROVANDO RESPUESTA"
if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: el header  se envio incorrectamente"
	exit 1
fi
echo "OK"
echo "5. ENVIO DE ARCHIVO"
echo "FILE_NAME dragon.txt" | nc localhost $PORT
DATA=`nc -l $PORT`
echo "7. COMPROVANDO RESPUESTA"
if [ "$DATA" != "OK_FILE_NAME" ]
then 
	echo "ERROR 2: el archivo se envió incorrectamente"
	exit 2
fi
echo "OK"
echo "8. ENVIO CONTENIDO ARCHIVO"
cat client/dragon.txt | nc localhost $PORT
DATA=`nc -l $PORT`
echo "11. COMPROVANDO RESPUESTA"
if [ "$DATA" != "OK_ARCHIVO_SAVED" ]
then 
	echo "ERROR 4: Los datos se enviaron incorrectamente"
	exit 4
fi
echo "OK"
