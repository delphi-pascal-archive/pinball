unit frmMain;

interface

uses
  Windows, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls;

type
  TBallDirection = (bdLeftUP, bdLeftDown, bdRightUp, bdRightDown);

type
  TBrick = class(TShape)
  public
    FTimesToHit   : integer;
    FNumberOfHits : integer;
  end;

  TBrickArray = Array[0..160] of TBrick;
  TBricks     = TBrickArray;

type
  TformMain = class(TForm)
    MainMenu1     : TMainMenu;
    PanelGame     : TPanel;
    miGame        : TMenuItem;
    miNew         : TMenuItem;
    miPauze       : TMenuItem;
    miN1          : TMenuItem;
    miExit        : TMenuItem;
    miHelp: TMenuItem;
    ShapeUser     : TShape;
    ShapeBall     : TShape;
    miTakeItEasy  : TMenuItem;
    miBringThemOn : TMenuItem;
    miHurtMe      : TMenuItem;
    miFoolsPlay   : TMenuItem;
    miKeys: TMenuItem;
    miAbout: TMenuItem;
    procedure miTakeItEasyClick(Sender: TObject);
    procedure miBringThemOnClick(Sender: TObject);
    procedure miHurtMeClick(Sender: TObject);
    procedure miFoolsPlayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miAboutClick(Sender: TObject);
    procedure miKeysClick(Sender: TObject);
  private
    BallDirection : TBallDirection;
    GameSpeed     : integer;
    BallSpeed     : integer;
    Difficulty    : integer;
    Bricks        : TBricks;
    procedure StartNewGame(aDifficulty: integer);
    procedure PlayABall;
    procedure BuildTheWall;
    procedure ShowDelphi;
    procedure CheckTheWall(var NumberOfHits, HorizontalValue, VerticalValue: integer);
  public
  end;

var
  formMain: TformMain;

implementation

{$R *.DFM}

procedure TformMain.StartNewGame(aDifficulty: integer);
var
  I : integer;
begin
  BallDirection := bdRightUp;
  GameSpeed     := 15;
  BallSpeed     := aDifficulty;
  ShapeBall.SetBounds((PanelGame.Width - ShapeBall.Width) div 2,
                      229,
                      ShapeBall.Width,
                      ShapeBall.Height);
  for I := 0 to 160 do
    begin
      Bricks[I].Visible       := TRUE;
      Bricks[I].FNumberOfHits := 0;
    end;
  PlayABall;
end;


procedure TformMain.BuildTheWall;
var
  I,
  RowCount,
  BrickTop,
  BrickLeft,
  BrickWidth : integer;
begin
  BrickWidth := 20;
  RowCount   := 0;
  BrickTop   := 24;//0;
  BrickLeft  := 0;
  if Bricks[0] = NIL then
    for I := 0 to 160 do
      begin
        Bricks[I] := TBrick.Create(Self);
        with Bricks[I] do
          begin
            Parent        := PanelGame;
            FTimesToHit   := 1;
            FNumberOfHits := 0;
            Width         := BrickWidth;
            Height        := 12;
            Brush.Color   := clYellow;
            Shape         := stRoundRect;
            BrickLeft     := RowCount * BrickWidth + 1;
            SetBounds(BrickLeft,
                      BrickTop,
                      BrickWidth,
                      12);
            Inc(BrickLeft);
            Inc(RowCount);
            if RowCount >= 23 then
              begin
                RowCount  := 0;
                BrickTop  := BrickTop + Height;
                BrickLeft := 0;
              end;
          end;
      end;
  ShowDelphi;
end;


procedure TformMain.ShowDelphi;
var
  I : integer;
  procedure DoSetting(aBrick: TBrick);
  begin
    aBrick.Brush.Color       := clRed;
    aBrick.FTimesToHit := 2;
    aBrick.Update;
  end;
begin
  DoSetting(Bricks[24]);
  DoSetting(Bricks[25]);
  DoSetting(Bricks[28]);
  DoSetting(Bricks[29]);
  DoSetting(Bricks[30]);
  DoSetting(Bricks[32]);
  DoSetting(Bricks[36]);
  DoSetting(Bricks[37]);
  DoSetting(Bricks[38]);
  DoSetting(Bricks[40]);
  DoSetting(Bricks[42]);
  DoSetting(Bricks[44]);

  DoSetting(Bricks[47]);
  DoSetting(Bricks[49]);
  DoSetting(Bricks[51]);
  DoSetting(Bricks[55]);
  DoSetting(Bricks[59]);
  DoSetting(Bricks[61]);
  DoSetting(Bricks[63]);
  DoSetting(Bricks[65]);
  DoSetting(Bricks[67]);

  DoSetting(Bricks[70]);
  DoSetting(Bricks[72]);
  DoSetting(Bricks[74]);
  DoSetting(Bricks[75]);
  DoSetting(Bricks[78]);
  DoSetting(Bricks[82]);
  DoSetting(Bricks[83]);
  DoSetting(Bricks[84]);
  DoSetting(Bricks[86]);
  DoSetting(Bricks[87]);
  DoSetting(Bricks[88]);
  DoSetting(Bricks[90]);

  DoSetting(Bricks[93]);
  DoSetting(Bricks[95]);
  DoSetting(Bricks[97]);
  DoSetting(Bricks[101]);
  DoSetting(Bricks[105]);
  DoSetting(Bricks[109]);
  DoSetting(Bricks[111]);
  DoSetting(Bricks[113]);

  DoSetting(Bricks[116]);
  DoSetting(Bricks[117]);
  DoSetting(Bricks[120]);
  DoSetting(Bricks[121]);
  DoSetting(Bricks[122]);
  DoSetting(Bricks[124]);
  DoSetting(Bricks[125]);
  DoSetting(Bricks[126]);
  DoSetting(Bricks[128]);
  DoSetting(Bricks[132]);
  DoSetting(Bricks[134]);
  DoSetting(Bricks[136]);
end;


procedure TformMain.PlayABall;
var
  BallIsOut                                   : boolean;
  DummyRect                                   : TRect;
  HorizontalValue,
  VerticalValue,
  NumberOfHits,
  CalculatedLeftPosOfTheBallWhenHittingTheTop : integer;
begin
  HorizontalValue := 0;
  VerticalValue   := 0;
  NumberOfHits    := 0;
  BallIsOut       := (ShapeBall.Top <= 0 - ShapeBall.Height) or
                     (ShapeBall.Top >= (PanelGame.Height + ShapeBall.Height));
  while not BallIsOut do
    begin
      Application.ProcessMessages;
      //Set the Pallet of the user to whatever he thinks is right...
      if GetKeyState(VK_LEFT) < 0 then
        if ShapeUser.Left > 0 then
          ShapeUser.SetBounds(ShapeUser.Left - 7, ShapeUser.Top, ShapeUser.Width, ShapeUser.Height);
      if GetKeyState(VK_RIGHT) < 0 then
        if ShapeUser.Left < (PanelGame.Width - ShapeUser.Width) then
          ShapeUser.SetBounds(ShapeUser.Left + 7, ShapeUser.Top, ShapeUser.Width, ShapeUser.Height);
      if GetKeyState(VK_END) < 0 then
        begin
          Application.ProcessMessages;
          Application.Terminate;
          Halt;
          Application.ProcessMessages;
        end;


      //Find and correct the direction of the ball...
      if ShapeBall.Left <= 0 then
        begin
          if BallDirection = bdLeftUp then
            BallDirection := bdRightUp;
          if BallDirection = bdLeftDown then
            BallDirection := bdRightDown;
        end;
      if (ShapeBall.Left + ShapeBall.Width) >= PanelGame.Width then
        begin
          if BallDirection = bdRightUp then
            BallDirection := bdLeftUp;
          if BallDirection = bdRightDown then
            BallDirection := bdLeftDown;
        end;
      if ShapeBall.Top <= 0 then
        begin
          if BallDirection = bdLeftUp then
            BallDirection := bdLeftDown;
          if BallDirection = bdRightUp then
            BallDirection := bdRightDown;
        end;
      CheckTheWall(NumberOfHits, HorizontalValue, VerticalValue);

      if InterSectRect(DummyRect, ShapeBall.BoundsRect, ShapeUser.BoundsRect) then
        begin
          //The ball is bouncing against the pallet of the User...
          inc(NumberOfHits);
          if BallDirection = bdRightDown then
            BallDirection := bdRightUp;
          if BallDirection = bdLeftDown then
            BallDirection := bdLeftUp;

          if (ShapeBall.Left + (ShapeBall.Width div 2)) < (ShapeUser.Left + (ShapeUser.Width div 3)) then
            begin
              HorizontalValue := 2;
              VerticalValue   := 0;
            end;
          if ((ShapeBall.Left + (ShapeBall.Width div 2)) > (ShapeUser.Left + (ShapeUser.Width div 3))) and
             ((ShapeBall.Left + (ShapeBall.Width div 2)) < (ShapeUser.Left + ((ShapeUser.Width div 3) * 2))) then
            begin
              HorizontalValue := 0;
              VerticalValue   := 0;
            end;
          if (ShapeBall.Left + (ShapeBall.Width div 2)) > (ShapeUser.Left + ((ShapeUser.Width div 3) * 2)) then
            begin
              HorizontalValue := 0;
              VerticalValue   := 2;
            end;
        end;

      //Move the ball...
      if NumberOfHits > 30 then
        begin
          NumberOfHits := 0;
          inc(BallSpeed);
        end;
      case BallDirection of
        bdLeftUP    : ShapeBall.SetBounds(ShapeBall.Left - (HorizontalValue + BallSpeed), ShapeBall.Top - (VerticalValue + BallSpeed), ShapeBall.Width, ShapeBall.Height);
        bdLeftDown  : ShapeBall.SetBounds(ShapeBall.Left - (HorizontalValue + BallSpeed), ShapeBall.Top + (VerticalValue + BallSpeed), ShapeBall.Width, ShapeBall.Height);
        bdRightUp   : ShapeBall.SetBounds(ShapeBall.Left + (HorizontalValue + BallSpeed), ShapeBall.Top - (VerticalValue + BallSpeed), ShapeBall.Width, ShapeBall.Height);
        bdRightDown : ShapeBall.SetBounds(ShapeBall.Left + (HorizontalValue + BallSpeed), ShapeBall.Top + (VerticalValue + BallSpeed), ShapeBall.Width, ShapeBall.Height);
      end;
      ShapeBall.UpDate;
      Sleep(GameSpeed);
      BallIsOut := (ShapeBall.Top >= (PanelGame.Height + ShapeBall.Height));
    end;
  showmessage('Ball is out...');
end;


procedure TformMain.CheckTheWall(var NumberOfHits, HorizontalValue, VerticalValue: integer);
var
  I         : integer;
  DummyRect : TRect;
  Found     : boolean;
begin
  I     := 0;
  Found := FALSE;
  while not Found and (I < 160) do
    begin
      if Bricks[I].Visible then
        if InterSectRect(DummyRect, ShapeBall.BoundsRect, Bricks[I].BoundsRect) then
          begin
            Found := TRUE;

            Inc(NumberOfHits);
            case BallDirection of
              bdRightUp   : BallDirection := bdRightDown;
              bdLeftUp    : BallDirection := bdLeftDown;
              bdRightDown : BallDirection := bdRightUp;
              bdLeftDown  : BallDirection := bdLeftUp;
            end;

            if (ShapeBall.Left + (ShapeBall.Width div 2)) < (Bricks[I].Left + (Bricks[I].Width div 3)) then
              begin
                HorizontalValue := 2;
                VerticalValue   := 0;
              end;
            if ((ShapeBall.Left + (ShapeBall.Width div 2)) > (Bricks[I].Left + (Bricks[I].Width div 3))) and
               ((ShapeBall.Left + (ShapeBall.Width div 2)) < (Bricks[I].Left + ((Bricks[I].Width div 3) * 2))) then
              begin
                HorizontalValue := 0;
                VerticalValue   := 0;
              end;
            if (ShapeBall.Left + (ShapeBall.Width div 2)) > (Bricks[I].Left + ((Bricks[I].Width div 3) * 2)) then
              begin
                HorizontalValue := 0;
                VerticalValue   := 2;
              end;

            Bricks[I].FNumberOfHits  := Bricks[I].FNumberOfHits + 1;
            if Bricks[I].FNumberOfHits = Bricks[I].FTimesToHit then
              Bricks[I].Visible := FALSE;
          end;
      Inc(I);
    end;
end;


procedure TformMain.miTakeItEasyClick(Sender: TObject);
begin
  StartNewGame(1)
end;


procedure TformMain.miBringThemOnClick(Sender: TObject);
begin
    StartNewGame(2)
end;


procedure TformMain.miHurtMeClick(Sender: TObject);
begin
  StartNewGame(3);
end;


procedure TformMain.miFoolsPlayClick(Sender: TObject);
begin
  StartNewGame(4);
end;


procedure TformMain.FormShow(Sender: TObject);
begin
  BuildTheWall;
end;


procedure TformMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I : integer;
begin
  for I := 0 to 160 do
    try
      Bricks[I].Free;
      Bricks[I] := NIL;
    except  
    end;
end;

procedure TformMain.miAboutClick(Sender: TObject);
begin
  MessageBox(Handle,
             PChar('Break out, by Guido Geurts' + #13 + #13 + 'Written in Delphi, the best Windows development tool ever...'),
             PChar('Use the source, Luke'),
             MB_OK);
end;

procedure TformMain.miKeysClick(Sender: TObject);
begin
  MessageBox(Handle,
             PChar('Arrow keys : move your pallet' + #13 +
                   'End key    : Quit game rapidly and remove from screen.'),
             PChar('How to play...'),
             MB_OK);
end;

end.
