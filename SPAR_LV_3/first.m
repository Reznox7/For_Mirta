%load measurements.mat

x1x2x3=cat(3,x1,x2,x3);
M=[];
for index=1:3
    x_2d=x1x2x3(:,:,index);
    M_pom=[];
    for i=1:4

        x_=[X(1,i) X(2,i) X(4,i)];
        zero=[0 0 0];
        u=x_2d(1,i);
        v=x_2d(2,i);
        
        pom=[x_  zero -x_*u;
             zero x_  -x_*v];

        M_pom=[M_pom; pom];
    end
    M=cat(3,M,M_pom);
end
H=[];
for index=1:3
    [U,S,V] = svd(M(:,:,index));
    H_=V(:,end);
    H_=reshape(H_,3,3)';
    H_=H_/H_(3,3);
    H=cat(3,H,H_);
end
N=[];
for i=1:3
    h=H(:,:,i);
    red_1=[h(1,1)*h(1,2) h(1,2)*h(2,1)+h(2,2)*h(1,1) h(1,2)*h(3,1)+h(1,1)*h(3,2) h(2,2)*h(2,1) h(3,1)*h(2,2)+h(3,2)*h(2,1) h(3,2)*h(3,1)];
    
    red_21=[h(1,1)*h(1,1) h(1,1)*h(2,1)+h(2,1)*h(1,1) h(1,1)*h(3,1)+h(1,1)*h(3,1) h(2,1)*h(2,1) h(3,1)*h(2,1)+h(3,1)*h(2,1) h(3,1)*h(3,1)]; 
    red_22=[h(1,2)*h(1,2) h(1,2)*h(2,2)+h(2,2)*h(1,2) h(1,2)*h(3,2)+h(1,2)*h(3,2) h(2,2)*h(2,2) h(3,2)*h(2,2)+h(3,2)*h(2,2) h(3,2)*h(3,2)];
    
    red_2=red_21-red_22;
    N=[N; red_1; red_2];
end




[U,S,V] = svd(N);
b=V(:,end);
B=[b(1) b(2) b(3); b(2) b(4) b(5); b(3) b(5) b(6)];
B=B/b(6);


A=chol(B);
K=inv(A)
K=K/K(3,3)


T1=A*H(:,:,1)
T1(:,end)=T1(:,end)/( norm(A*H(:,:,1)) )
T2=A*H(:,:,2)
T2(:,end)=T2(:,end)/( norm(A*H(:,:,2)) )
T3=A*H(:,:,3)
T3(:,end)=T3(:,end)/( norm(A*H(:,:,3)) )

x1_=K*T1*[X(1,:);X(2,:);X(4,:)];
x1_=x1_/x1_(3,1);
Error=0;
for i=1:4
    Error=Error+norm(x1-x1_);
end
Error

