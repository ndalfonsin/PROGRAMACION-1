program practica;
    {
        • Piso (1..N)          -|  matriz edificio
        • Departamento (1..6)  _|
        
        • Apellido del ocupante responsable (cadena de 12)
        • Categoría (cadena de 3, referencia en archivo CATEGORIAS.TXT)
        • Cantidad de ocupantes del departamento
        • Propietario (S/N) 
    }

const
    departamentos=6;
type 
    Str12 = String[12];
    Str3 = String[3];

    TregC = Record
        Cod: Str3;
        Tipo: Str12;
        Monto: real;
    end;

    TregP = Record  
        Apellido: Str12;
        Categoria: TregC;
        Ocupantes: byte;
        Propietario: char;
    end; 
    
    TM = Array[1..10,1..6] of TregP;
    TV = Array[1..3] of TregC;

Function buscaTipo(Ccod: Str3; Vcat: TV):byte;
    var
        i:byte;

    begin
        i:= 1;

        while Ccod <> Vcat[i].Cod do
            i:= i + 1;
        
        buscaTipo:=i;
    end;

Procedure iniciarMatriz (var MEdificio:TM; pisos:byte);
    const
        num = 0;
        str = ' ';
    var 
        i,j: byte;
    begin
        for i:=1 to pisos do
            begin
                for j:=1 to departamentos do
                    begin
                        MEdificio[i,j].Apellido:=str;
                        MEdificio[i,j].Categoria.Cod:=str;
                        MEdificio[i,j].Categoria.Tipo:=str;
                        MEdificio[i,j].Categoria.Monto:=num;
                        MEdificio[i,j].Ocupantes:=num;
                        MEdificio[i,j].Propietario:=str;
                    end;
            end;
    end;

Procedure creaEdificio(var MEdificio:TM; var pisos:byte);
    var
        Aocup, Acat: text;
        fila, colum, N, i: byte;
        Aux:char;
        Ccod: Str3;
        Vcat : TV; 

    begin
        Assign(Aocup, 'ocupantes.txt');
        Assign(Acat, 'categorias.txt');
        Reset(Aocup);
        Reset(Acat);
        N:= 0;

        while not EOF(Acat) do
            begin
                N:=N+1;
                readln(Acat, Vcat[N].Cod, Aux, Vcat[N].Tipo, Vcat[N].Monto);
            end;

        readln(Aocup, pisos);
        iniciarMatriz(MEdificio, pisos);

        while not EOF(Aocup) do
            begin
                readln(Aocup, fila, colum, MEdificio[fila,colum].Apellido, Ccod, MEdificio[fila,colum].Ocupantes,Aux,MEdificio[fila,colum].Propietario);
                i:= buscaTipo(Ccod, Vcat);
                MEdificio[fila, colum].Categoria.Cod := Ccod;
                MEdificio[fila, colum].Categoria.Tipo := Vcat[i].Tipo;
                MEdificio[fila, colum].Categoria.Monto := Vcat[i].Monto;
            end;        

        close(Aocup);
        close(Acat)
    end;



var
    MEdificio : TM;
    pisos: byte;

begin
    
    creaEdificio(MEdificio, pisos);
    readln;
end.
    



