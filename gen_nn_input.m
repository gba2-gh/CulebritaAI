function nn_input=gen_nn_input(snake,plane,dirHead);
    %%Direccion cola
    
    if size(snake,1) >=2
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
    else
        dirTail=[0 0 0 0]';
    end
    
    %%VISION CULEBRA
    snakeNorth=plane(2:snake(1,1)-1, snake(1,2))';
    snakeSouth=plane(snake(1,1)+1:end-1, snake(1,2))';
    snakeWest=plane(snake(1,1),2:snake(1,2)-1);
    snakeEast=plane(snake(1,1),snake(1,2)+1:end-1);
    
       %%vision esquinas
    snakeNE=[];
    dirx=snake(1,2);
    diry=snake(1,1);
    for k=dirx:size(plane,2)-2
        dirx=dirx+1;
        diry=diry-1;
        if diry == 13 || diry==1
            break
        end
        if dirx==13 || dirx==1
            break
        end
        snakeNE=[snakeNE , plane(diry,dirx)];
    
    end
    
    snakeNW=[];
    dirx=snake(1,2);
    diry=snake(1,1);
    for k=dirx:-1:3
        dirx=dirx-1;
        diry=diry-1;
        if diry == 13 || diry==1
            break
        end
        if dirx==13 || dirx==1
            break
        end
        snakeNW=[snakeNW , plane(diry,dirx)];
    
    end
    
    snakeSE=[];
    dirx=snake(1,2);
    diry=snake(1,1);
    for k=dirx:size(plane,2)-2
        dirx=dirx+1;
        diry=diry+1;
        if diry == 13 || diry==1
            break
        end
        if dirx==13 || dirx==1
            break
        end
        snakeSE=[snakeSE , plane(diry,dirx)];
    
    end
    
    snakeSW=[];
    dirx=snake(1,2);
    diry=snake(1,1);
    for k=dirx:-1:3
        dirx=dirx-1;
        diry=diry+1;
        if diry == 13 || diry==1
            break
        end
        if dirx==13 || dirx==1
            break 
        end
        snakeSW=[snakeSW , plane(diry,dirx)];
    end
    
    
    
    %%DISTANCIA A MURO
    distMuroN=size(snakeNorth,2);
    distMuroS=size(snakeSouth,2);
    distMuroW=size(snakeWest,2);
    distMuroE=size(snakeEast,2);
    
    distMuroNE=size(snakeNE,2);
    distMuroNW=size(snakeNW,2);
    distMuroSE=size(snakeSE,2);
    distMuroSW=size(snakeSW,2);
    
    
    %%DISTA A TARGET
    distTargetN=0;
    distTargetS=0;
    distTargetW=0;
    distTargetE=0;
    
    distTargetNE=0;
    distTargetNW=0;
    distTargetSE=0;
    distTargetSW=0;
    
    if find(snakeNorth==3)     
        distTargetN=1;
        %distTargetN=size(snakeNorth,2)- find(snakeNorth==3)+1;
    end  
    if find(snakeSouth==3)    
       distTargetS=1;
       %distTargetS= find(snakeSouth==3) ;  
    end  
    if find(snakeWest==3)    
        distTargetW=1;
        %distTargetW= size(snakeWest,2) - find(snakeWest==3) +1;
    end
    if find(snakeEast==3)     
        distTargetE=1;
        %distTargetE= find(snakeEast==3) ;
    end

    
    if find(snakeNE==3)     
        distTargetNE=1;
        %distTargetN=size(snakeNorth,2)- find(snakeNorth==3)+1;
    end  
    if find(snakeSE==3)    
       distTargetSE=1;
       %distTargetS= find(snakeSouth==3) ;  
    end  
    if find(snakeNW==3)    
        distTargetNW=1;
        %distTargetW= size(snakeWest,2) - find(snakeWest==3) +1;
    end
    if find(snakeSW==3)     
        distTargetSW=1;
        %distTargetE= find(snakeEast==3) ;
    end
    
    
    distBodyN=0;
    distBodyS=0; 
    distBodyW=0; 
    distBodyE=0;     
    
    
    distBodyNE=0;
    distBodyNW=0; 
    distBodySW=0; 
    distBodySE=0; 
    
    %%%DIST CUERPO
    if find(snakeNorth==1)     
%         body=find(snakeNorth==1);
%         distBodyN=size(snakeWest,2)- body(end)+1;
        distBodyN=1;
    end  
    if find(snakeSouth==1) 
%        body=find(snakeSouth==1);
%        distBodyS= body(end) ;  
        distBodyS=1;
    end  
    if find(snakeWest==1)>0
%         body=find(snakeWest==1);
%         distBodyW= size(snakeWest,2) -body(end)  +1;
        distBodyW=1;
    end
    if find(snakeEast==1)>0
%         body=find(snakeEast==1);
%         distBodyE= body(end);  
        distBodyE=1;
    end
    
    
    
    
    if find(snakeNE==1)     
%         body=find(snakeNorth==1);
%         distBodyN=size(snakeWest,2)- body(end)+1;
        distBodyNE=1;
    end  
    if find(snakeNW==1) 
%        body=find(snakeSouth==1);
%        distBodyS= body(end) ;  
        distBodyNW=1;
    end  
    if find(snakeSE==1)>0
%         body=find(snakeWest==1);
%         distBodyW= size(snakeWest,2) -body(end)  +1;
        distBodySE=1;
    end
    if find(snakeSW==1)>0
%         body=find(snakeEast==1);
%         distBodyE= body(end);  
        distBodySW=1;
    end
    
    
    
    
    
    
   
    distMuro= [distMuroN; distMuroNW; distMuroW ; distMuroSW; distMuroS;distMuroSE ;distMuroE; distMuroNE];
    distTarget=[distTargetN; distTargetNW; distTargetW ; distTargetSW; distTargetS;distTargetSE ;distTargetE; distTargetNE];
    distBody=[distBodyN; distBodyNW; distBodyW ; distBodySW; distBodyS;distBodySE ;distBodyE; distBodyNE];
    
    nn_input=[distMuro;distTarget;distBody;dirHead;dirTail];
    
end