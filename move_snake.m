function [snake, plane, kill, ate]=move_snake(code, snake, plane);

code= bin2dec(code);
ate=false;
head_y=snake(1,1);
head_x=snake(1,2);
snakeLen=size(snake,1);
kill=false;
nTar=false;

%AVANZAR CABEZA

if code==1 %%MOVIMIENTO DERECHA   
    head_x=head_x+1;
elseif code==2 %%MOVIMIENTO IZQUIERDA
    head_x=head_x-1;
elseif code==4 %%MOVIMIENTO ABAJO
    head_y=head_y+1;
elseif code==8 %% MOVIMIENTO ARRIBA
    head_y=head_y-1;
end
  
%DESTRUIR SI ENCUENTRA PARED
if plane(head_y, head_x)==4
    fprintf('encontro pared\n')
    kill=true;
    return
end

%DESTRUIR SI ENCUENTRA EL CUERPO
if plane(head_y,head_x)==1 
    fprintf('encontro cuerpo\n')
    kill=true;
    return
end

cola=snake(end,:);
vis_head=plane(head_y,head_x);


%%Antes de avanzar borrar posicion actual de la cola
%avanzar cola
for k=size(snake,1):-1:2
    snake(k,:) = snake(k-1,:)   ; 
end 
%%ACTUALIZAR CABEZA
snake(1,:)=[head_y,head_x];
 
 

%%Encuentra marca
if vis_head==3
    snakeLen=snakeLen + 1;
    snake(snakeLen,:)=cola;
    
%     %%NUEVA MARCA
    [row,col] = find(plane==1 | plane==2);%%posicion que contiene a la serpiente
    new_target=round(random(2,size(plane)-1,2));
    while (ismember(new_target(1),row,'rows') && ismember(new_target(2),col,'rows'))
        new_target=round(random(2,size(plane,1)-2,2));
    end
     %new_target=[10,6]
     plane(new_target(1), new_target(2))=3;
     ate=true;
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


