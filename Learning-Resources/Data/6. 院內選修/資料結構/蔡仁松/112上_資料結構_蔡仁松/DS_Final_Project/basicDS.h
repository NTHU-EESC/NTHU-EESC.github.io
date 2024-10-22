#ifndef BASICDS_H
#define BASICDS_H

#include <vector>

using namespace std;

// a mathematical set
struct Set {
	int size = 0;
	vector<int> destinationVertices;
};

// an edge in graph
struct graphEdge {
	int vertex[2];
    int b;          // remaining bandwidth
	int be;   		// bandwidth limit
	int ce;   		// bandwidth cost
};

// an edge in tree
struct treeEdge {
	int vertex[2];
};

// an undirected graph
struct Graph {
	vector<int> V;
	vector<graphEdge> E;
};

// a multicast tree
struct Tree {
	vector<int> V;
	vector<treeEdge> E;
	int s;          // source node
	int id;         // corresponding multicast request id
	int ct;         // transmission cost of multicast tree
};

// a forest
struct Forest {
	int size = 0;
	vector<Tree> trees;
};
#endif
