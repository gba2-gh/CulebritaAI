function out=ga_crossing(snakes_w);

%%RESHAPE

w1_flat=reshape(snakes_w,[ 1,size(snakes_w,1)* size(snakes_w,2), size(snakes_w,3)]);

k=1;
temp=w1_flat;
while size(temp,3) > 0
    %Seleccionar padres al azar
    padre_idx=round(1 + (size(temp,3)-1).*rand());
    padre1= temp(:,:,padre_idx);
    temp(:,:,padre_idx) = [];
    
    padre_idx=round(1 + (size(temp,3)-1).*rand());
    padre2= temp(:,:,padre_idx);    
    temp(:,:,padre_idx) = [];
    
    
    cross_point= round(random(1,size(padre1,2),1));%x
    
    hijo1 = padre1(1,[1:cross_point-1]) ;
    hijo1 = cat(2, hijo1, padre2(1,[cross_point:end]));    
    hijo2 = padre2(1,[1:cross_point-1]) ;
    hijo2 = cat(2, hijo2, padre1(1,[cross_point:end]));
    
    %     %%%Mutacion
    per_mut=0.05;
    for p=1:size(hijo1,2)
        prob=random(0,1,1);
        if prob<=per_mut
            r = normrnd(0,1,1,1);
            r=r*0.2;
            hijo1(p)=r;
        end
    end
    for p=1:size(hijo2,2)
        prob=random(0,1,1);
        if prob<=per_mut
            r = normrnd(0,1,1,1);
            r=r*0.2;
            hijo2(p)=r;
        end
    end
    hijos(:,:,k) = hijo1;
    hijos(:,:,k+1) =hijo2;
    k=k+2;
end

out=reshape(hijos,[size(snakes_w,1), size(snakes_w,2), size(snakes_w,3)]);
%B=reshape(A,[ 1,size(A,1)* size(A,2)])

end