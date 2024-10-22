#include "basicDS.h"
#include <string.h>
#include <set>
#include <algorithm>
#include <map>

/* You can add more functions or variables in each class. 
   But you "Shall Not" delete any functions or variables that TAs defined. */

std::map<int, int> globalPacketSize;
std::map<int, int> globalDestNum;

class Problem2 {

private:
	// int size = 0;
	// Forest connectedNetwork;
	// std::vector<bool> isRunning;
	std::map<int, bool> fullConnected;
	std::map<int, int> packetSize;
	std::map<int, std::set<int>> destination;
	// std::set<int> idList;
	std::map<int, Tree> connectedTrees;
	Graph OriginalG;

public:

	Problem2(Graph G);  //constructor
	~Problem2();        //destructor
	bool insert(int id, int s, Set D, int t, Graph &G, Tree &MTid);
	void stop(int id, Graph &G, Forest &MTidForest);
	void rearrange(Graph &G, Forest &MTidForest);
	bool cmpEdge(int e1[], int e2[]);
	std::map<int, Tree> getForest();
	/*std::vector<bool> getIsRunning() {
		return isRunning;
	}*/
	/*std::vector<bool> getFullConnected() {
		return fullConnected;
	}*/
};

bool cmpByPacketSize(int a, int b) {
	return (globalPacketSize.at(a) * globalDestNum.at(a) < globalPacketSize.at(b) * globalDestNum.at(b));
}

std::map<int, Tree> Problem2::getForest() {
	return connectedTrees;
}

Problem2::Problem2(Graph G) {
	/* Write your code here. */
	// size = 0;
	OriginalG = G;
}

Problem2::~Problem2() {
	/* Write your code here. */

}

bool Problem2::insert(int id, int s, Set D, int t, Graph &G, Tree &MTid) {
	/* Store your output graph and multicast tree into G and MTid */
	
	/* Write your code here. */

	// id--;

	/*if (id >= size) {
		idList.insert(id);
		std::set<int> tmp_dest;
		for (auto dest : D.destinationVertices) tmp_dest.insert(dest);
		destination.push_back(tmp_dest);
	}
	if (id >= size) packetSize.push_back(t);*/
	packetSize[id] = t;
	if (destination.find(id) == destination.end()) {
		for (auto dest : D.destinationVertices) destination[id].insert(dest);
	}
	// problem

	Graph modified_G;
	for (auto& vertex : G.V) modified_G.V.push_back(vertex);
	for (auto& edge : G.E) {
		if (edge.b >= t) modified_G.E.push_back(edge);
	}

	int table[modified_G.V.size() + 1][modified_G.V.size() + 1];
	memset(table, -1, sizeof(table));
	for (auto& edge : modified_G.E) table[edge.vertex[0]][edge.vertex[1]] = table[edge.vertex[1]][edge.vertex[0]] = edge.b;
	
	int predecessor[modified_G.V.size() + 1];
	memset(predecessor, -1, sizeof(predecessor));

	int key[modified_G.V.size() + 1];
	memset(key, -1, sizeof(key));

	bool visited[modified_G.V.size() + 1];
	memset(visited, 0, sizeof(visited));

	int remainSize = modified_G.V.size();
	int currNode = s;

	std::set<int> remainDest = destination.at(id);

	while (remainSize--) {
		if (currNode == -1) break;
		if (remainDest.empty()) break;
		
		visited[currNode] = true;
		remainDest.erase(currNode);
		key[currNode] = 0;

		for (auto& i : modified_G.V) {
			if (visited[i]) continue;
			if (table[currNode][i] != -1) {
				if (key[i] == -1 || key[i] < table[currNode][i]) {
					key[i] = table[currNode][i];
					predecessor[i] = currNode;
				}
			}
		}

		currNode = -1;
		int max = -1;

		for (auto& i : modified_G.V) {
			if (visited[i]) continue;
			if (key[i] == -1) continue;
			if (max == -1 || max < key[i]) {
				currNode = i;
				max = key[i];
			}
		}

	}
	if (currNode != -1) {
		visited[currNode] = true;
		remainDest.erase(currNode);
	}

	memset(&MTid, 0, sizeof(MTid));

	if (remainDest.size()) {
		MTid.id = id;
		MTid.s = s;
		// if (id >= size) fullConnected.push_back(false);
		// else fullConnected.at(id) = false;
		fullConnected[id] = false;
		// if (id >= size) connectedNetwork.trees.push_back(MTid);
		// else connectedNetwork.trees.at(id) = MTid;
		connectedTrees[id] = MTid;
		// if (id >= size) isRunning.push_back(true);
		// else isRunning.at(id) = true;

		// if (id >= size) connectedNetwork.size++;
		// if (id >= size) size++;

		return false;
	}

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

	// if (id >= size) connectedNetwork.size++;
	// if (id >= size) size++;

	/* You should return true or false according the insertion result */
	return true;
}

void Problem2::stop(int id, Graph &G, Forest &MTidForest) {
	/* Store your output graph and multicast tree forest into G and MTidForest
	   Note: Please "only" include mutlicast trees that you added nodes in MTidForest. */
	
	/* Write your code here. */
	// id--;
	// isRunning.at(id) = false;
	

	for (auto& releaseEdge : connectedTrees[id].E/*connectedNetwork.trees.at(id).E*/) {
		for (auto& graphE : G.E) {
			if (cmpEdge(releaseEdge.vertex, graphE.vertex)) {
				graphE.b += packetSize.at(id);
				break;
			}
		}
	}

	connectedTrees.erase(id);

	std::vector<int> idAcendingByPacketSize;

	for (auto MT : connectedTrees) {
		int ID = MT.first;
		if (!fullConnected[ID]) idAcendingByPacketSize.push_back(ID);
	}

	auto pre_fullConnected = fullConnected;

	if (idAcendingByPacketSize.size()) {

		// while (globalDestNum.size()) globalDestNum.pop_back();
		globalDestNum.clear();
		for (auto it : destination) globalDestNum[it.first] = it.second.size();
		globalPacketSize = packetSize;
		std::sort(idAcendingByPacketSize.begin(), idAcendingByPacketSize.end(), cmpByPacketSize);

		for (auto ID : idAcendingByPacketSize) {
			Set D;
			Tree tmp_t;
			D.size = destination[ID].size();
			for (auto dest : destination.at(ID)) D.destinationVertices.push_back(dest);
			insert(ID, connectedTrees[ID].s/*connectedNetwork.trees.at(ID).s*/, D, packetSize.at(ID), G, tmp_t);
		}

	}

	Forest F;
	F.size = 0;
	for (auto MT : connectedTrees) {
		int ID = MT.first;
		if (/*isRunning.at(ID) && */fullConnected[ID] && !pre_fullConnected[ID]) {
			F.trees.push_back(connectedTrees[ID]/*connectedNetwork.trees.at(ID)*/);
			// F.trees.back().id++;
			F.size++;
		}
	}
	MTidForest = F;

	return;
}

void Problem2::rearrange(Graph &G, Forest &MTidForest) {
	/* Store your output graph and multicast tree forest into G and MTidForest
	   Note: Please include "all" active mutlicast trees in MTidForest. */

	/* Write your code here. */

	G = OriginalG;

	for (auto& tree : /*connectedNetwork.trees*/connectedTrees) {
		tree.second.ct = 0;
		while (tree.second.E.size()) tree.second.E.pop_back();
		while (tree.second.V.size()) tree.second.V.pop_back();
	}
	for (auto i : fullConnected) i.second = false;
	
	std::vector<int> idAcendingByPacketSize;
	
	for (auto MT : connectedTrees) {
		int ID = MT.first;
		if (!fullConnected[ID]) idAcendingByPacketSize.push_back(ID);
	}

	
	if (idAcendingByPacketSize.size()) {

		globalDestNum.clear();
		for (auto it : destination) globalDestNum[it.first] = it.second.size();
		globalPacketSize = packetSize;
		std::sort(idAcendingByPacketSize.begin(), idAcendingByPacketSize.end(), cmpByPacketSize);

		for (auto ID : idAcendingByPacketSize) {
			Set D;
			Tree tmp_t;
			D.size = destination[ID].size();
			for (auto dest : destination[ID]) D.destinationVertices.push_back(dest);
			insert(ID, connectedTrees[ID].s/*connectedNetwork.trees.at(ID).s*/, D, packetSize[ID], G, tmp_t);
		}

	}

	
	Forest F;
	F.size = 0;
	for (auto MT : connectedTrees) {
		int ID;
		if (/*isRunning.at(ID) && */fullConnected[ID]) {
			F.trees.push_back(connectedTrees[ID]/*connectedNetwork.trees.at(ID)*/);
			F.size++;
		}
	}
	MTidForest = F;
	
	return;
}

bool Problem2::cmpEdge(int e1[], int e2[]) {
	return (e1[0] == e2[0] && e1[1] == e2[1]) || (e1[0] == e2[1] && e1[1] == e2[0]);
}