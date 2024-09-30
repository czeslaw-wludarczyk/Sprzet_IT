unit Information;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  BGRAShape, versiontypes, versionresource, resource, FileInfo;

type

  { TfrmInformation }

  TfrmInformation = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblUserName1: TLabel;
    lblUserName2: TLabel;
    lblUserName3: TLabel;
    pnlUserContent: TPanel;
    pnlUserContent1: TPanel;
    ScrollBox1: TScrollBox;
    shpContent2: TBGRAShape;
    shpContent3: TBGRAShape;
    shpLine3: TShape;
    shpLine4: TShape;
    procedure FormShow(Sender: TObject);
  private
    function Version_info() :String;
  public

  end;

var
  frmInformation: TfrmInformation;

implementation

{$R *.lfm}

procedure TfrmInformation.FormShow(Sender: TObject);
var
  Major, Minor, Rel, Build: Cardinal;
begin
  lblUserName2.Caption:= Version_info;
end;

//Get exe file version information
function TfrmInformation.Version_info() :String;
var
   VersionInfo: TVersionInfo;
   version: AnsiString;
begin
   VersionInfo := TVersionInfo.Create;
  try
    VersionInfo.Load(HINSTANCE);
    version:= (IntToStr(VersionInfo.FixedInfo.FileVersion[0]) + '.' +
                IntToStr(VersionInfo.FixedInfo.FileVersion[1]) + '.' +
                IntToStr(VersionInfo.FixedInfo.FileVersion[2]) + '.' +
                IntToStr(VersionInfo.FixedInfo.FileVersion[3]));
  finally
    VersionInfo.Free;
    result:= version;
end;

end;

end.

