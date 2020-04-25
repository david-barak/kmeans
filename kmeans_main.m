%% Initialization Section (run before any other section)
clear
I = imread('house.tiff');
X = reshape(I, 256*256, 3);
X = double(X);
m = length(X);

%% Part A K-Means w/ 2 Clusters
k = 2;
[labeledX1, J1, c1] = kmeans(X, k);
labeledI1 = reshape(labeledX1,256, 256, 3);

figure(1) 
imshow(uint8(labeledI1))
title(['Reconstructed Image using ', num2str(k), ' Cluster Centroids'])

figure(2)
plot(J1)
title(['Error Criterion using ', num2str(k), ' Cluster Centroids'])

figure(3)
plot3(X(c1(:) == 1, 1), X(c1(:) == 1, 2), X(c1(:) == 1, 3), '.', 'Color', [0 0 1])
hold on
plot3(X(c1(:) == 2, 1), X(c1(:) == 2, 2), X(c1(:) == 2, 3), '.', 'Color', [1 0 0])
hold off;
title('RGB Space Plot');

%% Part A K-Means w/ 5 Clusters
k = 5;
RGB = [0 0 1;
       1 0 0;
       0 1 0;
       0 1 1;
       0 0 0];

[labeledX1, J1, c1, uInit1, uFinal1] = kmeans(X, k);
labeledI1 = reshape(labeledX1,256, 256, 3);

[labeledX2, J2, c2, uInit2, uFinal2] = kmeans(X, k);
labeledI2 = reshape(labeledX2,256, 256, 3);

XB1 = zeros(m, 1);
XB2 = zeros(m, 1);

% Calculating XB Index
for i = 1:m
    num1 = 0;
    denom1 = 0;
    num2 = 0;
    denom2 = 0;
    
   for j = 1:k
      if (c1(i) == j)
          num1 = sum(abs(X(i,:)-uFinal1(j,:)));
          denom1 = sum(abs(uFinal1(1, :) - uFinal1), 2);
          denom1 = min(denom1(denom1>0));
      end
      
      if (c2(i) == j)
          num2 = sum(abs(X(i,:)-uFinal2(j,:)));
          denom2 = sum(abs(uFinal2(1, :) - uFinal2), 2);
          denom2 = min(denom2(denom2>0));
      end
   end
   
   XB1(i) = num1/denom1;
   XB2(i) = num2/denom2;
end

totalXB1 = sum(XB1)/m; % Xie-Beni Index for Trial 1
totalXB2 = sum(XB2)/m; % Xie-Beni Index for Trial 2

% Plotting All the Figures
figure(4) 
subplot(2, 1, 1)
imshow(uint8(labeledI1))
title(['Trial 1: Reconstructed Image using ', num2str(k), ' Cluster Centroids'])

subplot(2, 1, 2)
imshow(uint8(labeledI2))
title(['Trial 2: Reconstructed Image using ', num2str(k), ' Cluster Centroids'])

figure(5)
subplot(2, 1, 1)
plot(J1)
title(['Trial 1: Error Criterion using ', num2str(k), ' Cluster Centroids'])

subplot(2, 1, 2)
plot(J2)
title(['Trial 2: Error Criterion using ', num2str(k), ' Cluster Centroids'])

figure(6)
subplot(2, 1, 1)
for i = 1:k
    plot3(X(c1(:) == i, 1), X(c1(:) == i, 2), X(c1(:) == i, 3), '.', 'Color', RGB(i, :))
    
    if (i == 1)
       hold on; 
    end
end
hold off
title('Trial 1: RGB Space Plot');

subplot(2, 1, 2)
for i = 1:k
    plot3(X(c2(:) == i, 1), X(c2(:) == i, 2), X(c2(:) == i, 3), '.', 'Color', RGB(i, :))
    
    if (i == 1)
       hold on; 
    end
end
hold off
title('Trial 2: RGB Space Plot');