B4A=true
Group=Libraries
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Private Sub Class_Globals
	Private su As StringUtils
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'Convert file to base64
Sub EncodeFromImage(Dir As String,Filename As String) As String
	Return su.EncodeBase64(Bit.InputStreamToBytes(File.OpenInput(Dir, Filename)))
End Sub

'decode base64 code and convert to file
Sub DecodeFromBase64(Base64Code As String,Dir As String,Filename As String)
	
	Dim b() As Byte = su.DecodeBase64(Base64Code)
	Dim in As InputStream
	in.InitializeFromBytesArray(b, 0, b.Length)
	
	Dim ou As OutputStream
	ou = File.OpenOutput(Dir,Filename,False)
	File.Copy2(in,ou)
	ou.Close
	
End Sub