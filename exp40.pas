program exp40;
{
    задача:
    - считать из stdin числа;
    - вывести на экран те, которые втречалисть чаще других;
}

type 
     ptr = ^node;
     node = record
         data: longint;
         next: ptr;
     end;
     linked_list = ptr;

procedure push(var lst: linked_list; n: longint);
var
    tmp: ptr;
begin
     if lst <> nil then
     begin
         tmp := @lst^;
         while tmp^.next <> nil do
         begin
             tmp := tmp^.next;
         end;
         new(tmp^.next);
         tmp^.next^.next := nil;
         tmp^.next^.data := n;
     end
     else
     begin
         new(lst);
         lst^.data := n;
         lst^.next := nil;
     end;
end;

function get_most_count(var lst: linked_list) : linked_list;
var
   new_lst: linked_list;
   tmp: ptr;
   count: integer;
   i: integer;
   current: ptr;
begin
   tmp := @lst^;
   count := 0;
   current := @lst^;
   while current <> nil do
   begin
       i := 1;
       while tmp <> nil do 
       begin
           if current^.data = tmp^.data then
           begin
               i := i + 1;
           end;
           tmp := tmp^.next;
       end;
       if i = count then
       begin
           count := i;
           push(new_lst, current^.data);
       end;
       if i > count then
       begin
           count := i;
           new_lst := nil;
           push(new_lst, current^.data);
       end;
       tmp := @lst^;
       current := current^.next;
    end;
    get_most_count := new_lst;
end;

var
    lst: linked_list;
    n: longint;
    n_lst: linked_list;
begin
    while not eof do
    begin
        read(n);
        push(lst, n);
    end;
    n_lst := get_most_count(lst);
    while n_lst <> nil do
    begin
        writeln(n_lst^.data);
        n_lst := n_lst^.next;
    end;
end.











