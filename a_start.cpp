#include <bits/stdc++.h>
using namespace std;

map<char, vector<pair<char, int>>> graph;
map<char, int> heuristicValue;
map<char, int> parentNode;

void addEdge(char u, char v, int cost)
{
    graph[u].push_back({v, cost});
    graph[v].push_back({u, cost});
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

    cout << "Shortest Path: ";

    for (int i = 0; i < path.size(); i++)
    {
        cout << path[i];

        if (i < path.size() - 1)
        {
            cout << " -> ";
        }
    }
}

void aStar(char start, char goal)
{
    priority_queue<
        pair<int, char>,
        vector<pair<int, char>>,
        greater<pair<int, char>>
    > openList;

    map<char, int> gCost;

    for (char node : {'a', 'b', 'c', 'd', 'e', 'f', 'z'})
    {
        gCost[node] = INT_MAX;
    }

    gCost[start] = 0;

    int startingFCost = gCost[start] + heuristicValue[start];

    openList.push({startingFCost, start});

    cout << "Visited Nodes: ";

    while (!openList.empty())
    {
        int currentFCost = openList.top().first;
        char current = openList.top().second;

        openList.pop();

        cout << current << " ";

        if (current == goal)
        {
            cout << "\n";
            printPath(start, goal);
            cout << "\nTotal Cost: " << gCost[goal];
            return;
        }

        for (auto neighbour : graph[current])
        {
            char nextNode = neighbour.first;
            int edgeCost = neighbour.second;

            int newGCost = gCost[current] + edgeCost;

            if (newGCost < gCost[nextNode])
            {
                gCost[nextNode] = newGCost;
                parentNode[nextNode] = current;

                int newFCost =
                    gCost[nextNode] + heuristicValue[nextNode];

                openList.push({newFCost, nextNode});
            }
        }
    }

    cout << "\nNo path found.";
}

int main()
{
    addEdge('a', 'b', 4);
    addEdge('a', 'c', 3);
    addEdge('b', 'f', 5);
    addEdge('f', 'z', 16);
    addEdge('b', 'e', 12);
    addEdge('c', 'e', 10);
    addEdge('c', 'd', 7);
    addEdge('d', 'e', 2);
    addEdge('e', 'z', 5);

    heuristicValue['a'] = 14;
    heuristicValue['b'] = 12;
    heuristicValue['c'] = 11;
    heuristicValue['d'] = 6;
    heuristicValue['e'] = 4;
    heuristicValue['f'] = 11;
    heuristicValue['z'] = 0;

    char start = 'a';
    char goal = 'z';

    aStar(start, goal);

    return 0;
}