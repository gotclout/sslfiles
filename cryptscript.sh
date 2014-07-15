#!/bin/bash

## gen private key to file
openssl genrsa -out mykey.pem 1024;

## gen public key to file
openssl rsa -in mykey.pem -pubout > mypubkey.pem;

## create a message for testing
#echo "This is a test of the openssl encryption system">test.msg
echo "allow(PK,Access,Resources):-pk_bind(P,PK),allow(P,Access,Resources).pk_bind(jeremiah,rsa_3fcb4a57240d9287e43b8615e9994bba).allow(jeremiah,read,file1).allow(jeremiah,_anyAccess,file2).allow(jeremiah,read,file3).datime(2011,12,19,0,0,0).datime(2012,12,19,0,0,0).">test.msg

##### sign
## create a digest of the message to be signed
openssl dgst -md5 -sign mykey.pem -out test.dgst test.msg
## base64 encode test mesage so that it can be sent
openssl enc -base64 -in test.dgst -out testb64.dgst

##### verify
## decode the digested message
openssl enc -base64 -d -in testb64.dgst -out testb64dec.dgst
## verify the message digest using the pub key and signature
openssl dgst -md5 -verify mypubkey.pem -signature testb64dec.dgst test.msg
