{
   Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma fue
	construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
	máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
	archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
	cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
	cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
	detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
	tiempo_total_de_sesiones_abiertas.
	Notas:
	● Cada archivo detalle está ordenado por cod_usuario y fecha.
	● Un usuario puede iniciar más de una sesión el mismo día en la misma máquina, o
	inclusive, en diferentes máquinas.
	● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.

}
program untitled;
uses sysutils;
const
	valor_alto = '9999';
	DF = 5;
type
	sesion = record
		cod_usuario : string;
		fecha : string;
		tiempo : integer;
	end;
	
	maestro = file of sesion;
	
	detalle = file of sesion;
	
	arc_detalle = array[0..DF-1] of detalle;
	reg_detalle = array[0..DF-1] of sesion;

procedure leer(var det : detalle;var dato : sesion);
begin
	if(not eof(det)) then read(det,dato)
	else dato.cod_usuario := valor_alto;
end;

procedure inicializarDetalles(var vec_det : arc_detalle);
var
	i:integer;
begin
	for i:=0 to DF-1 do
	begin
		assign(vec_det[i],'ejer6pract2det'+i.tostring()+'.dat');	
		rewrite(vec_det[i]);
	end;
end;

procedure cerrarDetalles(var vec_det : arc_detalle);
var
	i : integer;
begin
	for i:=0 to DF-1 do
	begin
		close(vec_det[i]);
	end;
end;

procedure cargarRegistros(var vec_det : arc_detalle;var vec_reg : reg_detalle);
var
	i : integer;
begin
	for i:=0 to DF-1 do
	begin
		leer(vec_det[i],vec_reg[i]);
	end;
end;

procedure minimo(var vec_det : arc_detalle;var vec_reg : reg_detalle;var min : sesion);
type
	tminimo = record
		indice : integer;
		codigo : string;
	end;
var
	minimo : tminimo;
	i : integer;
begin
	minimo.codigo := valor_alto;
	minimo.indice := 0;	
	for i:= 0 to DF-1 do
	begin
		if (vec_reg[i].cod_usuario < minimo.codigo) then
		begin
			minimo.codigo := vec_reg[i].cod_usuario;
			minimo.indice := i;
		end;
	end;
	min := vec_reg[minimo.indice];
	leer(vec_det[minimo.indice],vec_reg[minimo.indice]);
end;

procedure actualizarMae(var vec_det : arc_detalle;var mae : maestro);
var
	min,regm : sesion;
	vec_reg : reg_detalle;
begin
	cargarRegistros(vec_det,vec_reg);
	minimo(vec_det,vec_reg,min);
	while(min.cod_usuario<>valor_alto) do
	begin
		regm.cod_usuario := min.cod_usuario;
		while(regm.cod_usuario = min.cod_usuario)do
		begin
			regm.fecha := min.fecha;
			regm.tiempo := 0;
			while(regm.fecha = min.fecha) and (regm.cod_usuario = min.cod_usuario)do
			begin
				regm.tiempo := regm.tiempo + min.tiempo;
				minimo(vec_det,vec_reg,min);
			end;
			write(mae,regm);
		end;		
	end;
	close(mae);
	cerrarDetalles(vec_det);
end;

procedure imprimirMae(var mae : maestro);
var
	regm : sesion;
begin
	while(not eof(mae)) do
	begin
		read(mae,regm);
		with regm do writeln(cod_usuario,' ',fecha,' ',tiempo);
	end;
	close(mae);
end;

var
	mae : maestro;
	deta : arc_detalle;
	regd : sesion;
BEGIN
	assign(mae,'ejer6pract2mae.dat');
	inicializarDetalles(deta);
	regd.cod_usuario := '1';
	regd.fecha := '01-01-2024';
	regd.tiempo := 5;
	write(deta[0],regd);
	regd.cod_usuario := '1';
	regd.fecha := '01-01-2024';
	regd.tiempo := 5;
	write(deta[0],regd);
	
	regd.cod_usuario := '1';
	regd.fecha := '01-02-2024';
	regd.tiempo := 5;
	write(deta[0],regd);
	
	regd.cod_usuario := '2';
	regd.fecha := '01-01-2024';
	regd.tiempo := 5;
	write(deta[0],regd);
	reset(deta[0]);
	rewrite(mae);
	actualizarMae(deta,mae);
	reset(mae);
	imprimirMae(mae);
END.

