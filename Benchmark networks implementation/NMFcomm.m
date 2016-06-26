num_nodes=1650;  
exp_num_comm=160;

%range of mu values of the LFRs to loop over
muwLow=0.1;
muwHigh=0.5;

mutLow=0.1;
mutHigh=0.5;

%range of intermediate networks to loop over
start_cl_bench_net=2;
end_cl_bench_net=100;

for i=muwLow:0.1:muwHigh
    
    muw=i;
    
    for j=mutLow:0.1:mutHigh
        
        mut=j;
        
        %create result directory for each LFR's results
        res_path=sprintf('NMF_Results/BayesNMF_Results_for_LFR muw %.1f mut %.1f',muw, mut);
        mkdir(res_path);
        
        %loop over range of intermediate networks
        for k=start_cl_bench_net:end_cl_bench_net    
                      
                %load the edgelists for the specific LFR's intermediate
                %network
                perc=k-1;
                path=sprintf('Individual File Benchmarks/LFR muw %.1f mut %.1f/%d%s',muw,mut,perc,'%_closed_bench.txt');
                elist=load(path);
                
                %create adjacency matrix for the intermediate network from
                %the edgelist
                adj=zeros(num_nodes);
                
                for (n = 1:length(elist))
                     
                    row=elist(n,1);
                    column=elist(n,2);
                    weight=elist(n,3);

                    adj(row,column)=weight;
                    
                end
                
                %apply method which returns community membership list g 
                clear P g commList;
                
                [P,g] = commDetNMF(adj,exp_num_com);  
                
                %reformat to two-column community membership list
                commList=MembList(g);
                
                %save community membership list to text file for each
                %intermediate network's result in its specific LFR's result
                %folder
                res_name=sprintf('%d%s',perc,'%_closed_bench.txt');
                result=sprintf('%s/%s',res_path,res_name);
                
                save_path=result;
                dlmwrite(save_path,commList,' ');
     
        end
     end
 end

    

  

