#!/bin/bash

PORT="2022"
echo "Servidor de Dragón Magia Abuelita Miedo 2022"
echo "0.ESCUCHAMOS"
DATA=`nc -l $PORT`
IP=`echo "$DATA" | cut -d " " -f 2`
HEADER=`echo "$DATA" | cut -d " " -f 1`
echo "La IP del cliente es: $IP"
echo "2.CHEKING HEADER"
if [ "$HEADER" != "DMAM" ]
then
	echo "ERROR 1: Cabecera Incorrecta"
	echo "KO_HEADER" | nc $IP $PORT
	exit 1
fi
echo "3. CHECK OK - Enviando OK_HEADER"
echo "OK_HEADER" | nc $IP $PORT

DATA=`nc -l $PORT`
FILE_NAME=`echo "$DATA" | cut -d ' ' -f 1`
MD5SUM_RECEIVED=`echo "$DATA" | cut -d ' ' -f 3`  


if [ "$FILE_NAME" != "FILE_NAME" ]
then
	echo "ERROR 2: Archivo Incorrecto"
	echo "KO_FILE_NAME" | nc $IP $PORT
	exit 2
fi 
MD5SUM_GENERATED=$(echo -n "$FILE_NAME" | md5sum | cut -d ' ' -f 1)

if [ "$MD5SUM_RECEIVED" != "$MD5SUM_GENERATED" ]
then
    echo "ERROR 3: El MD5 es incorrecto"
    echo "KO_FILE_NAME_MD5" | nc $IP $PORT
    exit 3
fi

echo "6. CHECK OK FILE_NAME - Enviando OK_FILE_NAME"
echo "OK_FILE_NAME" | nc $IP $PORT

FILE_NAME=`nc -l $PORT`
mkdir /home/enti/mis/server/$FILE_NAME

DATA=`nc -l $PORT`

if [ "$DATA" == "" ]
then
	echo "ERROR 4: ARCHIVO VACÍO"
 	rm -r /home/enti/mis/server/$FILE_NAME
	echo "KO_ARCHIVO"
	exit 3
fi
echo "9. SAVING DATA"
echo "$DATA" > server/dragon.txt

echo "10. CHECK OK ARCHIVO_SAVED - Enviando OK_ARCHIVO_SAVED"
echo "OK_ARCHIVO_SAVED" | nc $IP $PORT

DATA=`nc -l $PORT`
echo "13. CALCULATING MD5"
FILE_MD5_RECEIVED=`echo "$DATA" | cut -d ' ' -f 2`

FILE_MD5_CALCULATED=$(md5sum /home/enti/mis/Server/$FILE_NAME | cut -d ' ' -f 1)

if [ "$FILE_MD5_RECEIVED" != "$FILE_MD5_CALCULATED" ]
then
	echo "ERROR 4: MD5 del archivo no coincide"
 	rm -r /home/enti/mis/server/$FILE_NAME
 	echo "KO_FILE_MD5" | nc $IP $PORT
  	exit 4
fi
echo "14. CHECK OK MD5_VERIFIED - Enviando OK_FILE_MD5"
echo "OK_FILE_MD5" | nc $IP $PORT
