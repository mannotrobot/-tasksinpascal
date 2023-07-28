program exp30;
{
задача:
    - очистить экран;
    - отрисовать область 3*3;
    - принажатии стрелок увеличивать область на строку либо столбец;
    - принажатии escape или пробела выход;
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
{процедура счивания нажатия клавиш}
var
    symbol: char;
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
    start.x := screenwidth div 2  - size;
    start.y := screenheight div 2 - size;
    get_start_xy := start;
end;

procedure show_line(var w:integer; start: coordinats);
var
    i: integer;
begin
    for i:= 1 to w do
    begin
        gotoxy(start.x, start.y);
        write(CELL);
        gotoxy(1, 1);
        start.x := start.x + 1;
    end
end;

procedure show_column(var h: integer; start: coordinats);
var
    i: integer;
begin
    for i:= 1 to h do
    begin
        gotoxy(start.x, start.y);
        write(CELL);
        gotoxy(1, 1);
        start.y := start.y + 1;
    end
end;

procedure show_start_figure(var w, s: integer; start: coordinats);
var
    i: integer;
begin
    for i:= 1 to s do
    begin
        show_line(w, start);
        start.y := start.y + 1;
    end
end;

procedure set_figure(var width, height: integer; start: coordinats; direction: integer);
begin
   case direction of
       -1: show_column(height, start);
        1: show_line(width, start);
   end
end;

var
    start : coordinats;
    new_c : coordinats;
    size  : integer;
    width : integer;
    height: integer;
    code  : integer;
    w_left: integer;
    w_right: integer;
    h_up  : integer;
    h_down: integer;
begin
    clrscr;
    size := 3;
    start := get_start_xy(size);
    width := size;
    height := size;
    w_left := 0;
    w_right:= 0;
    h_up   := 0;
    h_down := 0;
    show_start_figure(width, size, start);
    while True do
    begin
        get_key(code);
        if code = 27 then
        begin
            break;
        end;
        if code = - 75 then
        begin
            if w_left < 6 then
            begin
                w_left := w_left + 1;
                textcolor(5);
                width := width + 1;
                start.x := start.x - 1;
                set_figure(width, height, start, -1);
            end
        end;
        if code = -77 then
        begin
            if w_right < 6 then
            begin
               w_right := w_right + 1;
               textcolor(5);
               width := width + 1;
               new_c := start;
               new_c.x := new_c.x + width - 1;
               set_figure(width, height, new_c, -1);
            end
        end;
        if code = -72 then
        begin
            if h_up < 6 then
            begin
            h_up := h_up + 1;
            textcolor(cyan);
            height := height + 1;
            start.y := start.y - 1;
            set_figure(width, height, start, 1);
            end
        end;
        if code = -80 then
        begin
            if h_down < 6 then
            begin
                h_down := h_down + 1;
                textcolor(cyan);
                height := height + 1;
                new_c := start;
                new_c.y := new_c.y + height - 1;
                set_figure(width, height, new_c, 1);
            end
        end;
    end;
    clrscr;
end.





