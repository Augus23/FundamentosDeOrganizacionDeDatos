{
	A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
	archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
	alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
	agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
	localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos
	necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
	NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
	pueden venir 0, 1 ó más registros por cada provincia
}


program untitled;
const
	valor_alto = 'zzzz';
type
	
	alfabetizacion = record
		provincia : string;
		cant : integer;
		total : integer;
	end;
	
	agencia = record
		provincia : string;
		localidad : string;
		calt_alfa : integer;
		total : integer;
	end;
	
	maestro = file of alfabetizacion;
	detalle = file of agencia;

procedure leer(var det : detalle;var dato : agencia);
begin
	if(not eof(det)) then read(det,dato)
	else dato.provincia := valor_alto;
end;

procedure minimo(var r1,r2 : agencia ; var min : agencia; var det1,det2 : detalle);
begin
	if (r1.provincia < r2.provincia)then
	begin
		min := r1;
		leer(det1,r1);
	end
	else
	begin
		min := r2;
		leer(det2,r2);
	end
end;

procedure actualizarMae(var mae : maestro;var det1 : detalle;var det2 : detalle);
var
	regm : alfabetizacion;
	regd1,regd2,min : agencia;
	cod_provincia : string;
	total_encuestados, total_alfabetizados : integer;
begin
	read(mae,regm);
	leer(det1,regd1);
	leer(det2,regd2);
	minimo(regd1,regd2,min,det1,det2);
	while(min.provincia <> valor_alto)do
	begin
		cod_provincia := min.provincia;
		total_encuestados := 0;
		total_alfabetizados := 0;
		while(min.provincia = cod_provincia)do
		begin
			total_encuestados := min.total;
			total_alfabetizados := min.calt_alfa;
			minimo(regd1,regd2,min,det1,det2);
		end;
		while(regm.provincia <> cod_provincia)do read(mae,regm);
		regm.cant := regm.cant + total_alfabetizados;
		regm.total := regm.total + total_encuestados;
		seek(mae,filepos(mae)-1);
		write(mae,regm);
		if(not eof(mae)) then read(mae,regm);
	end;
end;

var
	mae : maestro;
	det1,det2 : detalle;

BEGIN
	assign(mae,'pract2ejer4mae.dat');
	assign(det1,'pract2ejer4det1.dat');
	assign(det2,'pract2ejer4det2.dat');
	reset(mae);
	reset(det1);
	reset(det2);
	actualizarMae(mae,det1,det2);
END.

