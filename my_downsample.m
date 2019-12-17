function [outMatrix, inMatrix] = my_downsample(inMatrix, rate)

inSize = size(inMatrix);
dim = nb_dims(inMatrix);

if (dim==1)
    if inSize(1)==1
        inMatrix = inMatrix';
        inSize = size(inMatrix);
    end
    lengthOut = ceil(max(inSize)/rate);
    diffSize = rate*lengthOut - inSize(1);
    outMatrix = zeros(lengthOut,1);
    inMatrix = [inMatrix;inMatrix(end)*ones(diffSize,1)];
    outSize = size(outMatrix);
    for i = 1:rate
        outMatrix = outMatrix+inMatrix(i:rate:end);
    end
    outMatrix = outMatrix/rate;
elseif (dim==2)
    if inSize(1)==1 || inSize(2)==1
        error('Logical Error');
    end
    lengthOut = [inSize(1),ceil(inSize(2)/rate)];
    diffSize = [lengthOut(1),rate*lengthOut(2)] - inSize;
    outMatrix = zeros(lengthOut);
    if diffSize(1)~=0
        inMatrix = [inMatrix; repmat(inMatrix(end,:),[diffSize(1),1] )];
    end
    if diffSize(2)~=0
        inMatrix = [inMatrix repmat(inMatrix(:,end), [1, diffSize(2)] )];
    end
    for j = 1:rate
        outMatrix = outMatrix + inMatrix(:,j:rate:end);
    end
    outMatrix = outMatrix/(rate);
elseif (dim==3)
    if inSize(1)==1 || inSize(2)==1 || inSize(3)==1
        error('Logical Error');
    end
    lengthOut = [inSize(1),inSize(2),round(inSize(3)/rate)];
    diffSize = uint16([lengthOut(1),lengthOut(2),rate*lengthOut(3)] - inSize);
    outMatrix = zeros(lengthOut);
    if diffSize(1)~=0
        inMatrix = [inMatrix; repmat(inMatrix(end,:,:),[diffSize(1),1] )];
    end
    if diffSize(2)~=0
        inMatrix = [inMatrix repmat(inMatrix(:,end,:), [1, diffSize(2)] )];
    end
    if diffSize(3)~=0
        inMatrix(:,:,end+1:end+diffSize(3)) = repmat(inMatrix(:,:,end), [1,1,diffSize(3)]);
    end
    for k = 1:rate
        outMatrix = outMatrix + inMatrix(:,:,k:uint16(round(rate)):end);
    end
    outMatrix = outMatrix/(rate);
else
    error('TODO');
end
