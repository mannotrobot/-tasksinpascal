program test02;
type
    npointer = ^node; { это указатель на ноду списка }
    node = record       {это нода она содержить данные и указатель на след.ноду}
        data : integer;
        next : npointer;
    end;

    linked_list = npointer;

procedure push(var lst: linked_list; i: integer);
{добавление в конец списка}
var
    n: npointer;
begin
    if lst <> nil then
    begin
        n := @lst^;
        while n^.next <> nil do
        begin
            n := n^.next;
        end;
        new(n^.next);
        n^.next^.next := nil;
        n^.next^.data := i;
    end
    else
    begin
        new(lst);
        lst^.data := i;
        lst^.next := nil;
    end;
end;

procedure read_link(var lst: linked_list);
var
    tmp : npointer;
begin
    tmp := @lst^;
    while tmp <> nil do
    begin
         writeln(tmp^.data);
         tmp := tmp^.next;
    end;
end;

function sum_lst(var lst: linked_list): integer;
begin
     if lst = nil then
     begin
         sum_lst := 0
     end
     else
     begin
         sum_lst := lst^.data + sum_lst(lst^.next);
     end
end;

var
   lst : linked_list;
   a   : integer;
begin
   lst := nil;
   while not seekeof do
   begin
       read(a);
       push(lst, a);
   end;
   read_link(lst);
   writeln(sum_lst(lst));
end.
