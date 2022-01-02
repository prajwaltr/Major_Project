#include <iostream>
using namespace std;
#include <climits>

// function to find the vertex with minimum distance value, from
// the set of vertices not yet included in shortest path
int minDistance(int dist[], bool sptSet[])
{

	// Initialize min value
	int min = INT_MAX, min_index;
    
	for (int v = 0; v < 9; v++)
		if (sptSet[v] == false && dist[v] <= min)
        {
            min = dist[v], min_index = v;
        }
    //cout<<min_index<<endl;
    //cout<<"hi"<<endl;
	return min_index;
}

void printPath(int parent[], int j)
{

    // Base Case : If j is source
    if (parent[j] == - 1)
        return;

    printPath(parent, parent[j]);

    char nextNode = 65 + j;

    cout<<"-> "<<nextNode<<" ";
}

void printSolution(int dist[], int parent[], int destina,int src)  //print the result
{  
    cout<<"dist_array"<<endl;
   for(int i=0;i<9;i++)
    {
        cout<<"distance from node "<<i<<" to source node "<<src<<" is "<<dist[i]<<endl;
    }
    cout<<"parent_array"<<endl;

    for(int i=0;i<9;i++)
    {
        cout<<"parent of "<<i<<" is "<<parent[i]<<endl;
    }
    cout<<"\n****************\n";
    //cout<<dist[destina]<<" "<<parent[destina]<<endl;
    
    cout<<"\nSource "<<src<<" -> Detination "<<destina<<" \t Distance \t Path"<<endl;
    
                  
    char snode = 65+ src;
    char node = 65 + destina; //converting from number to alphabets
    cout<<"\n"<<snode<<"\t -> \t "<<node<<"\t\t  "<<dist[destina]<<"\t\t "<<snode;
    printPath(parent, destina);     
    
    
    cout<<"\n";
}

void dijkstra(int graph[9][9], int src,int destina)
{
	int dist[9], parent[9];
    bool sptSet[9];

	for (int i = 0; i < 9; i++)
		dist[i] = INT_MAX, sptSet[i] = false, parent[src] = -1;


	dist[src] = 0; //source node distnace

	// Find shortest path for all vertices
	for (int count = 0; count < 8; count++) {
		// Pick the minimum distance vertex from the set of vertices not
		// yet processed. u is always equal to src in the first iteration.
		int u = minDistance(dist, sptSet);

		// Mark the picked vertex as processed
		sptSet[u] = true;

		// Update dist value of the adjacent vertices of the picked vertex.
		for (int v = 0; v < 9; v++)

			// Update dist[v] only if is not in sptSet, there is an edge from
			// u to v, and total weight of path from src to v through u is
			// smaller than current value of dist[v]
			if (!sptSet[v] && graph[u][v] && dist[u] != INT_MAX && dist[u] + graph[u][v] < dist[v])
               {
				    parent[v] = u;
				    dist[v] = dist[u] + graph[u][v];
				}

	}

	printSolution(dist, parent,destina,src);
}


int main()
{   int src,dst;
    int graph[9][9] =
    { {0, 1, 0, 9, 0, 0, 0, 0, 0}, // distance from A to all the other nodes
      {1, 0, 3, 0, 4, 0, 0, 0, 0}, // distance from B to all the other nodes
      {0, 3, 0, 0, 0, 2, 0, 0, 0}, // distance from C to all the other nodes
      {9, 0, 0, 0, 8, 0, 1, 0, 0}, // distance from D to all the other nodes
      {0, 4, 0, 8, 0, 5, 0, 1, 0}, // distance from E to all the other nodes
      {0, 0, 2, 0, 5, 0, 0, 0, 7}, // distance from F to all the other nodes
      {0, 0, 0, 1, 0, 0, 0, 3, 0}, // distance from G to all the other nodes
      {0, 0, 0, 0, 1, 0, 3, 0, 4}, // distance from H to all the other nodes
      {0, 0, 0, 0, 0, 7, 0, 4, 0} // distance from I to all the other nodes
     }; 
    cin>>src>>dst;
   // if(src<=dst)
	dijkstra(graph, src, dst);     // 0 indicates node A (source node)
    
   // else
   // dijkstra(graph, dst, src);

	return 0;
}


