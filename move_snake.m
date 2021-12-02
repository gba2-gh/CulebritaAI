function [snake, plane, kill]=move_snake(code, snake, plane);

%code= bin2dec(code);

head_y=snake(1,1);
head_x=snake(1,2);
snakeLen=size(snake,1);
kill=false;
nTar=false;

%AVANZAR CABEZA

if code==1 %%MOVIMIENTO DERECHA   
    head_x=head_x+1;
elseif code==4 %%MOVIMIENTO IZQUIERDA
    head_x=head_x-1;
elseif code==2 %%MOVIMIENTO ABAJO
    head_y=head_y+1;
elseif code==8 %% MOVIMIENTO ARRIBA
    head_y=head_y-1;
end
  
%DESTRUIR SI ENCUENTRA PARED
if head_x==24 || head_y==24 
    kill=true;
    return
end

%DESTRUIR SI ENCUENTRA EL CUERPO
if plane(head_y,head_x)==1 
    kill=true;
    return
end

cola=snake(end,:);
vis_head=plane(head_y,head_x);


%%Antes de avanzar borrar posicion actual de la cola
%plane(snake(end,1),snake(end,2))=0; 
%avanzar cola
for k=size(snake,1):-1:2
    snake(k,:) = snake(k-1,:)   ;
    plane(snake(k,1),snake(k,2))=1;
    %plane(snake(end,1),snake(end,2))=1;     
end 
%%ACTUALIZAR CABEZA
snake(1,:)=[head_y,head_x];
plane(snake(1,1),snake(1,2))=2;     
 

%%Encuentra marca
if vis_head==3
    snakeLen=snakeLen + 1;
    snake(snakeLen,:)=cola;
    
%     %%NUEVA MARCA
    [row,col] = find(plane==1 | plane==2);%%posicion que contiene a la serpiente
    new_target=round(random(2,size(plane)-1,2));
    while (ismember(new_target(1),row,'rows') && ismember(new_target(2),col,'rows'))
        new_target=round(random(2,gridSize+1,2));
    end
     %new_target=[10,6]
     plane(new_target(1), new_target(2))=3;
%     
 end

%%Direccion cola
dify=snake(end-1,1)-snake(end,1);
difx=snake(end-1,2)-snake(end,2);

if dify>0
    dirCola='0100'
elseif dify<0
    dirCola='1000'
elseif difx>0
    dirCola='0001'
elseif difx<0
    dirCola='0010'
else
    dirCola='0000'
end




%%%AVANZAR





end








% 
% %%NUEVA MARCA
% if nTar
%     [row,col] = find(plane==1 | plane==2);%%posicion que contiene a la serpiente
%     new_target=round(random(2,size(plane)-1,2));
%     while (ismember(new_target(1),row,'rows') && ismember(new_target(2),col,'rows'))
%         new_target=round(random(2,gridSize+1,2));
%     end
%     plane(new_target(1), new_target(2))=3;
% end

