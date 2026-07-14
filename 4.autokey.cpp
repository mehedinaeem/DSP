#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main() {
    string plaintext, ciphertext = "", decryptedText = "";
    int initialKey;

    cout << "Plaintext: ";
    cin >> plaintext;

    cout << "Initial Key: ";
    cin >> initialKey;

    vector<int> keystream;

    // First key is the initial numeric key
    keystream.push_back(initialKey);

    // Remaining keys come from plaintext
    for (int i = 0; i < plaintext.length() - 1; i++) {
        keystream.push_back(plaintext[i] - 'A');
    }

    // Encryption
    for (int i = 0; i < plaintext.length(); i++) {
        int p = plaintext[i] - 'A';
        int c = (p + keystream[i]) % 26;

        ciphertext += char(c + 'A');
    }

    // Decryption
    for (int i = 0; i < ciphertext.length(); i++) {
        int c = ciphertext[i] - 'A';
        int p = (c - keystream[i] + 26) % 26;

        decryptedText += char(p + 'A');
    }

    // Output
    cout << "\nKeystream: ";

    for (int i = 0; i < keystream.size(); i++) {
        cout << keystream[i] << " ";
    }

    cout << "\nCiphertext: " << ciphertext;
    cout << "\nDecrypted Text: " << decryptedText << endl;

    return 0;
}