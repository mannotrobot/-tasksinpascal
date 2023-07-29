program exp32;

{
  задача:
ok   - заполнить центр прямоугольной областью 5*5;
ok   - принажатии клавиш <- -> менять цвет фона;
ok   - принажатии клавиш верх | низ менять цвет символов;
ok   - escape выход; 
}
uses
    crt;
const
    CELL = '*';

type
    coordinats = record
        x, y: integer;
    end;

procedure get_key(var code: integer);
var
    symbol : char;
begin
    symbol := readkey;
    if symbol = #0 then
    begin
        symbol := readkey;
        code := -(ord(symbol))
    end
    else
    begin
        code := ord(symbol)
    end
end;

function get_start_xy(size: integer): coordinats;
var
    start: coordinats;
begin
    start.x := screenwidth div 2 - size;
    start.y := screenheight div 2 - size;
    get_start_xy := start;
end;

procedure show_line(var size: integer; start: coordinats);
var
    i : integer;
begin
    for i := 1 to size do
    begin
        gotoxy(start.x, start.y);
        write(CELL);
        gotoxy(1, 1);
        start.x := start.x + 1;
    end
end;

procedure show_figure(var scolor, size: integer; start: coordinats; delta: integer);
var
    i : integer;
begin
    scolor:= scolor + delta;
    if scolor > 15 then
    begin
        scolor := 0;
    end;
    if scolor < 0 then
    begin
        scolor := 15;
    end;
    textcolor(scolor);
    for i:= 1 to size do
    begin
        show_line(size, start);
        start.y := start.y + 1;
    end;
end;

procedure set_background(var bgcolor, scolor, size: integer; delta: integer; start: coordinats);
begin
    bgcolor := bgcolor + delta;
    if bgcolor > 7 then
    begin
        bgcolor := 0;
    end;
    if bgcolor < 0 then
    begin
        bgcolor := 7;
    end;
    textbackground(bgcolor);
    show_figure(scolor, size, start, 0);
end;

var
    size   : integer;
    start  : coordinats;
    bgcolor: integer;
    scolor : integer;
    code   : integer;
begin
    clrscr;
    size := 5;
    start := get_start_xy(size);
    bgcolor := 0;
    scolor := 1;
    show_figure(scolor, size, start, 0);
    while True do
    begin
        get_key(code);
        case code of
            27 : break;
            -80: show_figure(scolor, size, start, 1);
            -72: show_figure(scolor, size, start, -1); 
            -77: set_background(bgcolor,scolor, size, 1, start);
            -75: set_background(bgcolor, scolor, size, -1, start);
        end;
    end;
    clrscr;
end.
