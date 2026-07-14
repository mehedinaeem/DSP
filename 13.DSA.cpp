#include <iostream>
using namespace std;


// Fast Modular Power
long long powerMod(
    long long base,
    long long power,
    long long mod
) {

    long long result = 1;

    while (power > 0) {

        if (power % 2 == 1)
            result = (result * base) % mod;

        base = (base * base) % mod;

        power = power / 2;
    }

    return result;
}


// Modular Inverse
long long modInverse(
    long long a,
    long long mod
) {

    for (long long i = 1; i < mod; i++) {

        if ((a * i) % mod == 1)
            return i;
    }

    return -1;
}


int main() {

    long long p, q, g;
    long long x, hash, k;

    cout << "p = ";
    cin >> p;

    cout << "q = ";
    cin >> q;

    cout << "g = ";
    cin >> g;

    cout << "Private key x = ";
    cin >> x;

    // Public key
    long long y =
        powerMod(g, x, p);

    cout << "Public key y = g^x mod p = "
         << g << "^"
         << x << " mod "
         << p << " = "
         << y << endl;

    cout << "Message hash H(m) = ";
    cin >> hash;

    cout << "Random k = ";
    cin >> k;

    long long kInverse =
        modInverse(k, q);

    cout << "(k^-1 mod q = "
         << kInverse << ")"
         << endl;


    // Signing
    long long gk =
        powerMod(g, k, p);

    long long r =
        gk % q;

    long long s =
        (
            kInverse *
            (hash + x * r)
        ) % q;


    cout << "\nSigning:" << endl;

    cout << "r = (g^k mod p) mod q = ("
         << g << "^"
         << k << " mod "
         << p << ") mod "
         << q << " = "
         << gk << " mod "
         << q << " = "
         << r << endl;


    cout << "s = k^-1 (H(m) + x*r) mod q = "
         << kInverse
         << " x ("
         << hash
         << " + "
         << x
         << "x"
         << r
         << ") mod "
         << q
         << " = "
         << s
         << endl;


    cout << "\nSignature: (r, s) = ("
         << r << ", "
         << s << ")"
         << endl;


    // Verification
    long long w =
        modInverse(s, q);

    long long u1 =
        (hash * w) % q;

    long long u2 =
        (r * w) % q;

    long long v =
        (
            powerMod(g, u1, p)
            *
            powerMod(y, u2, p)
        ) % p % q;


    cout << "\nVerification "
         << "(receiver, using y, r, s, H(m)):"
         << endl;

    cout << "w = s^-1 mod q = "
         << w << endl;

    cout << "u1 = H(m)*w mod q = "
         << u1 << endl;

    cout << "u2 = r*w mod q = "
         << u2 << endl;

    cout << "v = ((g^u1 * y^u2) mod p) mod q = "
         << v << endl;


    if (v == r) {

        cout << "If v == r -> Signature Valid"
             << endl;

        cout << "\nResult: Signature Valid"
             << endl;
    }
    else {

        cout << "\nResult: Signature Invalid"
             << endl;
    }

    return 0;
}