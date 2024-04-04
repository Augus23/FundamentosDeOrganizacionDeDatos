{
  Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
	cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
	(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
	un archivo detalle con el código de alumno e información correspondiente a una materia
	(esta información indica si aprobó la cursada o aprobó el final).
	Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
	haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
	programa con opciones para:
	a. Actualizar el archivo maestro de la siguiente manera:
	i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado,
	y se decrementa en uno la cantidad de materias sin final aprobado.
	ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
	final.
	b. Listar en un archivo de texto aquellos alumnos que tengan más materias con finales
	aprobados que materias sin finales aprobados. Teniendo en cuenta que este listado
	es un reporte de salida (no se usa con fines de carga), debe informar todos los
	campos de cada alumno en una sola línea del archivo de texto.
	NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.
}


program untitled;

const

	valor_alto = 'zzzz';

type

	alumno = record
		cod : string; 
		apellido : string;
		nombre : string;
		cant_materias : integer;
		cant_finales : integer;
	end;
	
	detalumno = record
		cod : string;
		aprobado : string;
	end;
	
	maestro = file of alumno;
	detalle = file of detalumno;
	
procedure leer(var archivo : detalle;var dato : detalumno);
begin
    if(not EOF(archivo))then read(archivo,dato)
    else dato.cod := valor_alto;
end;

procedure ejerA(var mae : maestro;var det : detalle);
var
	regm : alumno;
	regd : detalumno;
	cod_actual : string;
	finales,cursada : integer;
begin	
	read(mae,regm);
	leer(det,regd);
	while (regd.cod <> valor_alto)do
	begin
		cod_actual := regd.cod;
		finales := 0;
		cursada :=0;
		while(regd.cod = cod_actual)do
		begin
			if(regd.aprobado  = 'final')then
			begin
				finales := finales + 1;
			end
			else if(regd.aprobado = 'cursada') then cursada := cursada +1; 
			leer(det,regd);
		end;
		while(regm.cod <> cod_actual) do
        begin
            read(mae,regm);
        end;
		regm.cant_materias := regm.cant_materias + cursada;
		regm.cant_finales := regm.cant_finales + finales;
		while((regm.cant_materias > 0) and (finales > 0)) do
		begin
			regm.cant_materias := regm.cant_materias - 1;
			finales := finales - 1;
		end;
		seek(mae,filepos(mae)-1);
		write(mae,regm);
		if(not eof(mae)) then read(mae,regm);
	end;
	close(mae);
	close(det);
end;

procedure imprimirMae(var mae : maestro);
var
	regm : alumno;
begin
	while(not eof(mae))do
	begin
		read(mae,regm);
		writeln('Alumno ',regm.nombre,' ',regm.apellido,' codigo ',regm.cod,' cant cursadas ', regm.cant_materias,' cant finales ', regm.cant_finales);
	end;
	close(mae);
end;

procedure ejerB(var mae : maestro;var archivo_texto : text);
var
	regm : alumno;
begin
	assign(archivo_texto,'ejer2texto.txt');
	rewrite(archivo_texto);
	while(not eof(mae)) do
	begin
		read(mae,regm);
		if(regm.cant_finales > regm.cant_materias) then
		begin
			with regm do writeln(archivo_texto,cod,' ',nombre,' ',apellido,' ',cant_materias,' ',cant_finales);
		end;
	end;
	close(archivo_texto);
	close(mae);
end;

var 

	mae : maestro;
	det : detalle;
	menu : integer;
	txt : text;

BEGIN
	assign(mae,'ejer2mae.dat');
	assign(det,'ejer2det.dat');
	{rewrite(mae);
	rewrite(det);
	regm.cod := '1';
    regm.nombre := 'augus';
    regm.apellido := 'laguna';
    regm.cant_materias := 0;
    regm.cant_finales := 0;
    write(mae,regm);
    regm.cod := '2';
    regm.nombre := 'mate';
    regm.apellido := 'pascu';
    regm.cant_materias := 0;
    regm.cant_finales := 0;
    write(mae,regm);
    regm.cod := '3';
    regm.nombre := 'juan';
    regm.apellido := 'roche';
    regm.cant_materias := 0;
    regm.cant_finales := 0;
    write(mae,regm);
    regm.cod := '4';
    regm.nombre := 'massi';
    regm.apellido := 'kaleb';
    regm.cant_materias := 0;
    regm.cant_finales := 0;
    write(mae,regm);

    regd.cod := '1';
    regd.aprobado := 'cursada';
    write(det,regd);
    regd.cod := '1';
    regd.aprobado := 'cursada';
    write(det,regd);
    regd.cod := '2';
    regd.aprobado := 'final';
    write(det,regd);
    regd.cod := '2';
    regd.aprobado := 'final';
    write(det,regd);
    regd.cod := '4';
    regd.aprobado := 'cursada';
    write(det,regd);
    regd.cod := '4';
    regd.aprobado := 'cursada';
    write(det,regd);
    regd.cod := '4';
    regd.aprobado := 'final';
    write(det,regd);}
	writeln('Que desea hacer?');
	writeln('1. Actualizar archivo maestro');
	writeln('2. Listar en archivo de texto alumnos que tengan mas cursada que finales aprobados');
	readln(menu);	
	reset(mae);
	reset(det);
	case menu of
		1: ejerA(mae,det);
		2: ejerB(mae,txt);
	end;
	reset(mae);
	imprimirMae(mae);
END.

