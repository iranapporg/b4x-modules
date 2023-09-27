B4A=true
Group=Libraries\B4X
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Needed libraries: ByteConverter,StringUtils

Sub Process_Globals

End Sub

Sub UCFirst(Text As String) As String
	
	If Text.Length = 0 Then Return Text
	
	Dim words() As String
	words	=	Regex.Split(" ",Text.Trim)
	
	If words.Length = 0 Then
		
		If Text.Length > 0 Then
			Return Text.SubString2(0,1).ToUpperCase & Text.SubString2(1,Text.Length)
		Else
			Return Text
		End If
		
	Else

		Try
			For i = 0 To words.Length - 1
				words(i) = words(i).SubString2(0,1).ToUpperCase & words(i).SubString2(1,words(i).Length)
			Next
		Catch
			Return Text
		End Try
		
		Dim res As String
		
		For j = 0 To words.Length - 1
			res = res & " " & words(j)	
		Next
		
		Return res
		
	End If
	
End Sub

Sub StringCount(StringToSearch As String,TargetStr As String,IgnoreCase As Boolean) As Int
	If IgnoreCase Then
		StringToSearch = StringToSearch.ToLowerCase
		TargetStr = TargetStr.ToLowerCase
	End If
	Return (StringToSearch.Length - StringToSearch.Replace(TargetStr,"").Length) / TargetStr.Length
End Sub

'Sub RemoveAccents(s As String) As String
'	Dim normalizer As JavaObject
'	normalizer.InitializeStatic("java.text.Normalizer")
'	Dim n As String = normalizer.RunMethod("normalize", Array As Object(s, "NFD"))
'	Dim sb As StringBuilder
'	sb.Initialize
'	For i = 0 To n.Length - 1
'		If Regex.IsMatch("\p{InCombiningDiacriticalMarks}", n.CharAt(i)) = False  Then
'			sb.Append(n.CharAt(i))
'		End If
'	Next
'	Return sb.ToString
'End Sub

Sub RemoveEmoji(Str As String) As String
	Dim strCleaned As String = Regex.Replace("[^\u0000-\u00FF]", Str, "")
	Return strCleaned
End Sub

#IgnoreWarnings:19,2,12,10
Sub Substitute(chain As String, search As String, replaced As String) As String
	If chain.IndexOf(search) = 0 Then Return chain
	Dim gauche, droite As String
	Do While chain.IndexOf(search)>0
		chain = chain.substring2(0,chain.IndexOf(search)) & replaced & _
	chain.SubString(chain.IndexOf(search)+search.Length)
	Loop
	Return chain
End Sub

Sub Lower(Str As String) As String
	Return Str.ToLowerCase
End Sub

Sub Upper(Str As String) As String
	Return Str.ToUpperCase
End Sub

Sub SubString(Str As String,Begin As Int,Length2 As Int) As String
	
	If Length2 > Str.Length Then
		Return Str
	Else
		Return Str.SubString2(0,Length2)
	End If
	
End Sub

Sub SubString2(Str As String,Begin As Int) As String
	Return Str.SubString(Begin)
End Sub

Sub Length(Str As String) As Int
	Return Str.Trim.Length
End Sub

Sub ShuffleString(pl As String) As String
	pl = pl.ToLowerCase
	Dim chars As List
	chars.Initialize
	For i = 0 To pl.Length -1
		chars.Add(pl.SubString2(i,i+1))
	Next

	For i = chars.Size - 1 To 0 Step -1
		Dim j As Int
		Dim k As Object
		j = Rnd(0, i + 1)
		k = chars.Get(j)
		chars.Set(j,chars.Get(i))
		chars.Set(i,k)
	Next
	Dim newdayname As String = ""
	For i = 0 To chars.Size -1
		newdayname = newdayname &    chars.Get(i)
	Next
   
	Return newdayname
End Sub

Sub StartWith(Str As String,Start As String) As Boolean
	Return Str.StartsWith(Start)
End Sub

'Description: Vb equivalent function for the EndsWith method
Sub EndWith(svalue As String, sfind As String) As Boolean
	Return svalue.EndsWith(sfind)
End Sub

'--- joins a list together as a string
'--- if you do not want a join char then pass in ""
Public Sub Join(lst As List, joinChar As Object) As String
 
	Dim retStr As StringBuilder
	retStr.Initialize
 
	For Each str In lst
		retStr.Append(str).Append(joinChar)
	Next
 
	Return retStr.ToString
 
End Sub

'--- joins a array together as a string
'--- if you do not want a join char then pass in ""
Public Sub Join2(arr() As String, joinChar As Object) As String
 
	Dim retStr As StringBuilder
	retStr.Initialize
 
	For Each str In arr
		retStr.Append(str).Append(joinChar)
	Next
 
	Return retStr.ToString
 
End Sub

Sub UnicodeToString (codepoint As Int) As String
	Dim bc As ByteConverter
	Dim b() As Byte = bc.IntsToBytes(Array As Int(codepoint))
	Return BytesToString(b, 0, 4, "UTF32")
End Sub

'Description: VB equivalent LTrim method using Regular Expressions
Sub LTrim(s As String) As String
	Dim m As Matcher = Regex.Matcher("^(\s+)", s)
	If m.Find Then
		Return s.SubString(m.GetEnd(1))
	Else
		Return s
	End If
End Sub

'Description: VB equivalent RTrim method using Regular Expressions
Sub RTrim(s As String) As String
	Dim m As Matcher = Regex.Matcher("(\s+)$", s)
	If m.Find Then
		Return s.SubString(m.GetEnd(1))
	Else
		Return s
	End If
End Sub

'Description: long method to replace escape sequences
Sub EscapeURL(s As String) As String
	Dim encoded As String
	encoded = s
	encoded = encoded.Replace("%", "%25") 'NB this must be done first so as not to replace the %
	encoded = encoded.Replace(" ", "%20")
	encoded = encoded.Replace("<", "%3C")
	encoded = encoded.Replace(">", "%3E")
	encoded = encoded.Replace("#", "%23")
	encoded = encoded.Replace("{", "%7B")
	encoded = encoded.Replace("}", "%7D")
	encoded = encoded.Replace("|", "%7C")
	encoded = encoded.Replace("\", "%5C")
	encoded = encoded.Replace("^", "%5E")
	encoded = encoded.Replace("~", "%7E")
	encoded = encoded.Replace("[", "%5B")
	encoded = encoded.Replace("]", "%5D")
	encoded = encoded.Replace("`", "%60")
	encoded = encoded.Replace(";", "%3B")
	encoded = encoded.Replace("/", "%2F")
	encoded = encoded.Replace("?", "%3F")
	encoded = encoded.Replace(":", "%3A")
	encoded = encoded.Replace("@", "%40")
	encoded = encoded.Replace("=", "%3D")
	encoded = encoded.Replace("&", "%26")
	encoded = encoded.Replace("$", "%24")
	encoded = encoded.Replace("+", "%2B")
	encoded = encoded.Replace("-", "%2D")
	encoded = encoded.Replace(CRLF, "%0D%0A")
	Return encoded
End Sub

Sub Left(Text As String, Lengths As Long)As String
	If Lengths>Text.Length Then Lengths=Text.Length
	Return Text.SubString2(0, Lengths)
End Sub

'Description: Return Right part of a string
Sub Right(Text As String, Lengths As Long) As String
	If Lengths>Text.Length Then Lengths=Text.Length
	Return Text.SubString(Text.Length-Lengths)
End Sub

'Description: Return the Mid portion of a string
Sub Mid(Text As String, Start As Int, Lengths As Int) As String
	Return Text.SubString2(Start-1,Start+Lengths-1)
End Sub

'Description: Returns an array from a delimited string
Sub Split(Text As String, Delimiter As String) As String()
	Return Regex.Split(Delimiter,Text)
End Sub

'Description: Returns the length of a string
Sub Len(Text As String) As Int
	Return Text.Length
End Sub

'Description: Replace a string within a string
Sub Replace(Text As String, sFind As String, sReplaceWith As String) As String
	Return Text.Replace(sFind, sReplaceWith)
End Sub

Sub Replace2(Text As String, sFind As String, sReplaceWith As String) As String
	Dim strCleaned As String = Regex.Replace2(sFind,Regex.CASE_INSENSITIVE,Text,sReplaceWith)
	Return strCleaned
End Sub

'Description: Returns true if a string contains another string
Sub Contains(Text As String, sFind As String) As Boolean
	Return Text.Contains(sFind)
End Sub

Sub CombineStringArray(Arrays() As String,Delimiter As String) As String
	
	If Arrays.Length = 0 Then Return ""
	
	Dim temp As String
	
	For i = 0 To Arrays.Length - 1
		temp	=	temp & "," & Arrays(i)	
	Next
	
	Return temp.SubString(1)
	
End Sub

Sub CombineDoubleArray(Arrays() As Double,Delimiter As String) As String
	
	If Arrays.Length = 0 Then Return ""
	
	Dim temp As String
	
	For i = 0 To Arrays.Length - 1
		temp	=	temp & "," & Arrays(i)	
	Next
	
	Return temp.SubString(1)
	
End Sub

Sub Base64(Str As String) As String
	Dim su As StringUtils
	Return su.EncodeBase64(Str.GetBytes("UTF8"))
End Sub

Sub UrlEncode(Str As String) As String
	Dim su As StringUtils
	Return su.EncodeUrl(Str,"UTF8")
End Sub

Sub List2Strings(List2 As List,Seperator As String) As String
	
	If List2.IsInitialized = False Then Return ""
	If List2.Size = 0 Then Return ""
	
	Dim temp As String
	
	For i = 0 To List2.Size - 1
		temp = temp & Seperator & List2.Get(i)
	Next
	
	Return temp.SubString(1)
	
End Sub

Sub IndexOf(Str As String,Search As String) As Int
	Return Str.IndexOf(Search)
End Sub

Sub RemoveSpace(Str As String) As String
	
	Dim st As String
	
	For i = 0 To Str.Length - 1
		Dim rs As String
		rs = Str.SubString2(i,i+1)
		If IsNumber(rs) Then
			st = st & Str.SubString2(i,i+1)
		End If
	Next
	
	Return st
	
End Sub

Sub Trim(Str As String) As String
	Return Str.Trim
End Sub

Sub Concat(FirstString As String,SecondString As String,Separator As String) As String
	Return FirstString & Separator & SecondString
End Sub