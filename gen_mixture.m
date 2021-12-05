function mixture = gen_mixture(vector, M)

  [mean esp nn]=kmeans1(vector,M);

  for j=1:M
      ind=find(j==nn);
      tmp=vector(ind,:);
      var(j,:)=std(tmp);
  end

  weight=zeros(M,1);
  for j=1:M
    for k=1:size(nn,1)  
      if nn(k)==j
          weight(j)=weight(j)+1;
      end
    end
  end
  weight=weight/sum(weight);

  mix.M=M;
  mix.mean=mean;    
  mix.var=var.^2;	
  mix.weight=weight;	
end