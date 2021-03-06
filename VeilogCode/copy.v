
module main;
	int graph[9][9];
	int source = 6 , destination = 2;

        //typedef int gra[9][9];
	/*function automatic void randGen();
		automatic int graph1[9][9];
		automatic int a = $urandom_range(1,10); //(0,1) =(1,0)
		automatic int b = $urandom_range(1,10); //(0,3) =(3,0)
		automatic int c = $urandom_range(1,10); //(1,2) =(2,1)
		automatic int d = $urandom_range(1,10); //(1,4) =(4,1)
		automatic int e = $urandom_range(1,10); //(2,5) =(5,2)
		automatic int f = $urandom_range(1,10); //(3,4) =(4,3)
		automatic int g = $urandom_range(1,10); //(3,6) =(6,3)
		automatic int h = $urandom_range(1,10); //(4,5) =(5,4)
		automatic int i = $urandom_range(1,10); //(4,7) =(7,4)
		automatic int j = $urandom_range(1,10); //(5,8) =(8,5)
		automatic int k = $urandom_range(1,10); //(6,7) =(7,6)
		automatic int l = $urandom_range(1,10); //(7,8) =(8,7)

		graph1 = '{ 
			'{0, a, 100, b, 100, 100, 100, 100, 100},  // distance from A (0) to all the other nodes
    	 		'{a, 0, c, 100, d, 100, 100, 100, 100},    // distance from B (1) to all the other nodes
     	 		'{100, c, 0, 100, 100, e, 100, 100, 100},  // distance from C (2) to all the other nodes
      			'{b, 100, 100, 0, f, 100, g, 100, 100},    // distance from D (3) to all the other nodes
     			'{100, d, 100, f, 0, h, 100, i, 100},      // distance from E (4) to all the other nodes
     	 		'{100, 100, e, 100, h, 0, 100, 100, j},    // distance from F (5) to all the other nodes
    	 		'{100, 100, 100, g, 100, 100, 0, k, 100},  // distance from G (6) to all the other nodes
    	 		'{100, 100, 100, 100, i, 100, k, 0, l},    // distance from H (7) to all the other nodes
     	 		'{100, 100, 100, 100, 100, j, 100, l, 0}   // distance from I (8) to all the other nodes
    	 		};
		$display("-------Displaying Graph/Node's--------");
		for(int i=0; i<9; i++) begin
			for(int j=0; j<9; j++) begin
				$write("%0d ",graph1[i][j]);
			end
			$display();
		end
		//return graph1;
	endfunction : randGen */
        
	initial begin


		graph = '{ 
			'{0, 1, 100, 9, 100, 100, 100, 100, 100}, // distance from A (0) to all the other nodes
      			'{1, 0, 3, 100, 4, 100, 100, 100, 100},   // distance from B (1) to all the other nodes
      			'{100, 3, 0, 100, 100, 2, 100, 100, 100}, // distance from C (2) to all the other nodes
      			'{9, 100, 100, 0, 8, 100, 1, 100, 100},   // distance from D (3) to all the other nodes
     			'{100, 4, 100, 8, 0, 5, 100, 1, 100},     // distance from E (4) to all the other nodes
      			'{100, 100, 2, 100, 5, 0, 100, 100, 7},   // distance from F (5) to all the other nodes
      			'{100, 100, 100, 1, 100, 100, 0, 3, 100}, // distance from G (6) to all the other nodes
      			'{100, 100, 100, 100, 1, 100, 3, 0, 4},   // distance from H (7) to all the other nodes
      			'{100, 100, 100, 100, 100, 7, 100, 4, 0}  // distance from I (8) to all the other nodes
     			};


		/*for(int i=0; i<9; i++) begin
			for(int j=0; j<9; j++) begin
				$readmemh("D:\Final_year_project\code\project_file.txt", graph);
			end
		end*/
		
	end

	dijkstra d1(graph,source,destination); 

	//int graph3[9][9]; 
	//randGen r1();
	//randGen r2();
	//dijkstra d2(graph,source,destination);
	/*
	randGen r2(graph,source,destination);
	//dijkstra d3(graph,source,destination);

	randGen r3(graph,source,destination);
	//dijkstra d4(graph,source,destination);

	randGen r4(graph,source,destination);
	
	randGen r5(graph,source,destination);
	*/

endmodule

//seq2

module dijkstra(ref int graph[9][9], src, dest);
	//`define max = 1000;
	//sptSet (shortest path tree set)
	int distance[9], parent[9], sptSet[9];

	function int minDistance(input int distance[9], sptSet[9]);

   		// Initialize min value
    		int min, min_index;
		min = 100;
   
    		for (int v = 0; v < 9; v++) begin
       			if (sptSet[v] == 0 && distance[v] <= min)
         		begin
            			min = distance[v];  min_index = v; 
	  		end
        		end
  
    		return min_index;

	endfunction : minDistance



	initial begin
		for(int i = 0; i < 9; i++) begin
			distance[i] = 100; sptSet[i] = 0; parent[src] = -1; end

		distance[src] = 0; //source node distnace


		for (int count = 0; count < 8; count++) begin

			int u; 
			u = minDistance(distance, sptSet);
			sptSet[u] = 1;

			for (int V = 0; V < 9; V++) begin
				if (sptSet[V] == 0 && graph[u][V] != 0 && distance[u] != 100 && (distance[u] + graph[u][V] < distance[V]))
               			begin
                    			parent[V] = u;
                    			distance[V] = distance[u] + graph[u][V];
                		end

			end

		end
	 end

	print p(distance, parent, src, dest, graph);

endmodule

//seq3

module print(ref int distance[9], parent[9], src, dest, graph[9][9]);

	task automatic printPath(input int parent[9], dest, src);
		//int array[10];
		while(dest != src) begin
			//for(int i=0; i<5; i++) begin
			//array[i] = parent[dest]; break;  end
			$write("<--%d",parent[dest]); 
			dest = parent[dest];  
		end
		$display;
		$display;
	endtask

	initial begin

		$monitor("Source:%d Destination:%d     Distance:%d", src, dest, distance[dest]);
		$display("Path:");
		$write("%d",dest);
		printPath(parent, dest, src);

	end
endmodule


/*
module randGen();
	int graph1[9][9];
	int a = $urandom_range(1,10); //(0,1) =(1,0)
	int b = $urandom_range(1,10); //(0,3) =(3,0)
	int c = $urandom_range(1,10); //(1,2) =(2,1)
	int d = $urandom_range(1,10); //(1,4) =(4,1)
	int e = $urandom_range(1,10); //(2,5) =(5,2)
	int f = $urandom_range(1,10); //(3,4) =(4,3)
	int g = $urandom_range(1,10); //(3,6) =(6,3)
	int h = $urandom_range(1,10); //(4,5) =(5,4)
	int i = $urandom_range(1,10); //(4,7) =(7,4)
	int j = $urandom_range(1,10); //(5,8) =(8,5)
	int k = $urandom_range(1,10); //(6,7) =(7,6)
	int l = $urandom_range(1,10); //(7,8) =(8,7)

	initial begin		
		graph1 = '{ 
			'{0, a, 100, b, 100, 100, 100, 100, 100},  // distance from A (0) to all the other nodes
    	 		'{a, 0, c, 100, d, 100, 100, 100, 100},    // distance from B (1) to all the other nodes
     	 		'{100, c, 0, 100, 100, e, 100, 100, 100},  // distance from C (2) to all the other nodes
      			'{b, 100, 100, 0, f, 100, g, 100, 100},    // distance from D (3) to all the other nodes
     			'{100, d, 100, f, 0, h, 100, i, 100},      // distance from E (4) to all the other nodes
     	 		'{100, 100, e, 100, h, 0, 100, 100, j},    // distance from F (5) to all the other nodes
    	 		'{100, 100, 100, g, 100, 100, 0, k, 100},  // distance from G (6) to all the other nodes
    	 		'{100, 100, 100, 100, i, 100, k, 0, l},    // distance from H (7) to all the other nodes
     	 		'{100, 100, 100, 100, 100, j, 100, l, 0}   // distance from I (8) to all the other nodes
    	 		};
		$display("-------Displaying Graph/Node's--------");
		for(int i=0; i<9; i++) begin
			for(int j=0; j<9; j++) begin
				$write("%0d ",graph1[i][j]);
			end
			$display();
		end
		//return graph1;
	end
endmodule
*/