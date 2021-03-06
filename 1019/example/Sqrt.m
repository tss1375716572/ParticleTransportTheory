clear
clc
x=1.06;
dx=0.001;
n=x/dx;
w=[0.17132,0.36076,0.46791,0.46791,0.36076,0.17132];
u=[-0.93247,-0.66121,-0.23862,0.23862,0.66121,0.93247];
s(1:n+1)=1;
c=1;

for i=1:1000
    b(1:n+1)=0;
    
    for j=1:6
        
        if u(j)<0
            y(n+2)=0;
            a=dx/u(j);
            for k=n+1:-1:1
                y(k)=(1+a*a/2)*y(k+1)-a*s(k)+a*sqrt((1+a*a/4)*y(k+1)*y(k+1)-a*s(k)*y(k+1));
                d(k)=sqrt(y(k+1)*y(k));
                b(k)=b(k)+w(j)*d(k);
            end
        elseif u(j)>0
            y(1)=0;
            a=dx/u(j);
            for k=2:n+2
                y(k)=(1+a*a/2)*y(k-1)+a*s(k-1)-a*sqrt((1+a*a/4)*y(k-1)*y(k-1)+a*s(k-1)*y(k-1));
                d(k-1)=sqrt(y(k-1)*y(k));
                b(k-1)=b(k-1)+w(j)*d(k-1);
            end
        end
        
    end
    s(1:n+1)=c*b(1:n+1)/2;  
    g(i)=max(s(:));
    if i>3
        c=g(i-1)/g(i)*c;
    end
end

c
plot(0:0.001:x,b(1:n+1))