#include<iostream>
#include<climits>
using namespace std;

int miniDist(int distance[], bool Tset[]) // finding minimum distance
{
    int minimum=INT_MAX,ind;
              
    for(int k=0;k<9;k++) 
    {
        if(Tset[k]==false && distance[k]<=minimum)      
        {
            minimum=distance[k];
            ind=k;
        }
    }
    return ind;
}

void DijkstraAlgo(int graph[9][9],int src) // adjacency matrix 
{
    int distance[9]; // // array to calculate the minimum distance for each node                             
    bool Tset[9];// boolean array to mark visited and unvisited for each node
    
     
    for(int k = 0; k<9; k++)
    {
        distance[k] = INT_MAX;
        Tset[k] = false;    
    }
    
    distance[src] = 0;   // Source vertex distance is set 0               
    
    for(int k = 0; k<9; k++)                           
    {
        int m=miniDist(distance,Tset); 
        Tset[m]=true;
        for(int k = 0; k<9; k++)                  
        {
            // updating the distance of neighbouring vertex
            if(!Tset[k] && graph[m][k] && distance[m]!=INT_MAX && distance[m]+graph[m][k]<distance[k])
                distance[k]=distance[m]+graph[m][k];
        }
    }
    cout<<"Vertex\t\tDistance from source vertex"<<endl;
    for(int k = 0; k<9; k++)                      
    { 
        char str=65+k; 
        cout<<str<<"\t\t\t"<<distance[k]<<endl;
    }
}

int main()
{
    int graph[9][9]={
        {0, 1, 0, 9, 0, 0, 0, 0, 0},    // distance from A to all the other nodes
        {1, 0, 3, 0, 4, 0, 0, 0, 0},    // distance from B to all the other nodes
        {0, 3, 0, 0, 0, 2, 0, 0, 0},    // distance from C to all the other nodes
        {9, 0, 0, 0, 8, 0, 1, 0, 0},    // distance from D to all the other nodes
        {0, 4, 0, 8, 0, 5, 0, 1, 0},    // distance from E to all the other nodes
        {0, 0, 2, 0, 5, 0, 0, 0, 7},    // distance from F to all the other nodes
        {0, 0, 0, 1, 0, 0, 0, 3, 0},    // distance from G to all the other nodes
        {0, 0, 0, 0, 1, 0, 3, 0, 4},    // distance from H to all the other nodes
        {0, 0, 0, 0, 0, 7, 0, 4, 0} };  // distance from I to all the other nodes
    DijkstraAlgo(graph,0);
    return 0;                           
}
