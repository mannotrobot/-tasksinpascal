program exp43;
{
  задача:
   - получить строку "без ограничений" из stdin;
   - вывести на экран слова "вертикально";
}

type
    ptr_char = ^node_char;
    node_char= record
        symbol: char;
        next: ptr_char;
    end;
    queue_symbol = ptr_char;
    ptr_word = ^node_word;
    node_word = record
        nword: queue_symbol;
        next: ptr_word;
    end;
    queue_string = ptr_word;
    size = record
        len, count : integer;
    end;    

procedure push_back_symbol(var q: queue_symbol; c: char);
var
    tmp : ptr_char;
begin
    if q = nil then
    begin
        new(q);
        q^.symbol := c;
        q^.next := nil
    end
    else
    begin
        tmp := @q^;
        while tmp^.next <> nil do
        begin
            tmp := tmp^.next;
        end;
        new(tmp^.next);
        tmp^.next^.symbol := c;
        tmp^.next^.next := nil; 
    end
end;

procedure push_back_word(var q: queue_string; new_word: queue_symbol);
var
   tmp : ptr_word;
begin
    if q = nil then
    begin
        new(q);
        new(q^.nword);
        q^.nword^ := new_word^;
        q^.next := nil;
    end
    else
    begin
        tmp := @q^;
        while tmp^.next <> nil do
        begin
            tmp := tmp^.next;
        end;
        new(tmp^.next);
        new(tmp^.next^.nword);
        tmp^.next^.nword^ := new_word^;
        tmp^.next^.next := nil;
    end;
end;

procedure read_string_stdin(var qw: queue_symbol);
var
    c: char;
begin
    while not eoln do
    begin
         read(c);
         push_back_symbol(qw, c);
    end;
end;

function handler_string(var qs: queue_string; var qw: queue_symbol): size;
var
    new_q: queue_symbol;
    len_word: integer;
    count_word: integer;
    i : integer;
    s : size;
begin
    new_q := nil;
    count_word := 0;
    len_word := 0;
    while qw <> nil do
    begin
        i := 0;
        while qw^.symbol <> ' ' do
        begin
            i := i + 1;
            push_back_symbol(new_q, qw^.symbol);
            if qw^.next = nil then
                 break;
            qw := qw^.next;
        end;
        if i > len_word then
             len_word := i;
        count_word := count_word + 1;
        push_back_word(qs, new_q);
        dispose(new_q);
        if qw^.next = nil then
           break
        else
           qw := qw^.next;
    end;
    s.len   := len_word;
    s.count := count_word;
    handler_string := s;  
end;

function get_need_char(q: queue_symbol;var pos: integer): char;
var
    k: integer;
    c: char;
    f: boolean;
begin
    c := ' ';
    f := True;
    for k:= 1 to pos do
    begin
        if q^.next <> nil then
            q := q^.next
        else
            f:= False;
    end;
    if f then
        get_need_char := q^.symbol
    else
        get_need_char := c;
end; 

procedure create_new_string(var qs: queue_string; var s: size);
var
    i : integer;
    j : integer;
    x : integer; 
    tmp: queue_string;
begin
     x := 0;
     for i:=0 to s.len do
     begin
         tmp := @qs^;
         for j := 0 to s.count do
         begin
             while tmp <> nil do
             begin
                 write(get_need_char(tmp^.nword, x));
                 tmp := tmp^.next;
             end; 
         end;
         writeln;
         x := x + 1;
     end;
end;

procedure read_stdin;
var
    qw : queue_symbol;
    qs : queue_string;
    c  : char;
    s  : size; 
begin
    while not eof do
    begin
        qw := nil;
        qs := nil;
        read_string_stdin(qw);
        s := handler_string(qs, qw);
        writeln('\*--------------*\');
        create_new_string(qs, s);
        writeln('\*--------------*\');
        read(c);
    end;   
end;

begin
    read_stdin;
    writeln('Good Bye!')
end.
