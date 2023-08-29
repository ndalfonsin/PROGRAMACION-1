program homebanking;

(* Se conoce el saldo inicial de una cuenta bancaria y una serie de movimientos realizados
      -codigo de movimiento(D=deposito, R=retiro, F=fin)
      -monto

Escribir un programa que ingrese dichos datos y determine el saldo exacto de la cuenta
despues de procesar las transacciones. Al final del proceso indique cuantas veces no pudo retirar dinero
por insuficiencia de fondos.
   *)

Var
  cod, conf: char;
  depMon, retMon, monto: longint;
  insfcont : byte;

begin

  //Inicializacion de variables y contadores
  depMon :=0;
  retMon :=0;
  insfcont :=0;

  //validacion de monto de entrada
  repeat
        writeln('Ingrese el monto inicial con el que va a operar su gestor de movimientos bancarios');
        readln(monto);
        writeln('Ha ingresado un monto total de $',monto);
        writeln('Es correcto?... [S/N]');
        readln(conf);
        conf :=Upcase(conf);
  until (monto > 0) and (conf = 'S');

  writeln(' ');
  writeln('|-------------------------------------------------|');
  writeln('  Bienvenido a su gestor de movimientos bancarios!');
  writeln('|-------------------------------------------------|');


  //control de repeticion del programa
  repeat
        writeln('');
        writeln('Monto total de $',monto);
        writeln('');
        writeln('Que accion desea realizar? [D]Deposito, [R]Retiro, [F]salir');
        readln(cod);
        cod := Upcase(cod);
        writeln('');

        //Verificador de acciones
        if cod = 'D' then
           begin
             //validacion del deposito
             repeat
                   writeln('Cuantos pesos desea depositar?');
                   readln(depMon);
             until depMon > 0;

             //Salida de deposito
             monto := (monto + depMon);
             writeln('');
             writeln('Su nuevo monto total es $',monto);
           end
        else if cod = 'R' then
           begin
             //validacion del retiro
             repeat
                   writeln('Cuantos pesos desea retirar?');
                   readln(retMon);

                   if retMon > monto then
                      begin
                           //Suma al contador de fondos insuficientes
                           insfcont := (insfcont + 1);
                           writeln('');
                           //Mensaje de error
                           writeln('ERROR: saldo insuficiente, se agregara al informe');
                      end;
             until (retMon > 0) and (retMon < monto);

             //Salida del retiro
             monto := (monto-retMon);
             writeln('');
             writeln('Su nuevo monto total es $',monto);
           end
        else if cod = 'F' then
           begin
                writeln('');
                writeln('Hasta luego, se le generara la salida de informes de datos');
           end
        else
           begin
                writeln('');
                writeln('HaD ingresado un dato incorrecto');
           end;

  until cod = 'F';

  writeln('');
  writeln('Han ocurrido un total de ',insfcont:2,' Registros de saldo insuficiente');
  writeln('Saldo final en cuenta: $',monto);
  readln();


end.

