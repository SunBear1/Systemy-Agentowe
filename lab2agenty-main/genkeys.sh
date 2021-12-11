#!/bin/sh

# Parametry
# $1 - ile bedzie kontenerow

if [ $# -ne 1 ] || [ $1 -lt 2 ]; then
    echo "xd"
    exit
fi

counter=0

# Tworzenie par kluczy i eksport certyfikatów

while [ $counter -lt $1 ]; do
    keytool -genkey -alias cont${counter} -keyalg RSA -keystore kstore${counter} -keypass changeit -storepass changeit -dname "CN=Giada,OU=JADE,O=FooBar Ltd,L=Naples,ST=na,C=IT"
    keytool -export -keystore kstore${counter} -storepass changeit -alias cont${counter} -rfc -file cert${counter}.cer
    let counter++
done 

counter=0

# Importowanie certyfikatow

while [ $counter -lt $1 ]; do
    inner_counter=0
    while [ $inner_counter -lt $1 ]; do
        if [ $counter -ne $inner_counter ]; then
            keytool -import -keystore tstore${counter} -storepass changeit -alias cont${inner_counter} -file cert${inner_counter}.cer -noprompt    
        fi
        let inner_counter++
    done
    let counter++
done
