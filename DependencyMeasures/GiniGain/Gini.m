function [GI_] = Gini(true_mem,mem)
    if nargin==1
      T=true_mem; %contingency table pre-supplied
    elseif nargin==2;
      %build the contingency table from membership arrays
      r=max(true_mem);
      c=max(mem);

      %identify & removing the missing labels
      list_t=ismember(1:r,true_mem);
      list_m=ismember(1:c,mem);
      T=Contingency(true_mem,mem);
      T=T(list_t,list_m);
    end

    [r c]=size(T);
    if (c == 1 || r == 1)
     error('r and c should be greater than 1')
     return
    end

    n = sum(sum(T));

    %update the true dimensions
    [r c]=size(T);
    if c>1 nX=sum(T'); else nX=T';end;
    if r>1 nY=sum(T); else nY=T;end;
    
    GiniColumns = 1;
    
    for j=1:c
        GiniColumns = GiniColumns - (nY(j)/n)^2;
    end
       
    
    GI_=0;
    for i=1:r
        G = 0;
        for j=1:c
            G = G + (T(i,j)/nX(i))^2;
        end
        GI_ = GI_ + (1 - G)*nX(i);
    end
    
    
    GI_ = (GiniColumns - GI_/n);
    
%---------------------auxiliary functions---------------------
function Cont=Contingency(Mem1,Mem2)

if nargin < 2 || min(size(Mem1)) > 1 || min(size(Mem2)) > 1
   error('Contingency: Requires two vector arguments')
   return
end

Cont=zeros(max(Mem1),max(Mem2));

for i = 1:length(Mem1);
   Cont(Mem1(i),Mem2(i))=Cont(Mem1(i),Mem2(i))+1;
end

            
