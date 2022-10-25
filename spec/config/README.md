The *.pem files in this directory were created explicitly for this test suite, and do not correspond to any real service account, or any real anything.

The password for the private.pem is `1111`.

Command used to create `private.pem`:
```shell
openssl genrsa -des3 -out private.pem 2048
```

Command used to create `private_unencrypted.pem` (NEVER DO THIS IN REAL LIFE)
```shell
openssl rsa -in private.pem -out private_unencrypted.pem -outform PEM
```

To convert the `private_unencrypted.pem` to a "single line" string to paste into the JSON as `private_key_id`:
```shell
cat private_unencrypted.pem | pbcopy
```
