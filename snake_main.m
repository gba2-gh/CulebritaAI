%%%IA PROYECTO FINAL
%%$Gibran Z.


close all
clear all
clc
delay=0.02;
gridSize=11;
plane = snakeGrid(gridSize);

kill=false;
a_start=round(gridSize/2) +1;
snakeLen=1;

it=0;
j=0;
%dirHead_n=2^j   
dirHead=[0; 0 ;0 ;0];

%%GENERAR POBLACION CON PESOS
R=32;
S=4;
neuron_hl_1=20;
neuron_hl_2=12;
totalSnakes=500;

% %Iniciar pesos
% for i=1:totalSnakes
%     snakes_w1(:,:,i)=nn_random_weights(neuron_hl_1, R);
%     snakes_w2(:,:,i)=nn_random_weights(neuron_hl_2, neuron_hl_1);
%     snakes_w3(:,:,i)=nn_random_weights(S, neuron_hl_2);
% end

file1 = matfile('snakes_w1.mat');
snakes_w1=file1.snakes_w1;
file2 = matfile('snakes_w2.mat');
snakes_w2=file2.snakes_w2;
file3 = matfile('snakes_w3.mat');
snakes_w3=file3.snakes_w3;


for ep=1:700

for i=1:totalSnakes
    ate=false;
    step=0;
    steps_to_die=0;
    %primer target
    target=round(random(2,11,2));
    plane(target(1), target(2))=3;
    
    snake=[a_start,a_start; a_start,a_start-1;a_start,a_start-2];
    
        while(1)
        step=step+1;
        steps_to_die=steps_to_die+1;
        
        %%Mostrar snake
        for k=2:size(snake,1)
            plane(snake(k,1),snake(k,2))=1;       
        end
        plane(snake(1,1),snake(1,2))=2;
        
        
        imagesc(plane); caxis([0 3]);
        colormap summer; 
        axis off; axis equal; drawnow
        title(sprintf(['snake explorador']))
         %text(3,0.9,sprintf(['snakee actual=',num2str(k), ', Iteracion=',num2str(d),', Ambiente=',num2str(v),'\n            Score=',...
        % num2str(punt(k)), ' Sig accion=',num2str(accion)]),'FontSize',13)
        text(3,0.9,sprintf(['snake actual=',num2str(i), ', ep=',num2str(ep)]))
        pause(delay)

        %NN
        nn_input=gen_nn_input(snake, plane, dirHead);

        out= neural_net(nn_input, snakes_w1(:,:,i), snakes_w2(:,:,i), snakes_w3(:,:,i));

        output=compet(out);

        index=output==0;
        aux=sum(index(:));
        if aux == 4
            %pause(2)
            fprintf('entrada 0 kill\n')
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
        
        
        [snake, plane, kill, ate]= move_snake(dirHead_n, snake, plane);


        %%borrar snakee anteriro
%         for k=2:size(snake,1)
%             plane(snake(k,1),snake(k,2))=0;
% 
%         end
%         plane(snake(1,1),snake(1,2))=0;
        plane(find(plane==1))=0;
        plane(find(plane==2))=0;

        %snake=snake_n;
        
        if ate
            steps_to_die=0;
            ate=false;
        end
        
        if steps_to_die>=100
            fprintf('supero pasos\n')
            break
        end
        
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
for k=1:size(fitness,2)-50
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
    snakes_w1_new(:,:,k)= snakes_w1(:,:,idx(k))  ;
    snakes_w2_new(:,:,k)= snakes_w2(:,:,idx(k))  ;
    snakes_w3_new(:,:,k)= snakes_w3(:,:,idx(k))  ;
end

id=find(fitness==max(fitness))
for z=1:50
    rr=round(random(1,size(id,2),1));
    snakes_w1_new(:,:,490+z)= snakes_w1(:,:,id(rr));
    snakes_w2_new(:,:,490+z)= snakes_w2(:,:,id(rr));
    snakes_w3_new(:,:,490+z)= snakes_w3(:,:,id(rr));
end

snakes_w1=snakes_w1_new;
snakes_w2=snakes_w2_new;
snakes_w3=snakes_w3_new;

snakes_w1=ga_crossing(snakes_w1);
snakes_w2=ga_crossing(snakes_w2);
snakes_w3=ga_crossing(snakes_w3);


score_max(ep)=max(score)
fitness_max(ep)=max(fitness)

ep

end

figure
plot(score_max)
grid on

figure
plot(fitness_max)
grid on

