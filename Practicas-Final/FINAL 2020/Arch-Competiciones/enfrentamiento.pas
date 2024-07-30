program enfrentamiento;
{La Federación de Fórmula 1 tiene registrado en un archivo CARRERAS toda la 
información acerca de las carreras en los últimos años, las escuderías que 
intervinieron y todos sus pilotos. Además se cuenta con un archivo PILOTOS 
que contiene los datos de los 50 mejores pilotos que participaron en las mismas.

Generar el siguiente listado:
Carreras

Fecha: 9999/99/99
Escudería      (*)Mejor Piloto  		 Puesto	    Tiempo    Superó marca personal 	
XXXXXXX	XXXXXXXXX	  99	     99.99		 si/no			
XXXXXXX	XXXXXXXXX	  99	     99.99		 si/no      		
...		 ...			   ...	     …..			   ...			
Cantidad  de pilotos que abandonaron  99  

Fecha: 9999/99/99
Escudería	Mejor Piloto   		Puesto	    Tiempo    Superó marca personal 	 
XXXXXXX	XXXXXXXXX	  99	     99.99		 si/no			
XXXXXXX	XXXXXXXXX	  99	     99.99		 si/no      		
...		 ...			   ...   	      .....			   ...	
Cantidad de pilotos que abandonaron  99

La Escudería XXXXXXXX con su piloto: XXXXXXXX hizo el mejor tiempo

Listado de escuderías con cantidad de podios 
	   Escudería        Podios
	   XXXXXXX         99   
	   XXXXXXX         99    
	    ………	     …… 
	    TOTAL          999

}

type
    ANUFech = string[10];
    Tnombre = string[20];

    {tr -> Tipo Registro}
    {ta -> Tipo Archivo}

    trCarreras = record
        fecha: ANUFech; {AAAA/MM/DD}
        esc, cod_pil, puesto: byte;
        tiempo: real;
    end;

    trEsc = record
        cod_esc: byte;
        nombre: Tnombre;
    end;

    trPil = record
        cod_pil: byte;
        nombre: Tnombre;
        mej_tiempo: real;
    end;

    taCarreras = file of trCarreras;
    taEsc = file of trEsc;
    taPil = file of trPil;

Procedure cargaCarreras(var carreras: taCarreras);
    var
        arch: text;
        auxR: trCarreras;
    begin
        Assign(arch, 'carreras.txt');
        Assign(carreras, 'carreras.dat');
        Reset(arch);
        Rewrite(carreras);

        while not EOF(arch) do
            begin
                readln(arch, auxR.fecha, auxR.esc, auxR.cod_pil, auxR.puesto, auxR.tiempo);
                writeln('Carga:', auxR.fecha,' ', auxR.esc,' ', auxR.cod_pil,' ', auxR.puesto,' ', auxR.tiempo);
                write(carreras, auxR);
            end;

        Close(carreras);
        Close(arch);
    end;

Procedure cargaEscuderias(var escuderias: taEsc);
    var
        arch: text;
        auxR: trEsc;
    begin
        Assign(arch, 'escuderias.txt');
        Assign(escuderias, 'escuderias.dat');
        Reset(arch);
        Rewrite(escuderias);

        while not EOF(arch) do
            begin
                readln(arch, auxR.cod_esc, auxR.nombre);
                writeln('Carga: ', auxR.cod_esc, ' ', auxR.nombre);
                write(escuderias, auxR);
            end;
        
        Close(arch);
        Close(escuderias);
    end;

Procedure cargaPilotos(var pilotos: taPil);
    var
        arch: text;
        auxR: trPil;
    begin
        Assign(arch, 'pilotos.txt');
        Assign(pilotos, 'pilotos.dat');
        Reset(arch);
        Rewrite(pilotos);

        while not EOF(arch) do
            begin
                readln(arch, auxR.cod_pil, auxR.nombre);
                readln(arch, auxR.mej_tiempo);
                writeln('Carga: ', auxR.cod_pil, ' ', auxR.nombre, ' ', auxR.mej_tiempo);
                write(pilotos, auxR);
            end;
        
        Close(arch);
        Close(pilotos);
    end;

Procedure enfrentamiento(var carreras: taCarreras; var pilotos: taPil; var escuderias: taEsc);
    var
        fecha: ANUFech;
        abandonos, ind_mej_esc, ind_mej_tiempo: byte; {nro de piloto, clave primaria}
        auxRc, auxRcMej, auxRcomp: trCarreras;
        auxRp: trPil;
        auxRe: trEsc;

        {Datos x fecha:
            -fecha
            -X escuderia
                -escuderia -> ESCUDERIA DE ANALISIS EN LA FECHA
                -mej_escud -> el mejor de la escuderia dentro de la fecha COD_PIL
                -mej_puesto_esc -> el puesto del mejor de la escuderia en la fecha
                -mej_tiempo_esc -> el tiempo del mejor de la escuderia en la fecha
            -abandonos
        Generales
            ind_mej_tiempo: el piloto que hizo el mejor tiempo

            }
    begin
        Assign(carreras, 'carreras.dat');
        Assign(pilotos, 'pilotos.dat');
        Assign(escuderias, 'escuderias.dat');
        Reset(carreras);
        Reset(escuderias);
        Reset(pilotos);
        
        writeln('----------- Carreras -----------');

        read(carreras, auxRc);
        auxRcomp:= auxRc;

        
        while auxRc.fecha <> 'XXXX/XX/XX' do
            begin
                if auxRc.puesto <> 99 then
                    abandonos:= 0
                else
                    abandonos:= 1;
                        
                fecha:= auxRc.fecha;
                writeln('Fecha: ',fecha);
                writeln('ESCUDERIA | Mejor Piloto | Puesto | Tiempo | Sup Marca Per');
                {Tomo como que la lectura del mejor piloto es la primer asignacion para hacer 
                la comparacion}
                while not (fecha <> auxRc.fecha) do
                    begin
                        
                        auxRcMej:= auxRc;
                        read(carreras, auxRc);
                        
                        while (fecha = auxRc.fecha) and (auxRcMej.esc = auxRc.esc) and (auxRc.tiempo <> 99) do
                            begin
                                if (auxRc.tiempo < auxRcMej.tiempo) then
                                    auxRcMej:= auxRc;

                                if auxRc.puesto = 99 then
                                    abandonos:= abandonos + 1;
                                 
                                if auxRcomp.tiempo > auxRc.tiempo then
                                    auxRcomp:= auxRc;
                                
                                read(carreras, auxRc);
                            end;
                        
                        
                        seek(carreras, Filepos(carreras) - 1);
                        seek(escuderias, auxRcMej.esc - 1);
                        seek(pilotos, auxRcMej.cod_pil -1);
                        read(escuderias, auxRe);
                        read(pilotos, auxRp);
                        write(auxRe.nombre, ' | ');
                        write(auxRp.nombre, ' | ');
                        write(auxRcMej.puesto,' | ');
                        write(auxRcMej.tiempo:3:2, ' | ');
                        if auxRcMej.tiempo < auxRp.mej_tiempo then
                            write('    SI   ')
                        else
                            write('    NO   ');
                        writeln;
                    end;
                read(carreras, auxRc);
                writeln('Cantidad de abandonos: ', abandonos);
                writeln();
            end;
        seek(escuderias, auxRcomp.esc - 1);
        seek(pilotos, auxRcomp.cod_pil -1);
        read(escuderias, auxRe);
        read(pilotos, auxRp);
        writeln('La escuderia ', auxRe.nombre, ' con su piloto: ', auxRp.nombre, ' hizo el mejor tiempo');
        
        Close(carreras);
        Close(escuderias);
        Close(pilotos);
    end;
var
    carreras: taCarreras;
    escuderias: taEsc;
    pilotos: taPil;
begin
    //cargaCarreras(carreras);
    // cargaEscuderias(escuderias);
    // cargaPilotos(pilotos);
    enfrentamiento(carreras, pilotos, escuderias);


end.



