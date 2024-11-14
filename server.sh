#!/bin/bash

PORT="2022"
echo "Servidor de Dragón Magia Abuelita Miedo 2022"
echo "0.ESCUCHAMOS"

DATA=`nc -l $PORT`

if [ "$DATA" != "DMAM" ]
then
	echo "ERROR 1: Cabecera Incorrecta"
	echo "KO_HEADER" | nc localhost $PORT
	exit 1
fi
echo "2. CHECK OK - Enviando OK_HEADER"
echo "OK_HEADER" | nc localhost $PORT

DATA=`nc -l $PORT`
FILE_NAME=`echo "$DATA" | cut -d ' ' -f 1`

if [ "$FILE_NAME" != "FILE_NAME" ]
then
	echo "ERROR 2: Archivo Incorrecto"
	echo "KO_FILE_NAME" | nc localhost $PORT
	exit 2
fi 
echo "4. CHECK OK FILE_NAME - Enviando OK_FILE_NAME"
echo "OK_FILE_NAME" | nc localhost $PORT
