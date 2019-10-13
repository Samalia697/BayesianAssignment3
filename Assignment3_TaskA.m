% function [post_dis_given_test,post_no_dis_given_test]=disease(testsq)  %row matrix
N=10;%number of sequential test results
keySet={':)',':(','-|:)','-|:(','+|:)','+|:('};
valueSet=[0.999,0.001,1-0.05,1-0.99,0.05,0.99];
p=containers.Map(keySet,valueSet);

p('+')=p('+|:)')*p(':)')+p('+|:(')*p(':(');
p('-')=p('-|:)')*p(':)')+p('-|:(')*p(':(');

p(':(|+')=p(':(');%p('+|:(')*p(':(')/p('+');
p(':(|-')=p(':(');%p('-|:(')*p(':(')/p('-');

p(':)|+')=p(':)');%p('+|:)')*p(':)')/p('+');
p(':)|-')=p(':)');%p('-|:)')*p(':)')/p('-');

post_pres_test=p(':(');
post_abs_test=p(':)');

Test=randi(2,[1,N]); 
T=cell(1,N);

for i=1:N
    if(Test(i)==1) % test is negative
        p(':(|-')=p('-|:(')*p(':(|-')/(p('-|:(')*p(':(|-')+p('-|:)')*p(':)|-'));
        p(':)|-')=p('-|:)')*p(':)|-')/(p('-|:(')*p(':(|-')+p('-|:)')*p(':)|-'));
        post_pres_test=[post_pres_test,p(':(|-')];
        post_abs_test=[post_abs_test,p(':)|-')];
        T(i)={'-'};
    else    % test is positive 
        p(':(|+')=p('+|:(')*p(':(|+')/(p('+|:(')*p(':(|+')+p('+|:)')*p(':)|+'));
        p(':)|+')=p('+|:)')*p(':)|+')/(p('+|:(')*p(':(|+')+p('+|:)')*p(':)|+'));
        post_pres_test=[post_pres_test,p(':(|+')];
        post_abs_test=[post_abs_test,p(':)|+')];
        T(i)={'+'};
    end
   
end
display(T);
display(post_pres_test);
display(post_abs_test);
% return