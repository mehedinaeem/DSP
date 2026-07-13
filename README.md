# Part A - Prolog & LISP Programs

## Exp 01: Print a list of items
```prolog
item(tshirt).
item(pant).
item(caps).
item(shirt).
item(shoe).
item(sunglass).

products :-
    item(X),
    write(X),
    nl,
    fail.

?- products.
```

## Exp 02: Maximum between two numbers
```prolog
max(X,Y,X) :-
    X >= Y.
max(X,Y,Y) :-
    Y > X.

?- max(10,7,M).
```

## Exp 03: GPA of a student
```prolog
gpa(ashik,3.45).
gpa(rukon,3.50).
gpa(moni,3.25).
gpa(zaman,3.35).
gpa(abid,3.55).

result :-
    write('Enter student name: '),
    read(X),
    gpa(X,Y),
    nl,
    write('GPA is '),
    write(Y).

?- result.
```

## Exp 04: Student-professor relationships
```prolog
studies(tamanna,cse421).
studies(tirana,cse421).
studies(sayem,cse422).
studies(tamanna,cse452).
studies(tamanna,cse423).

teaches(selim_sir,cse452).
teaches(mijan_sir,cse421).
teaches(ujjal_sir,cse423).

professor(X,Y) :-
    teaches(X,Z),
    studies(Y,Z).

?- professor(mijan_sir,tamanna).
```

## Exp 05: Nth Fibonacci number
```prolog
fib(1,1).
fib(2,1).
fib(N,F) :-
    N > 2,
    N1 is N-1,
    N2 is N-2,
    fib(N1,F1),
    fib(N2,F2),
    F is F1+F2.

?- fib(5,F).
```

## Exp 06: Factorial of a number
```prolog
fact(0,1).
fact(N,F) :-
    N > 0,
    N1 is N-1,
    fact(N1,F1),
    F is N*F1.

?- fact(5,F).
```

## Exp 07: Cube of a number
```prolog
cube :-
    write('Enter a number: '),
    read(X),
    process(X).

process(stop) :- !.
process(N) :-
    C is N*N*N,
    write('Cube of '),
    write(N),
    write(' is '),
    write(C),
    nl,
    cube.

?- cube.
```

## Exp 08: Satisfy a list of goals
```prolog
big(bear).
big(elephant).
small(cat).
small(dog).
brown(bear).
black(cat).
black(dog).
gray(elephant).

dark(Z) :- black(Z).
dark(Z) :- brown(Z).
dark(Z) :- gray(Z).

?- dark(cat).
```

## Exp 09: GCD and LCM of two numbers
```prolog
gcd(X,0,X).
gcd(X,Y,D) :-
    Y > 0,
    R is X mod Y,
    gcd(Y,R,D).

lcm(X,Y,M) :-
    gcd(X,Y,D),
    M is (X*Y)/D.

?- gcd(12,9,GCD).
?- lcm(5,7,LCM).
```

## Exp 10: Cyclic graph
```prolog
edge(a,b).
edge(a,c).
edge(b,d).
edge(d,e).
edge(e,b).

path(A,B) :-
    nextRoute(A,B,[]),
    write(B).

nextRoute(A,B,V) :-
    edge(A,X),
    write(A),
    write('->'),
    not(member(X,V)),
    (
        B = X
        ;
        nextRoute(X,B,[A|V])
        ;
        write(X)
    ).

?- path(a,e).
```

## Exp 11: File handling
```prolog
% Writing into a file
writeinfile :-
    tell('mfile.txt'),
    write('Start'),
    told.

% Reading from a file
readfromfile(Infile, Outfile) :-
    see(Infile),
    tell(Outfile),
    read(X1),
    read(X2),
    read(X3),
    write(X1), nl,
    write(X2), nl,
    write(X3), nl,
    seen,
    told.

?- writeinfile.
?- readfromfile('input.txt','output.txt').
```

## Exp 12: Bubble sort
```prolog
bubblesort(InputList,SortList) :-
    swap(InputList,List),
    !,
    printlist(List),
    bubblesort(List,SortList).

bubblesort(SortList,SortList).

swap([X,Y|List],[Y,X|List]) :-
    X > Y.
swap([Z|List],[Z|List1]) :-
    swap(List,List1).

printlist([]) :- nl.
printlist([Head|List]) :-
    write(Head),
    write(' '),
    printlist(List).

?- bubblesort([4,2,3,1],R).
```

## Exp 13: Concatenate two lists
```prolog
list_concat([],L,L).
list_concat([X1|L1],L2,[X1|L3]) :-
    list_concat(L1,L2,L3).

?- list_concat([1,2,3],[a,b,c],R).
```

## Exp 14: Delete an element from a list
```prolog
list_delete(X,[X],[]).
list_delete(X,[X|L1],L1).
list_delete(X,[Y|L2],[Y|L1]) :-
    list_delete(X,L2,L1).

?- list_delete(3,[1,2,3,4],R).
```

## Exp 15: Insert an element into a list
```prolog
list_insert(X,L,R) :-
    list_delete(X,R,L).

?- list_insert(5,[6,4,3,1],R).
```

## Exp 16: LISP - basic list manipulation
```lisp
(setq mylist '(10 20 30 40 50))
(print (car mylist))
(print (cdr mylist))
(print (cons 5 mylist))
(print (list 1 2 3))
(print (append mylist '(60 70)))
```

## Exp 17: LISP - additional list functions
```lisp
(setq mylist '(1 2 3 4 5))
(print (reverse mylist))
(print (member 3 mylist))
(print (nth 2 mylist))
(print (length mylist))
(print (mapcar #'(lambda (x) (* x x)) mylist))
```

## Exp 18: LISP - max and min of numbers
```lisp
(setq numlist '(23 45 12 67 34))
(print (apply #'max numlist))
(print (apply #'min numlist))
```

## Exp 19: LISP - PutProp function
```lisp
(setf (get 'ball 'color) 'red)
(setf (get 'ball 'size) 'small)
(setf (get 'ball 'material) 'rubber)
(print (get 'ball 'color))
(print (get 'ball 'size))
(print (get 'ball 'material))
```

# Part B - Graph Search Algorithms (C++)

## Exp 20: Breadth First Search (BFS)
```cpp
#include <iostream>
#include <queue>
#include <vector>
using namespace std;
int main() {
int n = 6;
vector<vector<int>> graph = {
{1, 2}, {0, 3, 4}, {0, 4}, {1, 5}, {1, 2, 5}, {3, 4}
};
vector<bool> visited(n, false);
queue<int> q;
q.push(0);
visited[0] = true;
cout << "BFS Traversal: ";
while (!q.empty()) {
int node = q.front();
q.pop();
cout << node << " ";
for (int neighbor : graph[node]) {
if (!visited[neighbor]) {
visited[neighbor] = true;
q.push(neighbor);
}
}
}
return 0;
}
```

## Exp 21: Depth First Search (DFS)
```cpp
#include <iostream>
#include <vector>
using namespace std;
vector<vector<int>> graph;
vector<bool> visited;
void dfs(int node) {
visited[node] = true;
cout << node << " ";
for (int neighbor : graph[node]) {
if (!visited[neighbor]) {
dfs(neighbor);
}
}
}
int main() {
int n = 6;
graph = {
{1, 2}, {0, 3, 4}, {0, 4}, {1, 5}, {1, 2, 5}, {3, 4}
};
visited.assign(n, false);
cout << "DFS Traversal: ";
dfs(0);
return 0;
}
```

## Exp 22: A* Search Algorithm
```cpp
#include <iostream>
#include <vector>
#include <queue>
#include <cmath>
#include <climits>
using namespace std;
struct Node {
int vertex;
int gCost;
int fCost;
bool operator>(const Node& other) const {
return fCost > other.fCost;
}
};
int heuristic(int node, int goal, vector<pair<int,int>>& coords) {
int dx = coords[node].first - coords[goal].first;
int dy = coords[node].second - coords[goal].second;
return abs(dx) + abs(dy); // Manhattan distance
}
int main() {
int n = 6;
vector<vector<pair<int,int>>> graph(n); // neighbor, edge cost
graph[0] = {{1, 1}, {2, 4}};
graph[1] = {{0, 1}, {3, 2}, {4, 5}};
graph[2] = {{0, 4}, {4, 1}};
graph[3] = {{1, 2}, {5, 3}};
graph[4] = {{1, 5}, {2, 1}, {5, 1}};
graph[5] = {{3, 3}, {4, 1}};
// Node coordinates used only for the heuristic estimate
vector<pair<int,int>> coords = {
{0,0}, {1,0}, {0,2}, {2,0}, {1,2}, {2,2}
};
int start = 0, goal = 5;
vector<int> gCost(n, INT_MAX);
vector<int> parent(n, -1);
vector<bool> visited(n, false);
priority_queue<Node, vector<Node>, greater<Node>> open;
gCost[start] = 0;
open.push({start, 0, heuristic(start, goal, coords)});
while (!open.empty()) {
Node current = open.top();
open.pop();
if (visited[current.vertex]) continue;
visited[current.vertex] = true;
if (current.vertex == goal) break;
for (auto& [neighbor, cost] : graph[current.vertex]) {
int newG = gCost[current.vertex] + cost;
if (newG < gCost[neighbor]) {
gCost[neighbor] = newG;
parent[neighbor] = current.vertex;
int f = newG + heuristic(neighbor, goal, coords);
open.push({neighbor, newG, f});
}
}
}
cout << "A* Path (goal to start): ";
for (int v = goal; v != -1; v = parent[v])
cout << v << " ";
cout << "\nTotal Cost: " << gCost[goal] << endl;
return 0;
}
```
