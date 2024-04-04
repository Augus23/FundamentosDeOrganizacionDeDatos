{
   El encargado de ventas de un negocio de productos de limpieza desea administrar el stock
	de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los
	productos que comercializa. De cada producto se maneja la siguiente información: código de
	producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se
	genera un archivo detalle donde se registran todas las ventas de productos realizadas. De
	cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide
	realizar un programa con opciones para:
	a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
	● Ambos archivos están ordenados por código de producto.
	● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
	archivo detalle.
	● El archivo detalle sólo contiene registros que están en el archivo maestro.
	b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
	stock actual esté por debajo del stock mínimo permitido.
}


program untitled;

const
	
	valor_alto = 'zzzz';

type
	
	producto = record
		cod : string;
		nombre : string;
		precio : real;
		stock_actual : integer;
		stock_minimo : integer;
	end;
	
	ventas = record
		cod : string;
		cant : integer;
	end;
	
	maestro = file of producto;
	detalle = file of ventas;

procedure leer(var det : detalle;var dato : ventas);
begin
	if (not eof(det)) then read(det,dato)
	else dato.cod := valor_alto;
end;

procedure ejerA(var mae : maestro;var det : detalle);
var
	regm : producto;
	regd : ventas;
	cod_actual : string;
	cant : integer;
begin
	reset(det);
	reset(mae);
	read(mae,regm);
	leer(det,regd);
	while(regd.cod <> valor_alto)do
	begin
		cod_actual := regd.cod;
		cant := 0;
		while(regd.cod = cod_actual)do
		begin
			cant := cant + regd.cant;
			leer(det,regd);
		end;
		while(regm.cod <> cod_actual) do read(mae,regm);
		regm.stock_actual := regm.stock_actual - cant;
		seek(mae,filepos(mae)-1);
		write(mae,regm);
		if(not eof(mae)) then read(mae,regm);
	end;
	close(mae);
	close(det);
end;

procedure ejerB(var mae : maestro;var txt : text);
var
	regm : producto;
begin
	reset(mae);
	assign(txt,'stock_minimo.txt');
	rewrite(txt);
	while(not eof(mae))do
	begin
		read(mae,regm);
		if(regm.stock_actual < regm.stock_minimo) then
		with regm do writeln(txt,cod,' ',nombre,' ',precio,' ',stock_actual,' ',stock_minimo);
	end;
	close(txt);
	close(mae);
end;

var
	mae : maestro;
	det : detalle;
	menu : integer;
	txt : text;
	//regm : producto;
	//regd : ventas;
BEGIN
	assign(mae,'pract2ejer3mae.dat');
	assign(det,'pract2ejer3det.dat'); 
	{rewrite(mae);
	rewrite(det);
	regm.cod := '1';
    regm.nombre := 'fernet';
    regm.precio := 10000;
    regm.stock_minimo := 5;
    regm.stock_actual := 8;
    write(mae,regm);
    regm.cod := '2';
    regm.nombre := 'palta';
    regm.precio := 1500;
    regm.stock_minimo := 12;
    regm.stock_actual := 10;
    write(mae,regm);
    regm.cod := '3';
    regm.nombre := 'hamburguesa';
    regm.precio := 7000;
    regm.stock_minimo := 4;
    regm.stock_actual := 7;
    write(mae,regm);
    regm.cod := '4';
    regm.nombre := 'pinta';
    regm.precio := 3000;
    regm.stock_minimo := 10;
    regm.stock_actual := 9;
    write(mae,regm);

    regd.cod := '1';
    regd.cant := 2;
    write(det,regd);
    regd.cod := '1';
    regd.cant := 1;
    write(det,regd);
    regd.cod := '2';
    regd.cant := 3;
    write(det,regd);
    regd.cod := '2';
    regd.cant := 1;
    write(det,regd);
    regd.cod := '4';
    regd.cant := 1;
    write(det,regd);
    regd.cod := '4';
    regd.cant := 2;
    write(det,regd);
    regd.cod := '4';
    regd.cant := 2;
    write(det,regd);}
	repeat
		writeln('1. Actualizar stock');
		writeln('2. Listar en txt');
		writeln('Ingrese una opcion: ');
		read(menu);
		case menu of
			1:ejerA(mae,det);
			2:ejerB(mae,txt);
		end;
	until (menu = 3);
END.

