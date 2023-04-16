program potenciaEnecima;

(*

Crear una funcion que nos devuelva la raiz enecima de una variable.

Aspectos a tener en cuenta:
         -SI X es negativa y N par : +
         -SII X es negativa y N impar : -
         -SI N es negativa entonces el resultado debe ser 1/R

         *)

function Xn(X,N: integer):real;
         var
           ctr:boolean;
           i:integer;

         begin
           Xn:=1;
           ctr:=false;

           if N < 0 then
              begin
                N:= (N*(-1));
                ctr:= true;
              end;

           for i:=N downto 1 do
               Xn:= (Xn*X);

           if ctr=true then
              Xn:=(1/Xn);
         End;

var
  X,N:integer;

begin
     repeat
       write('Ingrese la variable X: '); readln(X);
       write('Ingrese la potencia de X que desea obtener: '); readln(N);
     until (X<>0) and (N<>0);

     writeln(X,'^',N,'=',Xn(X,N):6:1);
     readln;
End.

