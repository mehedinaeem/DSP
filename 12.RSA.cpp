#include <iostream>
using namespace std;

long long powerMod(
    long long base,
    long long exponent,
    long long mod
) {
    long long result = 1;

    while (exponent > 0) {
        if (exponent % 2 == 1)
            result = (result * base) % mod;

        base = (base * base) % mod;
        exponent /= 2;
    }

    return result;
}

int modInverse(int e, int phi) {
    for (int d = 1; d < phi; d++) {
        if ((e * d) % phi == 1)
            return d;
    }

    return -1;
}

int main() {
    int p, q, e, message;

    cout << "Enter prime p: ";
    cin >> p;

    cout << "Enter prime q: ";
    cin >> q;

    cout << "Enter public exponent e: ";
    cin >> e;

    cout << "Enter message: ";
    cin >> message;

    int n = p * q;
    int phi = (p - 1) * (q - 1);

    int d = modInverse(e, phi);

    if (d == -1) {
        cout << "Invalid e." << endl;
        return 0;
    }

    cout << "\nPublic Key: ("
         << e << ", " << n << ")" << endl;

    cout << "Private Key: ("
         << d << ", " << n << ")" << endl;

    long long cipher =
        powerMod(message, e, n);

    long long decrypted =
        powerMod(cipher, d, n);

    cout << "Ciphertext: "
         << cipher << endl;

    cout << "Decrypted Message: "
         << decrypted << endl;

    return 0;
}