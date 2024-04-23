{ La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio web
de la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se
realizan al sitio. La información que se almacena en el archivo es la siguiente: año, mes, día,
idUsuario y tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado
por los siguientes criterios: año, mes, día e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará
el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato
mostrado a continuación:
	Año : ---
	Mes:-- 1
	día:-- 1
	idUsuario 1 Tiempo Total de acceso en el dia 1 mes 1
	--------
	idusuario N Tiempo total de acceso en el dia 1 mes 1
	Tiempo total acceso dia 1 mes 1
	-------------
	día N
	idUsuario 1 Tiempo Total de acceso en el dia N mes 1
	--------
	idusuario N Tiempo total de acceso en el dia N mes 1
	Tiempo total acceso dia N mes 1
	Total tiempo de acceso mes 1
	------
	Mes 12
	día 1
	idUsuario 1 Tiempo Total de acceso en el dia 1 mes 12
	--------
	idusuario N Tiempo total de acceso en el dia 1 mes 12
	Tiempo total acceso dia 1 mes 12
	-------------
	día N
	idUsuario 1 Tiempo Total de acceso en el dia N mes 12
	--------
	idusuario N Tiempo total de acceso en el dia N mes 12
	Tiempo total acceso dia N mes 12
	Total tiempo de acceso mes 12
	Total tiempo de acceso año
Se deberá tener en cuenta las siguientes aclaraciones:
● El año sobre el cual realizará el informe de accesos debe leerse desde el teclado.
● El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año
no encontrado”.
● Debe definir las estructuras de datos necesarias.
● El recorrido del archivo debe realizarse una única vez procesando sólo la información
necesaria.
}


program untitled;
const
	valor_alto = 9999;
type
	usuario = record
		ano : integer;
		mes : integer;
		dia : integer;
		id : integer;
		tiempo : real;
	end;
	
procedure leer(var mae : text;var dato : usuario);
begin
	if(not eof(mae)) then read(mae,dato.ano,dato.mes,dato.dia,dato.id,dato.tiempo)
	else dato.ano := valor_alto;
end;

procedure recorrerAno(var mae : text;regm : usuario;ano : integer);
var
	mes_actual,dia_actual : integer;
	tiempo_total_dia,tiempo_total_mes,tiempo_total : real;
begin
	writeln('Ano: ',regm.ano);
	tiempo_total := 0;
	while(regm.ano <> valor_alto) and (regm.ano = ano)do
	begin
		tiempo_total_mes := 0;
		mes_actual := regm.mes;
		writeln('	Mes: ', regm.mes);
		while(mes_actual = regm.mes) and (regm.ano <> valor_alto) and (regm.ano = ano)do
		begin
			dia_actual := regm.dia;
			writeln('		Dia: ',regm.dia);
			tiempo_total_dia := 0;
			while(dia_actual = regm.dia) and (mes_actual = regm.mes) and (regm.ano <> valor_alto) and (regm.ano = ano)do
			begin
				writeln('			IdUsuario: ',regm.id,' Tiempo total de acceso en el dia ',dia_actual,' mes ',mes_actual,': ',regm.tiempo);
				tiempo_total_dia := tiempo_total_dia + regm.tiempo;
				leer(mae,regm);
			end;
			writeln('		Tiempo total dia ',dia_actual,' mes ',mes_actual,': ',tiempo_total_dia); 
			tiempo_total_mes := tiempo_total_mes + tiempo_total_dia;
		end;
		writeln('	Tiempo total mes ',mes_actual,': ',tiempo_total_mes);
		tiempo_total := tiempo_total + tiempo_total_mes;
	end;
	writeln('Tiempo total del ano: ', tiempo_total);
end;

procedure verificarAno(var mae : text;ano : integer);
var
	dato : usuario;
begin
	reset(mae);
	leer(mae,dato);
	while(not eof(mae)) and (ano<>dato.ano)do leer(mae,dato);
	if(dato.ano <> ano)then writeln('No se encontro el ano')
	else recorrerAno(mae,dato,ano);
end;
var
	mae : text;
	ano : integer;
BEGIN
	assign(mae,'ejer11pract2mae.txt');
	writeln('Ingrese el ano a buscar: ');
	readln(ano);
	verificarAno(mae,ano);
END.

