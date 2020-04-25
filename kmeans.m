function [labeledX, J, c, uInitial, uFinal] = kmeans(X, k)
    % Initialize relevant variables for K-means algorithm
    m = length(X);
    max = 100;

    % Initialize the clusters with a random sample
    indices = randsample(1:m, k);
    u = X(indices, :);
    uInitial = u;
    c = zeros(m, 1);
    J = zeros(m, 1);

    for x = 1:max
        u_old = u;

        for i = 1:m
            dist = zeros(1, 2);

            for j = 1:k
                diff = (X(i, :)-u(j)).^2;
                dist(j) = sqrt(sum(diff));
            end

            [~, index] = min(dist);
            c(i) = index;
            J(i) = sum(abs(X(i, :)-u(c(i),:)).^2);
        end

        for j = 1:k
            u(j, :) = sum(X(c(:) == j, :))/length(X(c(:) == j, :));
        end

        if (u == u_old)
           break; 
        end
    end

    labeledX = zeros(m, 3);

    for i = 1:m
        labeledX(i, :) = u(c(i), :);
    end
    
    uFinal = u;
end

