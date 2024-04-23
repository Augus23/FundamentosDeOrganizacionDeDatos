{Se desea modelar la información necesaria para un sistema de recuentos de casos de covid
para el ministerio de salud de la provincia de buenos aires.
Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad de
casos activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad de casos activos, cantidad de casos
nuevos, cantidad de recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).}

program untitled;
uses sysutils;
const
	valor_alto = 9999;
type
	casos_covid_mae = record
		cod_localidad : integer;
		nombre_localidad : string;
		cod_cepa : integer;
		nombre_cepa : string;
		cant_activos : integer;
		cant_nuevos : integer;
		cant_recu : integer;
		cant_falle : integer;
	end;
	
	casos_covid = record
		cod_localidad : integer;
		cod_cepa : integer;
		cant_activos : integer;
		cant_nuevos : integer;
		cant_recu : integer;
		cant_falle : integer;
	end;
	
	maestro = file of casos_covid_mae;
	detalle = file of casos_covid;
	arc_detalle = array[1..10] of detalle;
	reg_detalle = array[1..10] of casos_covid;

procedure leer(var det : detalle;var dato : casos_covid);
begin
	if(not eof(det)) then read(det,dato)
	else dato.cod_localidad := valor_alto;

procedure minimo(var vec_det : arc_detalle;var vec_reg : reg_detalle;var min : casos_covid);
var
	i,pos : integer;
begin
	min := vec_reg[1];
	for i:=2 to 10 do
	begin
		if ((vec_reg[i].cod_localidad < min.cod_localidad) or ((vec_reg[i].cod_localidad = min.cod_localidad) and (vec_reg[i].cod_cepa < min.cod_cepa)))then
		begin
			min := vec_reg[i];
			pos := i;
		end;
	end;
	leer(vec_det[pos],vec_reg[pos]);
end;

procedure inicializarDetalles(var vec_det : arc_detalle);
var
	i : integer;
begin
	for i:=1 to 10 do
	begin
		assign(vec_det[i],'ejer7pract2'+i.tostring()+'.dat');
		rewrite(vec_det[i]);
	end;
end;

procedure cargarRegistros(var vec_det : arc_detalle;var vec_reg : reg_detalle);
var
	i : integer;
begin
	for i := 1 to 10 do
	begin
		leer(vec_det[i],vec_reg[i]);
	end;
end;

procedure actualizarMae(var vec_det : arc_detalle;var mae : maestro);
var
	regm : casos_covid_mae;
	vec_reg : reg_detalle;
	min : casos_covid;
	loc_actual,cepa_actual,muertos,nuevos,activos,cant : integer;
begin
	cargarRegistros(vec_det,vec_reg);
	minimo(vec_det,vec_reg,min);
	read(mae,regm);
	while(min.cod_localidad <> valo_alto)do
	begin
		loc_actual := min.cod_localidad;
		while(loc_actual = min.cod_localidad)do
		begin
			cepa_actual := min.cod_cepa;
			cant:=0;
			muertos:=0;
			nuevos:=0;
			actvios:=0;
			while(cepa_actual = min.cod_cepa) and (loc_actual = min.cod_localidad) do
			begin
				activos := activos + min.cant_activos;
				muertos := muertos + min.cant_falle;
				nuevos := nuevos + min.cant_nuevos;
				recu := recu + min.cant_recu;
				minimo(vec_det,vec_reg,min);
			end;
			while(regm.cod_localidad <> loc_actual) or (regm.cod_cepa <> cepa_actual) do read(mae,regm);
			regm.cant_activos := regm.cant_activos;
			regm.cant_falle := regm.cant_falle + muertos;
			regm.cant_nuevos := regm.cant_nuevos;
			regm.cant_recu := regm.cant_recu + recu;
			seek(mae,filepos(mae)-1);
			write(mae,regm);
		end;
	end;
	close(mae);
end;

var
	vec_det : arc_detalle;
	mae : maestro;
BEGIN
	
	
END.

