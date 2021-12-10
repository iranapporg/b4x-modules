B4A=true
Group=Libraries
ModulesStructureVersion=1
Type=StaticCode
Version=10.9
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Private Sub Process_Globals

End Sub

Sub HideKeyboard
	
	#if b4a
	Dim im As IME
	im.Initialize("")
	im.HideKeyboard
	#else
	Try
		B4XPages.GetNativeParent(B4XPages.GetManager.GetTopPage.B4XPage).ResignFocus
	Catch
		
	End Try
	#End If
	
End Sub

'add below code for relate activity in android
'<code>SetActivityAttribute(activity_name, android:windowSoftInputMode,adjustPan)</code>
Sub ShowKeyboard(View As B4XView)
	
	View.RequestFocus
	
	#if b4a
	Sleep(100)
	Dim im As IME
	im.Initialize("")
	im.ShowKeyboard(View)
	#else
	View.RequestFocus
	#End If
	
End Sub

Sub ChangeProgressColor(ProgressBar1 As B4XView,Color As Int)
	
	#if b4a
	Dim jo As JavaObject = ProgressBar1
	jo = jo.RunMethod("getIndeterminateDrawable", Null)
	jo.RunMethod("setColorFilter", Array (Color , "MULTIPLY"))
	#else
	Dim pg As ActivityIndicator
	pg = ProgressBar1
	pg.TintColor = Color
	#end if
	
End Sub

Sub CenterView(v As View, parent As View)
	v.Left = parent.Width / 2 - v.Width / 2
	v.Top = parent.Height / 2 - v.Height / 2
End Sub

Sub CenterViewTop(v As View, parent As View)
	v.Top = parent.Height / 2 - v.Height / 2
End Sub

Sub CenterViewLeft(v As View, parent As View)
	v.Left = parent.Width / 2 - v.Width / 2
End Sub

Sub OpenUrl(Url As String)
	
	#if b4a
	Dim p As PhoneIntents
	StartActivity(p.OpenBrowser(Url))
	#else
	Main.App.OpenUrl(Url)
	#End If
	
End Sub

Sub ChangeNullValue(Map As Map) As Map
	
	#if b4a
	For i = 0 To Map.Size - 1
		If Map.GetValueAt(i) = Null Or Map.GetValueAt(i) = "null" Then
			Map.Put(Map.GetKeyAt(i),"")
		End If
	Next
	
	Return Map
	#else
	Dim m As Map
	m.Initialize
	
	For Each key As String In Map.Keys
		If Map.Get(key) = Null Or Map.Get(key) = "null" Then
			m.Put(key,"")
		Else
			m.Put(key,Map.Get(key))
		End If
	Next
	
	Return m
	#end if
	
End Sub

Sub LimitTextboxNumber(TextView As B4XView)
	
	Sleep(10)
	
	If Regex.IsMatch("^\d+$",TextView.Text) = False Then
		TextView.Text	=	Regex.Replace($"[^\d]"$,TextView.Text,"")
	End If
	
End Sub

Sub ChangeNullValueByDefault(Map As Map,Default As String) As Map
	
	#if b4a
	For i = 0 To Map.Size - 1
		If Map.GetValueAt(i) = Null Or Map.GetValueAt(i) = "null" Then
			Map.Put(Map.GetKeyAt(i),Default)
		End If
	Next
	
	Return Map
		#else
	Dim m As Map
	m.Initialize
	
	For Each key As String In Map.Keys
		If Map.Get(key) = Null Or Map.Get(key) = "null" Then
			m.Put(key,Default)
		Else
			m.Put(key,Map.Get(key))
		End If
	Next
	
	Return m
	#end if
	
End Sub

Sub ColorToHex(clr As Int) As String
	Dim bc As ByteConverter
	Return bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))
End Sub

Sub HexToColor(Hex As String) As Int
	Dim bc As ByteConverter
	If Hex.StartsWith("#") Then
		Hex = Hex.SubString(1)
	Else If Hex.StartsWith("0x") Then
		Hex = Hex.SubString(2)
	End If
	Dim ints() As Int = bc.IntsFromBytes(bc.HexToBytes(Hex))
	Return ints(0)
End Sub

Sub HideScrollbar(Sv As B4XView)
	
	#if b4a
	Dim jo As JavaObject = Sv
	jo.RunMethod("setVerticalScrollBarEnabled", Array(False))
	jo.RunMethod("setHorizontalScrollBarEnabled", Array(False))
	#else
	Dim s As ScrollView
	s = Sv
	s.ShowsHorizontalIndicator = False
	s.ShowsVerticalIndicator = False
	#End If
	
End Sub

Sub CreateScrollView(Height As Int) As B4XView
	
	Dim Sv As ScrollView
	#if b4a
	Sv.Initialize(Height)
	Return Sv
	#else
	Sv.Initialize("",100%x,Height)
	Return Sv
	#End If
	
End Sub

Sub MesaureLabelHeight(Label As B4XView) As Int
	
	#if b4a
	Dim s As StringUtils
	Return s.MeasureMultilineTextHeight(Label,Label.Text)
	#else
	Return Label.Text.MeasureHeight(Label.Font)
	#End If
	
End Sub

Sub SetGradient(v As View,color1 As Int,color2 As Int,ReplaceOrRadius As Object)
	
	#if b4i
	Dim NaObj As NativeObject = Me
	NaObj.RunMethod("SetGradient::::",Array(v,NaObj.ColorToUIColor(color1),NaObj.ColorToUIColor(color2), False))
#If OBJC
- (void)SetGradient: (UIView*) View :(UIColor*) Color1 :(UIColor*) Color2 :(BOOL)replace{
   CAGradientLayer *gradient = [CAGradientLayer layer];
   gradient.colors = [NSArray arrayWithObjects:(id)Color1.CGColor, (id)Color2.CGColor, nil];
   gradient.frame = View.bounds;
   if (replace)
     [View.layer replaceSublayer:View.layer.sublayers[0] with:gradient];
   else
     [View.layer insertSublayer:gradient atIndex:0];
}
#end if
	#else
	Dim g As GradientDrawable
	g.Initialize("RIGHT_LEFT",Array As Int(color1,color2))
	If IsNumber(ReplaceOrRadius) Then
		g.CornerRadius = ReplaceOrRadius
	End If
	v.Background = g
	#End If
	
End Sub

Sub GetFilename(Url As String) As String
	Dim r As String
	r = Url.SubString(Url.LastIndexOf("/") + 1)
	Return r
End Sub

Sub ScrollToY(Scrollview As ScrollView,Y As Int)
	
	#if b4a
	Scrollview.ScrollPosition = Y
	#else
	Scrollview.ScrollOffsetY = 0
	#End If
	
End Sub

Sub GetExtension(fullpath As String) As String
	Return fullpath.SubString(fullpath.LastIndexOf(".") + 1)
End Sub

Public Sub SetTextOrCSBuilderToLabel(xlbl As B4XView, Text As Object)
   #if B4A or B4J
	xlbl.Text = Text
   #else if B4i
	If Text Is CSBuilder And xlbl Is Label Then
		Dim lbl As Label = xlbl
		lbl.AttributedText = Text
	Else
		If GetType(Text) = "__NSCFNumber" Then Text = "" & Chr(Text)
		xlbl.Text = Text
	End If
   #end if
End Sub

Public Sub SetSpaceLabel(lbl As Label,LineSpace As Float)
	
	#if b4i
	Dim A As AttributedString
	A = lbl.AttributedText

	Dim NaObj2 As NativeObject
	NaObj2 = NaObj2.Initialize("NSMutableParagraphStyle").RunMethod("new",Null)
	NaObj2.RunMethod("setLineSpacing:",Array(LineSpace))
	NaObj2.RunMethod("setAlignment:",Array(lbl.TextAlignment))
 
	Dim NaObj As NativeObject
	NaObj = NaObj.Initialize("NSMutableAttributedString").RunMethod("alloc",Null).RunMethod("initWithAttributedString:",Array(A))
	NaObj.RunMethod("addAttribute:value:range:",Array("NSParagraphStyle",NaObj2,NaObj.MakeRange(0,lbl.Text.Length)))

	Dim NaObj3 As NativeObject = lbl
	NaObj3.SetField("attributedText",NaObj)
	#else
	Dim Obj1 As Reflector
	Obj1.Target = lbl
	Obj1.RunMethod3("setLineSpacing", 1, "java.lang.float",LineSpace, "java.lang.float")
	#end if
	
End Sub

Sub ChangeViewFont(Panel As Panel,FontName As String)
	
	For Each v1 As View In Panel.GetAllViewsRecursive
		ChangeFontView(v1,FontName)
	Next
	
End Sub

Sub ChangeViewFontByTag(Panel As Panel)
	
	For Each v1 As View In Panel.GetAllViewsRecursive
		
		Dim r As String = v1.Tag
		If r.ToLowerCase.IndexOf(".ttf") > -1 Then
			ChangeFontView(v1,v1.Tag)
			v1.Tag = ""
		End If
		
	Next
	
End Sub

Sub SetShadow(Panel As Panel,Color As Int)
	
	#if b4i
	Panel.SetShadow(Color,1dip,1dip,1,True)
	#else
	If Panel.IsInitialized Then Panel.SetElevationAnimated(100,1dip)
	#End If
	
End Sub

Private Sub ChangeFontView(V1 As View,FontName As String)

	If V1 Is Label Then
		
		Dim lb As Label
		lb = V1
		
		#if b4i
		lb.Font	=	Font.CreateNew2(FontName.Replace(".ttf",""),lb.Font.Size)
		#End If
		
	End If
		
	#if b4i
	If V1 Is TextField Then
		Dim t As TextField
		t = V1
		t.Font	=	Font.CreateNew2(FontName.Replace(".ttf",""),t.Font.Size)
	End If
	#End If
		
	#if b4i
	If V1 Is TextView Then
		Dim t1 As TextView
		t1 = V1
		t1.Font	=	Font.CreateNew2(FontName.Replace(".ttf",""),t1.Font.Size)
	End If
	#end if
	
	#if b4i
	If V1 Is Button Then
		Dim b1 As Button
		b1 = V1
		b1.CustomLabel.Font	=	Font.CreateNew2(FontName.Replace(".ttf",""),b1.CustomLabel.Font.Size)
	End If
	#end if
	
End Sub