#include <iostream>
#include <vector>

using namespace std;

int main() {
    vector<string> v = {"foo", "bar"};
    string *p = &(v[0]);
    v.push_back("baz");
    cout << *p << endl;

    return 0;
}
