function [commMemb] = MembList(g)
%vectors to store the nodes and the community they are a member of
node=[];
memb=[];
    
%loop through all cells in list g
    for i=1:length(g)
        
        %extract all nodes listed in each cell, which represents a community, add to node list 
        node=[node,g{i}];
        
        %create an equivalent length vector as number of nodes in the cell filled with nodes 
        comm=zeros(1,length(g{i}));
       
        %cell's index indicates the community the nodes are a member of
        comm(:)=i;
        
        %add this vector to the membership vector to indicate the community
        %the corresponding node is a part of in the node vector
        memb=[memb,comm];

    end
%combine the two vectors into a reformatted community membership list
commMemb=[node;memb]';
end