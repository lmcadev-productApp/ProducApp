#!/usr/bin/.env bash
set -e

host="$1"
port="$2"
shift 2
cmd="$@"

until (echo > /dev/tcp/"$host"/"$port") >/dev/null 2>&1; do
  echo "Esperando a $host:$port..."
  sleep 2
done

echo "$host:$port está listo. Ejecutando comando..."
exec $cmd
