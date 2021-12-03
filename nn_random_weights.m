function w= nn_random_weights(numOutputs, numInputs);
    maxW=1;
    %maxB=50;
    
    for i=1:numOutputs
        for j=1:numInputs
            w(i,j)=random(-maxW,maxW,1);
        end
       % b1(i,1)=random(-maxB,maxB,1);
    end
    
end