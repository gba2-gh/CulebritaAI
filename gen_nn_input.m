function nn_input=gen_nn_input(snake,plane,dirHead);
    %%Direccion cola
    dify=snake(end-1,1)-snake(end,1);
    difx=snake(end-1,2)-snake(end,2);
    if dify>0
        dirTail=[0 1 0 0]';
    elseif dify<0
        dirTail=[1 0 0 0]';
    elseif difx>0
        dirTail=[0 0 0 1]';
    elseif difx<0
        dirTail=[0 0 1 0]';
    else
        dirTail=[0 0 0 0]';
    end
   
    %%VISION CULEBRA
    snakeNorth=plane(2:snake(1,1)-1, snake(1,2))';
    snakeSouth=plane(snake(1,1)+1:end-1, snake(1,2))';
    snakeWest=plane(snake(1,1),2:snake(1,2)-1);
    snakeEast=plane(snake(1,1),snake(1,2)+1:end-1);
    
    dirx=snake(1,1);
    diry=snake(1,2);
    for k=dirx:size(snakeEast,2)
    snakeNE=1
    plane( snake(1,2)-1,snake(1,1)+1)
    
    
    
    
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
        distTargetN=size(snakeNorth,2)- find(snakeNorth==3)+1;
    end  
    if find(snakeSouth==3)     
       distTargetS= find(snakeSouth==3) ;  
    end  
    if find(snakeWest==3)     
        distTargetW= size(snakeWest,2) - find(snakeWest==3) +1;
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
   
    distMuro= [distMuroN;distMuroS;distMuroW;distMuroE];
    distTarget=[distTargetN;distTargetS;distTargetW;distTargetE];
    distBody=[distBodyN;distBodyS;distBodyW;distBodyE];
    
    nn_input=[distMuro;distTarget;distBody;dirHead;dirTail];
end