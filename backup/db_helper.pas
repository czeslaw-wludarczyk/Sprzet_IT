unit db_helper;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

var i: integer;
   function Get_category(): integer;

implementation

uses data;

function Get_category(): integer;
begin
    //Get ID category for computers kategory name
  try
    DBModule.SQLQuery.Close;
    DBModule.SQLQuery.SQL.Text :=
      'select * from category_items where category = "Komputer"';
    DBModule.SQLQuery.Open;
    category := DBModule.SQLQuery.FieldByName('id_category').AsInteger;
  except
  end;

    result:= i;
end;

end.

