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
    char current = goal;

    while (current != start)
    {
        path.push_back(current);
        current = parentNode[current];
    }

    path.push_back(start);
    reverse(path.begin(), path.end());

    cout << "\nPath: ";

    for (char node : path)
    {
        cout << node << " ";
    }
}

int main()
{
    int numberOfNodes, numberOfEdges;

    cout << "Enter number of nodes: ";
    cin >> numberOfNodes;

    cout << "Enter number of edges: ";
    cin >> numberOfEdges;

    cout << "Enter the edges:\n";

    for (int i = 0; i < numberOfEdges; i++)
    {
        char u, v;
        cin >> u >> v;

        graph[u].push_back(v);
    }

    char start, goal;

    cout << "Enter starting node: ";
    cin >> start;

    cout << "Enter goal node: ";
    cin >> goal;

    cout << "DFS Traversal: ";

    if (dfs(start, goal))
    {
        cout << "\nGoal node found.";
        printPath(start, goal);
    }
    else
    {
        cout << "\nGoal node not found.";
    }

    return 0;
}