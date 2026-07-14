#include <iostream>
#include <string>
#include <cctype>
using namespace std;

int modInverse(int a) {
    for (int i = 1; i < 26; i++) {
        if ((a * i) % 26 == 1)
            return i;
    }
    return -1;
}

int main() {
    string text, cipher = "", decrypted = "";
    int a, b;

    cout << "Enter plaintext: ";
    cin >> text;

    cout << "Enter key a: ";
    cin >> a;

    cout << "Enter key b: ";
    cin >> b;

    int inverse = modInverse(a);

    if (inverse == -1) {
        cout << "Invalid value of a." << endl;
        return 0;
    }

    for (char c : text) {
        c = toupper(c);
        int p = c - 'A';
        cipher += char((a * p + b) % 26 + 'A');
    }

    for (char c : cipher) {
        int value = c - 'A';
        int p = (inverse * (value - b + 26)) % 26;
        decrypted += char(p + 'A');
    }

    cout << "\nCiphertext: " << cipher << endl;
    cout << "Decrypted Text: " << decrypted << endl;

    return 0;
}