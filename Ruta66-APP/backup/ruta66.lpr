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


    Parto de una hipotesis de tener unicamente 6 autos en alquiler, que las patentes
    tienen el formato de 6 digitos alfanumericos, Por ultimo se utilizara un archivo
    de tipo texto como un simulador de almacenado de datos cargados, para mantener un
    registro tras la utilizacion diaria del programa.
 *)
uses
       Sysutils;
type
    st6=string[6];

    VStr = array[1..3] of st6;
    VRl = array[1..3] of real;

var
    patente: VStr;
    Litros, Km: VRl;
    Op: byte;



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
           Write('Ingrese su opcion:  ');
           readln(Op);
         until (Op>=0)And(Op<=5) ;
    end;

procedure ingresoDatos (var patente:VStr; var Litros:VRl; var Km:VRl);
   var
      i:byte;

      begin
           Writeln(Upcase('El ingreso de datos se realizara de a uno por campo'));
           for i:=1 to 3 do
               begin

                    Writeln('Ingrese la patente');
                    readln(patente[i]);
                    Writeln('Ingrese el consumo de combustible en litros');
                    readln(Litros[i]);
                    Writeln('Ingrese la cantidad de km recorridos');
                    readln(Km[i]);
               end;

      end;

procedure guardadoEnTxt (patente:VStr; Litros:VRl; Km:VRl);

   var
      Arch:text;
      i:byte;
      Cadena:String;

   begin
        assign(Arch, 'basededatos.txt');
        rewrite(Arch);

        for  i:=1 to 3 do
            begin
                 Cadena:= patente[i]+' '+FloatToStr(Litros[i])+' '+FloatToStr(Km[i]);
                 writeln(Arch, Cadena);
            end;
        close(Arch);
        writeln('Su carga a finalizado');


   end;

begin
     Op := 1;

     While Op<>0 do
           begin
                Menu(Op);

                case Op of
                     1: ingresoDatos(patente, Litros, Km);
                     2: guardadoEnTxt (patente, Litros, Km);
                end;
           end;
end.
