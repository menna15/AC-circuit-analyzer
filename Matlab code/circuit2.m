importscript;
load('compressed_file.mat');
max=n1(2);
s=size(n1);
for a=2:s
    if(n1(a)>max)
        max=n1(a);
    end
    if(n2(a)>max)
        max=n2(a);
    end
end
numofnode=max;
node=max;
nodev=max;
for b=1:s
    if(char(V(b))=='IVS')
        max=max+1;
          
    end
    if(char(V(b))=='DVS')
        if(char(V(b+1))=='C')
          max=max+2;
        else
            max=max+1;
        end
    
    end
    if(char(V(b))=='DCS')
        if(char(V(b+1))=='C')
            max=max+1;
        end
    end
end

G=zeros(max,max);
Is=zeros(max,1);
num=0;
num2=0;
for c=2:s
    if(char(V(c))=='R')
        num=num+1;
        if(n2(c)==0)
            G(n1(c),n1(c))=G(n1(c),n1(c))+(1/val(c));
       
        else
          G(n1(c),n1(c))=G(n1(c),n1(c))+(1/val(c));
          G(n2(c),n2(c))=G(n2(c),n2(c))+(1/val(c));
          G(n1(c),n2(c))=G(n1(c),n2(c))+(-1/val(c));
          G(n2(c),n1(c))=G(n2(c),n1(c))+(-1/val(c));
        end
    end
    
    if(char(V(c))=='L')
        num=num+1;
        Z=n1(1)*val(c)*i;
        if(n2(c)==0)
            G(n1(c),n1(c))=G(n1(c),n1(c))+(1/Z);
       
        else
          G(n1(c),n1(c))=G(n1(c),n1(c))+(1/Z);
          G(n2(c),n2(c))=G(n2(c),n2(c))+(1/Z);
          G(n1(c),n2(c))=G(n1(c),n2(c))+(-1/Z);
          G(n2(c),n1(c))=G(n2(c),n1(c))+(-1/Z);
        end
        
        
    end
    if(char(V(c))=='CAP')
        num=num+1;
        Z=1/(n1(1)*val(c)*i);
        if(n2(c)==0)
            G(n1(c),n1(c))=G(n1(c),n1(c))+(1/Z);
       
        else
          G(n1(c),n1(c))=G(n1(c),n1(c))+(1/Z);
          G(n2(c),n2(c))=G(n2(c),n2(c))+(1/Z);
          G(n1(c),n2(c))=G(n1(c),n2(c))+(-1/Z);
          G(n2(c),n1(c))=G(n2(c),n1(c))+(-1/Z);
        end
        
    end
     if(char(V(c))=='ICS')
         num2=num2+1;
        if(n1(c)==0)
            Is(n2(c))=Is(n2(c))+val(c);
        elseif(n2(c)==0)
            Is(n1(c))=Is(n1(c))-val(c);
        else
            Is(n1(c))=Is(n1(c))-val(c);
            Is(n2(c))=Is(n2(c))+val(c);
        end
     end
    if(char(V(c))=='DCS')
        num2=num2+1;
       if(char(V(c+1))=='V')
           if(n1(c+1)==0)
               if(n1(c)==0)
                  G(n2(c),n2(c+1))= G(n2(c),n2(c+1))+val(c); 
               elseif(n2(c)==0)   
                  G(n1(c),n2(c+1))= G(n1(c),n2(c+1))-val(c);
               else   
            G(n2(c),n2(c+1))= G(n2(c),n2(c+1))+val(c);
            G(n1(c),n2(c+1))= G(n1(c),n2(c+1))-val(c);
               end
           elseif(n2(c+1)==0)
               if(n1(c)==0)
                  G(n2(c),n1(c+1))= G(n2(c),n1(c+1))-val(c);
               elseif(n2(c)==0)
                 G(n1(c),n1(c+1))= G(n1(c),n1(c+1))+val(c); 
               else  
            G(n1(c),n1(c+1))= G(n1(c),n1(c+1))+val(c); 
            G(n2(c),n1(c+1))= G(n2(c),n1(c+1))-val(c);
               end
           elseif(n1(c)==0)
          G(n2(c),n2(c+1))= G(n2(c),n2(c+1))+val(c);
          G(n2(c),n1(c+1))= G(n2(c),n1(c+1))-val(c);
           elseif(n2(c)==0)
          G(n1(c),n1(c+1))= G(n1(c),n1(c+1))+val(c);
          G(n1(c),n2(c+1))= G(n1(c),n2(c+1))-val(c);
           else
        G(n1(c),n1(c+1))= G(n1(c),n1(c+1))+val(c);
        G(n2(c),n2(c+1))= G(n2(c),n2(c+1))+val(c);
        G(n1(c),n2(c+1))= G(n1(c),n2(c+1))-val(c);
        G(n2(c),n1(c+1))= G(n2(c),n1(c+1))-val(c);
           end
       else
           numofnode=numofnode+1;
           if(n1(c+1)==0)
               
               G(numofnode,n2(c+1))=G(numofnode,n2(c+1))-1;
               G(n2(c+1),numofnode)=G(n2(c+1),numofnode)-1;
               if(n1(c)==0)
                   G(n2(c),numofnode)=G(n2(c),numofnode)-val(c);
               elseif(n2(c)==0)
                   G(n1(c),numofnode)=G(n1(c),numofnode)+val(c);
               else
               G(n1(c),numofnode)=G(n1(c),numofnode)+val(c);
               G(n2(c),numofnode)=G(n2(c),numofnode)-val(c);
               end
           elseif(n2(c+1)==0)
               
               G(numofnode,n1(c+1))=G(numofnode,n1(c+1))+1;
               G(n1(c+1),numofnode)=G(n1(c+1),numofnode)+1;
               if(n1(c)==0)
                   G(n2(c),numofnode)=G(n2(c),numofnode)-val(c);
               elseif(n2(c)==0)
                   G(n1(c),numofnode)=G(n1(c),numofnode)+val(c);
               else    
               G(n1(c),numofnode)=G(n1(c),numofnode)+val(c);
               G(n2(c),numofnode)=G(n2(c),numofnode)-val(c);
               end
           elseif(n1(c)==0)
               G(numofnode,n1(c+1))=G(numofnode,n1(c+1))+1;
               G(numofnode,n2(c+1))=G(numofnode,n2(c+1))-1;
               G(n1(c+1),numofnode)=G(n1(c+1),numofnode)+1;
               G(n2(c+1),numofnode)=G(n2(c+1),numofnode)-1;
               G(n2(c),numofnode)=G(n2(c),numofnode)-val(c);
           elseif(n2(c)==0)
               G(numofnode,n1(c+1))=G(numofnode,n1(c+1))+1;
               G(numofnode,n2(c+1))=G(numofnode,n2(c+1))-1;
               G(n1(c+1),numofnode)=G(n1(c+1),numofnode)+1;
               G(n2(c+1),numofnode)=G(n2(c+1),numofnode)-1;
               G(n1(c),numofnode)=G(n1(c),numofnode)+val(c);
           else
           G(numofnode,n1(c+1))=G(numofnode,n1(c+1))+1;
           G(numofnode,n2(c+1))=G(numofnode,n2(c+1))-1;
           G(n1(c+1),numofnode)=G(n1(c+1),numofnode)+1;
           G(n2(c+1),numofnode)=G(n2(c+1),numofnode)-1;
           G(n1(c),numofnode)=G(n1(c),numofnode)+val(c);
           G(n2(c),numofnode)=G(n2(c),numofnode)-val(c);
           end
       end
    
        
       
    end
     if(char(V(c))=='IVS')
         num2=num2+1;
         numofnode=numofnode+1;
         Is(numofnode)=val(c);
         if(n1(c)==0)
         G(numofnode,n2(c))=-1;
         G(n2(c),numofnode)=-1;
         elseif(n2(c)==0)
         G(numofnode,n1(c))=1;
         G(n1(c),numofnode)=1;
         else
        
         G(numofnode,n1(c))=1;
         G(numofnode,n2(c))=-1;
         G(n1(c),numofnode)=1;
         G(n2(c),numofnode)=-1;
         end
      
     end
     if(char(V(c))=='DVS')
         num2=num2+1
        if(char(V(c+1))=='V') 
         numofnode=numofnode+1;
         if(n1(c)==0)
          G(numofnode,n2(c))=-1; 
          G(n2(c),numofnode)=-1;
          if(n1(c+1)==0)
              G(numofnode,n2(c+1))=val(c);
          elseif(n2(c+1)==0)
              G(numofnode,n1(c+1))=-val(c);
          else   
          G(numofnode,n1(c+1))=-val(c);
          G(numofnode,n2(c+1))=val(c);
          end
         elseif(n2(c)==0)
          G(numofnode,n1(c))=1;
          G(n1(c),numofnode)=1;
          if(n1(c+1)==0)
            G(numofnode,n2(c+1))=val(c);
          elseif(n2(c+1)==0)
            G(numofnode,n1(c+1))=-val(c);
          else
          G(numofnode,n1(c+1))=-val(c);
          G(numofnode,n2(c+1))=val(c);
          end
         elseif(n1(c+1)==0)
             if(n1(c)==0)
                G(numofnode,n2(c))=-1;
                G(n2(c),numofnode)=-1;
                G(numofnode,n2(c+1))=val(c);
             elseif(n2(c+1)==0)
                G(numofnode,n1(c))=1;
                G(n1(c),numofnode)=1;
                G(numofnode,n2(c+1))=val(c);
             else  
          G(numofnode,n1(c))=1;
          G(numofnode,n2(c))=-1;
          G(n1(c),numofnode)=1;
          G(n2(c),numofnode)=-1;
          G(numofnode,n2(c+1))=val(c);
             end
         elseif(n2(c+1)==0)
             if(n1(c)==0)
               G(numofnode,n2(c))=-1;
               G(n2(c),numofnode)=-1;
               G(numofnode,n1(c+1))=-val(c);
             elseif(n2(c)==0)
                G(numofnode,n1(c))=1;
                G(n1(c),numofnode)=1;
                G(numofnode,n1(c+1))=-val(c);
             else   
           G(numofnode,n1(c))=1;
           G(numofnode,n2(c))=-1;
           G(n1(c),numofnode)=1;
           G(n2(c),numofnode)=-1;
           G(numofnode,n1(c+1))=-val(c);
             end
         else    
         G(numofnode,n1(c))=1;
         G(numofnode,n2(c))=-1;
         G(n1(c),numofnode)=1;
         G(n2(c),numofnode)=-1;
         G(numofnode,n1(c+1))=-val(c);
         G(numofnode,n2(c+1))=val(c);
         end
        elseif(char(V(c+1))=='C')
         numofnode=numofnode+1;
         if(n1(c+1)==0)
             G(numofnode,n2(c+1))=G(numofnode,n2(c+1))-1;
             G(n2(c+1),numofnode)=G(n2(c+1),numofnode)-1;
             numofnode=numofnode+1;
             if(n1(c)==0)
                 G(numofnode,n2(c))=G(numofnode,n2(c))-1;
                 G(n2(c),numofnode)=G(n2(c),numofnode)-1;
                 G(numofnode,numofnode-1)=G(numofnode,numofnode-1)-val(c);
             elseif(n2(c)==0)
                 G(numofnode,n1(c))=G(numofnode,n1(c))+1;
                 G(n1(c),numofnode)=G(n1(c),numofnode)+1;
                 G(numofnode,numofnode-1)=G(numofnode,numofnode-1)-val(c);
             else   
             G(numofnode,n1(c))=G(numofnode,n1(c))+1;
             G(numofnode,n2(c))=G(numofnode,n2(c))-1;
             G(n1(c),numofnode)=G(n1(c),numofnode)+1;
             G(n2(c),numofnode)=G(n2(c),numofnode)-1;
             G(numofnode,numofnode-1)=G(numofnode,numofnode-1)-val(c);
             end
         elseif(n2(c+1)==0) 
             G(numofnode,n1(c+1))=G(numofnode,n1(c+1))+1;
             G(n1(c+1),numofnode)=G(n1(c+1),numofnode)+1;
             numofnode=numofnode+1;
             if(n1(c)==0)
                 G(numofnode,n2(c+1))=G(numofnode,n2(c+1))-1;
                 G(n2(c+1),numofnode)=G(n2(c+1),numofnode)-1;
                 G(numofnode,numofnode-1)=G(numofnode,numofnode-1)-val(c);
             elseif(n2(c)==0)
                 G(numofnode,n1(c))=G(numofnode,n1(c))+1;
                 G(n1(c),numofnode)=G(n1(c),numofnode)+1;
                 G(numofnode,numofnode-1)=G(numofnode,numofnode-1)-val(c);
             else
             G(numofnode,n1(c))=G(numofnode,n1(c))+1;
             G(numofnode,n2(c))=G(numofnode,n2(c))-1;
             G(n1(c),numofnode)=G(n1(c),numofnode)+1;
             G(n2(c),numofnode)=G(n2(c),numofnode)-1;
             G(numofnode,numofnode-1)=G(numofnode,numofnode-1)-val(c);
             end
         elseif(n1(c)==0)
             G(numofnode,n1(c+1))=G(numofnode,n1(c+1))+1;
             G(numofnode,n2(c+1))=G(numofnode,n2(c+1))-1;
             G(n1(c+1),numofnode)=G(n1(c+1),numofnode)+1;
             G(n2(c+1),numofnode)=G(n2(c+1),numofnode)-1;
             numofnode=numofnode+1;
             G(numofnode,n2(c))=G(numofnode,n2(c))-1;
             G(n2(c),numofnode)=G(n2(c),numofnode)-1;
             G(numofnode,numofnode-1)=G(numofnode,numofnode-1)-val(c);
         elseif(n2(c)==0)
            G(numofnode,n1(c+1))=G(numofnode,n1(c+1))+1;
            G(numofnode,n2(c+1))=G(numofnode,n2(c+1))-1;
            G(n1(c+1),numofnode)=G(n1(c+1),numofnode)+1;
            G(n2(c+1),numofnode)=G(n2(c+1),numofnode)-1;
            numofnode=numofnode+1;
            G(numofnode,n1(c))=G(numofnode,n1(c))+1;
            G(n1(c),numofnode)=G(n1(c),numofnode)+1;
            G(numofnode,numofnode-1)=G(numofnode,numofnode-1)-val(c);
         else
         G(numofnode,n1(c+1))=G(numofnode,n1(c+1))+1;
         G(numofnode,n2(c+1))=G(numofnode,n2(c+1))-1;
         G(n1(c+1),numofnode)=G(n1(c+1),numofnode)+1;
         G(n2(c+1),numofnode)=G(n2(c+1),numofnode)-1;
         numofnode=numofnode+1;
         G(numofnode,n1(c))=G(numofnode,n1(c))+1;
         G(numofnode,n2(c))=G(numofnode,n2(c))-1;
         G(n1(c),numofnode)=G(n1(c),numofnode)+1;
         G(n2(c),numofnode)=G(n2(c),numofnode)-1;
         G(numofnode,numofnode-1)=G(numofnode,numofnode-1)-val(c);
        end
        end
     end
    
end

disp(G);
v=G\Is

pw=zeros(num,1);
pw2=zeros(num2,1);
n=1;
m=1
for c=2:s
    if(char(V(c))=='R')
        if(n2(c)==0)
            I=v(n1(c))/val(c);
            pw(n)=real(v(n1(c))*conj(I)/2);
        else
    I=(v(n1(c))-v(n2(c)))/val(c);
    pw(n)=real((v(n1(c))-v(n2(c)))*conj(I)/2);
        end
    
    n=n+1;
    end
    if(char(V(c))=='L')
        Z=n1(1)*val(c)*i;
        if(n2(c)==0)
            I=v(n1(c))/Z;
            pw(n)=imag(v(n1(c))*conj(I)/2);
            n=n+1;
            else
    I=(v(n1(c))-v(n2(c)))/Z;
    pw(n)=imag((v(n1(c))-v(n2(c)))*conj(I)/2);
    n=n+1;
        end
    end
    if(char(V(c))=='CAP')
        Z=1/(n1(1)*val(c)*i);
        if(n2(c)==0)
            I=v(n1(c))/Z;
            pw(n)=imag(v(n1(c))*conj(I)/2);
            n=n+1;
            else
    I=(v(n1(c))-v(n2(c)))/Z;
    pw(n)=imag((v(n1(c))-v(n2(c)))*conj(I)/2);
    n=n+1;
        end
    end
    
    if(char(V(c))=='ICS')
        if(n1(c)==0)
            pw2(m)=(v(n2(c))*conj(val(c))/2);
            m=m+1;
        elseif(n2(c)==0)
            pw2(m)=(-v(n1(c))*conj(val(c))/2);
            m=m+1;
        else
        pw2(m)=((-v(n1(c))+v(n2(c)))*conj(val(c))/2);
        m=m+1;
        end
       
    end
    
    if(char(V(c))=='DCS')
       if(char(V(c+1))=='V')
           if(n1(c+1)==0)
               II=val(c)*-v(n2(c+1));
               if(n1(c)==0)
               pw2(m)=(conj(II)*(v(n2(c)))/2);
               m=m+1;
               elseif(n2(c)==0)
               pw2(m)=(conj(II)*(-v(n1(c)))/2);
               m=m+1;
               else
               pw2(m)=conj(II)*(-v(n1(c)))+v(n2(c))/2;   
               m=m+1;
               end
           elseif(n2(c+1)==0)
               II=val(c)*v(n1(c+1));
               if(n1(c)==0)
               pw2(m)=conj(II)*(v(n2(c)))/2;
               m=m+1;
               elseif(n2(c)==0)
               pw2(m)=conj(II)*(-v(n1(c)))/2;
               m=m+1;
               else
               pw2(m)=conj(II)*(-v(n1(c)))+v(n2(c))/2;
               m=m+1;
               end
           elseif(n1(c)==0)
               II=val(c)*(v(n1(c+1))-v(n2(c+1)));
               pw2(m)=conj(II)*v(n2(c))/2;
               m=m+1;
           elseif(n2(c)==0)
               II=val(c)*(v(n1(c+1))-v(n2(c+1)));
               pw2(m)=conj(II)*(-v(n1(c)))/2;
               m=m+1;
           else
           II=val(c)*(v(n1(c+1))-v(n2(c+1)));
           pw2(m)=conj(II)*(-v(n1(c)))+v(n2(c))/2;
           m=m+1;
           end
       else
          node=node+1;
          II=val(c)*v(node);
          if(n1(c)==0)
              pw2(m)=conj(II)*(v(n2(c))/2);
              m=m+1;
          elseif(n2(c)==0)
              pw2(m)=conj(II)*(-v(n1(c)))/2;
              m=m+1;
          else
          pw2(m)=conj(II)*((-v(n1(c)))+v(n2(c)))/2;
          m=m+1;
          end
       end
    end
   
   if(char(V(c))=='IVS')
       node=node+1;
       pw2(m)=conj(-v(node))*val(c)/2;
       m=m+1;
       
   end
   
   if(char(V(c))=='DVS')
       if(char(V(c+1))=='V')
       node=node+1;
       if(n1(c+1)==0)
           vv=-v(n2(c+1))*val(c);
       elseif(n2(c+1)==0)
           vv=v(n1(c+1))*val(c);
       else
       vv=v(n1(c+1))-v(n2(c+1))*val(c);
       end
       pw2(m)=(conj(v(node))*vv/2);
       m=m+1;
       
       else
           node=node+1;
           vv=val(c)*v(node);
           node=node+1;
           pw2(m)=(vv*conj(-v(node))/2);
           m=m+1;
       end
   end
   
   

end
disp('pwww');

disp(pw);
disp('pwww2');
disp(pw2);
r=1;
a=1;
diary circuits.txt

for c=1:nodev
    if(c==1)
    disp('v1')
    disp(v(c))
    end
    if(c==2)
        disp('v2')
        disp(v(c))
    end
    if(c==3)
        disp('v3')
        disp(v(c))
    end
    if(c==4)
        disp('v4')
        disp(v(c))
    end
    if(c==5)
        disp('v5')
        disp(v(c))
    end
    if(c==6)
        disp('v5')
        disp(v(c))
    end
    if(c==6)
        disp('v6')
        disp(v(c))
    end
    if(c==7)
        disp('v7')
        disp(v(c))
    end
    if(c==8)
        disp('v8')
        disp(v(c))
    end
    if(c==9)
        disp('v9')
        disp(v(c))
    end
    if(c==10)
        disp('v10')
        disp(v(c))
    end
end
for c=nodev:max
    disp('I')
    disp(v(c))
    
end

for c=2:s
    if(char(V(c))=='R')
        disp('power(R)')
        disp(pw(r))
        r=r+1;
    end
    if(char(V(c))=='L')
        disp('power(L)')
        disp(pw(r))
        r=r+1;
    end
    if(char(V(c))=='CAP')
        disp('power(C)')
        disp(pw(r))
        r=r+1;
    end
    
    
    
end
for c=2:s
    if(char(V(c))=='IVS')
        disp('power(IVS)')
        disp(pw2(a))
        a=a+1;
    end
    if(char(V(c))=='ICS')
        disp('power(ICS)')
        disp(pw2(a))
        a=a+1;
    end
    if(char(V(c))=='DVS')
        disp('power(DVS)')
        disp(pw2(a))
        a=a+1;
    end
    if(char(V(c))=='DCS')
        disp('power(DCS)')
        disp(pw2(a))
        a=a+1;
    end
    
end


diary off

