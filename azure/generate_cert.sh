
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout azure.pem -out azure.pem
openssl x509 -inform pem -in azure.pem -outform der -out azure.cer

