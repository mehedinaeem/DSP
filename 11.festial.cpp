#include <iostream>
using namespace std;

int F(int right, int key) {
    return right ^ key;
}

int main() {
    int L, R, K1, K2;

    cout << "Enter left half: ";
    cin >> L;

    cout << "Enter right half: ";
    cin >> R;

    cout << "Enter key 1: ";
    cin >> K1;

    cout << "Enter key 2: ";
    cin >> K2;

    int originalL = L;
    int originalR = R;

    // Encryption Round 1
    int newL = R;
    int newR = L ^ F(R, K1);

    L = newL;
    R = newR;

    // Encryption Round 2
    newL = R;
    newR = L ^ F(R, K2);

    L = newL;
    R = newR;

    cout << "\nCipher Left: " << L << endl;
    cout << "Cipher Right: " << R << endl;

    // Decryption
    // Undo Round 2
    int oldR = L;
    int oldL = R ^ F(L, K2);

    L = oldL;
    R = oldR;

    // Undo Round 1
    oldR = L;
    oldL = R ^ F(L, K1);

    L = oldL;
    R = oldR;

    cout << "\nDecrypted Left: " << L << endl;
    cout << "Decrypted Right: " << R << endl;

    return 0;
}