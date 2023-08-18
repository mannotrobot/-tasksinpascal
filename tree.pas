program tree;
{create b-tree}
type
    tree_node_ptr = ^tree_node;
    tree_node = record
        data: longint;
        left, right: tree_node_ptr;
    end;
    pos = ^tree_node_ptr;


function sum_tree(p: tree_node_ptr): longint;
begin
    if p = nil then
        sum_tree := 0
    else
        sum_tree := sum_tree(p^.left) + p^.data + sum_tree(p^.right)
end;

function search_tree(var p: tree_node_ptr; val: longint) : pos;
begin
    if (p = nil) or (p^.data = val) then
        search_tree := @p
    else
    if val < p^.data then
        search_tree := search_tree(p^.left, val)
    else
        search_tree := search_tree(p^.right, val)
end;

function add_node(var p: tree_node_ptr; val: longint): boolean;
var
    position : pos;
begin
     position := search_tree(p, val);
     if position^ = nil then
     begin
         new(position^);
         position^^.data := val;
         position^^.left := nil;
         position^^.right:= nil;
         add_node := True
     end
     else
         add_node := False
end;

function is_in_tree(p: tree_node_ptr; val: longint): boolean;
begin
    is_in_tree := search_tree(p, val)^ <> nil;
end;

var
    root: tree_node_ptr = nil;
    c : char;
    n : longint;
begin
    while not eof do
    begin
        readln(c, n);
        case c of
            '?': begin
                 if is_in_tree(root, n) then
                      writeln('YES!')
                 else
                      writeln('NO!')
             end;
             '+': begin
                  if add_node(root, n) then
                      writeln('succesfully added')
                  else
                      writeln('Couldn''t add!')
             end;
        else
             writeln('I don''t know such command! Try "+" or "?"')
        end; 
   end;
end.
