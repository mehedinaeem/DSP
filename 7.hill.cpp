#include <iostream>
#include <string>
#include <cctype>
using namespace std;

int modInverse(int n) {
    n = (n % 26 + 26) % 26;

    for (int i = 1; i < 26; i++) {
        if ((n * i) % 26 == 1)
            return i;
    }

    return -1;
}

int main() {
    string text, cipher = "", decrypted = "";

    int key[2][2] = {
        {3, 3},
        {2, 5}
    };

    cout << "Enter plaintext: ";
    cin >> text;

    for (char &c : text)
        c = toupper(c);

    if (text.length() % 2 != 0)
        text += 'X';

    // Encryption
    for (int i = 0; i < text.length(); i += 2) {
        int p1 = text[i] - 'A';
        int p2 = text[i + 1] - 'A';

        int c1 = (key[0][0] * p1 + key[0][1] * p2) % 26;
        int c2 = (key[1][0] * p1 + key[1][1] * p2) % 26;

        cipher += char(c1 + 'A');
        cipher += char(c2 + 'A');
    }

    // Inverse matrix
    int determinant =
        key[0][0] * key[1][1]
        - key[0][1] * key[1][0];

    determinant =
        (determinant % 26 + 26) % 26;

    int detInverse = modInverse(determinant);

    int inverse[2][2];

    inverse[0][0] =
        (key[1][1] * detInverse) % 26;

    inverse[0][1] =
        ((-key[0][1] * detInverse) % 26 + 26) % 26;

    inverse[1][0] =
        ((-key[1][0] * detInverse) % 26 + 26) % 26;

    inverse[1][1] =
        (key[0][0] * detInverse) % 26;

    // Decryption
    for (int i = 0; i < cipher.length(); i += 2) {
        int c1 = cipher[i] - 'A';
        int c2 = cipher[i + 1] - 'A';

        int p1 =
            (inverse[0][0] * c1
            + inverse[0][1] * c2) % 26;

        int p2 =
            (inverse[1][0] * c1
            + inverse[1][1] * c2) % 26;

        decrypted += char(p1 + 'A');
        decrypted += char(p2 + 'A');
    }

    cout << "\nCiphertext: " << cipher << endl;
    cout << "Decrypted Text: " << decrypted << endl;

    return 0;
}