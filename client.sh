#!/bin/bash
if [ "$1" == "" ]
then
	echo "ERROR 0: No se ha indicado la direccion del servidor."
	echo "Ejemplo:"
	echo -e "\t$0 127.0.0.1" 
	exit 0
fi
IP_SERVER=$1
IP=`ip a |grep "scope global" |xargs |cut -d " " -f 2 | cut -d "/" -f 1`
PORT="2022"
echo "Cliente de Dragón magia Abuelita Miedo 2022"
echo "1. ENVÍO DE CABECERA"

echo "DMAM $IP" | nc $IP_SERVER $PORT
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
FILENAME="dragon.txt"  
MD5SUM=$(echo -n "$FILENAME" | md5sum | cut -d ' ' -f 1)
echo "FILE_NAME "$FILENAME $MD5SUM | nc $IP_SERVER $PORT
DATA=`nc -l $PORT`
echo "7. COMPROVANDO RESPUESTA"
if [ "$DATA" != "OK_FILE_NAME" ]
then 
	echo "ERROR 2: el archivo se envió incorrectamente"
	exit 2
fi
echo "OK"
echo "8. ENVIO CONTENIDO ARCHIVO"
echo $FILENAME | nc $IP_SERVER $PORT
cat client/$FILENAME | nc $IP_SERVER $PORT
DATA=`nc -l $PORT`
echo "11. COMPROVANDO RESPUESTA"
if [ "$DATA" != "OK_ARCHIVO_SAVED" ]
then 
	echo "ERROR 4: Los datos se enviaron incorrectamente"
	exit 4
fi
echo "OK"

MD5SUM=$(echo -n "$FILENAME" | md5sum | cut -d ' ' -f 1)
echo "FILE_MD5 $FILE_MD5" | nc $IP_SERVER $PORT

DATA=`nc -l $PORT`
echo "13.COMPROBANDO RESPUESTA DEL MD5"
if [ "$DATA" != "OK_FILE_MD5" ]
then 
	echo "EROOR 5: El MD5 no coincide o hubo un error"
 	exit 5
fi
echo "OK"
