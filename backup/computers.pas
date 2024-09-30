unit computers;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  ExtCtrls, Buttons, BGRAShape, LCLType, fgl, Types;

type

  TComputer = class
    id_item: integer;
    Name: string;
    aq_name: string;
    mark: string;
    model: string;
    serial_number: string;
    status: integer;
    category: integer;
    description: string;
  end;

type
  TComputersList = specialize TFPGObjectList<TComputer>;

type

  { TfrmComputers }

  TfrmComputers = class(TForm)
    btnAdd: TSpeedButton;
    btnDelete: TSpeedButton;
    btnEdit: TSpeedButton;
    edtSearchUser: TEdit;
    lblComp2: TLabel;
    lblComp3: TLabel;
    lblComp4: TLabel;
    lblCompData1: TLabel;
    lblCompData2: TLabel;
    lblCompData3: TLabel;
    lblCompData4: TLabel;
    lblCompData5: TLabel;
    lblUserName1: TLabel;
    lblComp1: TLabel;
    lblUserName2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlButtons: TPanel;
    pnlEditName: TPanel;
    pnlLeftMenu: TPanel;
    pnlCompContent1: TPanel;
    pnlCompContent2: TPanel;
    scBoxUsersDetails: TScrollBox;
    shpContent: TBGRAShape;
    shpContent2: TBGRAShape;
    shpContent3: TBGRAShape;
    shpEditBck1: TBGRAShape;
    shpLine2: TShape;
    shpLine3: TShape;
    shpLine4: TShape;
    shpLineEdit2: TShape;
    shpLineEdit3: TShape;
    stBoxComputers: TListBox;
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure stBoxComputersDrawItem(Control: TWinControl; Index: integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure stBoxComputersSelectionChange(Sender: TObject; User: boolean);
  private
  var
    First: boolean;
    Computer: TComputer;
    ComputerList: TComputersList;

    procedure GetComputers();
    procedure UpdateGUI();
  public
  var
    old_selected: integer;
  end;

var
  frmComputers: TfrmComputers;

implementation

{$R *.lfm}

uses main, Data, add_computer, shadow, db_helper, del_computer, del_computer_error, edit_computer;

  { TfrmComputers }

procedure TfrmComputers.UpdateGUI();
begin
  if stBoxComputers.ItemIndex <> -1 then
  begin
    pnlCompContent1.Visible := True;
    lblComp1.Caption := ComputerList.Items[stBoxComputers.ItemIndex].Name + ':';
    lblComp1.Left := (lblComp2.Left + lblComp2.Width) - lblComp1.Width;

    lblCompData1.Caption := ComputerList.Items[stBoxComputers.ItemIndex].aq_name;
    lblCompData2.Caption := ComputerList.Items[stBoxComputers.ItemIndex].mark;
    lblCompData3.Caption := ComputerList.Items[stBoxComputers.ItemIndex].model;
    lblCompData4.Caption := ComputerList.Items[stBoxComputers.ItemIndex].serial_number;
    lblCompData5.Caption := ComputerList.Items[stBoxComputers.ItemIndex].description;
    if ComputerList.Items[stBoxComputers.ItemIndex].description <> '' then
    begin
      pnlCompContent2.Visible := True;
      pnlCompContent2.Height := 48 + lblCompData5.Height + 20;
      shpContent3.Height := lblCompData5.Height + 20;
    end;
  end
  else
  begin
    pnlCompContent1.Visible := False;
    pnlCompContent2.Visible := False;
    Exit;
  end;
end;

procedure TfrmComputers.GetComputers();
var
  i, category: integer;
begin
  //Initialize variable and lists
  ComputerList := TComputersList.Create();

  //Get ID category for computers kategory name
  category := db_helper.Get_category('Komputer');

  try
    DBModule.SQLQuery.Close;
    DBModule.SQLQuery.SQL.Text := 'select * from items where category = :category';
    DBModule.SQLQuery.Params.ParamByName('category').AsInteger := category;
    DBModule.SQLQuery.Open;
  except
  end;

  stBoxComputers.Clear();

  if DBModule.SQLQuery.RecordCount > 0 then
  begin
    while not DBModule.SQLQuery.EOF do
    begin
      Computer := TComputer.Create;
      Computer.id_item := DBModule.SQLQuery.FieldByName('id_item').AsInteger;
      Computer.Name := DBModule.SQLQuery.FieldByName('name').AsString;
      Computer.aq_name := DBModule.SQLQuery.FieldByName('aq_name').AsString;
      Computer.mark := DBModule.SQLQuery.FieldByName('mark').AsString;
      Computer.model := DBModule.SQLQuery.FieldByName('model').AsString;
      Computer.serial_number := DBModule.SQLQuery.FieldByName('serial_number').AsString;
      Computer.description := DBModule.SQLQuery.FieldByName('description').AsString;
      ComputerList.Add(Computer);
      stBoxComputers.Items.AddObject(Computer.aq_name, Computer);
      DBModule.SQLQuery.Next;
    end;
  end;

  //Check buttons
  btnDelete.Enabled := False;
  btnEdit.Enabled := False;
  if stBoxComputers.Items.Count > 0 then
  begin
    btnDelete.Enabled := True;
    btnEdit.Enabled := True;
  end;
end;

procedure TfrmComputers.stBoxComputersDrawItem(Control: TWinControl;
  Index: integer; ARect: TRect; State: TOwnerDrawState);
begin
  if stBoxComputers.ItemIndex = -1 then Exit;
  with (Control as TListBox).Canvas do
  begin
    if odSelected in State then Brush.Color := $00F9EEE0;
    Font.Color := clBlack;
    FillRect(ARect);
    TextOut(ARect.Left + 5, ARect.Top + 2, stBoxComputers.Items[Index]);
  end;
end;

procedure TfrmComputers.stBoxComputersSelectionChange(Sender: TObject; User: boolean);
begin
  UpdateGUI();
end;

procedure TfrmComputers.FormShow(Sender: TObject);
begin
  First := True;
  GetComputers();
  pnlCompContent1.Visible := False;
  pnlCompContent2.Visible := False;
end;

procedure TfrmComputers.FormResize(Sender: TObject);
begin
  if (First) and (stBoxComputers.Count > 0) then
  begin
    stBoxComputers.ItemIndex := 0;
    stBoxComputers.SetFocus;
    old_selected := 0;
  end;
  First := False;
end;

procedure TfrmComputers.btnAddClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to stBoxComputers.Items.Count - 1 do
    if stBoxComputers.Selected[i] then
    begin
      old_selected := i;
    end;
  frmShadow.Show();
  frmAddComputer.ShowModal();
  frmMain.SetFocus;
  stBoxComputers.Clear;
  GetComputers();

  //Setlect added item or select old selected item
  for i := 0 to stBoxComputers.Items.Count - 1 do
    if stBoxComputers.Items[I].Contains(frmAddComputer.added_item) then
    begin
      stBoxComputers.Selected[i] := True;
      Exit;
    end
    else
    if stBoxComputers.Items.Count - 1 >= 0 then
      stBoxComputers.Selected[old_selected] := True;

end;

procedure TfrmComputers.btnDeleteClick(Sender: TObject);
var
  i, selected: integer;
begin
  for i := 0 to stBoxComputers.Items.Count - 1 do
    if stBoxComputers.Selected[i] then
    begin
      selected := i;
    end;
  frmShadow.Show();

  //Check if computer not assigned to user
  try
    DBModule.SQLQuery.Close;
    DBModule.SQLQuery.SQL.Text :=
      'select id_item, id_customer from items where id_item = :id_comp and id_customer is null';
    DBModule.SQLQuery.Params.ParamByName('id_comp').AsInteger :=
      TComputer(stBoxComputers.Items.Objects[stBoxComputers.ItemIndex]).id_item;
    DBModule.SQLQuery.Open;
  finally
  end;

  //Show messages when computer is assigned to user and can not delete.
  if DBModule.SQLQuery.RecordCount = 0 then
  begin
    frmShadow.Show();
    frmDelComputerError.ShowModal();
  end
  else
  begin
    //Dialog box for delete computer when not assigned to user.
    case frmDelComputer.ShowModal() of
      mrOk: begin
        try
          DBModule.SQLQuery.Close;
          DBModule.SQLQuery.SQL.Text :=
            'delete from items where id_item = :id_comp and id_customer is null';
          DBModule.SQLQuery.Params.ParamByName('id_comp').AsInteger :=
            TComputer(stBoxComputers.Items.Objects[stBoxComputers.ItemIndex]).id_item;
          DBModule.SQLQuery.ExecSQL;
          GetComputers();
          if selected = 0 then
          begin
            if stBoxComputers.Items.Count - 1 >= 0 then
              stBoxComputers.Selected[selected] := True;
          end
          else
          begin
            if stBoxComputers.Items.Count - 1 >= 0 then
              stBoxComputers.Selected[selected - 1] := True;
          end;
          UpdateGUI();
        except
        end;
      end;
      mrCancel: begin
        Exit;
      end;
    end;
  end;
end;

procedure TfrmComputers.btnEditClick(Sender: TObject);
 var
  i: integer;
begin
  for i := 0 to st.Items.Count - 1 do
    if stBoxComputers.Selected[i] then
    begin
      old_selected := i;
    end;

  if stBoxComputers.Items.Count > 0 then
  begin
    frmShadow.Show();
    frmEditComputer.ShowModal();
    frmMain.SetFocus;
    stBoxComputers.Clear;
    GetComputers();
    if stBoxComputers.Items.Count - 1 >= 0 then stBoxComputers.Selected[old_selected] := True;
  end;
end;

procedure TfrmComputers.FormPaint(Sender: TObject);
begin
  UpdateGUI();
end;

end.
