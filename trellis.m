


i=0;j=0;

% states=zeros(1,3);

nextState(5)


function [zero,one] = nextState(i)
 states=binarify(i);
 states = circshift(states,1);
 states(1)=0;
 zero=decify(states)
 states(1)=1;
 one=decify(states)
end


 

 function bin=binarify(dec_nr)
i = 1;
q = floor(dec_nr/2);
r = rem(dec_nr, 2);
bin(i) = r(i);
while 2 <= q
    dec_nr = q;
    i = i + 1;
    q = floor(dec_nr/2);
    r = rem(dec_nr, 2);
    bin(i) = r;
end
bin(i + 1) = q;
bin = fliplr(bin);
 
 end
 




function y=decify(x)
sum =0;

for i=1:length(x)
    sum=sum+x(i)*2^(length(x)-i);
end
 y=sum;
end
