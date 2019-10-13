clc
clear all
close all
if(0)
theta=[0.5,0.25];
for i=1:length(theta)
    p_y0=1-theta(i);
    p_y1=theta(i);
    figure
    X=[0,1];
    Y=[p_y0,p_y1];
    stem(X,Y,'LineStyle','-.','MarkerFaceColor','red','MarkerEdgeColor','green')
end
elseif(0)
    theta=0:0.2:1;
    likelihood_y0=zeros(1,length(theta));
    likelihood_y1=zeros(1,length(theta));
    for i=1:length(theta)
        likelihood_y0(i)=1-theta(i);
        likelihood_y1(i)=theta(i);
    end
    figure;
    area(theta,likelihood_y0);
    title('Likelihood for y=0');
    figure;
    area(theta,likelihood_y1);
    title('Likelihood for y=1');
elseif(0)
    theta=0.5;
    n=100000;%10,1000,100000
    events=rand([1 n]);
    y1=[];
    for i=1:length(events)
        if(events(i)<theta)
            y1=[y1;1];
        else
            y1=[y1;0];
        end
    end
    t1=ones(n,1).*theta;
    t2=ones(n,1).*(1-theta);
    y2=ones(n,1)-y1;
    likelihood=prod((t1.^y1).*(t2.^y2));
    display(likelihood);
    loglikelihood=sum((y1.*log(t1))+(y2.*log(t2)));
    display(loglikelihood);
    exp_loglikelihood=exp(sum((y1.*log(t1))+(y2.*log(t2))));
    display(exp_loglikelihood);
elseif(0)
    yd1=[1];%[1],[1,1],[1,1,0,1]
    n=length(yd1);
    yd2=ones(n,1)-yd1;
    thetas=0:0.01:1;
    loglikelihoods=zeros(1,length(thetas));
    exp_loglikelihoods=zeros(1,length(thetas));
    for i=1:length(thetas)
        t1=ones(n,1).*thetas(i);
        t2=ones(n,1).*(1-thetas(i));
        loglikelihoods(i)=-sum((yd1.*log(t1))+(yd2.*log(t2)));%-log!!
        exp_loglikelihoods(i)=exp(sum((yd1.*log(t1))+(yd2.*log(t2))));
    end
    figure;
    plot(thetas,loglikelihoods);
    title('log-likelihoods for y=[1]')
    figure;
    plot(thetas,exp_loglikelihoods);
    title('exp of log-likelihoods for y=[1]')
elseif(1)
    a=1;%col1:a=b=250,col2:a=18.25,b=6.75,col3:a=b=1
    b=1;
    yd1=[ones(17,1);zeros(3,1)];%[1],[1,1],[1,1,0,1],[ones(17,1);zeros(3,1)]
    n=length(yd1);
    thetas=0:0.01:1;
    Postwithloglikelihoods=zeros(1,length(thetas));
    Postwithexp_loglikelihoods=zeros(1,length(thetas));
    for i=1:length(thetas)
        Postwithloglikelihoods(i)=-(((sum(yd1)+a-1)*log(thetas(i)))+(((n-sum(yd1)+b-1))*log(1-thetas(i)))-(log(beta(sum(yd1)+a,n-sum(yd1)+b))));%-log!!
        Postwithexp_loglikelihoods(i)=exp(-Postwithloglikelihoods(i));
    end
    figure;
    plot(thetas,Postwithloglikelihoods);%/sum(Postwithloglikelihoods)
    title('Posterior based on log-likelihoods')% for y=[1 1]
    figure;
    plot(thetas,Postwithexp_loglikelihoods);%/sum(Postwithexp_loglikelihoods)
    title('Posterior based on exp of log-likelihoods')% for y=[1 1]
end