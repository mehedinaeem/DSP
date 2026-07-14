#include <iostream>
#include <string>
#include <cctype>
using namespace std;

int main() {
    string text, key;
    string cipher = "", decrypted = "";

    cout << "Enter plaintext: ";
    cin >> text;

    cout << "Enter key: ";
    cin >> key;

    for (char &c : text)
        c = toupper(c);

    for (char &c : key)
        c = toupper(c);

    for (int i = 0; i < text.length(); i++) {
        int p = text[i] - 'A';
        int k = key[i % key.length()] - 'A';

        cipher += char((p + k) % 26 + 'A');
    }

    for (int i = 0; i < cipher.length(); i++) {
        int c = cipher[i] - 'A';
        int k = key[i % key.length()] - 'A';

        decrypted += char((c - k + 26) % 26 + 'A');
    }

    cout << "\nCiphertext: " << cipher << endl;
    cout << "Decrypted Text: " << decrypted << endl;

    return 0;
}