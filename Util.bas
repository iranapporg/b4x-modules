B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.9
@EndOfDesignText@
'Code module
#IgnoreWarnings: 12
'Subs in this code module will be accessible from all modules.
Private Sub Process_Globals
	Private xui As XUI
End Sub

Sub HideKeyboard
	
	#if b4a
	Dim im As IME
	im.Initialize("")
	im.HideKeyboard
	#else
	#if b4xpages
	B4XPages.GetNativeParent(B4XPages.GetManager.GetTopPage.B4XPage).ResignFocus
	#else
	Main.Page1.ResignFocus
	#end if
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
	If ProgressBar1.As(ProgressBar).Indeterminate Then
		Dim jo As JavaObject = ProgressBar1
		jo = jo.RunMethod("getIndeterminateDrawable", Null)
		jo.RunMethod("setColorFilter", Array (Color , "SRC_IN"))
	Else
		Dim jo As JavaObject = ProgressBar1
		jo = jo.RunMethod("getIndeterminateDrawable", Null)
		jo.RunMethod("setColorFilter", Array (Color , "MULTIPLY"))
	End If
	#else
	If ProgressBar1.IsInitialized Then
		Dim pg As ActivityIndicator
		pg = ProgressBar1
		pg.TintColor = Color
	End If
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

Sub HexToColor(InHex As String) As Int
	Dim bc As ByteConverter
	If InHex.StartsWith("#") Then
		InHex = InHex.SubString(1)
	Else If InHex.StartsWith("0x") Then
		InHex = InHex.SubString(2)
	End If

	If InHex.Length = 6 Then
		InHex = "FF" & InHex
	End If

	Dim ints() As Int = bc.IntsFromBytes(bc.HexToBytes(InHex))
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
	Sv.Initialize("",GetPercentX(100),Height)
	Return Sv
	#End If
	
End Sub

Sub GetPercentX(Percent As Int) As Int
	#if b4i
	Dim r As Int = Main.page1.RootPanel.Width * Percent / 100
	Return r
	#end if
End Sub

Sub MesaureLabelHeight(Label As B4XView) As Int
	
	#if b4a
	Dim s As StringUtils
	Return s.MeasureMultilineTextHeight(Label,Label.Text)
	#else
	Return Label.Text.MeasureHeight(Label.Font)
	#End If
	
End Sub

Sub MesaureLabelWidth(Label As B4XView) As Int

	
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
	Scrollview.ScrollOffsetY = y
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

Sub SetAlpha(View As View,Level As Float)
	
	If Level > 1 Then Level = Level / 255
	
	 #if B4A
	Dim jo As JavaObject = View
	Dim alpha As Float = Level
	jo.RunMethod("setAlpha", Array(alpha))
    #Else If B4J
    Dim n As Node = View
    n.Alpha = Level
    #else if B4i
    Dim v As View = View
    v.Alpha = Level
    #End If
	
End Sub

Sub SetPadding(lb As View,Padding As Int)
	
	#if b4i
	Dim left,top,width,height As Int
	left = lb.Left
	top = lb.Top
	width = lb.Width
	height = lb.Height
    
	Dim newlbl As View = lb
	Dim parent As Panel = lb.Parent
    
	lb.RemoveViewFromParent
    
	Dim p As Panel
	p.Initialize("")
	parent.AddView(p,left,top,width,height)
	p.AddView(newlbl,Padding,Padding,width - Padding - Padding,height - Padding - Padding)
	#else
	lb.Padding = Array As Int(Padding,Padding,Padding,Padding)
	#End If
	
End Sub

Sub SetShadow(View As B4XView, Offset As Double, Color As Int)

    #If B4A
	Offset = Offset * 2
	View.As(JavaObject).RunMethod("setElevation", Array(Offset.As(Float)))
	View.As(JavaObject).RunMethod("setOutlineAmbientShadowColor",Array(Color))
	View.As(JavaObject).RunMethod("setOutlineSpotShadowColor",Array(Color))
    #Else If B4i
    View.As(View).SetShadow(Color, Offset, Offset, 0.5, False)
    #End If
	
End Sub

Sub ToastMessage(Text As Object,LongDuration As Boolean,BackgroundColor As Int,TextColor As Int,Fontname As String,TextSize As Int)
	
	#if b4a
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim duration As Int
	If LongDuration Then duration = 1 Else duration = 0
	Dim toast As JavaObject
	toast = toast.InitializeStatic("android.widget.Toast").RunMethod("makeText", Array(ctxt, Text, duration))
	toast.RunMethod("show", Null)
	#else
	Dim hu As HUD
	hu.ToastMessageShow(Text,LongDuration)
	
	Dim no1 As NativeObject = Main.App.KeyController
	no1 = no1.GetField("view")
	Dim no2 As NativeObject
	Dim hud_ As NativeObject = no2.Initialize("MMBProgressHUD").RunMethod("HUDForView:", Array(no1))
	If hud_.IsInitialized Then
		hud_.SetField("color",hud_.ColorToUIColor(BackgroundColor))
		hud_.SetField("labelColor",hud_.ColorToUIColor(TextColor))
		hud_.SetField("labelFont",Font.CreateNew2(Fontname,TextSize))
		hud_.SetField("yOffset", 250dip)
	End If
	#End If
	
End Sub

Sub ShowProgressDialog(Text As String,BackgroundColor As Int,TextColor As Int,FontName As String,FontSize As Int)
	
	#if b4i
	Dim hud As HUD
	hud.ProgressDialogShow(Text)
	
	Dim no1 As NativeObject = Main.App.KeyController
	no1 = no1.GetField("view")
	Dim no2 As NativeObject
	Dim hud_ As NativeObject = no2.Initialize("MMBProgressHUD").RunMethod("HUDForView:", Array(no1))
	If hud_.IsInitialized Then
		hud_.SetField("color",BackgroundColor)
		hud_.SetField("labelColor",TextColor)
		hud_.SetField("labelFont",Font.CreateNew2(FontName,FontSize))
	End If
	#else
	ProgressDialogShow(Text)
	#End If
	
End Sub

Sub SetScale(View1 As View,ScaleX As Float,ScaleY As Float)
	#if b4a
	Dim jo As JavaObject = View1
	jo.RunMethod("setScaleX",Array(ScaleX))
	jo.RunMethod("setScaleY",Array(ScaleY))
	#else
		Dim no As NativeObject = Me
		no.RunMethod("SetScaleTransformation:::", Array(View1, ScaleX, ScaleY))
		#if ObjC
		- (void) SetScaleTransformation:(UIView*) view :(float)x :(float)y {
		   view.transform = CGAffineTransformMakeScale(x, y);
		}
		#End if
	#end if
End Sub

Sub ShakeView (View As B4XView, Duration As Int)
	#if debug
	Return
	#End If
	Dim Left As Int = View.Left
	Dim Delta As Int = 20dip
	For i = 1 To 4
		View.SetLayoutAnimated(Duration / 5, Left + Delta, View.Top, View.Width, View.Height)
		Delta = -Delta
		Sleep(Duration / 5)
	Next
	View.SetLayoutAnimated(Duration/5, Left, View.Top, View.Width, View.Height)
End Sub

Sub Bitmap2File(Source As Bitmap,Dir As String,Filename As String)
	Dim out As OutputStream
	out = File.OpenOutput(Dir, Filename, False)
	Source.WriteToStream(out,100,"JPEG")
	out.Close
End Sub

Sub GetCSBuiler(FontName As String,TextSize As Int,TextColor As Int,Text As String) As Object
	
	Dim cs As CSBuilder
	cs.Initialize
	#if b4a
	cs.Typeface(Typeface.LoadFromAssets(FontName)).Size(TextSize)
	#else
	cs.Font(Font.CreateNew2(FontName,TextSize))
	#end if
	cs.Color(TextColor).Append(Text).Pop
	Return cs.PopAll
	
End Sub

Private Sub ChangeFontView(V1 As View,FontName As String)

	If V1 Is Label Then
		
		Dim lb As Label
		lb = V1
		
		#if b4i
		lb.Font	=	Font.CreateNew2(FontName.Replace(".ttf",""),lb.Font.Size)
		#else
		lb.Typeface = Typeface.LoadFromAssets(FontName)
		#End If
		
	End If
		
	#if b4i
	If V1 Is TextField Then
		Dim t As TextField
		t = V1
		t.Font	=	Font.CreateNew2(FontName.Replace(".ttf",""),t.Font.Size)
	End If
	#else
	If V1 Is EditText Then
		Dim t As EditText
		t = V1
		t.Typeface	=	Typeface.LoadFromAssets(FontName.Replace(".ttf",""))
	End If
	#End If
		
	#if b4i
	If V1 Is TextView Then
		Dim t1 As TextView
		t1 = V1
		t1.Font	=	Font.CreateNew2(FontName.Replace(".ttf",""),t1.Font.Size)
	End If
	#else
	
	#end if
	
	#if b4i
	If V1 Is Button Then
		Dim b1 As Button
		b1 = V1
		b1.CustomLabel.Font	=	Font.CreateNew2(FontName.Replace(".ttf",""),b1.CustomLabel.Font.Size)
	End If
	#else
	If V1 Is Button Then
		Dim b1 As Button
		b1 = V1
		b1.Typeface	=	Typeface.LoadFromAssets(FontName.Replace(".ttf",""))
	End If
	#end if
	
End Sub

Sub AddDashedBorder(v As View, Color As Int,LineWidth As Int)
	
	#if b4i
	Dim no As NativeObject = Me
	no.RunMethod("addDashedBorder::::", Array(v, no.ColorToUIColor(Color),0,LineWidth))
	
	#if OBJC
	- (void) addDashedBorder:(UIView*)v :(UIColor*) clr :(float) radius :(float) lineWidth  {
	   CAShapeLayer* border;
	   NSArray* layers = v.layer.sublayers;
	   if ([layers count] == 0 || [layers.lastObject isKindOfClass:[CAShapeLayer class]] == false) {
	     border = [CAShapeLayer layer];
	     [v.layer addSublayer:border];
	   }
	   else
	   border = layers.lastObject;
	   border.strokeColor = clr.CGColor;
	   border.fillColor = nil;
	   border.lineWidth = lineWidth;
	   border.lineDashPattern = @[@6, @4];
	   
	   border.path = [UIBezierPath bezierPathWithRect:v.bounds].CGPath;
	   border.frame = v.bounds;
	}
	#end if
	#end if
	
End Sub

Public Sub GetRelativeLeft(View As Object,Parent As View) As Int
	
	#if b4i
	Dim NaObj As NativeObject = Me
	Dim r As Rect	=	NaObj.RunMethod("PositionInView::",Array(View,Parent))
	Return r.Left
	#else
	If GetType(View) = "android.view.ViewRoot" Or GetType(View) = "android.view.ViewRootImpl" Then
		Return 0
	Else
		'If V.Left is valid for this view returns a value then add it, else skip to the next parent
		Try
			Dim v As JavaObject = View
			Dim VW As View = View
			Return VW.Left + GetRelativeLeft(v.RunMethod("getParent",Null),Null)
		Catch
			Return GetRelativeLeft(v.RunMethod("getParent",Null),Null)
		End Try
	End If
	#end if
	
End Sub

Public Sub GetMD5(Text As String) As String
	
	Dim md As MessageDigest
	Dim ByteCon As ByteConverter
	Dim passwordhash() As Byte = md.GetMessageDigest(Text.GetBytes("UTF8"),"MD5")
	Return ByteCon.HexFromBytes(passwordhash)
	
End Sub

Public Sub TintColorImage(Imageview As ImageView,Color As Int)
	
	#if b4i
	Dim NaObj As NativeObject = Me
	NaObj.RunMethod("BmpColor::",Array(Imageview,NaObj.ColorToUIColor(Color)))

	#If OBJC
	- (void)BmpColor: (UIImageView*) theImageView :(UIColor*) Color{
	theImageView.image = [theImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	[theImageView setTintColor:Color];
	}
	#End If
	#else
	Dim ac As AppCompat
	Dim bp As BitmapDrawable
	bp.Initialize(Imageview.Bitmap)
	ac.SetDrawableTint(bp,Color)
	Imageview.Background = bp
	#end if
	
End Sub

#if b4i
Public Sub GetRelativeTop(View As View) As Int
	Dim parent As Panel = View.Parent
#else
Public Sub GetRelativeTop(V As JavaObject) As Int
#end if
	'I tried several methods to do this, this was the only one that worked across API's and devices
 	#if b4i
	Dim NaObj As NativeObject = Me
	Dim r As Rect=NaObj.RunMethod("PositionInView::",Array(View,parent))
	Return r.Top
	#else
	'One of these should always be the last parent
	If GetType(V) = "android.view.ViewRoot" Or GetType(V) = "android.view.ViewRootImpl" Or GetType(V) = "android.widget.FrameLayout$LayoutParams" Then
		Return 0
	Else
		'If V.Top is valid for this view returns a value then add it, else skip to the next parent
		Try
			Try
				Dim VW As View = V
				Return VW.Top + GetRelativeTop(V.RunMethod("getParent",Null))
			Catch
				Return 0
			End Try
		Catch
			Try
				Return GetRelativeTop(V.RunMethod("getParent",Null))
			Catch
				Return 0
			End Try
		End Try
	End If
	#end if
End Sub

Sub RotateView(View As View,Duration As Int,Angle As Int)
	
	#if b4a
	Dim jo As JavaObject = View
	jo.RunMethod("setRotation", Array(Angle))
	#End If
	
	#if b4i
	Dim no As NativeObject = Me
	no.RunMethod("rotateView:::", Array(View, Duration, Angle * cPI / 180))
	
		#If OBJC
	- (void) rotateView:(UIView*)view :(int)DurationMs :(double)angle {
	[UIView animateWithDuration:DurationMs / 1000.0 delay:0.0f
	options:UIViewAnimationOptionCurveEaseOut animations:^{
	view.transform = CGAffineTransformMakeRotation(angle);
	} completion:^(BOOL finished) {

	}];
	}
	#End If

#End If
End Sub

Sub SetHintColor(TextField As B4XView,Color As Int)
	
	#if b4i
	Try
		Dim t As TextField
		t = TextField
		Dim NoTxtField As NativeObject = t
		Dim AttrTxt As AttributedString
		AttrTxt.Initialize(t.HintText,t.Font,Color)
		NoTxtField.SetField("attributedPlaceholder",AttrTxt)
	Catch
	End Try
	#else
	Dim t As EditText = TextField
	t.HintColor = Color
	#End If
	
End Sub

'set all views enable to false
Sub LockView(pnl As Panel)
	
	For Each v1 As B4XView In pnl.GetAllViewsRecursive
		v1.Enabled  = False
	Next
	
End Sub

'set all views enable to true
Sub UnLockView(pnl As Panel)
	
	For Each v1 As B4XView In pnl.GetAllViewsRecursive
		v1.Enabled  = True
	Next
	
End Sub

Sub SetDateFormat(Language As String, Country As String)
    #if B4A or B4J
	Dim locale As JavaObject
	locale.InitializeNewInstance("java.util.Locale", Array(Language, Country))
'	Dim DateFormat As JavaObject
'	DateFormat.InitializeNewInstance("java.text.SimpleDateFormat", Array(format, locale))
'	Dim r As Reflector
'	r.Target = r.RunStaticMethod("anywheresoftware.b4a.keywords.DateTime", "getInst", Null, Null)
'	r.SetField2("dateFormat", DateFormat)
    #else if B4i
    Dim locale As NativeObject
    locale = locale.Initialize("NSLocale").RunMethod("alloc", Null).RunMethod("initWithLocaleIdentifier:", Array(Language & "_" & Country))
    DateTime.As(NativeObject).GetField("dateFormat").SetField("locale", locale)
    DateTime.DateFormat = "YYYY-mm-dd"
    #End if
End Sub

Sub SetButtonStateBackground(Button1 As Button,NormalColor As Int,PressColor As Int,DisableColor As Int)
	
	#if b4a
	Dim res As StateListDrawable
	res.Initialize
 
	Dim drwEnabledColor, drwDisabledColor, drwPressedColor As ColorDrawable
	drwEnabledColor.Initialize2(NormalColor, 5, 0, Colors.Black)
	drwDisabledColor.Initialize2(DisableColor, 5, 0, Colors.Black)
	drwPressedColor.Initialize2(PressColor, 5, 0, Colors.Black)
 
	res.AddState(res.State_Enabled, drwEnabledColor)
	res.AddState(res.State_Disabled, drwDisabledColor)
	res.AddState(res.State_Pressed, drwPressedColor)
	res.AddCatchAllState(drwEnabledColor)
	Button1.Background = res
	#else
	Dim ca As Canvas
	ca.Initialize(Button1)
	ca.DrawColor(NormalColor)
	
	Dim No As NativeObject = Button1
	No.RunMethod("setBackgroundImage:forState:", Array(ca.CreateBitmap, 0))
	
	ca.DrawColor(PressColor)
	No.RunMethod("setBackgroundImage:forState:", Array(ca.CreateBitmap, 1))
	
	ca.DrawColor(DisableColor)
	No.RunMethod("setBackgroundImage:forState:", Array(ca.CreateBitmap, 2))
	#End If
	
End Sub