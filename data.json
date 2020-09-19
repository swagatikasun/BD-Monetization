from flask import Flask, jsonify, request,Response,json
from flask_restful import Resource, Api, reqparse
from flask_cors import CORS
from web3 import Web3
from npre import bbs98
import base64

parser = reqparse.RequestParser()
pre = bbs98.PRE()

app = Flask(__name__)
app.config['SECRET_KEY'] = 'the quick brown fox jumps over the lazy   dog'
app.config['CORS_HEADERS'] = 'Content-Type'

cors = CORS(app, resources={r"*": {"origins": "*"}})

# w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:7545"))
w3 = Web3(Web3.HTTPProvider("http://ganachecli:8545"))
w3.eth.defaultAccount = w3.eth.accounts[1]

sw3 = Web3(Web3.HTTPProvider("http://ganachecli:8545"))
w3.eth.defaultAccount = w3.eth.accounts[1]

with open("data.json", 'r') as f:
    datastore = json.load(f)
    abi = datastore["abi"]
    contract_address = datastore["contract_address"]

with open("sdata.json", 'r') as sf:
    sdatastore = json.load(sf)
    sabi = sdatastore["abi"]
    scontract_address = sdatastore["contract_address"]


@app.route("/demo1/<string:gg>", methods=['POST'])
def demotw(gg):
    user = w3.eth.contract(address=contract_address, abi=abi)
    tx_hash = user.functions.setMessage(gg).transact()
    print(tx_hash);
    return jsonify({"data": "Raja"}), 200

@app.route("/demo", methods=['GET'])
def demot():
    user = w3.eth.contract(address=contract_address, abi=abi)
    tx_hash = user.functions.getMessage().call()
    print(tx_hash);
    return jsonify({"data": "tx_hash"}), 200


@app.route('/suplier/genkey', methods = ['GET'])
def suppGenerateKey():
    if(request.method == 'GET'):
        key = generatingPrivPub()
        return jsonify({'spriv_key': key["priv_key"],'spub_key': key["pub_key"]})

@app.route('/consumer/genkey', methods = ['GET'])
def consGenerateKey():
    if(request.method == 'GET'):
        key = generatingPrivPub()
        return jsonify({'cpriv_key': key["priv_key"],'cpub_key': key["pub_key"]})

@app.route('/encrypt/text', methods=['GET','POST'])
def encryptText():
    if(request.method == 'POST'):
        parser.add_argument('text', type=str)
        parser.add_argument('own_key', type=str)
        args = parser.parse_args()
        plaintext = args["text"]
        ownerkey_pub = args["own_key"]
        bytesdata = bytes(plaintext, 'utf-8')
        ownerkeyb = bytes(ownerkey_pub, 'utf-8')
        pk_a = base64.b64decode(ownerkeyb)
        emsg = pre.encrypt(pk_a, bytesdata)
        emsgtext = base64.b64encode(emsg)
        ascemsgtext = emsgtext.decode('ascii')
        blockdata = w3.eth.contract(address=contract_address, abi=abi)
        tx_data = blockdata.functions.setCypherData(ascemsgtext).transact()
        return jsonify({'plaintext': plaintext,'ciphertext': ascemsgtext})

@app.route('/suplier/rekeygeneration', methods=['GET','POST'])
def rekeyEncryption():
    if(request.method == 'POST'):
        parser.add_argument('own_key', type=str)
        parser.add_argument('rec_key', type=str)
        args = parser.parse_args()
        ownerkey_priv = args["own_key"]
        rec_key_pub = args["rec_key"]
        sk_e = pre.gen_priv(dtype=bytes)
        ownerkeyb = bytes(ownerkey_priv, 'utf-8')
        sk_a = base64.b64decode(ownerkeyb)
        rec_key_keyb = bytes(rec_key_pub, 'utf-8')
        pk_b = base64.b64decode(rec_key_keyb)
        re_ae = pre.rekey(sk_a, sk_e)
        re_aebyte = base64.b64encode(re_ae)
        re_aebyte_encode = re_aebyte.decode('ascii')
        e_b = pre.encrypt(pk_b, sk_e)
        e_bbyte = base64.b64encode(e_b)
        e_b_encode = e_bbyte.decode('ascii')
        blockdata = w3.eth.contract(address=contract_address, abi=abi)
        tx_data = blockdata.functions.setData(re_aebyte_encode,e_b_encode).transact()
        return jsonify({'reencrytedkey': re_aebyte_encode,'encr_emphkey': e_b_encode})

@app.route('/proxy/displaykey', methods=['GET'])
def displayExtractionEncryption():
    if(request.method == 'GET'):
        blockdata = w3.eth.contract(address=contract_address, abi=abi)
        #regenkeybd = blockdata.functions.getDataGeneKey().call()
        ciphertext = blockdata.functions.getDataCipher().call()
        #encr_emphkey = blockdata.functions.getDataEmphEncryKey().call()
        return jsonify({'ciphertext':ciphertext})

@app.route('/proxy/rencrypted', methods=['GET'])
def msgreEncryption():
    if(request.method == 'GET'):
        blockdata = w3.eth.contract(address=contract_address, abi=abi)
        regenkeybd = blockdata.functions.getDataGeneKey().call()
        ciphertext = blockdata.functions.getDataCipher().call()
        encr_emphkey = blockdata.functions.getDataEmphEncryKey().call()
        dataid = blockdata.functions.setDataId(Data_id).transact()
        regenkeyb = bytes(regenkeybd, 'utf-8')
        re_ae = base64.b64decode(regenkeyb)
        ciphertextb = bytes(ciphertext, 'utf-8')
        emsg = base64.b64decode(ciphertextb)
        emsg_e = pre.reencrypt(re_ae, emsg)
        emsg_e_bbyte = base64.b64encode(emsg_e)
        emsg_e_btext = emsg_e_bbyte.decode('ascii')
        sblockdata = w3.eth.contract(address=scontract_address, abi=sabi)
        stx_data = sblockdata.functions.setData(emsg_e_btext,encr_emphkey).transact()
        return jsonify({'reencryptmsg': emsg_e_btext,'encr_emphkey':encr_emphkey})

@app.route('/decrypt', methods=['GET','POST'])
def decryption():
    if(request.method == 'POST'):
        sblockdata = w3.eth.contract(address=scontract_address, abi=sabi)
        parser.add_argument('rec_key', type=str)
        args = parser.parse_args()
        emp_key = sblockdata.functions.getDataEncryKey().call()
        rec_key = args["rec_key"]
        eemsg = sblockdata.functions.getDataReEncrpMsg().call()
        emp_keyb = bytes(emp_key, 'utf-8')
        e_e = base64.b64decode(emp_keyb)
        rec_keyb = bytes(rec_key, 'utf-8')
        sk_b = base64.b64decode(rec_keyb)
        eemsgb = bytes(eemsg, 'utf-8')
        emsg_e = base64.b64decode(eemsgb)
        sk_e = pre.decrypt(sk_b, e_e)
        bytedata = pre.decrypt(sk_e, emsg_e)
        plaintext = str(bytedata)[1:]
        return jsonify({'plaintext':plaintext})

def generatingPrivPub():
    priv_key = pre.gen_priv(dtype=bytes)
    pub_key = pre.priv2pub(priv_key)
    priv_enc = base64.b64encode(priv_key)
    pub_enc = base64.b64encode(pub_key)
    priv_enc_encode = priv_enc.decode('ascii')
    pub_enc_encode = pub_enc.decode('ascii')
    return {'priv_key': priv_enc_encode,'pub_key': pub_enc_encode}


if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000,debug = True)
