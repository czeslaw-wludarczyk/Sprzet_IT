unit db_helper;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

var i: integer;
   function Get_category(category: string): integer;

implementation

uses data;

function Get_category(category: string): integer;
begin
    //Get ID category for computers kategory name
  try
    DBModule.SQLQuery.Close;
    DBModule.SQLQuery.SQL.Text :=
      'select * from category_items where category = :category';
    DBModule.SQLQuery.Params.ParamByName('category').AsInteger := category;
    DBModule.SQLQuery.Open;
    i := DBModule.SQLQuery.FieldByName('id_category').AsInteger;
  except
  end;

    result:= i;
end;

end.

