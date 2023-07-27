program exp28;
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
var
    new_coord : coordinats;
    i         : integer;
    j         : integer;
begin
    for i:= 0 to LEN - 1 do
    begin
        new_path[i] := pole[i];
    end;
    j := 0;
    for i:= 0 to LEN -2 do
    begin
        new_path[LEN + i - 1] := pole[LEN - 1 + j];
        j := j + LEN ;
    end;
    for new_coord in new_path do
    begin
        writeln(new_coord.x, ' ][ ', new_coord.y)
    end;
end;

var
    code         : integer;
    direction    : integer;
    current_speed: integer;
    pole         : array [0..80] of coordinats;
    start        : coordinats;
    i            : integer;
    new_path     : path;
begin
    direction := 1;
    current_speed := SPEED;
    start.x := screenwidth div 2 - 4;
    start.y := screenwidth div 2 - 4;
    init_pole(pole, start);
    {while True do
    begin
        if not KeyPressed then
        begin
        continue 
        end;
        get_key(code);
        case code of
            27: break;
            32: direction:= direction * -1;
            -75: current_speed := current_speed + DSPEED;
            -77: current_speed := current_speed - DSPEED;
        end
    end;}
    i := 0;
    for start in pole do
    begin
        writeln('pos: ', i,'|      x: ', start.x, ' y: ', start.y);
        i := i + 1;
    end;
    create_path(new_path, pole);
end.