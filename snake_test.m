
close all
clear all
clc
delay=1
gridSize=11;
plane = snakeGrid(gridSize);

%target=round(random(2,11,2));

kill=false;
a_start=round(gridSize/2) +1;
agent=[a_start,a_start; a_start, a_start-1;a_start, a_start-2];
agentLen=1;
target=[a_start, a_start+2];

plane(target(1), target(2))=3;
plane(agent(1), agent(1))=2;  %%2 cabeza


it=0;
j=0;

while(1)
    
    plane(agent(1,1),agent(1,2))=2;
    for k=2:size(agent,1)
        plane(agent(k,1),agent(k,2))=1;
        
    end
    
    it=it+1;
    imagesc(plane); caxis([0 3]);
    colormap default; 
    axis off; axis equal; drawnow
    title(sprintf(['Agente explorador']))
    % text(3,0.9,sprintf(['Agente actual=',num2str(k), ', Iteracion=',num2str(d),', Ambiente=',num2str(v),'\n            Score=',...
    % num2str(punt(k)), ' Sig accion=',num2str(accion)]),'FontSize',13)
    pause(delay)
     
    if it>=5
        j=j+1;
        if j >3
            j=0;
        end
        it=0;
    end
    
    head_dir=2^j;
    
    
    plane(agent(1,1),agent(1,2))=0;
    for k=2:size(agent,1)
        plane(agent(k,1),agent(k,2))=0;
        
    end
    
    [agent, plane, kill]= move_snake(head_dir, agent, plane);
    
    
    
    
    
    if kill
        fprintf('Game over\n')
        break
    end
end

