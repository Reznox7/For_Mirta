current_x = [];
matrix_H = [];
matrix_N = [];
%% 1.a
disp("1.a")
for i=1:3
    if i == 1
        current_x = x1;
    elseif i == 2
        current_x = x2;
    else
        current_x = x3;
    end
    temp = [];
    % ZA DRUGI ZADATAK
    %for j=1:100 
    for j=1:4
        x = [X(1,j) X(2,j) X(4,j)];
        temp_2 = [x 0 0 0 -x*current_x(1,j); 0 0 0 x -x*current_x(2,j)];
        temp = [temp; temp_2];
    end
    matrix_M = temp;
    [U, S, V] = svd(matrix_M);
    H = reshape(V(:, end), 3,3);
    disp("Current Matrix = H"+i);
    H = H / H(3,3);
    disp(H);
    matrix_H = cat(3,matrix_H, H);
end

%% 1.b
disp("1.b");
syms h11 h12 h13 h21 h22 h23 h31 h32 h33
syms b11 b12 b13 b22 b23 b33

h1 = [h11; h12; h13];
h2 = [h21; h22; h23];
h3 = [h31; h32; h33];

B = [b11 b12 b13; b12 b22 b23; b13 b23 b33];
equation_1 = (h1' * B * h2 == 0);
equation_2 = (h1' * B * h1 - h2' * B * h2 == 0);

N_temp = equationsToMatrix([equation_1 equation_2], [b11; b12; b13; b22; b23; b33]);
for i=1:3
    temp = subs(N_temp, [h11 h12 h13; h21 h22 h23; h31 h32 h33], matrix_H(:,:,i));
    matrix_N = [matrix_N; temp];
    disp("Current matrix = N"+i)
    disp(vpa(temp,3));
end

%%1.c
[U,S,V] = svd(matrix_N);
temp=V(:,end);
B=[temp(1) temp(2) temp(3); temp(2) temp(4) temp(5); temp(3) temp(5) temp(6)];
B=B/temp(6);

A=chol(B,'nocheck');
K = vpa(inv(transpose(A)),3);
K = vpa(K/K(3,3),3)

%%1.d
