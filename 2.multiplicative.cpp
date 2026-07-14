#include <iostream>
#include <string>
#include <cctype>
using namespace std;

int modInverse(int key) {
    for (int i = 1; i < 26; i++) {
        if ((key * i) % 26 == 1)
            return i;
    }
    return -1;
}

int main() {
    string text, cipher = "", decrypted = "";
    int key;

    cout << "Enter plaintext: ";
    cin >> text;

    cout << "Enter key: ";
    cin >> key;

    int inverse = modInverse(key);

    if (inverse == -1) {
        cout << "Invalid key. Key must be relatively prime to 26." << endl;
        return 0;
    }

    for (char c : text) {
        c = toupper(c);
        cipher += char(((c - 'A') * key) % 26 + 'A');
    }

    for (char c : cipher) {
        decrypted += char(((c - 'A') * inverse) % 26 + 'A');
    }

    cout << "\nCiphertext: " << cipher << endl;
    cout << "Decrypted Text: " << decrypted << endl;

    return 0;
}