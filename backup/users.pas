unit users;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  ExtCtrls, Buttons, BGRAShape, LCLType, fgl;

type

  TCustomer = class
    id_customer: integer;
    first_name: string;
    last_name: string;
    full_name: string;
    customer_number: string;
    status: integer;
  end;

type

  TItem = class
    id_items: integer;
    Name: string;
    aq_name: string;
    mark: string;
    model: string;
    serial_number: string;
    IMEI_1: string;
    IMEI_2: string;
    phone_number: string;
    status: integer;
    category: string;
    description: string;
  end;

type
  TItemsList = specialize TFPGObjectList<TItem>;

type

  { TfrmUsers }

  TfrmUsers = class(TForm)
    shpEditBck1: TBGRAShape;
    btnEdit: TSpeedButton;
    edtSearchUser: TEdit;
    lblUserName1: TLabel;
    lblUserName: TLabel;
    lblUserNumber: TLabel;
    Panel1: TPanel;
    pnlEditName: TPanel;
    pnlLeftMenu: TPanel;
    shpLine2: TShape;
    shpLine3: TShape;
    shpLineEdit2: TShape;
    shpLineEdit3: TShape;
    stBoxUsers: TListBox;
    pnlUserContent: TPanel;
    pnlUserTop: TPanel;
    pnlButtons: TPanel;
    scBoxUsersDetails: TScrollBox;
    shpContent: TBGRAShape;
    shpUserTitleR: TBGRAShape;
    shpContent2: TBGRAShape;
    btnAdd: TSpeedButton;
    btnDelete: TSpeedButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure edtSearchUserEnter(Sender: TObject);
    procedure edtSearchUserExit(Sender: TObject);
    procedure edtSearchUserKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure stBoxUsersDrawItem(Control: TWinControl; Index: integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure stBoxUsersSelectionChange(Sender: TObject; User: boolean);

  private
  var
    First: boolean;
    customer: TCustomer;
    item: TItem;
    ItemList: TItemsList;

    procedure UpdateGUI();
    procedure GetCustomers();
  public
  var
    old_selected: integer;
  end;

var
  frmUsers: TfrmUsers;

implementation

{$R *.lfm}

uses main, add_user, del_user_error, del_user, edit_user, shadow, Data;

  { TfrmUsers }

procedure TfrmUsers.UpdateGUI();
var
  id, i, j, h, h1, ih: integer;
  cat_list: TStringList;
  lblCategory, lblItem: TLabel;
begin
  //Set variables to default
  id := 0;
  i := 0;
  ih := 0;
  cat_list := TStringList.Create();
  ItemList := TItemsList.Create();

  try
    DBModule.SQLQuery.Close;
    DBModule.SQLQuery.SQL.Text :=
      'select id_customer, full_name, customer_number from customers where id_customer = :id_customer';
    if stBoxUsers.ItemIndex <> -1 then
    begin
      DBModule.SQLQuery.Params.ParamByName('id_customer').AsInteger :=
        TCustomer(stBoxUsers.Items.Objects[stBoxUsers.ItemIndex]).id_customer;
      DBModule.SQLQuery.Open;
      id := DBModule.SQLQuery.FieldByName('id_customer').AsInteger;
      lblUserName.Caption := DBModule.SQLQuery.FieldByName('full_name').AsString;
      lblUserNumber.Caption := DBModule.SQLQuery.FieldByName('customer_number').AsString;
    end
    else
    begin
      pnlUserContent.Visible := False;
      pnlUserTop.Visible := False;
      Exit;
    end;
  except
    lblUserName.Caption := 'Imię i nazwisko';
    lblUserNumber.Caption := '0000';
  end;

  //Get category list
  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text := 'select category from category_items';
  DBModule.SQLQuery.Open;

  while not DBModule.SQLQuery.EOF do
  begin
    cat_list.Add(DBModule.SQLQuery.FieldByName('category').AsString);
    DBModule.SQLQuery.Next;
  end;
  for i := 0 to cat_list.Count - 1 do
  begin
    if cat_list[i] = 'Komputer' then cat_list.Move(i, 0);
  end;


  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text :=
    'select items.*, category_items.category as category_items from items' +
    ' inner join category_items on items.category = id_category where items.id_customer = :id_cust';
  DBModule.SQLQuery.Params.ParamByName('id_cust').AsInteger := id;
  DBModule.SQLQuery.Open;

  while not DBModule.SQLQuery.EOF do
  begin
    item := Titem.Create;
    item.Name := DBModule.SQLQuery.FieldByName('name').AsString;
    item.category := DBModule.SQLQuery.FieldByName('category_items').AsString;
    item.model := DBModule.SQLQuery.FieldByName('model').AsString;
    item.aq_name := DBModule.SQLQuery.FieldByName('aq_name').AsString;
    item.mark := DBModule.SQLQuery.FieldByName('mark').AsString;
    item.serial_number := DBModule.SQLQuery.FieldByName('serial_number').AsString;
    item.IMEI_1 := DBModule.SQLQuery.FieldByName('IMEI_1').AsString;
    item.IMEI_2 := DBModule.SQLQuery.FieldByName('IMEI_2').AsString;
    item.phone_number := DBModule.SQLQuery.FieldByName('phone_number').AsString;
    ItemList.Add(item);
    DBModule.SQLQuery.Next;
  end;

  //Delete controls from Panel
  for i := Panel1.ControlCount - 1 downto 0 do
  begin
    Panel1.Controls[i].Free;
  end;

  i := 0;
  j := 0;
  h := 0;
  h1 := 0;
  pnlUserContent.Visible := True;
  pnlUserTop.Visible := True;
  for i := 0 to cat_list.Count - 1 do
  begin
    ih := 0;
    lblcategory := TLabel.Create(Self);
    with lblCategory do
    begin
      Font.Size := 12;
      Font.Style := [fsBold];
      Font.Color := clBlack;
      Caption := cat_list[i];
      Autosize := True;
      Transparent := False;
      BorderSpacing.Bottom := 10;
      Parent := Panel1;
      if i > 0 then h := h + 20;
      Top := h;
      Caption := cat_list[i];
      //Align:=alTop;
    end;
    h := h + lblCategory.Height + lblCategory.BorderSpacing.Bottom +
      lblCategory.BorderSpacing.Top;
    for j := 0 to ItemList.Count - 1 do
    begin
      if ItemList.Items[j].category = cat_list[i] then
      begin
        Inc(ih);
        lblItem := TLabel.Create(self);
        with lblItem do
        begin
          Align := alNone;
          Font.Size := 10;
          Font.Style := [];
          Font.Color := clBlack;
          Autosize := True;
          Height := Font.Size * 3 + 5;
          Transparent := False;
          BorderSpacing.Bottom := 10;
          Parent := Panel1;
          Top := h;
          Caption := ItemList[j].Name + ' ' + ItemList[j].mark + ' ' +
            ItemList[j].model + chr(13) + chr(10);
          if ItemList[j].aq_name <> '' then
            Caption := Caption + '[' + ItemList[j].aq_name + '] ' + chr(13) + chr(10);
          Caption := Caption + 'SN: ' + ItemList[j].serial_number;
          if ItemList[j].IMEI_1 <> '' then
            Caption := Caption + chr(13) + chr(10) + 'IMEI_1: ' + ItemList[j].IMEI_1;
          if ItemList[j].IMEI_2 <> '' then
            Caption := Caption + chr(13) + chr(10) + 'IMEI_2: ' + ItemList[j].IMEI_2;
          if ItemList[j].phone_number <> '' then
            Caption := Caption + chr(13) + chr(10) + 'numer telefonu: ' +
              ItemList[j].phone_number;
          //Align:=alTop;
        end;
        h1 := lblItem.Height + lblItem.BorderSpacing.Bottom;
        h := h + h1;
      end;
    end;
    if ih = 0 then
    begin
      lblItem := TLabel.Create(self);
      with lblItem do
      begin
        Align := alNone;
        Font.Size := 10;
        Font.Style := [];
        Font.Color := clSilver;
        Autosize := True;
        Height := Font.Size * 3 + 5;
        Transparent := False;
        BorderSpacing.Bottom := 10;
        Parent := Panel1;
        Top := h;
        Caption := 'nie posiada';
      end;
      h1 := lblItem.Height + lblItem.BorderSpacing.Bottom;
      h := h + h1;
    end;
  end;

  //Panel1.Height:=h+20;
  panel1.Autosize := True;
  pnlUserContent.Height := 64 + Panel1.Height + 20;
  cat_list.Free;
  ItemList.Free;
end;

procedure TfrmUsers.GetCustomers();
var
  i: integer;
begin
  //Get all users(customers) and sorting by last_name
  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text := 'select * from customers order by last_name';
  DBModule.SQLQuery.Open;

  stBoxUsers.Clear;

  if DBModule.SQLQuery.RecordCount > 0 then
  begin
    stBoxUsers.Items.BeginUpdate;
    while not DBModule.SQLQuery.EOF do
    begin
      customer := TCustomer.Create;
      customer.full_name := DBModule.SQLQuery.FieldByName('full_name').AsString;
      customer.id_customer := DBModule.SQLQuery.FieldByName('id_customer').AsInteger;
      customer.status := DBModule.SQLQuery.FieldByName('status').AsInteger;
      customer.customer_number :=
        DBModule.SQLQuery.FieldByName('customer_number').AsString;
      //Add customer to ListBox as Object customer
      stBoxUsers.Items.AddObject(customer.full_name, customer);
      DBModule.SQLQuery.Next;
    end;
    stBoxUsers.Items.EndUpdate;
  end;

  //Check buttons
  btnDelete.Enabled := False;
  btnEdit.Enabled := False;
  if stBoxUsers.Items.Count > 0 then
  begin
    btnDelete.Enabled := True;
    btnEdit.Enabled := True;
  end;
end;

procedure TfrmUsers.FormShow(Sender: TObject);
begin
  First := True;
  GetCustomers();
  pnlUserContent.Visible := False;
  pnlUserTop.Visible := False;
end;

procedure TfrmUsers.stBoxUsersDrawItem(Control: TWinControl; Index: integer;
  ARect: TRect; State: TOwnerDrawState);
var
  s: string;
  st: integer;
begin

  if stBoxUsers.ItemIndex = -1 then Exit;
  with (Control as TListBox).Canvas do
  begin
    if odSelected in State then Brush.Color := $00F9EEE0;
    if TCustomer(stBoxUsers.Items.Objects[Index]).status = 0 then
    begin
      Font.Color := clGray;
      Font.Size := 10;
      s := TCustomer(stBoxUsers.Items.Objects[Index]).full_name;
      FillRect(ARect);
      TextOut(ARect.Left + 5, ARect.Top + 2, s);
    end
    else
    begin
      Font.Color := clBlack;
      s := TCustomer(stBoxUsers.Items.Objects[Index]).full_name;
      FillRect(ARect);
      TextOut(ARect.Left + 5, ARect.Top + 2, s);
    end;
  end;
end;

procedure TfrmUsers.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  stBoxUsers.Clear;
end;

procedure TfrmUsers.btnAddClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to stBoxUsers.Items.Count - 1 do
    if stBoxUsers.Selected[i] then
    begin
      old_selected := i;
    end;
  frmShadow.Show();
  frmAddUser.ShowModal();
  frmMain.SetFocus;
  stBoxUsers.Clear;
  GetCustomers();

  //Setlect added item or select old selected item
  for i := 0 to stBoxUsers.Items.Count - 1 do
    if stBoxUsers.Items[I].Contains(frmAddUser.added_item) then
    begin
      stBoxUsers.Selected[i] := True;
      Exit;
    end
    else
    if stBoxUsers.Items.Count - 1 >= 0 then stBoxUsers.Selected[old_selected] := True;

end;

procedure TfrmUsers.btnDeleteClick(Sender: TObject);
var
  i, selected: integer;
begin

  for i := 0 to stBoxUsers.Items.Count - 1 do
    if stBoxUsers.Selected[i] then
    begin
      selected := i;
    end;
  frmShadow.Show();

  //Dialog box
  case frmDelUser.ShowModal() of
    mrOk: begin
      try
        DBModule.SQLQuery.Close;
        DBModule.SQLQuery.SQL.Text :=
          'delete from customers where id_customer = :id_cust';
        DBModule.SQLQuery.Params.ParamByName('id_cust').AsInteger :=
          TCustomer(stBoxUsers.Items.Objects[stBoxUsers.ItemIndex]).id_customer;
        DBModule.SQLQuery.ExecSQL;
        GetCustomers();
        if selected = 0 then
        begin
          if stBoxUsers.Items.Count - 1 >= 0 then stBoxUsers.Selected[selected] := True;
        end
        else
        begin
          if stBoxUsers.Items.Count - 1 >= 0 then
            stBoxUsers.Selected[selected - 1] := True;
        end;
        UpdateGUI();
      except
        frmShadow.Show();
        frmDelUserError.showModal();
      end;
    end;
    mrCancel: begin
      Exit;
    end;
  end;

end;

procedure TfrmUsers.btnEditClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to stBoxUsers.Items.Count - 1 do
    if stBoxUsers.Selected[i] then
    begin
      old_selected := i;
    end;

  if stBoxUsers.Items.Count > 0 then
  begin
    frmShadow.Show();
    frmEditUser.ShowModal();
    frmMain.SetFocus;
    stBoxUsers.Clear;
    GetCustomers();
    if stBoxUsers.Items.Count - 1 >= 0 then stBoxUsers.Selected[old_selected] := True;
  end;

end;

procedure TfrmUsers.edtSearchUserEnter(Sender: TObject);
begin
  edtSearchUser.SetFocus;
  shpEditBck1.Height := 28;
  shpLineEdit2.Pen.Color := $00BA6900;
  shpLineEdit3.Pen.Color := $00BA6900;
end;

procedure TfrmUsers.edtSearchUserExit(Sender: TObject);
begin
  shpEditBck1.Height := 29;
  shpLineEdit2.Pen.Color := $00969696;
  shpLineEdit3.Pen.Color := $00969696;
end;

procedure TfrmUsers.edtSearchUserKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
var
  i: integer;
begin

  for i := 0 to stBoxUsers.Items.Count - 1 do
    if stBoxUsers.Items[I].Contains(edtSearchUser.Text) then
    begin
      stBoxUsers.Selected[i] := True;
      Exit;
    end;
end;

procedure TfrmUsers.FormResize(Sender: TObject);
begin
  if (First) and (stBoxUsers.Count > 0) then
  begin
    stBoxUsers.ItemIndex := 0;
    stBoxUsers.SetFocus;
    old_selected := 0;
  end;
  First := False;
end;

procedure TfrmUsers.stBoxUsersSelectionChange(Sender: TObject; User: boolean);
begin
  UpdateGui();
end;

end.
