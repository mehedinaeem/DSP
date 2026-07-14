#include <iostream>
#include <string>
#include <vector>
#include <cctype>
using namespace std;

char matrix5[5][5];

void createMatrix(string key) {
    bool used[26] = {false};
    used['J' - 'A'] = true;

    string result = "";

    for (char c : key) {
        c = toupper(c);

        if (c == 'J')
            c = 'I';

        if (!used[c - 'A']) {
            used[c - 'A'] = true;
            result += c;
        }
    }

    for (char c = 'A'; c <= 'Z'; c++) {
        if (!used[c - 'A']) {
            used[c - 'A'] = true;
            result += c;
        }
    }

    int k = 0;

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            matrix5[i][j] = result[k++];
        }
    }
}

void findPosition(char c, int &row, int &col) {
    if (c == 'J')
        c = 'I';

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            if (matrix5[i][j] == c) {
                row = i;
                col = j;
                return;
            }
        }
    }
}

string prepareText(string text) {
    string result = "";

    for (char c : text) {
        if (isalpha(c)) {
            c = toupper(c);

            if (c == 'J')
                c = 'I';

            result += c;
        }
    }

    string prepared = "";

    for (int i = 0; i < result.length();) {
        char a = result[i];
        char b;

        if (i + 1 >= result.length()) {
            b = 'X';
            i++;
        }
        else if (result[i] == result[i + 1]) {
            b = 'X';
            i++;
        }
        else {
            b = result[i + 1];
            i += 2;
        }

        prepared += a;
        prepared += b;
    }

    return prepared;
}

string encrypt(string text) {
    string result = "";

    for (int i = 0; i < text.length(); i += 2) {
        int r1, c1, r2, c2;

        findPosition(text[i], r1, c1);
        findPosition(text[i + 1], r2, c2);

        if (r1 == r2) {
            result += matrix5[r1][(c1 + 1) % 5];
            result += matrix5[r2][(c2 + 1) % 5];
        }
        else if (c1 == c2) {
            result += matrix5[(r1 + 1) % 5][c1];
            result += matrix5[(r2 + 1) % 5][c2];
        }
        else {
            result += matrix5[r1][c2];
            result += matrix5[r2][c1];
        }
    }

    return result;
}

string decrypt(string text) {
    string result = "";

    for (int i = 0; i < text.length(); i += 2) {
        int r1, c1, r2, c2;

        findPosition(text[i], r1, c1);
        findPosition(text[i + 1], r2, c2);

        if (r1 == r2) {
            result += matrix5[r1][(c1 + 4) % 5];
            result += matrix5[r2][(c2 + 4) % 5];
        }
        else if (c1 == c2) {
            result += matrix5[(r1 + 4) % 5][c1];
            result += matrix5[(r2 + 4) % 5][c2];
        }
        else {
            result += matrix5[r1][c2];
            result += matrix5[r2][c1];
        }
    }

    return result;
}

int main() {
    string text, key;

    cout << "Enter plaintext: ";
    cin >> text;

    cout << "Enter key: ";
    cin >> key;

    createMatrix(key);

    cout << "\nPlayfair Matrix:\n";

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++)
            cout << matrix5[i][j] << " ";

        cout << endl;
    }

    string prepared = prepareText(text);
    string cipher = encrypt(prepared);
    string decrypted = decrypt(cipher);

    cout << "\nPrepared Text: " << prepared << endl;
    cout << "Ciphertext: " << cipher << endl;
    cout << "Decrypted Text: " << decrypted << endl;

    return 0;
}