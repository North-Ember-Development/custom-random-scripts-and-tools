Set WshShell = CreateObject("WScript.Shell")
regKey = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\"

DigitalProductId = WshShell.RegRead(regKey & "DigitalProductId") 
Win10ProductName = Replace(WshShell.RegRead(regKey &  "ProductName"), "Windows ", "Win") & vbNewLine 
Win10ProductID   = WshShell.RegRead(regKey & "ProductID") & vbNewLine
Win10ProductKey  = ConvertToKey(DigitalProductId) & vbNewLine
Win10ProductID   = Win10ProductName & Win10ProductKey

yesnot = MsgBox(Win10ProductID, vbYesNo, "Save Key To File")

If yesnot = vbYes Then
    Set objFSO=CreateObject("Scripting.FileSystemObject")
    Set objFile = objFSO.CreateTextFile("winkey.txt",True)
    objFile.Write "PRODUCT_KEY: " & Win10ProductKey & vbNewLine & "// Author <nightmare.flow0@gmail.com>" & vbNewLine & "// Written at - " & TimeStamp
    objFile.Close
End iF

Function ConvertToKey(regKey)
    Const KeyOffset = 52
    isWin10 = (regKey(66) \ 6) And 1
    regKey(66) = (regKey(66) And &HF7) Or ((isWin10 And 2) * 4)
    j = 24
    Chars = "BCDFGHJKMPQRTVWXY2346789"
    Do
        Cur = 0
        y = 14
        Do
            Cur = Cur * 256
            Cur = regKey(y + KeyOffset) + Cur
            regKey(y + KeyOffset) = (Cur \ 24)
            Cur = Cur Mod 24
            y = y -1
        Loop While y >= 0
        j = j -1
        winKeyOutput = Mid(Chars, Cur + 1, 1) & winKeyOutput
        Last = Cur
    Loop While j >= 0
    If (isWin10 = 1) Then
    keypart1 = Mid(winKeyOutput, 2, Last)
    insert = "N"
    winKeyOutput = Replace(winKeyOutput, keypart1, keypart1 & insert, 2, 1, 0)
    If Last = 0 Then winKeyOutput = insert & winKeyOutput
    End If
    a = Mid(winKeyOutput, 1, 5)
    b = Mid(winKeyOutput, 6, 5)
    c = Mid(winKeyOutput, 11, 5)
    d = Mid(winKeyOutput, 16, 5)
    e = Mid(winKeyOutput, 21, 5)
    ConvertToKey = a & "-" & b & "-" & c & "-" & d & "-" & e
End Function


Function LZ(ByVal Number)
  If Number < 10 Then
    LZ = "0" & CStr(Number)
  Else
    LZ = CStr(Number)
  End If
End Function

Function TimeStamp
  Dim CurrTime
  CurrTime = Now()

  TimeStamp = CStr(Year(CurrTime)) & "-" _
    & LZ(Month(CurrTime)) & "-" _
    & LZ(Day(CurrTime)) & " " _
    & LZ(Hour(CurrTime)) & ":" _
    & LZ(Minute(CurrTime)) & ":" _
    & LZ(Second(CurrTime))
End Function