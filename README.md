# **BD-Monetization**
 
A novel big data watermarking technique that leverages the power of blockchain technology and provides a transparent immutable audit trail for
data movement in big data monetizing scenarios. We have provided complete functionalities in the form of Smart Contracts: \textsf{RegistrationSc}, \textsf{TransferOwnershipSc},
\textsf{tokenSc}, \textsf{AccessSc}, \textsf{ReviewSc}, \textsf{VcontrolSc}.

## Proxy Re-encryption

Proxy re-encryption is a set of algorithms which allows an untrusted proxy to transform ciphertext from being encrypted under one key to another, without learning anything about the underlying plaintext. Proxy re-encryption algorithms usually work as public-key encryption, in which a public-private key-pair is used to encrypt and decrypt the data, respectively.

In order to perform encryption of IPFS-hashes (during registration of watermarked-data) and their proxy re-encryption (during Data Transfer and Access Control), we used `npre' library which requires `libssl-dev` and `libgmp-dev` as its pre-requisites.

### ***Installation***

Proxy re-encryption on docker
```
1. First docker terminal
- docker run -it --detach --name ubuntucon -p 5000:5000 ubuntu:latest
- docker start ubuntucon           (docker start ubuntucon && docker attach ubuntucon)
- apt update
- apt upgrade
- apt-get install build-essential
- apt-get install python3
- apt install python3-pip
- apt-get install python3-dev libssl-dev libgmp-dev
- pip install Flask-RESTful
- pip install Flask-Cors
- pip install web3
```
```
2. Second docker terminal
- docker run -it --detach --name ganachecli -p 8545:8545 ubuntu:latest
- docker start ganachecli           (docker exec -it <container> bash)
- apt update
- apt upgrade
- apt install nodejs
- apt install npm
- npm install -g ganache-cli
- ganache-cli -h 0.0.0.0
```
