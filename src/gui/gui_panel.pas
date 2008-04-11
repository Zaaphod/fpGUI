{
    fpGUI  -  Free Pascal GUI Library

    Copyright (C) 2006 - 2008 See the file AUTHORS.txt, included in this
    distribution, for details of the copyright.

    See the file COPYING.modifiedLGPL, included in this distribution,
    for details about redistributing fpGUI.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    Description:
      Defines a Panel control. Also known as a Bevel or Frame control.
      This control can also draw itself like a GroupBox component.
}

unit gui_panel;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  fpgfx,
  gfxbase,
  gfx_widget;

type

  TPanelShape = (bsBox, bsFrame, bsTopLine, bsBottomLine, bsLeftLine,
    bsRightLine, bsSpacer);

  TPanelStyle = (bsLowered, bsRaised);


  TfpgAbstractPanel = class(TfpgWidget)
  private
    FPanelShape: TPanelShape;
    FPanelStyle: TPanelStyle;
    procedure   SetPanelStyle(const AValue: TPanelStyle);
    function    GetBackgroundColor: Tfpgcolor;
    procedure   SetBackgroundColor(const AValue: Tfpgcolor);
  protected
    property    BackgroundColor: TfpgColor read GetBackgroundColor write SetBackgroundColor;
    property    Style: TPanelStyle read FPanelStyle write SetPanelStyle default bsRaised;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TfpgBevel = class(TfpgAbstractPanel)
  private
    procedure   SetPanelShape(const AValue: TPanelShape);
  protected
    procedure   HandlePaint; override;
  published
    property    BackgroundColor;
    property    Shape: TPanelShape read FPanelShape write SetPanelShape default bsBox;
    property    Style;
    property    OnClick;
    property    OnDoubleClick;
  end;

  TfpgPanel = class(TfpgAbstractPanel)
  private
    FAlignment: TAlignment;
    FLayout: TLayout;
    FWrapText: boolean;
    FLineSpace: integer;
    FMargin: integer;
    FText: string;
    function    GetAlignment: TAlignment;
    procedure   SetAlignment(const AValue: TAlignment);
    function    GetLayout: TLayout;
    procedure   SetLayout(const AValue: TLayout);
    function    GetText: string;
    procedure   SetText(const AValue: string);
    function    GetTextColor: Tfpgcolor;
    procedure   SetTextColor(const AValue: Tfpgcolor);
    function    GetFontDesc: string;
    procedure   SetFontDesc(const AValue: string);
    function    GetLineSpace: integer;
    procedure   SetLineSpace(const AValue: integer);
    function    GetMargin: integer;
    procedure   SetMargin(const AValue: integer);
    function    GetWrapText: boolean;
    procedure   SetWrapText(const AValue: boolean);
  protected
    FFont: TfpgFont;
    procedure   HandlePaint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property    Font: TfpgFont read FFont;
  published
    property    Alignment: TAlignment read GetAlignment write SetAlignment default taCenter;
    property    BackgroundColor;
    property    FontDesc: string read GetFontDesc write SetFontDesc;
    property    Layout: TLayout read GetLayout write SetLayout default tlCenter;
    property    Style;
    property    Text: string read GetText write SetText;
    property    TextColor: Tfpgcolor read GetTextColor write SetTextColor;
    property    LineSpace: integer read GetLineSpace write SetLineSpace default 2;
    property    Margin: integer read GetMargin write SetMargin default 2;
    property    WrapText: boolean read GetWrapText write SetWrapText default False;
    property    OnClick;
    property    OnDoubleClick;
  end;

  TfpgGroupBox = class(TfpgAbstractPanel)
  private
    FAlignment: TAlignment;
    FMargin: integer;
    FText: string;
    function    GetAlignment: TAlignment;
    procedure   SetAlignment(const AValue: TAlignment);
    function    GetText: string;
    procedure   SetText(const AValue: string);
    function    GetTextColor: Tfpgcolor;
    procedure   SetTextColor(const AValue: Tfpgcolor);
    function    GetFontDesc: string;
    procedure   SetFontDesc(const AValue: string);
    function    GetMargin: integer;
    procedure   SetMargin(const AValue: integer);
  protected
    FFont: TfpgFont;
    procedure   HandlePaint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property    Font: TfpgFont read FFont;
  published
    property    Alignment: TAlignment read GetAlignment write SetAlignment default taCenter;
    property    BackgroundColor;
    property    FontDesc: string read GetFontDesc write SetFontDesc;
    property    Style;
    property    Text: string read GetText write SetText;
    property    TextColor: Tfpgcolor read GetTextColor write SetTextColor;
    property    Margin: integer read GetMargin write SetMargin default 2;
    property    OnClick;
    property    OnDoubleClick;
  end;


function CreateBevel(AOwner: TComponent; ALeft, ATop, AWidth, AHeight: TfpgCoord; AShape: TPanelShape;
         AStyle: TPanelStyle): TfpgBevel;

function CreatePanel(AOwner: TComponent; ALeft, ATop, AWidth, AHeight: TfpgCoord; AText: string;
         AStyle: TPanelStyle; AALignment: TAlignment= taCenter; ALayout: TLayout= tlCenter;
         AMargin: integer= 2; ALineSpace: integer= 2): TfpgPanel;

function CreateGroupBox(AOwner: TComponent; ALeft, ATop, AWidth, AHeight: TfpgCoord; AText: string;
         AStyle: TPanelStyle; AALignment: TAlignment= taCenter; AMargin: integer= 2): TfpgGroupBox;


implementation

function CreateBevel(AOwner: TComponent; ALeft, ATop, AWidth, AHeight: TfpgCoord; AShape: TPanelShape;
         AStyle: TPanelStyle): TfpgBevel;
begin
  Result        := TfpgBevel.Create(AOwner);
  Result.Left   := ALeft;
  Result.Top    := ATop;
  Result.Width  := AWidth;
  Result.Height := AHeight;
  Result.Shape  := AShape;
  Result.Style  := AStyle;
end;

function CreatePanel(AOwner: TComponent; ALeft, ATop, AWidth, AHeight: TfpgCoord; AText: string;
         AStyle: TPanelStyle; AALignment: TAlignment= taCenter; ALayout: TLayout= tlCenter;
         AMargin: integer= 2; ALineSpace: integer= 2): TfpgPanel;
begin
  Result          := TfpgPanel.Create(AOwner);
  Result.Left     := ALeft;
  Result.Top      := ATop;
  Result.Width    := AWidth;
  Result.Height   := AHeight;
  Result.FText    := AText;
  Result.Style    := AStyle;
  Result.FAlignment:= AAlignment;
  Result.FLayout   := ALayout;
  Result.FMargin   := AMargin;
  Result.FLineSpace:= ALineSpace;
end;

function CreateGroupBox(AOwner: TComponent; ALeft, ATop, AWidth, AHeight: TfpgCoord; AText: string;
         AStyle: TPanelStyle; AALignment: TAlignment= taCenter; AMargin: integer= 2): TfpgGroupBox;
begin
  Result            := TfpgGroupBox.Create(AOwner);
  Result.Left       := ALeft;
  Result.Top        := ATop;
  Result.Width      := AWidth;
  Result.Height     := AHeight;
  Result.FText      := AText;
  Result.Style      := AStyle;
  Result.FAlignment := AAlignment;
  Result.FMargin    := AMargin;
end;


{TfpgAbstractPanel}

procedure TfpgAbstractPanel.SetPanelStyle(const AValue: TPanelStyle);
begin
  if FPanelStyle = AValue then
    Exit; //==>
  FPanelStyle := AValue;
  Repaint;
end;

function TfpgAbstractPanel.GetBackgroundColor: Tfpgcolor;
begin
  Result := FBackgroundColor;
end;

procedure TfpgAbstractPanel.SetBackgroundColor(const AValue: Tfpgcolor);
begin
  if FBackgroundColor <> AValue then
  begin
    FBackgroundColor := AValue;
    Repaint;
  end;
end;

constructor TfpgAbstractPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPanelShape      := bsBox;
  FPanelStyle      := bsRaised;
  FWidth           := 80;
  FHeight          := 80;
  FFocusable       := True;  // otherwise children can't get focus
  FBackgroundColor := Parent.BackgroundColor;
end;

{TfpgBevel}

procedure TfpgBevel.SetPanelShape(const AValue: TPanelShape);
begin
  if FPanelShape <> AValue then
  begin
    FPanelShape := AValue;
    Repaint;
  end;
end;

procedure TfpgBevel.HandlePaint;
var
  r: TfpgRect;
begin
  Canvas.BeginDraw;
  inherited HandlePaint;

  Canvas.Clear(BackgroundColor);

  //  Canvas.SetLineStyle(2, lsSolid);
  //  Canvas.SetColor(clWindowBackground);
  //  Canvas.DrawRectangle(1, 1, Width - 1, Height - 1);
  Canvas.SetLineStyle(1, lsSolid);

  if Style = bsRaised then
    Canvas.SetColor(clHilite2)
  else
    Canvas.SetColor(clShadow2);

  if Shape in [bsBox, bsFrame, bsTopLine] then
    Canvas.DrawLine(0, 0, Width - 1, 0);
  if Shape in [bsBox, bsFrame, bsLeftLine] then
    Canvas.DrawLine(0, 1, 0, Height - 1);
  if Shape in [bsFrame, bsRightLine] then
    Canvas.DrawLine(Width - 2, 1, Width - 2, Height - 1);
  if Shape in [bsFrame, bsBottomLine] then
    Canvas.DrawLine(1, Height - 2, Width - 1, Height - 2);

  if Style = bsRaised then
    Canvas.SetColor(clShadow2)
  else
    Canvas.SetColor(clHilite2);

  if Shape in [bsFrame, bsTopLine] then
    Canvas.DrawLine(1, 1, Width - 2, 1);
  if Shape in [bsFrame, bsLeftLine] then
    Canvas.DrawLine(1, 2, 1, Height - 2);
  if Shape in [bsBox, bsFrame, bsRightLine] then
    Canvas.DrawLine(Width - 1, 0, Width - 1, Height - 1);
  if Shape in [bsBox, bsFrame, bsBottomLine] then
    Canvas.DrawLine(0, Height - 1, Width, Height - 1);

  Canvas.EndDraw;
end;

{TfpgPanel}

function TfpgPanel.GetAlignment: TAlignment;
begin
  Result := FAlignment;
end;

procedure TfpgPanel.SetAlignment(const AValue: TAlignment);
begin
  if FAlignment <> AValue then
  begin
    FAlignment := AValue;
    Repaint;
  end;
end;

function TfpgPanel.GetLayout: TLayout;
begin
  Result := FLayout;
end;

procedure TfpgPanel.SetLayout(const AValue: TLayout);
begin
  if FLayout <> AValue then
  begin
    FLayout := AValue;
    Repaint;
  end;
end;

function TfpgPanel.GetText: string;
begin
  Result := FText;
end;

procedure TfpgPanel.SetText(const AValue: string);
begin
  if FText <> AValue then
  begin
    FText := AValue;
    Repaint;
  end;
end;

function TfpgPanel.GetTextColor: Tfpgcolor;
begin
  Result := FTextColor;
end;

procedure TfpgPanel.SetTextColor(const AValue: Tfpgcolor);
begin
  if FTextColor <> AValue then
  begin
    FTextColor := AValue;
    Repaint;
  end;
end;

function TfpgPanel.GetFontDesc: string;
begin
  Result := FFont.FontDesc;
end;

procedure TfpgPanel.SetFontDesc(const AValue: string);
begin
  FFont.Free;
  FFont := fpgGetFont(AValue);
  Repaint;
end;

function TfpgPanel.GetLineSpace: integer;
begin
  Result := FLineSpace;
end;

procedure TfpgPanel.SetLineSpace(const AValue: integer);
begin
  if FLineSpace <> AValue then
  begin
    FLineSpace := AValue;
    Repaint;
  end;
end;

function TfpgPanel.GetMargin: integer;
begin
  Result := FMargin;
end;

procedure TfpgPanel.SetMargin(const AValue: integer);
begin
  if FMargin <> AValue then
  begin
    FMargin := AValue;
    Repaint;
  end;
end;

function Tfpgpanel.GetWrapText: boolean;
begin
  Result := FWrapText;
end;

procedure Tfpgpanel.SetWrapText(const AValue: boolean);
begin
  if FWrapText <> AValue then
  begin
    FWrapText := AValue;
    Repaint;
  end;
end;
procedure TfpgPanel.HandlePaint;
var
  r: TfpgRect;
  lTxtFlags: TFTextFlags;
begin
  Canvas.BeginDraw;
  inherited HandlePaint;

  Canvas.Clear(BackgroundColor);

  //  Canvas.SetLineStyle(2, lsSolid);
  //  Canvas.SetColor(clWindowBackground);
  //  Canvas.DrawRectangle(1, 1, Width - 1, Height - 1);
  Canvas.SetLineStyle(1, lsSolid);

  if Style = bsRaised then
    Canvas.SetColor(clHilite2)
  else
    Canvas.SetColor(clShadow2);

  Canvas.DrawLine(0, 0, Width - 1, 0);
  Canvas.DrawLine(0, 1, 0, Height - 1);

  if Style = bsRaised then
    Canvas.SetColor(clShadow2)
  else
    Canvas.SetColor(clHilite2);

  Canvas.DrawLine(Width - 1, 0, Width - 1, Height - 1);
  Canvas.DrawLine(0, Height - 1, Width, Height - 1);

  Canvas.SetTextColor(FTextColor);
  Canvas.SetFont(Font);

  lTxtFlags:= [];
  if FWrapText then
    Include(lTxtFlags, txtWrap);
  case FAlignment of
    taLeftJustify:
      Include(lTxtFlags, txtLeft);
    taRightJustify:
      Include(lTxtFlags, txtRight);
    taCenter:
      Include(lTxtFlags, txtHCenter);
    end;
  case FLayout of
    tlTop:
      Include(lTxtFlags, txtTop);
    tlBottom:
      Include(lTxtFlags, txtBottom);
    tlCenter:
      Include(lTxtFlags, txtVCenter);
    end;
  Canvas.DrawText(FMargin, FMargin, Width - FMargin * 2, Height - FMargin * 2, FText, lTxtFlags, FLineSpace);

  Canvas.EndDraw;
end;

constructor TfpgPanel.Create(Aowner: TComponent);
begin
  inherited Create(AOwner);
  FText             := 'Panel';
  FFont             := fpgGetFont('#Label1');
  FPanelShape       := bsBox;
  FPanelStyle       := bsRaised;
  FWidth            := 80;
  FHeight           := 80;
  FFocusable        := True;  // otherwise children can't get focus
  FBackgroundColor  := Parent.BackgroundColor;
  FAlignment        := taCenter;
  FLayout           := tlCenter;
  FWrapText         := False;
  FLineSpace        := 2;
  FMargin           := 2;
end;

{TfpgGroupBox}

function TfpgGroupBox.GetAlignment: TAlignment;
begin
  Result := FAlignment;
end;

procedure TfpgGroupBox.SetAlignment(const AValue: TAlignment);
begin
  if FAlignment <> AValue then
  begin
    FAlignment := AValue;
    Repaint;
  end;
end;

function TfpgGroupBox.GetText: string;
begin
  Result := FText;
end;

procedure TfpgGroupBox.SetText(const AValue: string);
begin
  if FText <> AValue then
  begin
    FText := AValue;
    Repaint;
  end;
end;

function TfpgGroupBox.GetTextColor: Tfpgcolor;
begin
  Result := FTextColor;
end;

procedure TfpgGroupBox.SetTextColor(const AValue: Tfpgcolor);
begin
  if FTextColor <> AValue then
  begin
    FTextColor := AValue;
    Repaint;
  end;
end;

function TfpgGroupBox.GetFontDesc: string;
begin
  Result := FFont.FontDesc;
end;

procedure TfpgGroupBox.SetFontDesc(const AValue: string);
begin
  FFont.Free;
  FFont := fpgGetFont(AValue);
  Repaint;
end;

function TfpgGroupBox.GetMargin: integer;
begin
  Result := FMargin;
end;

procedure TfpgGroupBox.SetMargin(const AValue: integer);
begin
  if FMargin <> AValue then
  begin
    FMargin := AValue;
    Repaint;
  end;
end;

procedure TfpgGroupBox.HandlePaint;
var
  r: TfpgRect;
  lTxtFlags: TFTextFlags;
  w: integer;
begin
  Canvas.BeginDraw;
  inherited HandlePaint;

  Canvas.Clear(Parent.BackgroundColor);
  Canvas.ClearClipRect;
  r.SetRect(0, 5, Width, Height);
  Canvas.SetClipRect(r);
  Canvas.Clear(FBackgroundColor);
//  Canvas.ClearClipRect;

  //  Canvas.SetLineStyle(2, lsSolid);
  //  Canvas.SetColor(clWindowBackground);
  //  Canvas.DrawRectangle(1, 1, Width - 1, Height - 1);
  Canvas.SetLineStyle(1, lsSolid);

  if Style = bsRaised then
    Canvas.SetColor(clHilite2)
  else
    Canvas.SetColor(clShadow2);

  Canvas.DrawLine(0, 5, Width - 1, 5);
  Canvas.DrawLine(0, 6, 0, Height - 1);

  if Style = bsRaised then
    Canvas.SetColor(clShadow2)
  else
    Canvas.SetColor(clHilite2);

  Canvas.DrawLine(Width - 1, 5, Width - 1, Height - 1);
  Canvas.DrawLine(0, Height - 1, Width, Height - 1);

  Canvas.SetTextColor(FTextColor);
  Canvas.SetFont(Font);
  
  lTxtFlags:= [txtTop];
  case FAlignment of
    taLeftJustify:
      begin
        w := FFont.TextWidth(FText) + FMargin * 2;
        r.SetRect(5, 0, w, FFont.Height + FMargin);
        Canvas.SetClipRect(r);
        Canvas.Clear(FBackgroundColor);

        if Style = bsRaised then
          Canvas.SetColor(clHilite2)
        else
          Canvas.SetColor(clShadow2);

        Canvas.DrawLine(5, 0, w + 5, 0);
        Canvas.DrawLine(5, 0, 5, 6);

        if Style = bsRaised then
          Canvas.SetColor(clShadow2)
        else
          Canvas.SetColor(clHilite2);

        Canvas.DrawLine(w + 5, 0, w + 5, 6);

        Include(lTxtFlags, txtLeft);
        Canvas.DrawText(FMargin + 5, 0, FText, lTxtFlags);
      end;
    taRightJustify:
      begin
        w := Width - FFont.TextWidth(FText) - (FMargin * 2) - 5;
        r.SetRect(w, 0, FFont.TextWidth(FText) + FMargin * 2, FFont.Height + FMargin);
        Canvas.SetClipRect(r);
        Canvas.Clear(FBackgroundColor);

        if Style = bsRaised then
          Canvas.SetColor(clHilite2)
        else
          Canvas.SetColor(clShadow2);

        Canvas.DrawLine(w, 0, Width - 5, 0);
        Canvas.DrawLine(w, 0, w, 6);

        if Style = bsRaised then
          Canvas.SetColor(clShadow2)
        else
          Canvas.SetColor(clHilite2);

        Canvas.DrawLine(Width - 6, 0, Width - 6, 6);

        Include(lTxtFlags, txtRight);
        Canvas.DrawText(Width - FFont.TextWidth(FText) - FMargin - 5, 0, FText, lTxtFlags);
      end;
    taCenter:
      begin
        w := (Width - FFont.TextWidth(FText) - FMargin * 2) div 2;
        r.SetRect(w, 0, FFont.TextWidth(FText) + FMargin * 2, FFont.Height + FMargin);
        Canvas.SetClipRect(r);
        Canvas.Clear(FBackgroundColor);

        if Style = bsRaised then
          Canvas.SetColor(clHilite2)
        else
          Canvas.SetColor(clShadow2);

        Canvas.DrawLine(w, 0, w + FFont.TextWidth(FText) + FMargin * 2, 0);
        Canvas.DrawLine(w, 0, w, 6);

        if Style = bsRaised then
          Canvas.SetColor(clShadow2)
        else
          Canvas.SetColor(clHilite2);

        Canvas.DrawLine(w + FFont.TextWidth(FText) + FMargin * 2, 0, w + FFont.TextWidth(FText) + FMargin * 2, 6);

        Include(lTxtFlags, txtHCenter);
        Canvas.DrawText(w + FMargin, 0, FText, lTxtFlags);
      end;
    end;

  Canvas.EndDraw;
end;

constructor TfpgGroupBox.Create(Aowner: TComponent);
begin
  inherited Create(AOwner);
  FText             := 'Group box';
  FFont             := fpgGetFont('#Label1');
  FPanelShape       := bsBox;
  FPanelStyle       := bsRaised;
  FWidth            := 80;
  FHeight           := 80;
  FFocusable        := True;  // otherwise children can't get focus
  FBackgroundColor  := Parent.BackgroundColor;
  FAlignment        := taLeftJustify;
  FMargin           := 2;
end;

end.

