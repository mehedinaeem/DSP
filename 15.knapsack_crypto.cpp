#include <iostream>
#include <vector>
#include <string>
using namespace std;

int modInverse(int a, int m) {
    for (int i = 1; i < m; i++) {
        if ((a * i) % m == 1)
            return i;
    }

    return -1;
}

int main() {
    vector<int> privateKey =
        {2, 3, 7, 14, 30, 57, 120, 251};

    int m = 491;
    int w = 41;

    vector<int> publicKey;

    for (int x : privateKey)
        publicKey.push_back((x * w) % m);

    string message;

    cout << "Enter 8-bit binary message: ";
    cin >> message;

    cout << "\nPrivate Key: ";

    for (int x : privateKey)
        cout << x << " ";

    cout << "\nPublic Key: ";

    for (int x : publicKey)
        cout << x << " ";

    // Encryption
    int cipher = 0;

    for (int i = 0; i < 8; i++) {
        if (message[i] == '1')
            cipher += publicKey[i];
    }

    cout << "\nCiphertext: "
         << cipher << endl;

    // Decryption
    int wInverse =
        modInverse(w, m);

    int sum =
        (cipher * wInverse) % m;

    string decrypted = "00000000";

    for (int i = 7; i >= 0; i--) {
        if (privateKey[i] <= sum) {
            decrypted[i] = '1';
            sum -= privateKey[i];
        }
    }

    cout << "Decrypted Message: "
         << decrypted << endl;

    return 0;
}