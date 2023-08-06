program exp50;
{
  задача:
ok  - получить через командную строку \
    filename | начальный угол | конечный угол | шаг |
     ascii      type: real       type: real     real
ok  - расчитать синусы | косинусы | тангенсы | котангенсы
ok  - записать данные в файл в виде таблицы:
   _________________________________
   | sin |  cos | tg  | ctg | step |
   ---------------------------------       
   | 3.5 |  0.1 | 2.2 | 7.7 | 3.8  |
   ---------------------------------
}

type
    args = record
        filename: string;
        start, stop, step : real;
    end;

    myarray = array [0..3] of real;

procedure str_to_real(s: string; var r: real; var code: integer);
begin
    val(s, r, code);
end;

function get_arguments() : args;
var
    start_args : args;
    r   : real;
    code: integer;
begin
    {$I-}
    if paramcount <> 4 then
    begin
        writeln('Invalid number of arguments...');
        halt(1);
    end;

    start_args.filename := paramstr(1);
    str_to_real(paramstr(2), r, code);
    start_args.start := r;
    str_to_real(paramstr(3), r, code);
    start_args.stop := r;
    str_to_real(paramstr(4), r, code);
    start_args.step := r;

    get_arguments := start_args;    
end;

function get_value_for_step(step: real): myarray;
var
    result : myarray;
begin
    result[0] := sin(step*pi/180);
    result[1] := cos(step*pi/180);
    result[2] := result[0] / result[1];
    result[3] := result[1] / result[0];
    get_value_for_step := result;
end;

function get_format_real(var x : real): string;
var
    a : real;
    s : string;    
begin
    a := x;
    str(a:2:4, s);
    get_format_real := s;
end;

function get_string_result(var res: myarray; i: real) : string;
var
    str_res : string;
begin
    str_res := '| ' + get_format_real(res[0]);
    str_res := str_res + ' | ' + get_format_real(res[1]);
    str_res := str_res + ' | ' + get_format_real(res[2]);
    str_res := str_res + ' | ' + get_format_real(res[3]);
    str_res := str_res + ' | ' + get_format_real(i);
    get_string_result := str_res;
end; 

procedure write_file_result(var arguments: args);
var
    stop : real;
    start     : real;
    f : text;
    line : string;
    res  : myarray;
begin
    stop := arguments.stop;
    start := arguments.start;
    {$I-}
    assign(f, arguments.filename + '.txt');
    rewrite(f);
    while start <= stop do 
    begin
        line := '---sin------cos------tan-------ctg------gradus';
        writeln(f, line);
        res := get_value_for_step(start);
        line := get_string_result(res, start);
        writeln(f, line);
        start := start + arguments.step;
    end;
    close(f);
end;

var
    arguments : args;
begin
    arguments := get_arguments;
    write_file_result(arguments);
end.
