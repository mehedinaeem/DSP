#include <iostream>
#include <string>
#include <cctype>
using namespace std;

int main() {
    string text, cipher = "", decrypted = "";
    int key;

    cout << "Enter plaintext: ";
    cin >> text;

    cout << "Enter key: ";
    cin >> key;

    for (char c : text) {
        c = toupper(c);
        cipher += char((c - 'A' + key) % 26 + 'A');
    }

    for (char c : cipher) {
        decrypted += char((c - 'A' - key + 26) % 26 + 'A');
    }

    cout << "\nCiphertext: " << cipher << endl;
    cout << "Decrypted Text: " << decrypted << endl;

    return 0;
}