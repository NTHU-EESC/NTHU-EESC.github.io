#include "basicDS.h"
#include <set>
#include <string.h>
#include <algorithm>
#include <map>

/* You can add more functions or variables in each class. 
   But you "Shall Not" delete any functions or variables that TAs defined. */

class Problem1 {

private:
	// int size = 0;
	// Forest connectedNetwork;
	// std::map<int, bool> isRunning;
	std::map<int, bool> fullConnected;
	std::map<int, int> packetSize;
	std::map<int, Tree> connectedTrees; // {id, tree}

public:
	Problem1(Graph G);  //constructor
	~Problem1();        //destructor
	void insert(int id, int s, Set D, int t, Graph &G, Tree &MTid);
	void stop(int id, Graph &G, Forest &MTidForest);
	void rearrange(Graph &G, Forest &MTidForest);
	bool cmpEdge(int e1[], int e2[]);
	std::map<int, Tree> getForest();
	/*std::map<int, bool> getIsRunning() {
		return isRunning;
	}*/

};

std::map<int, Tree> Problem1::getForest() {
	return connectedTrees;
}

Problem1::Problem1(Graph G) {
	/* Write your code here. */
	// size = 0;
}

Problem1::~Problem1() {
	/* Write your code here. */

}

void Problem1::insert(int id, int s, Set D, int t, Graph &G, Tree &MTid) {
	/* Store your output graph and multicast tree into G and MTid */
	
	/* Write your code here. */
	// id--;

	Graph modified_G;
	for (auto& vertex : G.V) modified_G.V.push_back(vertex);
	for (auto& edge : G.E) {
		if (edge.b >= t) modified_G.E.push_back(edge);
	}

	int table[modified_G.V.size() + 1][modified_G.V.size() + 1];
	memset(table, -1, sizeof(table));
	for (auto& edge : modified_G.E) table[edge.vertex[0]][edge.vertex[1]] = table[edge.vertex[1]][edge.vertex[0]] = edge.ce;
	
	int predecessor[modified_G.V.size() + 1];
	memset(predecessor, -1, sizeof(predecessor));

	int key[modified_G.V.size() + 1];
	memset(key, -1, sizeof(key));

	bool visited[modified_G.V.size() + 1];
	memset(visited, 0, sizeof(visited));

	int remainSize = modified_G.V.size();
	int currNode = s;

	while (remainSize--) {
		if (currNode == -1) break;
		
		visited[currNode] = true;
		key[currNode] = 0;

		for (auto& i : modified_G.V) {
			if (visited[i]) continue;
			if (table[currNode][i] != -1) {
				if (key[i] == -1 || key[i] > table[currNode][i]) {
					key[i] = table[currNode][i];
					predecessor[i] = currNode;
				}
			}
		}

		currNode = -1;
		int min = -1;

		for (auto& i : modified_G.V) {
			if (visited[i]) continue;
			if (key[i] == -1) continue;
			if (min == -1 || min > key[i]) {
				currNode = i;
				min = key[i];
			}
		}

	}
	if (currNode != -1) visited[currNode] = true;

	memset(&MTid, 0, sizeof(MTid));

	MTid.id = id;
	MTid.s = s;
	MTid.ct = 0;
	int num_of_connected_vertex = 0;
	for (auto& i : modified_G.V) {
		if (predecessor[i] != -1) {
			treeEdge tmpTreeEdge;
			tmpTreeEdge.vertex[0] = predecessor[i];
			tmpTreeEdge.vertex[1] = i;
			bool existed = false;
			for (auto& existedEdge : MTid.E) {
				if (cmpEdge(tmpTreeEdge.vertex, existedEdge.vertex)) {
					existed = true;
					break;
				}
			}
			if (!existed) {
				MTid.E.push_back(tmpTreeEdge);
				for (auto& edge : G.E) {
					if (cmpEdge(edge.vertex, tmpTreeEdge.vertex)) {
						edge.b -= t;
						MTid.ct += edge.ce;
						break;
					}
				}
			}
			
		}
		if (visited[i]) {
			MTid.V.push_back(i);
			num_of_connected_vertex++;
		}
	}
	MTid.ct *= t;
	

	// if (id >= size) packetSize.push_back(t);
	packetSize[id] = t;

	if (num_of_connected_vertex == modified_G.V.size()) {
		// if (id >= size) fullConnected.push_back(true);
		// else fullConnected.at(id) = true;
		fullConnected[id] = true;
	}
	else {
		// if (id >= size) fullConnected.push_back(false);
		// else fullConnected.at(id) = false;
		fullConnected[id] = false;
	}

	// if (id >= size) connectedNetwork.trees.push_back(MTid);
	// else connectedNetwork.trees.at(id) = MTid;
	connectedTrees[id] = MTid;
	
	// if (id >= size) isRunning.push_back(true);
	// else isRunning.at(id) = true;
	// isRunning[id] = true;

	// if (id >= size) connectedNetwork.size++;
	// if (id >= size) size++;

	return;
}

void Problem1::stop(int id, Graph &G, Forest &MTidForest) {
	/* Store your output graph and multicast tree forest into G and MTidForest
	   Note: Please "only" include mutlicast trees that you added nodes in MTidForest. */
	
	/* Write your code here. */
	// id--;
	// isRunning.at(id) = false;
	// isRunning[id] = false;

	for (auto& releaseEdge : /*connectedNetwork.trees.at(id).E*/connectedTrees[id].E) {
		for (auto& graphE : G.E) {
			if (cmpEdge(releaseEdge.vertex, graphE.vertex)) {
				graphE.b += /*packetSize.at(id)*/packetSize[id];
				break;
			}
		}
	}

	connectedTrees.erase(id);

	std::map<int, bool> isModified;
	for (auto MT : connectedTrees) isModified[MT.first] = false;

	// bool isModified[connectedNetwork.size];
	// memset(isModified, 0, sizeof(isModified));

	for (/*int ID = 0; ID < connectedNetwork.size; ID++*/auto tree : connectedTrees) {
		int ID = tree.first;
		if (/*isRunning[ID] && */!fullConnected[ID]) {
			// get modified Graph
			Graph modified_G;
			for (auto& vertex : G.V) modified_G.V.push_back(vertex);
			for (auto& edge : G.E) {
				if (edge.b >= packetSize[ID]) {
					bool existed[2] = {false, false};
					for (auto& existedVertex : connectedTrees[ID].V/*connectedNetwork.trees.at(ID).V*/) {
						if (existedVertex == edge.vertex[0]) {
							existed[0] = true;
							break;
						}
					}
					for (auto& existedVertex : connectedTrees[ID].V/*connectedNetwork.trees.at(ID).V*/) {
						if (existedVertex == edge.vertex[1]) {
							existed[1] = true;
							break;
						}
					}
					if (!existed[0] || !existed[1]) modified_G.E.push_back(edge);
				}
			}

			int table[modified_G.V.size() + 1][modified_G.V.size() + 1];
			memset(table, -1, sizeof(table));
			for (auto& edge : modified_G.E) table[edge.vertex[0]][edge.vertex[1]] = table[edge.vertex[1]][edge.vertex[0]] = edge.ce;

			int predecessor[modified_G.V.size() + 1];
			memset(predecessor, -1, sizeof(predecessor));

			int key[modified_G.V.size() + 1];
			memset(key, -1, sizeof(key));

			bool visited[modified_G.V.size() + 1];
			memset(visited, 0, sizeof(visited));

			for (auto& existedVertex : connectedTrees[ID].V/*.trees.at(ID).V*/) {
				visited[existedVertex] = true;
			}

			int remainSize = modified_G.V.size() - connectedTrees[ID].V.size()/*connectedNetwork.trees.at(ID).V.size()*/;
			int currNode = -1;
			int min = -1;

			for (auto& src : modified_G.V) {
				if (visited[src]) {
					for (auto& dest : modified_G.V) {
						if (table[src][dest] != -1) {
							if (min == -1) {
								min = table[src][dest];
								currNode = src;
							}
							else if (table[src][dest] < min) {
								min = table[src][dest];
								currNode = src;
							}
						}
					}
				}
			}

			while (remainSize--) {
				if (currNode == -1) break;

				isModified[ID] = true;
				
				visited[currNode] = true;
				key[currNode] = 0;

				for (auto& i : modified_G.V) {
					if (visited[i]) continue;
					if (table[currNode][i] != -1) {
						if (key[i] == -1 || key[i] > table[currNode][i]) {
							key[i] = table[currNode][i];
							predecessor[i] = currNode;
						}
					}
				}

				currNode = -1;
				min = -1;

				for (auto& i : modified_G.V) {
					if (visited[i]) continue;
					if (key[i] == -1) continue;
					if (min == -1 || min > key[i]) {
						currNode = i;
						min = key[i];
					}
				}

			}
			if (currNode != -1) visited[currNode] = true;

			while (connectedTrees[ID].V.size()/*connectedNetwork.trees.at(ID).V.size()*/) connectedTrees[ID].V.pop_back()/*connectedNetwork.trees.at(ID).V.pop_back()*/;

			int num_of_connected_vertex = 0;
			for (auto& i : modified_G.V) {
				if (predecessor[i] != -1) {
					treeEdge tmpTreeEdge;
					tmpTreeEdge.vertex[0] = predecessor[i];
					tmpTreeEdge.vertex[1] = i;

					bool existed = false;
					for (auto& existedEdge : connectedTrees[ID].E/*connectedNetwork.trees.at(ID).E*/) {
						if (cmpEdge(tmpTreeEdge.vertex, existedEdge.vertex)) {
							existed = true;
							break;
						}
					}
					if (!existed) {
						// connectedNetwork.trees.at(ID).E.push_back(tmpTreeEdge);
						connectedTrees[ID].E.push_back(tmpTreeEdge);
						for (auto& edge : G.E) {
							if (cmpEdge(edge.vertex, tmpTreeEdge.vertex)) {
								edge.b -= packetSize[ID];
								connectedTrees[ID].ct/*connectedNetwork.trees.at(ID).ct*/ += edge.ce * packetSize[ID];
								break;
							}
						}
					}
				}
				if (visited[i]) {
					// connectedNetwork.trees.at(ID).V.push_back(i);
					connectedTrees[ID].V.push_back(i);
					num_of_connected_vertex++;
				}
			}
			

			if (num_of_connected_vertex == modified_G.V.size()) fullConnected[ID] = true /*fullConnected.push_back(true)*/;
			else fullConnected[ID] = false /*fullConnected.push_back(false)*/;

		}
	}

	Forest newForest;
	for (/*int ID = 0; ID < connectedNetwork.size; ID++*/ auto MT : connectedTrees) {
		int ID = MT.first;
		if (/*isRunning[ID] && */isModified[ID]) {
			newForest.trees.push_back(connectedTrees[ID]/*connectedNetwork.trees.at(ID)*/);
			newForest.size++;
		}
	}
	MTidForest = newForest;

	// connectedTrees.erase(id);

	return;
}

void Problem1::rearrange(Graph &G, Forest &MTidForest) {
	/* Store your output graph and multicast tree forest into G and MTidForest
	   Note: Please include "all" active mutlicast trees in MTidForest. */

	/* Write your code here. */

	for (auto& edge : G.E) edge.b = edge.be;

	Set D;
	D.size = G.V.size();
	for (auto& newDest : G.V) D.destinationVertices.push_back(newDest);

	Tree tr;

	for (auto MT : connectedTrees) {
		int ID = MT.first;
		insert(ID, MT.second.s, D, packetSize[ID], G, tr);
	}

	/*for (int ID = 0; ID < size; ID++) {
		if (isRunning.at(ID)) {
			insert(ID + 1, connectedNetwork.trees.at(ID).s, D, packetSize.at(ID), G, tr);
		}
	}*/

	Forest newForest;
	for (/*int ID = 0; ID < connectedNetwork.size; ID++*/ auto MT : connectedTrees) {
		int ID = MT.first;
		// if (isRunning[ID]) {
			newForest.trees.push_back(connectedTrees[ID]/*connectedNetwork.trees.at(ID)*/);
			newForest.size++;
		// }
	}
	MTidForest = newForest;
	
	return;
}

bool Problem1::cmpEdge(int e1[], int e2[]) {
	return (e1[0] == e2[0] && e1[1] == e2[1]) || (e1[0] == e2[1] && e1[1] == e2[0]);
}