B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
Private Sub Class_Globals
	Private Zip_ As ABZipUnzip
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub

'The zip file must not be in the Asset folder
Public Sub Unzip(ZipFilename As String,OutputDir As String,Password As String) As Boolean
	Return Zip_.ABUnzip(ZipFilename,OutputDir)
End Sub

Public Sub Zip(Path As String,OutputFilename As String,Password As String)
	Zip_.ABZipDirectory(Path,OutputFilename)
End Sub