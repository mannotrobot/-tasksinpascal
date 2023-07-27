program MovingHello;
uses crt;
const
    MESSAGE = 'mannotrobot';
    BORDER = '+';
    arcade = '[ arcade mode ]';

procedure get_key(var code: integer);
var
    symbol: char;
begin
    symbol := readkey;
    if symbol = #0 then
    begin
        symbol := readkey;
        code := -ord(symbol);
    end
    else
    begin
       code := ord(symbol)  
    end
end;

procedure show_message(x, y: integer; msg: string);
begin
    gotoXY(x, y);
    write(msg);
    gotoXY(1, 1)
end;

procedure show_coordinates(x, y: integer);
begin
    gotoXY(screenwidth div 2 - length(arcade) div 2, 1);
    write('[ arcade mode ]');
    gotoXY(1, 2);
    write('coordinates: ', x, ' | ', y, ' ');
    gotoXY(1, 1);
end;

procedure hide_message(x, y: integer; msg: string);
var
    len, i : integer;
begin
    len := length(msg);
    gotoXY(x, y);
    for i := 1 to len do
        write(' ');
    gotoXY(1, 1)
end;

procedure move_message(var x, y: integer; msg: string; dx, dy: integer);
begin
    if dx = -1 then
        textcolor(14);
    if dx = 1 then
        textcolor(9);
    if dy = -1 then
        textcolor(4);
    if dy = 1 then
        textcolor(3);
    hide_message(x, y, msg);
    x := x + dx;
    y := y + dy;
    if x < 2 then
        x := 2;
    if x + length(msg) > screenwidth then
        x := screenwidth - length(msg);
    if y > screenheight - 2 then
        y := screenheight - 2;
    if y < 4 then
        y := 4;
    show_message(x, y, msg);
    textcolor(15);
end;

procedure show_borders_x(brdr: char);
var
    i : integer;
begin
    for i := 1 to screenwidth do
    begin
        gotoXY(i, 3);
        write(brdr+' ');
        gotoXY(i, screenheight-1);
        write(brdr);
        gotoXY(1, 1)
    end
end;

procedure show_border_y(brdr: char);
var
    i: integer;
begin
    for i:= 4 to screenheight - 1 do
    begin
        gotoXY(1, i);
        write(brdr);
        gotoXY(screenwidth, i);
        write(brdr);
        gotoXY(1, 1)
    end
end;

procedure show_cube;
var
    x, y: integer;
    symbol: char;
begin
    symbol := '#';
    y := screenheight div 2 + 1; 
    for x:= screenwidth div 2 to screenwidth div 2 + 2 do
    begin
        gotoXY(x, screenheight div 2);
        write(symbol);
        gotoXY(x, y);
        write(symbol);
        gotoXY(1, 1);
    end;
end;

var
    cur_x, cur_y: integer;
    c           : integer;
begin
    clrscr;
    cur_x := (screenwidth - length(MESSAGE)) div 2;
    cur_y := screenheight div 2;
    show_message(cur_x, cur_y, MESSAGE);
    while True do
    begin
        show_coordinates(cur_x, cur_y);
        show_borders_x(BORDER);
        show_border_y(BORDER);
        show_cube;
        get_key(c);
        if c > 0 then
            break;
        case c of
            -75: {move to left}
                move_message(cur_x, cur_y, MESSAGE, -1, 0);
            -77: {move to right}
                move_message(cur_x, cur_y, MESSAGE, 1, 0);
            -72: {move to down}
                move_message(cur_x, cur_y, MESSAGE, 0, -1);
            -80: {move to up}
                move_message(cur_x, cur_y, MESSAGE, 0, 1)
        end
    end;
    clrscr;
end.
