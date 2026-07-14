#include <iostream>
#include <vector>
#include <string>
using namespace std;

string encrypt(string text, int rails) {
    vector<string> row(rails);

    int current = 0;
    int direction = 1;

    for (char c : text) {
        row[current] += c;

        if (current == 0)
            direction = 1;
        else if (current == rails - 1)
            direction = -1;

        current += direction;
    }

    string result = "";

    for (string r : row)
        result += r;

    return result;
}

string decrypt(string cipher, int rails) {
    int n = cipher.length();

    vector<vector<char>> matrix(
        rails,
        vector<char>(n, '\0')
    );

    int row = 0;
    int direction = 1;

    for (int col = 0; col < n; col++) {
        matrix[row][col] = '*';

        if (row == 0)
            direction = 1;
        else if (row == rails - 1)
            direction = -1;

        row += direction;
    }

    int index = 0;

    for (int i = 0; i < rails; i++) {
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] == '*')
                matrix[i][j] = cipher[index++];
        }
    }

    string result = "";

    row = 0;
    direction = 1;

    for (int col = 0; col < n; col++) {
        result += matrix[row][col];

        if (row == 0)
            direction = 1;
        else if (row == rails - 1)
            direction = -1;

        row += direction;
    }

    return result;
}

int main() {
    string text;
    int rails;

    cout << "Enter plaintext: ";
    cin >> text;

    cout << "Enter number of rails: ";
    cin >> rails;

    string cipher = encrypt(text, rails);
    string decrypted = decrypt(cipher, rails);

    cout << "\nCiphertext: " << cipher << endl;
    cout << "Decrypted Text: " << decrypted << endl;

    return 0;
}