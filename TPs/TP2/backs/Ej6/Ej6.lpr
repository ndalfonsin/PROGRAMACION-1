program Ej6;

(*
Un negocio vende camisas, estas pueden ser de hombre o de mujer. Los talles que fabrican son:
S,M,L,X. El precio base unitario es de $1000 para hombres y $1200 para mujeres, se debe
ingresar el iva (21%). Hay una promocion en que los talles S de hombre y X de mujer con un
5% de descuento. Ademas si la compra supera la docena se considera venta mayorista y obtiene
un 7% de descuento.
*)

var
  talle, sexo, seguir:char;
  cantidad, acumC: byte;
  total,acumT:real;



const
  precioH=1000;
  precioM=1200;
  iva=1.21;
  descM=0.93;
  descE=0.95;

begin
     acumT:=0;
     acumC:=0;
     seguir:='S';


     while (seguir<>'N')and(seguir<>'n') do
           begin
                writeln('Ingrese el tipo de remera[(M) masculino, (F) femenino]');
                readln(sexo);
                sexo:= upcase(sexo);

                writeln('Ingrese el talle de la remera [S,M,L,X]');
                readln(talle);
                talle:= upcase(talle);

                writeln('Ingrese la cantidad de remeras (con el mismo talle y sexo)');
                readln(cantidad);

                if ((sexo='M')or(sexo='F'))and((talle='S')or(talle='M')or(talle='L')or(talle='X')) then
                   begin
                        if sexo='M' then
                           begin
                                total:=((precioH * cantidad) * iva);
                                if talle='S' then
                                   total:= (total * descE);
                           end
                        else
                            begin
                                 total:=((precioM * cantidad) * iva);
                                 if talle='X' then
                                   total:= (total * descE);
                            end;

                        acumT:= (acumT+total);
                        acumC:= (acumC+cantidad);

                   end
                else
                    writeln('Ha ingresado un valor incorrecto');

                writeln('Desea seguir ingresando Productos? [S/N]');
                readln(seguir);
           end;
     if acumC>=12 then
        acumT:=(acumT * descM);

     writeln('La cantidad total de productos son: ',acumC:2);
     writeln('La cantidad total a cobrar es: $',acumT:8:2);

     readln();
end.

