% Calculate the XOR of the state values of the 10 flip flops for g1 polynomial
function g1=caluc_g1(states)
g1=mod(sum(states([5 6 8 9 10])),2);
end

%{
function g1=caluc_g1(states)
g1=mod(sum(states([1 2 3 4])),2);
end
%}