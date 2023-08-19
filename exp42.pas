program exp42;
{
  задача:
  - считать сиз stdin строки без ограничения;
  - отзеркалить и вывести на экран строку;
}
type
    ptr_char = ^node_char;
    node_char = record
        symbol: char;
        next: ptr_char;
    end;
    queue = ptr_char;
    ptr_word = ^node_word;
    node_word = record
        nword: queue;
        next: ptr_word;
    end;
    stack = ptr_word;

procedure push_front(var s: stack; new_word: queue);
var
    tmp : ptr_word;
begin
    new(tmp);
    new(tmp^.nword);
    tmp^.nword^ := new_word^;
    tmp^.next := s;
    s := tmp;
end;

procedure push_back(var q: queue; c: char);
var
    tmp: ptr_char;
begin
    if q <> nil then
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
    else
    begin
        new(q);
        q^.next := nil;
        q^.symbol:= c;
    end;
end;

var
   c: char;
   q: queue;
   s: stack;
   tmp: queue;
begin
    s := nil;
    while not eof do
    begin
        while not eoln do
        begin
           read(c);
           push_back(q, c);
        end;
        read(c);
    end;
    while q <> nil do
    begin
        while q^.symbol <> ' ' do
        begin
            push_back(tmp, q^.symbol);
            if q^.next = nil then
                break;
            q := q^.next;
        end;
        push_front(s, tmp);
        dispose(tmp);
        if q^.next = nil then
            break
        else
           q := q^.next;
    end;
    while s <> nil do
    begin
        tmp := s^.nword;
        while tmp <> nil do
        begin
             write(tmp^.symbol);
             tmp := tmp^.next;
        end;
        write(' ');
        s:= s^.next;
    end;
    writeln;
end.
