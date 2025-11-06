#!/bin/bash
# Script riutilizzabile per decodificare e sbloccare Git-crypt
# Usa: ./decrypt.sh $GITCRYPT_KEY_SECRET

if [ -z "$1" ]; then
    echo "Errore: Variabile chiave non fornita. Uso: $0 \$GITCRYPT_KEY_SECRET"
    exit 1
fi

KEY_FILE="/tmp/git-crypt-temp-key"

echo "Decodifica chiave Base64..."
# La chiave viene fornita come argomento 1 (la variabile Secret)
echo "$1" | base64 -d > "$KEY_FILE" 2>/dev/null

if [ $? -ne 0 ]; then
    echo "Errore: Impossibile decodificare la chiave Base64."
    rm -f "$KEY_FILE"
    exit 1
fi

echo "Sblocco Git-crypt in corso..."
git-crypt unlock "$KEY_FILE"

if [ $? -eq 0 ]; then
    echo "✅ Git-crypt sbloccato con successo."
else
    echo "❌ Errore durante lo sblocco di Git-crypt."
fi

# Pulizia
rm -f "$KEY_FILE"
echo "Chiave temporanea rimossa."

# Termina con lo stato di uscita di git-crypt unlock
exit $?
