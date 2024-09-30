unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, LMessages, ExtCtrls,
  StdCtrls, dashboard, BGRAShape, Windows;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    imgListBtn: TImageList;
    lblComputersBck: TBGRAShape;
    lblComputersMenu1: TLabel;
    lblComputersMenu2: TLabel;
    lblTitleMenuForm: TLabel;
    lblAccesoriesBck: TBGRAShape;
    lblAccesoriesMenu1: TLabel;
    lblAccesoriesMenu2: TLabel;
    lblHomeBck: TBGRAShape;
    lblPhonesBck: TBGRAShape;
    lblPhonesMenu1: TLabel;
    lblPhonesMenu2: TLabel;
    lblReleaseBck: TBGRAShape;
    lblReleaseMenu1: TLabel;
    lblReleaseMenu2: TLabel;
    lblReturnBck: TBGRAShape;
    lblTrashBck: TBGRAShape;
    lblReturnMenu1: TLabel;
    lblReturnMenu2: TLabel;
    lblInfoBck: TBGRAShape;
    lblSettingsBck: TBGRAShape;
    lblTrashMenu1: TLabel;
    lblTrashMenu2: TLabel;
    lblInfoMenu1: TLabel;
    lblInfoMenu2: TLabel;
    lblSettingsMenu1: TLabel;
    lblSettingsMenu2: TLabel;
    lblUserMenu1: TLabel;
    lblUserMenu2: TLabel;
    lblUsersBck: TBGRAShape;
    lblUsersMenu1: TLabel;
    lblUsersMenu2: TLabel;
    pnlContent: TPanel;
    pnlAccesoriesMenu: TPanel;
    pnlComputersMenu: TPanel;
    pnlDivideMenu2: TPanel;
    pnlDivideMenu3: TPanel;
    pnlDivideMenu5: TPanel;
    pnlHomeMenu: TPanel;
    pnlPhonesMenu: TPanel;
    pnlReleaseMenu: TPanel;
    pnlReturnMenu: TPanel;
    pnlTrashMenu: TPanel;
    pnlInfoMenu: TPanel;
    pnlSettingsMenu: TPanel;
    pnlUsersMenu: TPanel;
    ScrollBox1: TScrollBox;
    shpSplitMenuDivideBottom: TShape;
    shpContent: TBGRAShape;
    pnlContentBck: TPanel;
    pnlSplitView: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lblInfoMenuClick(Sender: TObject);
    procedure pnlAccesoriesMenuClick(Sender: TObject);
    procedure pnlAccesoriesMenuMouseEnter(Sender: TObject);
    procedure pnlAccesoriesMenuMouseLeave(Sender: TObject);
    procedure pnlComputersMenuClick(Sender: TObject);
    procedure pnlComputersMenuMouseEnter(Sender: TObject);
    procedure pnlComputersMenuMouseLeave(Sender: TObject);
    procedure pnlHomeMenuClick(Sender: TObject);
    procedure pnlHomeMenuMouseEnter(Sender: TObject);
    procedure pnlHomeMenuMouseLeave(Sender: TObject);
    procedure pnlInfoMenuMouseEnter(Sender: TObject);
    procedure pnlInfoMenuMouseLeave(Sender: TObject);
    procedure pnlPhonesMenuClick(Sender: TObject);
    procedure pnlPhonesMenuMouseEnter(Sender: TObject);
    procedure pnlPhonesMenuMouseLeave(Sender: TObject);
    procedure pnlReleaseMenuMouseEnter(Sender: TObject);
    procedure pnlReleaseMenuMouseLeave(Sender: TObject);
    procedure pnlReturnMenuMouseEnter(Sender: TObject);
    procedure pnlReturnMenuMouseLeave(Sender: TObject);
    procedure pnlSettingsMenuMouseEnter(Sender: TObject);
    procedure pnlSettingsMenuMouseLeave(Sender: TObject);
    procedure pnlTrashMenuMouseEnter(Sender: TObject);
    procedure pnlTrashMenuMouseLeave(Sender: TObject);
    procedure pnlUsersMenuClick(Sender: TObject);
    procedure pnlUsersMenuMouseEnter(Sender: TObject);
    procedure pnlUsersMenuMouseLeave(Sender: TObject);
  private
  var
    select_item_color, hover_item_color, frm_color: TColor;
    select_menu: integer;
    First: boolean;
    procedure ClearMenu();
  public

  end;


var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

uses users, computers, information;

{ TfrmMain }

procedure TfrmMain.ClearMenu();
begin
  //Clear selected menu
  lblHomeBck.Visible := False;
  lblUsersBck.Visible := False;
  lblComputersBck.Visible := False;
  lblAccesoriesBck.Visible := False;
  lblPhonesBck.Visible := False;
  lblReleaseBck.Visible := False;
  lblReturnBck.Visible := False;
  lblTrashBck.Visible := False;
  lblSettingsBck.Visible := False;
  lblInfoBck.Visible := False;
  //Color default
  lblHomeBck.FillColor := hover_item_color;
  lblUsersBck.FillColor := hover_item_color;
  lblComputersBck.FillColor := hover_item_color;
  lblAccesoriesBck.FillColor := hover_item_color;
  lblPhonesBck.FillColor := hover_item_color;
  lblReleaseBck.FillColor := hover_item_color;
  lblReturnBck.FillColor := hover_item_color;
  lblTrashBck.FillColor := hover_item_color;
  lblSettingsBck.FillColor := hover_item_color;
  lblInfoBck.FillColor := hover_item_color;

  shpContent.BorderColor := clSilver;
  shpContent.FillColor := $F9F9F9;
  pnlContent.BorderSpacing.Around := 4;

  //Close form
  frmDashboard.Close();
  frmUsers.Close();
  frmComputers.Close();
  frmInformation.Close();

  case select_menu of
    1:
    begin
      lblHomeBck.Visible := True;
      lblHomeBck.FillColor := select_item_color;
      lblTitleMenuForm.Caption := 'Dashboard';
      frmDashboard.Parent := pnlContent;
      frmDashboard.Show();
    end;
    2:
    begin
      lblUsersBck.Visible := True;
      lblUsersBck.FillColor := select_item_color;
      lblTitleMenuForm.Caption := 'Użytkownicy';
      shpContent.FillColor := $00F3F3F3;
      shpContent.BorderColor := $00F3F3F3;
      pnlContent.BorderSpacing.Around := 0;
      frmUsers.Parent := pnlContent;
      frmUsers.Show();
    end;
    3:
    begin
      lblComputersBck.Visible := True;
      lblComputersBck.FillColor := select_item_color;
      lblTitleMenuForm.Caption := 'Komputery';
      shpContent.FillColor := $00F3F3F3;
      shpContent.BorderColor := $00F3F3F3;
      pnlContent.BorderSpacing.Around := 0;
      frmComputers.Parent := pnlContent;
      frmComputers.Show();
    end;
    4:
    begin
      lblAccesoriesBck.Visible := True;
      lblAccesoriesBck.FillColor := select_item_color;
      lblTitleMenuForm.Caption := 'Akcesoria';
    end;

    5:
    begin
      lblPhonesBck.Visible := True;
      lblPhonesBck.FillColor := select_item_color;
      lblTitleMenuForm.Caption := 'Telefony';
    end;
    6:
    begin
      lblReleaseBck.Visible := True;
      lblReleaseBck.FillColor := select_item_color;
      lblTitleMenuForm.Caption := 'Wydanie';
    end;
    7:
    begin
      lblReturnBck.Visible := True;
      lblReturnBck.FillColor := select_item_color;
      lblTitleMenuForm.Caption := 'Zwrot';
    end;
    8:
    begin
      lblTrashBck.Visible := True;
      lblTrashBck.FillColor := select_item_color;
      lblTitleMenuForm.Caption := 'Utylizacja';
    end;
    9:
    begin
      lblSettingsBck.Visible := True;
      lblSettingsBck.FillColor := select_item_color;
      lblTitleMenuForm.Caption := 'Ustawienia';
    end;
    10:
    begin
      lblInfoBck.Visible := True;
      lblInfoBck.FillColor := select_item_color;
      lblTitleMenuForm.Caption := 'Informacje';
      frmInformation.Parent := pnlContent;
      frmInformation.Show();
    end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  hover_item_color := $00EAEAEA;
  select_item_color := clWhite;
  frm_color := $00F3F3F3;
  select_menu := 1;

  //Set first item to active
  lblHomeBck.Visible := True;
  lblHomeBck.FillColor := select_item_color;
  lblTitleMenuForm.Caption := 'Dashboard';
  First := True;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  frmMain.Caption:='Width: '+frmMain.Width.ToString + ' Height: '+frmMain.Height.toString;
end;

procedure TfrmMain.lblInfoMenuClick(Sender: TObject);
begin
  select_menu:= 10;
  ClearMenu();
end;

procedure TfrmMain.pnlAccesoriesMenuClick(Sender: TObject);
begin
  select_menu := 4;
  ClearMenu();
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if First then
  begin
    frmDashboard.Parent := pnlContent;
    frmDashboard.Show();
    First := False;
  end;
end;

procedure TfrmMain.pnlAccesoriesMenuMouseEnter(Sender: TObject);
begin
  lblAccesoriesBck.Visible := True;
end;

procedure TfrmMain.pnlAccesoriesMenuMouseLeave(Sender: TObject);
begin
  if select_menu = 4 then Exit;
  lblAccesoriesBck.Visible := False;
end;

procedure TfrmMain.pnlComputersMenuClick(Sender: TObject);
begin
  select_menu := 3;
  ClearMenu();
end;

procedure TfrmMain.pnlComputersMenuMouseEnter(Sender: TObject);
begin
  lblComputersBck.Visible := True;
end;

procedure TfrmMain.pnlComputersMenuMouseLeave(Sender: TObject);
begin
  if select_menu = 3 then Exit;
  lblComputersBck.Visible := False;
end;

procedure TfrmMain.pnlHomeMenuClick(Sender: TObject);
begin
  select_menu := 1;
  ClearMenu();
  frmDashboard.Parent := pnlContent;
  frmDashboard.Show();
end;

procedure TfrmMain.pnlHomeMenuMouseEnter(Sender: TObject);
begin
  lblHomeBck.Visible := True;
end;

procedure TfrmMain.pnlHomeMenuMouseLeave(Sender: TObject);
begin
  if select_menu = 1 then Exit;
  lblHomeBck.Visible := False;
end;

procedure TfrmMain.pnlInfoMenuMouseEnter(Sender: TObject);
begin
  lblInfoBck.Visible := True;
end;

procedure TfrmMain.pnlInfoMenuMouseLeave(Sender: TObject);
begin
  if select_menu = 10 then Exit;
  lblInfoBck.Visible := False;
end;

procedure TfrmMain.pnlPhonesMenuClick(Sender: TObject);
begin
  select_menu := 5;
  ClearMenu();
end;

procedure TfrmMain.pnlPhonesMenuMouseEnter(Sender: TObject);
begin
  lblPhonesBck.Visible := True;
end;

procedure TfrmMain.pnlPhonesMenuMouseLeave(Sender: TObject);
begin
  if select_menu = 5 then Exit;
  lblPhonesBck.Visible := False;
end;

procedure TfrmMain.pnlReleaseMenuMouseEnter(Sender: TObject);
begin
  lblReleaseBck.Visible := True;
end;

procedure TfrmMain.pnlReleaseMenuMouseLeave(Sender: TObject);
begin
  lblReleaseBck.Visible := False;
end;

procedure TfrmMain.pnlReturnMenuMouseEnter(Sender: TObject);
begin
  lblReturnBck.Visible := True;
end;

procedure TfrmMain.pnlReturnMenuMouseLeave(Sender: TObject);
begin
  lblReturnBck.Visible := False;
end;

procedure TfrmMain.pnlSettingsMenuMouseEnter(Sender: TObject);
begin
  lblSettingsBck.Visible := True;
end;

procedure TfrmMain.pnlSettingsMenuMouseLeave(Sender: TObject);
begin
  lblSettingsBck.Visible := False;
end;

procedure TfrmMain.pnlTrashMenuMouseEnter(Sender: TObject);
begin
  lblTrashBck.Visible := True;
end;

procedure TfrmMain.pnlTrashMenuMouseLeave(Sender: TObject);
begin
  lblTrashBck.Visible := False;
end;

procedure TfrmMain.pnlUsersMenuClick(Sender: TObject);
begin
  select_menu := 2;
  ClearMenu();
end;

procedure TfrmMain.pnlUsersMenuMouseEnter(Sender: TObject);
begin
  lblUsersBck.Visible := True;
end;

procedure TfrmMain.pnlUsersMenuMouseLeave(Sender: TObject);
begin
  if select_menu = 2 then Exit;
  lblUsersBck.Visible := False;
end;

end.
