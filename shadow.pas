unit shadow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, BGRAShape, windows;

type

  { TfrmShadow }

  TfrmShadow = class(TForm)
    shpContent: TBGRAShape;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmShadow: TfrmShadow;

implementation

{$R *.lfm}

{ TfrmShadow }

uses main;


procedure TfrmShadow.FormShow(Sender: TObject);
  var
   titlebarheight:integer;
   rgn: HRGN;
begin
  //Set shadow form positions
  titlebarheight:=GetSystemMetrics(SM_CYCAPTION);

  frmShadow.Left:= frmMain.Left+8;
  frmShadow.Top:= frmMain.Top+1;
  frmShadow.Width:= frmMain.Width+1;
  frmShadow.Height:= frmMain.Height+titlebarheight+8;

  rgn := CreateRoundRectRgn(0,// x-coordinate of the region's upper-left corner
    0,            // y-coordinate of the region's upper-left corner
    frmShadow.Width+1,  // x-coordinate of the region's lower-right corner
    frmShadow.Height+1, // y-coordinate of the region's lower-right corner
    10,           // height of ellipse for rounded corners
    10);
  SetWindowRgn(Handle, rgn, True);
end;

end.

