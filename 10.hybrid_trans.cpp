#include <iostream>
#include <vector>
#include <string>
using namespace std;

// Rail Fence Encryption
string railEncrypt(string text, int rails) {

    vector<string> row(rails);

    int r = 0;
    int direction = 1;

    for (char c : text) {

        row[r] += c;

        if (r == 0)
            direction = 1;

        if (r == rails - 1)
            direction = -1;

        r += direction;
    }

    cout << "\nStep 1 (Rail Fence, "
         << rails << " rails):" << endl;

    for (int i = 0; i < rails; i++) {

        cout << "Row" << i << ": ";

        for (char c : row[i])
            cout << c << " ";

        cout << endl;
    }

    string result = "";

    for (int i = 0; i < rails; i++)
        result += row[i];

    return result;
}


// Rail Fence Decryption
string railDecrypt(string cipher, int rails) {

    int n = cipher.length();

    vector<vector<char>> matrix(
        rails,
        vector<char>(n, ' ')
    );

    int r = 0;
    int direction = 1;

    // Mark Rail Fence positions
    for (int col = 0; col < n; col++) {

        matrix[r][col] = '*';

        if (r == 0)
            direction = 1;

        if (r == rails - 1)
            direction = -1;

        r += direction;
    }

    // Fill ciphertext
    int index = 0;

    for (int i = 0; i < rails; i++) {

        for (int j = 0; j < n; j++) {

            if (matrix[i][j] == '*') {
                matrix[i][j] = cipher[index++];
            }
        }
    }

    // Read zigzag
    string plaintext = "";

    r = 0;
    direction = 1;

    for (int col = 0; col < n; col++) {

        plaintext += matrix[r][col];

        if (r == 0)
            direction = 1;

        if (r == rails - 1)
            direction = -1;

        r += direction;
    }

    return plaintext;
}


// Columnar Encryption
string columnEncrypt(
    string text,
    vector<int> key
) {

    int columns = key.size();

    // Padding if necessary
    while (text.length() % columns != 0)
        text += 'X';

    int rows = text.length() / columns;

    vector<vector<char>> matrix(
        rows,
        vector<char>(columns)
    );

    int index = 0;

    // Fill row by row
    for (int i = 0; i < rows; i++) {

        for (int j = 0; j < columns; j++) {

            matrix[i][j] = text[index++];
        }
    }

    string cipher = "";

    // Read columns according to key order
    for (int number = 1;
         number <= columns;
         number++) {

        int col = 0;

        for (int j = 0; j < columns; j++) {

            if (key[j] == number) {
                col = j;
                break;
            }
        }

        for (int i = 0; i < rows; i++) {

            cipher += matrix[i][col];
        }
    }

    return cipher;
}


// Columnar Decryption
string columnDecrypt(
    string cipher,
    vector<int> key
) {

    int columns = key.size();
    int rows = cipher.length() / columns;

    vector<vector<char>> matrix(
        rows,
        vector<char>(columns)
    );

    int index = 0;

    // Fill columns according to key
    for (int number = 1;
         number <= columns;
         number++) {

        int col = 0;

        for (int j = 0; j < columns; j++) {

            if (key[j] == number) {
                col = j;
                break;
            }
        }

        for (int i = 0; i < rows; i++) {

            matrix[i][col] = cipher[index++];
        }
    }

    string result = "";

    // Read row by row
    for (int i = 0; i < rows; i++) {

        for (int j = 0; j < columns; j++) {

            result += matrix[i][j];
        }
    }

    return result;
}


int main() {

    string plaintext;
    int rails;

    vector<int> key(4);

    cout << "Plaintext: ";
    cin >> plaintext;

    cout << "Step 1 Rails: ";
    cin >> rails;

    cout << "Step 2 Key: ";

    for (int i = 0; i < 4; i++)
        cin >> key[i];

    int originalLength = plaintext.length();

    // Step 1
    string intermediate =
        railEncrypt(plaintext, rails);

    cout << "Intermediate: "
         << intermediate << endl;

    // Step 2
    string ciphertext =
        columnEncrypt(intermediate, key);

    cout << "\nStep 2 "
         << "(Columnar Transposition with key ";

    for (int x : key)
        cout << x;

    cout << " on 4-column blocks):"
         << endl;

    cout << "Final Ciphertext: "
         << ciphertext << endl;

    // Reverse Step 2
    string step1 =
        columnDecrypt(ciphertext, key);

    // Remove padding
    step1 =
        step1.substr(0, originalLength);

    // Reverse Step 1
    string decrypted =
        railDecrypt(step1, rails);

    cout << "\nDecrypted Text: "
         << decrypted << endl;

    cout << "(Decryption reverses Step 2 then Step 1)"
         << endl;

    return 0;
}