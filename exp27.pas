program exp27;
uses crt;
type
    cell = record
        x, y : integer;
        flag : boolean;
    end;

procedure init_line(var pole: array of cell; start_x, start_y: integer; count: integer);
var
    i: integer;
begin
    for i := count to count + 8 do
    begin
        pole[i].x := start_x;
        pole[i].y := start_y;
        pole[i].flag := True;
        start_x := start_x + 1;
    end; 
end;

procedure init_pole(var pole: array of cell; start_x, start_y, count: integer);
var 
    i: integer;
begin
    i := 0;
    repeat
        init_line(pole, start_x, start_y, i);
        start_y := start_y + 1;
        count := count - 1;
        i := i + 9;
    until count < 0;
end;

procedure show_pole(var pole: array of cell);
var 
    c : cell;
begin
    for c in pole do
    begin
        gotoXY(c.x, c.y);
        write('*');
        gotoXY(1,1);
    end;
end;

procedure show_cursor(x, y : integer; symbol: char);
begin
    gotoXY(x, y);
    write(symbol);
    gotoXY(1, 1);
end;


var
    pole : array [0..80] of cell;
    i,j  : integer;
    c : cell;
    f : boolean;
begin
    if (screenheight < 12) or (screenwidth < 12) then
    begin
        writeln('sorry...');
        exit;
    end;
    init_pole(pole, screenwidth div 2 - 4, screenheight div 2 - 4, 9);
    clrscr;
    randomize;
    show_pole(pole);
    f:= True;
    while f do
    begin
        for i:= 0 to 7 do
        begin
            if not KeyPressed then
            begin
                c := pole[i];
                show_cursor(c.x, c.y, '#');
                delay(300);
                textcolor(random(16));
                show_cursor(c.x, c.y, '*');
                textcolor(15);
                continue
            end
            else
                f := False;
        end;
        j := 8;
        for i:= 1 to 8 do
        begin
        if not KeyPressed then
        begin
            c := pole[j];
            show_cursor(c.x, c.y, '#');
            textcolor(random(16));
            delay(300);
            show_cursor(c.x, c.y, '*');
            textcolor(15);
            j := j + 9;
            continue
        end
        else
            f := False;
        end;
        for i := 80 downto 73 do
            begin
            if not KeyPressed then
            begin
                c := pole[i];
                show_cursor(c.x, c.y, '#');
                textcolor(random(16));
                delay(300);
                show_cursor(c.x, c.y, '*');
                textcolor(15);
                continue
            end
            else
                f := False;
            end;
        j := 72;
        for i:= 1 to 8 do
        begin
        if not KeyPressed then
        begin
            c := pole[j];
            show_cursor(c.x, c.y, '#');
            textcolor(random(16));
            delay(300);
            show_cursor(c.x, c.y, '*');
            textcolor(15);
            j := j - 9;
            continue
        end
        else
            f := False;
        end;
    end;
    clrscr;
end.