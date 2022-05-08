module main;
	int graph[8:0][8:0];
	int source = 0 , destination = 8;

	initial begin
		graph = '{ '{0, 4, 0, 7, 0, 0, 0, 0, 0},
			'{4, 0, 3, 0, 1, 0, 0, 0, 0},
			'{0, 3, 0, 0, 0, 1, 0, 0, 0},
			'{7, 0, 0, 0, 5, 0, 2, 0, 0},
			'{0, 1, 0, 5, 0, 8, 0, 4, 0},
			'{0, 0, 1, 0, 8, 0, 0, 0, 9},
			'{0, 0, 0, 2, 0, 0, 0, 3, 0},
			'{0, 0, 0, 0, 4, 0, 3, 0, 1},
			'{0, 0, 0, 0, 0, 9, 0, 1, 0} };


		/*for(int i=0; i<9; i++) begin
			for(int j=0; j<9; j++) begin
				$readmemh("D:\project_file.txt", graph);
			end
		end
		*/
		$display("------**-Displaying Graph/Node's-**-------");
		for(int i=0; i<9; i++) begin
			for(int j=0; j<9; j++) begin
				$write("%0d ",graph[i][j]);
			end
			$display();
		end


	end
	dijkstra d(graph,source,destination); 
endmodule


module dijkstra(ref int graph[9][9], src, dest);
	//`define max = 1000;
	int distance[9], parent[9], sptSet[9];

	function int minDistance(input int distance[9], sptSet[9]);

    		// Initialize min value
    		int min, min_index;
			min = 1024;
   
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
			distance[i] = 1024; sptSet[i] = 0; parent[src] = -1;
		end

		distance[src] = 0; //source node distnace


		for (int count = 0; count < 8; count++) 
		begin
		int u,temp; 
		u = minDistance(distance, sptSet);
		sptSet[u] = 1;

		for (int v = 0; v < 9; v++)
		begin
			$display("sptSet[%0d]=%0d,graph[%0d][%0d]=%0d,diatance[%0d]=%0d ", v,sptSet[v],u,v,graph[u][v], u,distance[u]);

			temp = sptSet[v] != 1 && graph[u][v] && distance[u] != 1024 && ((distance[u] + graph[u][v]) < distance[v]);
			if (temp)
              			begin
                    			parent[v] = u;
                   			distance[v] = distance[u] + graph[u][v];
                		end

		end

		end
		end


	print p(distance, parent, src, dest);

endmodule


module print(input int distance[9], parent[9], src, dest);

	initial begin

	$monitor("SOURCE:%d  -->  Destination:%d     Distance: %d", src, dest, distance[dest]);

	end

endmodule
