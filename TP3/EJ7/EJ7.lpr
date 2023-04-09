Program EJ7;

 (* Dado un conjunto de alumnos, no se sabe cuantos son, de cada uno de ellos se
conoce:
       -nombre ( '***' indica fin de datos)
       -nota1, nota2, nota3
   Ingresar la informacion e informar
       -Promedio de cada alumno y su condicion
       (aprobado promedio > 4 y desaprobado promedio < 4)
       -Porcentaje de alumnos aprobados *)
uses
    sysutils;

var
   arch:text;
   nombre, cond: string[15];
   n1,n2,n3, prom: real;
   contA, contAp: byte;

begin
   contA:=0;
   contAp:=0;

   assign(arch, 'alumnos.txt');
   reset(arch);

   read(arch, nombre);
   nombre:=trim(nombre);

   while nombre <> '***' do
         begin
              readln(arch, n1, n2, n3);
              prom:= ((n1+n2+n3)/3);

              if prom > 4 then
                 begin
                      cond:= 'APROBADO';
                      contAp:= (contAp + 1);
                 end
              else
                  cond:= 'DESAPROBADO';

              writeln('____________________________');
              writeln(' Alumno: ',nombre);
              writeln('Promedio: ',prom:2:2 );
              writeln('Condicion: ',cond);

              contA:= (contA + 1);

              read(arch, nombre);
              nombre:=trim(nombre);

         end;

   prom:= ((contAp/contA)*100);
   writeln(' ');
   writeln('________________________________________');
   writeln('El promedio de aprobados es del ',prom:3:2,'%');


   readln();
end.
