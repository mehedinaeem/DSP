#include <bits/stdc++.h>
using namespace std;

map<char, vector<char>> graph;
set<char> visited;
map<char, char> parentNode;

bool dfs(char current, char goal)
{
    visited.insert(current);
    cout << current << " ";

    if (current == goal)
    {
        return true;
    }

    for (char nextNode : graph[current])
    {
        if (visited.find(nextNode) == visited.end())
        {
            parentNode[nextNode] = current;

            if (dfs(nextNode, goal))
            {
                return true;
            }
        }
    }

    return false;
}

void printPath(char start, char goal)
{
    vector<char> path;

    char node = goal;

    while (node != start)
    {
        path.push_back(node);
        node = parentNode[node];
    }

    path.push_back(start);
    reverse(path.begin(), path.end());

    cout << "\nPath: ";

    for (char x : path)
    {
        cout << x << " ";
    }
}

int main()
{
    graph['A'] = {'B', 'C', 'D'};
    graph['B'] = {'E', 'F'};
    graph['C'] = {};
    graph['D'] = {'G'};
    graph['E'] = {'H'};
    graph['F'] = {};
    graph['G'] = {};
    graph['H'] = {};

    char start = 'A';
    char goal = 'F';

    cout << "DFS Traversal: ";

    if (dfs(start, goal))
    {
        cout << "\nGoal node F found.";
        printPath(start, goal);
    }
    else
    {
        cout << "\nGoal node not found.";
    }

    return 0;
}