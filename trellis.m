
i=0;j=0;

global queue;
queue  = zeros( 50, 2 );
global firstq;
global lastq;
firstq= 1;
lastq  = 1;

global td;
td=zeros(8,8,4);
for i=1:8
    for j=1:8
    td(i,j,1)=-1;
    td(i,j,2)=-1;
    td(i,j,3)=-1;
    td(i,j,4)=-1;
    end
end

state=0;
time=0;

enqueue(state,time);


while notEmpty()
    
   [state,time]=dequeue();
   
   td=path(state,time,td);
   if time+1 <8
   enqueue(td(state+1,time+1,1),time+1);
   enqueue(td(state+1,time+1,2),time+1);
   end

end


% TRELLIS DIAGRAM FOR THE CONVOLUTIONAL CODE IS NOW AVAILABLE
%------------------------------------------------------------


% VITERBI DECODER

incoming=[0 1 1 1 0 1 1 1 0 1 0 1 1 1];

time=0;
pathmetric=zeros(1,8);





























% CONVOLUTIONAL ENCODER
function output=encoder(input)
    states=zeros(1,4);
    index=1;
    output=zeros(1,2);
    while(sum(states)>0 || size(input,2)>0)

        states = circshift(states,1);   
        if size(input,2)
            states(1)=input(1);    
        else
            states(1)=0;
        end

        input=input(2:end);

        g1=mod(sum(states([1 2 3 4])),2);
        g2=mod(sum(states([1 2 4])),2);


        output(index)=g1;
        output(index+1)=g2;

        index=index+2;

    end

end











function y=path(state,time,trellisdiag)

    y=trellisdiag;
    [zero,one]=nextState(state);
    [zero_o,one_o]=output(state);
    y(state+1,time+1,1)=zero;
    y(state+1,time+1,3)=zero_o;
    y(state+1,time+1,2)=one;
    y(state+1,time+1,4)=one_o;
    
end

function [zero,one] = output(i)
 states=binarify(i);
 states = [0, states];
 zero=[mod(sum(states([1 2 3 4])),2),mod(sum(states([1 2 4])),2)];
 zero=decify(zero);
 
 states(1)=1;
 one=[mod(sum(states([1 2 3 4])),2),mod(sum(states([1 2 4])),2)];
 one=decify(one);
 
end

function [zero,one] = nextState(i)
 states=binarify(i);
 states = circshift(states,1);
 states(1)=0;
 zero=decify(states);
 states(1)=1;
 one=decify(states);
end






 function bin=binarify(dec_nr)
bin=zeros(1,3);
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
if size(bin)==2
    bin=bin(1,end+1);
    bin=circshift(bin,1);
end

    
 end
 


function x=notEmpty()
    global lastq;
    global firstq;
    if firstq==lastq
        x=0;
    else
        x=1;
    end
end

function q= enqueue(state,time)
    global lastq;
    global queue;
    queue(lastq,1)=state;
    queue(lastq,2)=time;
    lastq=lastq+1;
    q=queue;
end

function [state,time]=dequeue()
    global firstq;
    global queue;
    state=queue(firstq,1);
    time=queue(firstq,2);
    firstq=firstq+1;
end



function y=decify(x)
    sum =0;
    for i=1:length(x)
        sum=sum+x(i)*2^(length(x)-i);
    end
    y=sum;
end
