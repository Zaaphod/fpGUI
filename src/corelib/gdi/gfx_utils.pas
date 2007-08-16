unit gfx_utils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils; 
  
  
{$I gfx_utils_intf.inc}


implementation


// File utils
function ExtractTargetSymLinkPath(ALink: string): string;
begin
{
    var
      info : _stat;
    .....
    fullname := FDirectoryName + e.Name;
    if lstat(PChar(fullname),info) = 0 then
    begin
      e.IsLink := ((sr.Mode and $F000) = $A000);
      if e.IsLink then
      begin
        SetLength(e.LinkTarget, MAX_PATH);  // length was 256
        r := libc.readlink(PChar(fullname),@(e.LinkTarget[1]), sizeof(e.LinkTarget));
        if r > 0 then
          SetLength(e.LinkTarget, r)
        else
          e.LinkTarget := '';
        libc.stat(PChar(fullname), info);
      end;
}
end;

function FileIsSymlink(const AFilename: string): boolean;
begin
  Result := False;
end;


end.

