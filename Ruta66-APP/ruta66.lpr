program ruta66;

(* Una empresa de autos de alquiler posee N vehiculos y ha registrado la siguiente informacion
 de los viajes realizados, por cada uno de ellos:
    -patentes
    -total de litros consumidos
 y por cada viaje realizado
    -km recorridos (0 indica fin de datos)

 Se pide ingresar los datos y e informar:
    a- Por cada vehiculo el consumo que tuvo (Cantidad de litros por km recorrido)
    b- patente del vehiculo que mas viajes realizo
    c- total de litros consumidos por el auto que hizo la menor cantidad de kms

 *)

uses
    Sysutils;

type
    st6=string[6];

    //Asignaciones de los arrays, de tipo real y string de 6
    VStr = array[1..50] of st6;
    VRl = array[1..50] of real;



var
    patente: VStr;
    Litros, Km: VRl;
    Op, N, posMin, posMax: byte;


//Menu de opciones del programa
procedure Menu (var Op : byte);
    begin
         Writeln(' ________________________________________');
         Writeln('|RUTA 66 - Alquiler de coches Ritman 4556|');
         Writeln('|                                        |');
         Writeln('|            MENU DE OPCIONES            |');
         Writeln('|                                        |');
         Writeln('| 1- Ingreso de datos                    |');
         Writeln('| 2- Guardado de datos en el archivo     |');
         Writeln('| 3- Informe de consumo por coche en     |');
         Writeln('|     en relacion Km/L                   |');
         Writeln('| 4- Informe del auto con mayor viajes   |');
         Writeln('| 5- L consumidos por C. menor viajes    |');
         Writeln('| 0- Exit                                |');
         Writeln('|________________________________________|');

         Repeat
           writeln(' ');
           Write('Ingrese su opcion:  ');
           readln(Op);
         until (Op>=0)And(Op<=5) ;
    end;


// 1---> Ingreso de datos a 3 vectores que se trabajaran en paralelo para un correcto manejo de los datos
procedure ingresoDatos (var patente:VStr; var Litros, Km:VRl; var N:byte);
   var
      i:byte;

      begin
           writeln;
           Write('INGRESAR CANTIDAD DE AUTOS A REGISTRAR: '); Readln(N);
           writeln;
           for i:=1 to N do
               begin
                    Writeln('Ingrese la patente');
                    readln(patente[i]);
                    Writeln('Ingrese el consumo de combustible en litros');
                    readln(Litros[i]);
                    Writeln('Ingrese la cantidad de km recorridos');
                    readln(Km[i]);
               end;

      end;


(* 2---> Guardado de los datos que contienen las matrices, de manera paralela, en un archivo
 txt, que funcione a modo de base de datos.
 Queda a incluir un procedimiento de extraccion de informacion de la 'base de datos' *)
procedure guardadoEnTxt (patente:VStr; Litros, Km:VRl; N:byte);

   var
      Arch:text;
      i:byte;
      Cadena:String;

   begin
        //Asigno por medio de una ruta relativa, el archivo se encuentra en la carpeta conteniente
        assign(Arch, 'basededatos.txt');
        //Preparo el archivo para escritura
        rewrite(Arch);

        for  i:=1 to N do
            begin
                 (* Ya que los valores de los vectores litros y km son de tipo real, para el
                 correcto cargado y la utilizacion de la variable 'cadena', utilizo la funcion
                 FloatToStr para convertir el tipo *)
                 Cadena:= patente[i]+' '+FloatToStr(Litros[i])+' '+FloatToStr(Km[i]);
                 writeln(Arch, Cadena);
            end;
        close(Arch);
        writeln('Su carga a finalizado');


   end;

//3---> Procedimiento para mostrar el informe de consumo de combustible por km
procedure KmL (patente:VStr; Litros, Km:VRl; N:byte);
   var
      i: byte;
      consumoKM: real;
   begin
      writeln(' _________________________________________');
      writeln('|Informe de consumo de combustible por Km |');
      writeln('|_________________________________________|');
      writeln(' ');

      for i:=1 to N do
          begin
               consumoKM:= (Litros[i]/Km[i]);

               writeln('Coche: ',patente[i]);
               writeln('El consumo fue de ',consumoKM:3:2);
               writeln('------------------------------------');
               writeln(' ');
          end;
   end;

//4----> Funcion para determinar la pantente del auto que mas km recorrio
Function patenteM(patente:VStr; Km:VRl; N:byte):byte;
      var
         i, maxPos:byte;
         maxKm: real;


      begin
         maxKm:=0.0;

         for i:=1 to N do
             begin
                  if Km[i] > maxKm then
                     begin
                          maxPos:= i;
                          maxKm:= Km[i];
                     end;
             end;

         patenteM:=maxPos;

      end;


//5---> Funcion para determinar el consumo en litros del auto que menos km recorrio
Function consumoMe(Litros, Km:VRl; N:byte):byte;
      var
         i, minPos:byte;
         minKm: real;

      begin
         minKm:=9999.99;

         for i:=1 to N do
             begin
                  if Km[i] < minKm then
                     begin
                          minPos:= i;
                          minKm:= Km[i];
                     end;
             end;

         consumoMe:=minPos;
      end;
begin
     Op := 1;

     While Op<>0 do
           begin
                Menu(Op);

                case Op of
                     1: ingresoDatos(patente, Litros, Km, N);
                     2: guardadoEnTxt (patente, Litros, Km, N);
                     3: KmL (patente, Litros, Km, N);
                     4: begin
                             posMax := patenteM(patente, Km, N);

                             writeln('');
                             writeln('-------------------------------------------------------------');
                             writeln('El auto con mayor cantidad de viajes es: ',patente[posMax]);
                             writeln('-------------------------------------------------------------');
                        end;
                     5: begin
                             posMin := consumoMe(Litros, Km, N);

                             writeln('');
                             writeln('-------------------------------------------------------------');
                             writeln('El consumo en litros del menor recorrido es: ',Litros[posMin]:3:2);
                             writeln('-------------------------------------------------------------');
                        end;
                end;
           end;

end.

