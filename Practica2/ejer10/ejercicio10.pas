{Se tiene información en un archivo de las horas extras realizadas por los empleados de una
empresa en un mes. Para cada empleado se tiene la siguiente información: departamento,
división, número de empleado, categoría y cantidad de horas extras realizadas por el
empleado. Se sabe que el archivo se encuentra ordenado por departamento, luego por
división y, por último, por número de empleado. Presentar en pantalla un listado con el
siguiente formato:
Departamento
División
Número de Empleado Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____
Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
posición del valor coincidente con el número de categoría.}
program untitled;
const

	valor_alto = 9999;

type
	
	empleado = record
		depto : integer;
		divi : integer;
		nro : integer;
		cate : integer;
		hs : real;
	end;
	
	maestro = file of empleado;
	
	arr_cate = array[1..15] of real;

procedure leer(var mae : text ; var dato : empleado);
begin
	if(not eof(mae)) then
	begin
		readln(mae,dato.depto,dato.divi,dato.nro,dato.cate,dato.hs);
	end
	else dato.depto := valor_alto;
end;

procedure imprimirMae(var mae : text;arr : arr_cate);
var
	regm : empleado;
	depto,divi,nro : integer;
	hs,importe,hs_divi,monto_divi,hs_depto,monto_depto : real;
begin
	reset(mae);
	leer(mae,regm);
	while(regm.depto <> valor_alto)do
	begin
		depto := regm.depto;
		hs_depto := 0;
		monto_depto := 0;
		writeln('Depto: ', depto);
		while(depto = regm.depto)do
		begin
			divi := regm.divi;
			hs_divi := 0;
			monto_divi := 0;
			writeln('	Divi: ',divi);
			while(divi = regm.divi) and (depto = regm.depto)do
			begin
				nro := regm.nro;
				hs := 0;
				importe := 0;
				writeln('		Empleado: ',nro);
				while(nro = regm.nro) and (divi = regm.divi) and (depto = regm.depto)do
				begin
					importe := importe + (regm.hs * arr[regm.cate]);
					hs := hs + regm.hs;
					leer(mae,regm);
				end;
				hs_divi := hs_divi + hs;
				monto_divi := monto_divi + importe;
				writeln('			Cant hs: ',hs:2:00,' Importe: ',importe:2:00);
			end;
			writeln('Total hs divi: ',hs_divi:2:00);
			writeln('Monto total divi: ',monto_divi:2:00);
			hs_depto := hs_depto + hs_divi;
			monto_depto := monto_depto + monto_divi;
			writeln();
		end;
		writeln('Total hs depto: ',hs_depto:2:00);
		writeln('Monto total depto: ',monto_depto:2:00);
	end;
	close(mae);
end;

procedure cargarArr(var arr : arr_cate;var arr_text : text);
var
	pos : integer;
	monto : real;
begin
	reset(arr_text);
	while(not eof(arr_text))do
	begin
		readln(arr_text,pos,monto);
		arr[pos] := monto;
	end;
	close(arr_text);
end;

var
	mae,arr_text : text;
	arr : arr_cate;
	i : integer;
BEGIN
	assign(mae,'ejer10pract2mae.txt');
	assign(arr_text,'ejer10pract2arr.txt');
	cargarArr(arr,arr_text);
	//for i:= 1 to 15 do writeln(arr[i]:2:00);
	imprimirMae(mae,arr);
END.

