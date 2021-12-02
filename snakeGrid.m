function plane = snakeGrid(gridSize);

%0. Vacía
%1. Cuerpo
%2. cabeza
%3. target
%5. pared

%%Ambiente
plane = zeros(gridSize + 2);
plane(1,:)=4;
plane(end,:)=4;
plane(:,1)=4;
plane(:,end)=4;

%marcas
%total_marcas=50;
% a=2;
% b=11;
% marcas(1,:)= round(a + (b-a).*rand(1,1));%x
% marcas(2,:)= round(a + (b-a).*rand(1,1));%y
% 
% for i=1:total_marcas
%     x=marcas(1,i);
%     y=marcas(2,i);
%     %Duplicados
%     while plane(y,x) == 1
%         marcas(1,i)= round(a + (b-a).*rand());%x
%         marcas(2,i)= round(a + (b-a).*rand());%y
%         x=marcas(1,i);
%         y=marcas(2,i);
%     end
%     plane(y,x)=1;
% end

end