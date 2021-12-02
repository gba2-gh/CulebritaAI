
close all
clear all
clc
delay=1;
gridSize=11;
plane = snakeGrid(gridSize);

%target=round(random(2,11,2));

kill=false;
a_start=round(gridSize/2) +1;
snake=[a_start,a_start; a_start, a_start-1;a_start, a_start-2];
snakeLen=1;
target=[a_start, a_start+2];

plane(target(1), target(2))=3;
plane(snake(1), snake(1))=2;  %%2 cabeza


it=0;
j=0;

while(1)
    for k=2:size(snake,1)
        plane(snake(k,1),snake(k,2))=1;       
    end
    plane(snake(1,1),snake(1,2))=2;
    
    
    it=it+1;
    imagesc(plane); caxis([0 3]);
    colormap default; 
    axis off; axis equal; drawnow
    title(sprintf(['snakee explorador']))
    % text(3,0.9,sprintf(['snakee actual=',num2str(k), ', Iteracion=',num2str(d),', Ambiente=',num2str(v),'\n            Score=',...
    % num2str(punt(k)), ' Sig accion=',num2str(accion)]),'FontSize',13)
    pause(delay)
     
    if it>=5
        j=j+1;
        if j >3
            j=0;
        end
        it=0;
    end
    
    dirHeadDec=2^j   
    
    %%Direccion cola
    dify=snake(end-1,1)-snake(end,1);
    difx=snake(end-1,2)-snake(end,2);
    
    dirHead= dec2bin(dirHeadDec)=='1';
    acom= 4- size(dirHead,2)
    acom2=zeros(1,acom)
    dirHead=[acom2 dirHead]'
    
    if dify>0
        dirTail=[0 1 0 0]'
    elseif dify<0
        dirTail=[1 0 0 0]'
    elseif difx>0
        dirTail=[0 0 0 1]'
    elseif difx<0
        dirTail=[0 0 1 0]'
    else
        dirTail=[0 0 0 0]'
    end
   
    %%VISION CULEBRA
    snakeNorth=plane(2:snake(1,1)-1, snake(1,2))';
    snakeSouth=plane(snake(1,1)+1:end-1, snake(1,2))';
    snakeWest=plane(snake(1,1),2:snake(1,2)-1);
    snakeEast=plane(snake(1,1),snake(1,2)+1:end-1);
    
    %%DISTANCIA A MURO
    distMuroN=size(snakeNorth,2);
    distMuroS=size(snakeSouth,2);
    distMuroW=size(snakeWest,2);
    distMuroE=size(snakeEast,2);
    
    %%DISA A TARGET
    distTargetN=0;
    distTargetS=0;
    distTargetW=0;
    distTargetE=0;
    
    if find(snakeNorth==3)     
        distTargetN=size(snakeWest,2)- find(snakeEast==3)+1;
    end  
    if find(snakeSouth==3)     
       distTargetS= find(snakeSouth==3) ;  
    end  
    if find(snakeWest==3)     
        distTargetW= size(snakeWest,2) - find(snakeEast==3) +1;
    end
    if find(snakeEast==3)     
        distTargetE= find(snakeEast==3) ;
    end
    
    distBodyN=0;
    distBodyS=0; 
    distBodyW=0; 
    distBodyE=0;     
    
    %%%DIST CUERPO
    if find(snakeNorth==1)     
        body=find(snakeNorth==1);
        distBodyN=size(snakeWest,2)- body(end)+1;
    end  
    if find(snakeSouth==1) 
       body=find(snakeSouth==1);
       distBodyS= body(end) ;  
    end  
    if find(snakeWest==1)>0
        body=find(snakeWest==1);
        distBodyW= size(snakeWest,2) -body(end)  +1;
    end
    if find(snakeEast==1)>0
        body=find(snakeEast==1);
        distBodyE= body(end);   
    end
   
    distMuro= [distMuroN;distMuroS;distMuroW;distMuroE]
    distTarget=[distTargetN;distTargetS;distTargetW;distTargetE]
    distBody=[distBodyN;distBodyS;distBodyW;distBodyE]
    
    nn_input=[distMuro;distTarget;distBody;dirHead;dirTail]
    

        
    
    
    
    
    
    
    
    [snake_n, plane, kill]= move_snake(dirHeadDec, snake, plane);
    
    
     if kill
        fprintf('Game over\n')
        break
    end
    
    
    %%borrar snakee anteriro
    plane(snake(1,1),snake(1,2))=0;
    for k=2:size(snake,1)
        plane(snake(k,1),snake(k,2))=0;
        
    end
    
    snake=snake_n;
end

