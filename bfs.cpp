#include <bits/stdc++.h>
using namespace std;

map<char, vector<char>> graph;
set<char> visited;
map<char, char> parentNode;

bool bfs(char start, char goal)
{
    queue<char> q;

    q.push(start);
    visited.insert(start);

    while (!q.empty())
    {
        char current = q.front();
        q.pop();

        cout << current << " ";

        if (current == goal)
        {
            return true;
        }

        for (char nextNode : graph[current])
        {
            if (visited.find(nextNode) == visited.end())
            {
                visited.insert(nextNode);
                parentNode[nextNode] = current;
                q.push(nextNode);
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

    cout << "BFS Traversal: ";

    if (bfs(start, goal))
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