program exp28;

{задача: 
 ok   - ввывод на центр экрана квадрата 9*9 из символов;
 ok   - по периметру квадрата движется символ;
 ok   - принажатии пробела движущийся символ меняет направление;
 ok   - принажатии стрелок "лево"|"право" менялась скорость;
 ok   - принажатии escape выход из программы;
 ok   - если размер экрана меньше 12 знакомест - сообщение обшибке;
}

uses crt;
const
    SPEED  = 300;
    DSPEED = 100;
    LEN    = 9;
    CELL   = '*';
    CURSOR    = '+';
type
    coordinats = record
        x, y : integer;
    end;
    path = array [0..(LEN-1)*4 - 1] of coordinats;

procedure get_key(var code: integer);
{процедура считавания нажатия клавиш}
var
    symbol: char;
begin
    symbol := readkey;
    if symbol = #0  then
    begin
        symbol := readkey;
        code := -(ord(symbol));
    end
    else
    begin
       code := ord(symbol) 
    end
end;

procedure init_cells(var pole: array of coordinats; position: integer;  current: coordinats);
{процедура инициализации линии}
var
    i  : integer;
    pos: integer;
begin
    pos := position;
    for i:= 0 to LEN - 1 do
    begin
        pole[pos].y := current.y;
        pole[pos].x := current.x;
        current.y := current.y + 1;
        pos := pos + 9;
    end;
end;

procedure init_pole(var pole: array of coordinats; start : coordinats);
{процедура инициализации поля}
var
    current : coordinats;
    i    : integer;
    count: integer;
begin
    count := LEN -1;
    current := start;
    i := 0;
    repeat 
        init_cells(pole, i, current);
        current.x := current.x + 1;
        count := count - 1;
        i:= i + 1;
    until count < 0;
end;

procedure create_path(var new_path: path; var pole: array of coordinats);
{процедура, которая создает путь по которому будет двигаться курсор}
var
    new_coord : coordinats;
    i         : integer;
    j         : integer;
begin
    for i:= 0 to LEN - 2 do
    begin
        new_path[i] := pole[i];
    end;
    j := LEN - 1;
    for i:= 0 to LEN - 2 do
    begin
        new_path[LEN + i - 1] := pole[j];
        j := j + LEN;
    end;
    for i:= 0 to LEN - 1 do
    begin
        new_path[i + 15] := pole[80 - i]
    end;
    j := LEN * (LEN - 2);
    for i:= 0 to LEN - 2 do
    begin
        new_path[24 + i] := pole[j];
        j := j - LEN;
    end;
end;

procedure show_pole(var pole: array of coordinats);
var
    xy : coordinats;
begin
    for xy in pole do
    begin
        gotoxy(xy.x, xy.y);
        write(CELL);
        gotoxy(1, 1);
    end;
end;

procedure show_cursor(cur: coordinats; current_speed: integer);
begin
    gotoxy(cur.x, cur.y);
    write(CURSOR);
    gotoxy(1, 1);
    delay(current_speed);
    textcolor(random(16));
    gotoxy(cur.x, cur.y);
    write(CELL);
    textcolor(15);
    gotoxy(1, 1);
end;

var
    code         : integer;
    direction    : integer;
    current_speed: integer;
    pole         : array [0..80] of coordinats;
    start        : coordinats;
    i            : integer;
    new_path     : path;
    pos          : integer;
begin
    if (screenwidth < 12) or (screenheight < 12) then
    begin
        gotoxy(screenwidth div 2, screenheight div 2);
        write('недостаточный размер экрана');
        writeln;
        exit;
    end;
    randomize;
    pos := 0;
    current_speed := SPEED;
    start.x := screenwidth div 2 - 4;
    start.y := screenheight div 2 - 4;
    init_pole(pole, start);
    create_path(new_path, pole);
    clrscr;
    show_pole(pole);
    direction := 1;
    while True do
        begin
            gotoxy(1, 1);
            write('current speed: ',600 - current_speed);
            gotoxy(1, 1);
            if current_speed < 100 then
            begin
               current_speed := SPEED;
            end;
            if pos > 31 then
            begin
                pos := 1;
            end;
            if pos < 0 then
            begin
                pos := 31;
            end;
            if not keypressed then
            begin
                show_cursor(new_path[pos], current_speed);
                pos := pos + direction;
                continue
            end;
            get_key(code);
            case code of
                -72: current_speed := current_speed - DSPEED;
                -80: current_speed := current_speed + DSPEED;
                -75: direction := -1;
                -77: direction := 1;
                27 : break
            end
        end;
    clrscr;
end.
