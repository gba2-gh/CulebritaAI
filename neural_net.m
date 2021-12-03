function out=neural_net(nn_input, w1, w2, w3);   
        
     a1=poslin(w1*nn_input(:,1) );
     a2=poslin(w2*a1(:,1) );
     out=sigmoid(w3*a2(:,1));
     
%     R=size(nn_input,1);
%     S=4;
%     neuron_hl_1=20;
%     neuron_hl_2=12;
%     maxW=100;
%     maxB=50;
%     
%     for i=1:neuron_hl_1
%         for j=1:R
%             w1(i,j)=random(-maxW,maxW,1);
%         end
%         b1(i,1)=random(-maxB,maxB,1);
%     end
%     
%     for i=1:neuron_hl_2
%         for j=1:neuron_hl_1
%             w2(i,j)=random(-maxW,maxW,1);
%         end
%     b2(i,1)=random(-maxB,maxB,1);
%     end
% 
%     %Peso tercera capa
%     for i=1:S
%         for j=1:neuron_hl_2
%             w3(i,j)=random(-maxW,maxW,1);
%         end
%         b3(i,1)=random(-maxB,maxB,1);
%     end

        
end
        