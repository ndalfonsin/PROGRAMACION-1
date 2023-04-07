program LiquidacionSueldos;

(*
Liquidacion de sueldo de N empleados. Todos parten de $15000, por antiguedad:
              Hasta 5 -> 5%
              De 6 a 10 -> 8%
              De 11 a 15 -> 12%
              Mas de 15 -> 20%
Ademas se descuenta 11% por cargas sociales y $500 pesos por seguro obligatorio

Objetivos:
          Nombre y sueldo de cada empleado
          Nombre del empleado que mas cobra (suponer que es unico)
          Monto del sueldo promedio

Ruta del txt ->   C:\Usuarios\nicob\INGE\PROGRAMACION1\TP3\EJ2\empleados.txt
 *)

var
  Arch : Text;
  N, Ant, i : integer;
  Nombre, Apellido, Nmax, Amax: string[10];
  SueldoTot, SueldoBrut, acumS, MaxS, SueldoProm: real;

const
  A1 = 1.05;
  A2 = 1.08;
  A3 = 1.12;
  A4 = 1.20;
  SueldoB = 15000;
  CargS = 0.89;
  seg = 500;


begin
     //Asignacion del archivo de texto con la informacion de los empleados
     Assign(Arch, 'C:\Users\nicob\INGE\PROGRAMACION1\TP3\EJ2\empleados.txt');
     //Reseteo de lectura del archivo
     Reset(Arch);

     //Inicializacion de acumuladores
     acumS := 0;
     MaxS := 0;

     readln(Arch, N);

     (* Realizacion de un ciclo para determinar los datos y realizar los
     calculos de sueldos de cada empleado *)
     for i:= N downto 1 do
         begin
              readln(Arch, Nombre, Apellido, Ant);

              //Evaluacion de Antiguedad para aplicar el Plus
              case Ant of
                   0..5 : SueldoTot:= (SueldoB * A1);
                   6..10: SueldoTot:= (SueldoB * A2);
                   11..15: SueldoTot:= (SueldoB * A3);
              end;

              if Ant > 15 then
                 SueldoTot:= (SueldoB * A4);

              SueldoTot:= ((SueldoTot*CargS)-Seg);

              //Analisis y guardado de el empleado con mayor sueldo
              //Se utiliza >= ya que la condicion del ej es que sea uno solo
              if SueldoTot >= MaxS then
                 begin
                      MaxS :=MaxS;
                      Nmax :=Nombre;
                      Amax :=Apellido;
                 end;

              //Acumulador de sueldos
              AcumS:= (AcumS+SueldoTot);

              Writeln('Nombre: ',Nombre);
              Writeln('Apellido: ',Apellido);
              Writeln('Antiguedad: ',Ant);
              Writeln('Sueldo: $',SueldoTot:8:2);
              Writeln(' ');
         end;

     //Calculo de sueldos promedio
     SueldoProm:= (AcumS/N);
     Writeln('El sueldo promedio es de $',SueldoProm:8:2);


     //Empleado que mas cobra
     writeln('El empleado que mas sueldo cobra es ',Nmax,' ',Amax);
     Writeln('Su sueldo es de $',MaxS:8:2);

     Close(Arch);
     Readln();



end.

