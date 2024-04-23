{
   Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
	De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
	stock mínimo y precio del producto.
	Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
	debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
	maestro. La información que se recibe en los detalles es: código de producto y cantidad
	vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
	descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
	debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo
	procedimiento de actualización, o realizarlo en un procedimiento separado (analizar
	ventajas/desventajas en cada caso).
	Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
	puede venir 0 o N registros de un determinado producto.
}
program untitled;

const
	valor_alto = 'zzzz';

type

	producto = record
		cod : string;
		nombre : string;
		descripcion : string;
		stock_dis : integer;
		stock_min : integer;
		precio : real;
	end;
	
	prod_det = record
		cod : string;
		cant_ven : integer;
	end;
	
	maestro = file of producto;
	detalle = file of prod_det;
	
procedure leer(var det:detalle;var dato:prod_det);
begin
	if(not eof(det)) then read(det,dato)
	else dato.cod := valor_alto;
end;

procedure minimo(var r1,r2,r3,min : prod_det;var det1,det2,det3 : detalle);
begin
	if((r1.cod <= r2.cod) and (r1.cod >= r3.cod))then
	begin
		min := r1;
		leer(det1,r1);
	end
	else if (r2.cod <= r3.cod)then
		begin
			min := r2;
			leer(det2,r2);
		end
		else begin
			min := r3;
			leer(det3,r3);
		end;
end;

procedure actualizarMae(var mae : maestro;var det1,det2,det3 : detalle);
var
	regm : producto;
	r1,r2,r3,min : prod_det;
begin
	leer(det1,r1);
	leer(det2,r2);
	leer(det3,r3);
	minimo(r1,r2,r3,min,det1,det2,det3);
	while(min.cod <> valor_alto)do
	begin
		read(mae,regm);
		while(regm.cod <> min.cod)do read(mae,regm);
		while(regm.cod = min.cod)do
		begin
			regm.stock_dis := regm.stock_dis - min.cant_ven;
			minimo(r1,r2,r3,min,det1,det2,det3);
		end;
		with regm do writeln(cod,' ',nombre,' ',descripcion,' ',stock_dis,' ',stock_min,' ',precio);
		seek(mae,filepos(mae)-1);
		write(mae,regm);
	end;
end;

var
	mae : maestro;
	det1,det2,det3 : detalle;
BEGIN
	assign(mae,'pract2ejer5mae.dat');
	assign(det1,'pract2ejer5det1.dat');
	assign(det2,'pract2ejer5det2.dat');
	assign(det3,'pract2ejer5det3.dat');
	reset(mae);
	reset(det1);
	reset(det2);
	reset(det3);
	actualizarMae(mae,det1,det2,det3);
END.

