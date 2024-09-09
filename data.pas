unit Data;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, SQLDBLib, DB, Forms;

type

  { TDBModule }

  TDBModule = class(TDataModule)
    DataSource1: TDataSource;
    SQLite3Conn: TSQLite3Connection;
    SQLQuery: TSQLQuery;
    SQLT: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  DBModule: TDBModule;

implementation

{$R *.lfm}

{ TDBModule }

procedure TDBModule.DataModuleCreate(Sender: TObject);
begin
  //SQLDBLibraryLoader1.ConnectionType:='SQLite3';
  //SQLDBLibraryLoader1.LibraryName:= ExtractFilePath(Application.ExeName)+'sqlite3.dll';
  //SQLDBLibraryLoader1.Enabled:= true;
  SQLite3Conn.DatabaseName:=ExtractFilePath(Application.ExeName)+'\Data\AQ_IT_Database.db';
  SQLite3Conn.Params.Add('FOREIGN_KEYS=ON'); //Enable foreign keys it's disabled by default
  SQLite3Conn.Connected:= true;
  SQLT.Active:= true;

end;

end.

