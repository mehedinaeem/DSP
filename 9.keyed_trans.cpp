#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main() {
    string text;
    int columns;

    cout << "Enter plaintext: ";
    cin >> text;

    cout << "Enter number of columns: ";
    cin >> columns;

    vector<int> key(columns);

    cout << "Enter key: ";

    for (int i = 0; i < columns; i++)
        cin >> key[i];

    int originalLength = text.length();

    while (text.length() % columns != 0)
        text += 'X';

    int rows = text.length() / columns;

    vector<vector<char>> matrix(
        rows,
        vector<char>(columns)
    );

    int index = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++)
            matrix[i][j] = text[index++];
    }

    string cipher = "";

    for (int number = 1; number <= columns; number++) {
        int col = 0;

        for (int j = 0; j < columns; j++) {
            if (key[j] == number) {
                col = j;
                break;
            }
        }

        for (int i = 0; i < rows; i++)
            cipher += matrix[i][col];
    }

    cout << "\nCiphertext: " << cipher << endl;

    // Decryption
    vector<vector<char>> decryptMatrix(
        rows,
        vector<char>(columns)
    );

    index = 0;

    for (int number = 1; number <= columns; number++) {
        int col = 0;

        for (int j = 0; j < columns; j++) {
            if (key[j] == number) {
                col = j;
                break;
            }
        }

        for (int i = 0; i < rows; i++)
            decryptMatrix[i][col] = cipher[index++];
    }

    string decrypted = "";

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++)
            decrypted += decryptMatrix[i][j];
    }

    decrypted = decrypted.substr(0, originalLength);

    cout << "Decrypted Text: " << decrypted << endl;

    return 0;
}