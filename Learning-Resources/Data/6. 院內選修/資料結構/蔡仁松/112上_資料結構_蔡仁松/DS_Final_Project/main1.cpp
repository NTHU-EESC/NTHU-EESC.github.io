/***********************************************/
//         This .cpp is for Problem1           //
/***********************************************/
#include <iostream>
#include "basicDS.h"
#include "Problem1.cpp"
#include <fstream>
#include <string>
#include <queue>
#include <sys/times.h>
#include <unistd.h>
#include <cstdio>
#include <map>

void graph_input(Graph& G) {
	int vertex_num, edge_num;
	cin >> vertex_num >> edge_num;

	for (int i = 1; i <= vertex_num; i++) {
		G.V.push_back(i);
	}

	for (int i = 0; i < edge_num; i++) {
		graphEdge gE;
		int a, b, c, d;
		cin >> a >> b >> c >> d;
		gE.vertex[0] = a;
		gE.vertex[1] = b;
		gE.b = c;
		gE.be = c;
		gE.ce = d;
		G.E.push_back(gE);
	}
}

void insert_input(int& id, int& s, int& t, Set& D, string input_string) {

	queue<string> q;

	while (1) {
		q.push(input_string.substr(0, input_string.find(" ")));
		input_string = input_string.substr(input_string.find(" ") + 1, input_string.length());

		if (input_string.find(" ") == -1) {
			q.push(input_string);
			break;
		}
	}

	q.pop();
	id = stoi(q.front());
	q.pop();
	s = stoi(q.front());
	q.pop();
	q.pop();

	while (1) {
		string tmp_s = q.front();
		q.pop();
		if (tmp_s == "}") { break; }
		int tmp_i = stoi(tmp_s);
		D.destinationVertices.push_back(tmp_i);
		D.size++;
	}

	t = stoi(q.front());
	q.pop();
}

int stop_input(string input_string) {
	string tmp_s = input_string.substr(input_string.find(" ") + 1, input_string.length());
	return stoi(tmp_s);
}

void printForest(Problem1 P, Forest F) {
	std::cout << "=========" << '\n';
	for (auto f : F.trees) {
		std::cout << "ID = " << f.id << '\n';
		std::cout << "tree root = " << f.s << '\n';
		std::cout << "ct = " << f.ct << '\n';
		std::cout << "vertices = ";
		for (auto v : f.V) std::cout << v << ' ';
		std::cout << '\n';
		std::cout << "edges = \n";
		for (auto e : f.E) std::cout << "<" << e.vertex[0] << ", " << e.vertex[1] << ">\n";
		std::cout << "---------\n";
	}
	std::cout << "=========" << '\n';
}

void printForest(Problem1 P) {
	std::map<int, Tree> F = P.getForest();
	// auto isRunning = P.getIsRunning();
	std::cout << "=========" << '\n';
	for (auto MT : F) {
		auto f = MT.second;
		// if (!isRunning.at(f.id)) continue;
		std::cout << "ID = " << f.id << '\n';
		std::cout << "tree root = " << f.s << '\n';
		std::cout << "ct = " << f.ct << '\n';
		std::cout << "vertices = ";
		for (auto v : f.V) std::cout << v << ' ';
		std::cout << '\n';
		std::cout << "edges = \n";
		for (auto e : f.E) std::cout << "<" << e.vertex[0] << ", " << e.vertex[1] << ">\n";
		std::cout << "---------\n";
	}
	std::cout << "=========" << '\n';
}

void printGraph(Graph G, int step) {
	// std::cout << "step = " << step << '\n';
	std::cout << "Graph G: \n";
	std::cout << "---------" << '\n';
	std::cout << "Verteices:" << '\n';
	for (auto v : G.V) std::cout << v << ' ';
	std::cout << '\n';
	std::cout << "Edges:" << '\n';
	for (auto e : G.E) std::cout << "{" << e.vertex[0] << ", " << e.vertex[1] << "}: bandwidth = " << e.b << ", cost = " << e.ce << '\n';
	std::cout << "=========" << '\n';
}

void print_graph(Graph &G)
{
  cout << "======Graph======" << endl;
  cout << "veritces: ";
  for(auto& v: G.V) cout << v << " ";
  cout << endl;
  cout << "edges:" << endl;
  for(auto& e: G.E)
  {
      cout << "<" << e.vertex[0] << "," << e.vertex[1] << "> ";
      cout << e.b << "/" << e.ce << endl;
  }
  cout << "=================" << endl;
}

void print_forest(Forest &F)
{
  cout << "----------MTforest----------" << endl;
  for(auto& tree: F.trees)
  {
    cout << "# ";
    cout << "id: " << tree.id << ", sc: " << tree.s << endl;
    //cout << "t: " << tree.second << " ,ct: " << tree.first.ct << endl;
	cout << "ct: " << tree.ct << endl;
    cout << "veritces: ";
    for(auto& v: tree.V) cout << v << " ";
    cout << endl;
    cout << "edges: ";
    for(auto& e: tree.E) cout << "<" << e.vertex[0] << "," << e.vertex[1] << "> ";
    cout << endl;
    cout << endl;
  }
  cout << "-----------------------------" << endl;
}

int main(void) {

	FILE* in = freopen("Problem1_test_case.txt", "r", stdin);
	// FILE* in = freopen("sample_input.txt", "r", stdin);
	FILE* out = freopen("Problem1_output.txt", "w", stdout);

	struct tms  tmsstart, tmsend;
    clock_t     start, end;
    static long     clktck = 0;
    clktck = sysconf(_SC_CLK_TCK);
    start = times(&tmsstart);

	Graph G;
	Tree T;
	Forest F;
	graph_input(G);

	Problem1 P1(G);

	int step = 0;
	// printGraph(G, step);
	print_graph(G);

	string input_string;
	while (getline(cin, input_string)) {
		// system("clear");
		// std::cout << "step = " << step++;
		if (input_string[0] == 'i') {
			int id, s, t;
			Set D;
			insert_input(id, s, t, D, input_string);
			P1.insert(id, s, D, t, G, T);

			// std::cout << "++++++++++++++++++++\n";
			// std::cout << input_string << '\n';
			// step++;
			// printGraph(G, step);
			// print_graph(G);
			// printForest(P1);
			
		}
		else if (input_string[0] == 's') {
			int id = stop_input(input_string);
			P1.stop(id, G, F);

			// std::cout << "++++++++++++++++++++\n";
			// std::cout << input_string << '\n';
			// step++;
			// printGraph(G, step);
			// print_graph(G);
			// printForest(P1, F);
			// print_forest(F);

		}
		else if (input_string[0] == 'r') {
			P1.rearrange(G, F);

			// std::cout << "++++++++++++++++++++\n";
			// std::cout << input_string << '\n';
			// step++;
			// printGraph(G, step);
			// print_graph(G);
			// printForest(P1, F);
			// print_forest(F);
			
		}
	}
	// std::cout << "++++++++++++++++++++\n";

	
	end = times(&tmsend);

    printf(" real:  %7.7f\n", (end-start) / (double) clktck);
    printf(" user:  %7.7f\n",
            (tmsend.tms_utime - tmsstart.tms_utime) / (double) clktck);
    printf(" sys:   %7.7f\n",
            (tmsend.tms_stime - tmsstart.tms_stime) / (double) clktck);
	

	fclose(in);
	fclose(out);

	return 0;
}
