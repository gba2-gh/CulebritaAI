
close all
clear all
clc
delay=0.005;
gridSize=11;
plane = snakeGrid(gridSize);

target=round(random(2,11,2));

kill=false;
a_start=round(gridSize/2) +1;
%snake=[a_start,a_start; a_start, a_start-1]
snakeLen=1;
%target=[a_start, a_start+2];

%plane(target(1), target(2))=3;
%plane(snake(1), snake(1))=2;  %%2 cabeza

it=0;
j=0;
%dirHead_n=2^j   
dirHead=[0; 0 ;0 ;0];

%%GENERAR POBLACION CON PESOS
R=20;
S=4;
neuron_hl_1=20;
neuron_hl_2=12;
totalSnakes=500;

for i=1:totalSnakes
    snake=[a_start,a_start; a_start, a_start-1];
    
    snakes(:,:,i)=snake;
    
    snakes_w1(:,:,i)=nn_random_weights(neuron_hl_1, R);
    snakes_w2(:,:,i)=nn_random_weights(neuron_hl_2, neuron_hl_1);
    snakes_w3(:,:,i)=nn_random_weights(S, neuron_hl_2);
end


for ep=1:100

for i=1:totalSnakes
    step=0;
    target=round(random(2,11,2));
    snake=[a_start,a_start; a_start, a_start-1];
    
    plane(target(1), target(2))=3;
    
        while(1)
        %snake=snakes(:,:,i);
        step=step+1;
        %%Mostrar snake
        for k=2:size(snake,1)
            plane(snake(k,1),snake(k,2))=1;       
        end
        plane(snake(1,1),snake(1,2))=2;
        
        
        
        
        imagesc(plane); caxis([0 3]);
        colormap default; 
        %axis off; axis equal; drawnow
        %title(sprintf(['snake explorador']))
         %text(3,0.9,sprintf(['snakee actual=',num2str(k), ', Iteracion=',num2str(d),', Ambiente=',num2str(v),'\n            Score=',...
        % num2str(punt(k)), ' Sig accion=',num2str(accion)]),'FontSize',13)
        text(3,0.9,sprintf(['snake actual=',num2str(i), ', ep=',num2str(ep)]))
        pause(delay)

        %NN
        nn_input=gen_nn_input(snake, plane, dirHead);

        out= neural_net(nn_input, snakes_w1(:,:,1), snakes_w2(:,:,1), snakes_w3(:,:,1));

        output=out;
        if find(out==1) > 0
            aux=find(out==1);
            aux2=aux(round(random(0.5,size(aux,1)+0.49,1)));
            output=zeros(4,1);
            output(aux2)=1;
        end

        zzz=find(output==1);
        if size(zzz,1) == 0
            %pause(2)
            fprintf('entrada 0 kill')
            break
        end

        dirHead=output;
        dirHead_n= dec2bin(output)';

%         x=input('input')
%         
%         if x==6
%             dirHead_n='0001'
%         elseif x==4
%             dirHead_n='0010'
%         elseif x==5
%             dirHead_n='0100'
%         elseif x==8
%             dirHead_n='1000'
%         end
        
        
        [snake, plane, kill]= move_snake(dirHead_n, snake, plane);


        %%borrar snakee anteriro
%         for k=2:size(snake,1)
%             plane(snake(k,1),snake(k,2))=0;
% 
%         end
%         plane(snake(1,1),snake(1,2))=0;
        plane(find(plane==1))=0;
        plane(find(plane==2))=0;

        %snake=snake_n;
        if kill
            %fprintf('Game over\n');
            break
        end

        end
    score(i)= size(snake,1);
    steps(i)= step;
    
    plane(find(plane==3))=0;
    plane(find(plane==1))=0;
    plane(find(plane==2))=0;
    snake=[];
end

%%Fitness
for i=1:totalSnakes
    fitness(i)=steps(i) + (2^(score(i)) + ((score(i))^(2.1))*500 )- (((score(i))^(2.1))*(((0.25)*steps(i))^(1.3)));
end



fitness2=fitness/1000;
fitness_sum = movsum(fitness2,[totalSnakes 0]);
%fiteness_sum=[0 fitness_sum];
%%%Ruleta. Elegir elementos
for k=1:size(fitness,2)
    p = random(fitness_sum(1),fitness_sum(end),1);
    %%Seleccionar el intervalo del número aleatorio
    temp=[0 fitness_sum];
    i=1;
    j=size(temp, 2);
    m= ceil(j/2);
    while size(temp,2) >2
        if p > temp(1,m)
            i=m;
            j=size(temp, 2);
        else 
            i=1;
            j=m;
        end
        temp = temp(1,[i:j]);
        j=size(temp, 2);
        m=ceil(j/2);
    end
    %%%Indice del elemento seleccionado
    id= find(fitness_sum==temp(1,2));
    idx(k)=id(1);
    %acciones_new(k,:)= acciones(idx(k),:)  ;
    
end

snakes_w1=ga_crossing(snakes_w1);
snakes_w2=ga_crossing(snakes_w2);
snakes_w3=ga_crossing(snakes_w3);


score_max(ep)=max(score)
ep
end

figure
plot(score_max)
grid on
