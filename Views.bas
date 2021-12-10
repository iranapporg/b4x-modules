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
	#if b4xpage
	B4XPages.GetNativeParent(B4XPages.GetManager.GetTopPage.B4XPage).ResignFocus
	#else
	Main.Page1.Resign
	#End If
	
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
	If ProgressBar1 Is ActivityIndicator Then
		Dim a As ActivityIndicator
		a = ProgressBar1
		a.TintColor = Color
	Else
		Dim a1 As ProgressView
		a1 = ProgressBar1
		a1.TintColor = Color
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

Sub ChangeFontByTag(Panel As Panel)
	
	#if b4i
	For Each v As View In Panel.GetAllViewsRecursive
		
		If v.Tag <> Null Then
			
			Dim Fontname As String = v.Tag
			If Fontname = "" Then Continue
			
			If v Is Label Then
				Dim l As Label
				l = v
				l.Font = Font.CreateNew2(Fontname,l.Font.Size)	
			End If
			
			If v Is Button Then
				Dim l2 As Button
				l2 = v
				l2.CustomLabel.Font = Font.CreateNew2(Fontname,l2.CustomLabel.Font.Size)
			End If
			
			If v Is TextField Then
				Dim l3 As TextField
				l3 = v
				l3.Font = Font.CreateNew2(Fontname,l3.Font.Size)
			End If
			
			If v Is TextView Then
				Dim l4 As TextView
				l4 = v
				l4.Font = Font.CreateNew2(Fontname,l4.Font.Size)
			End If
			
		End If
		
	Next
	#end if
	
End Sub

Sub SetButtonStateBackground(Button As Button,Normal As Int,Press As Int,Disable As Int)
	
	#if b4i
	Dim Ca As Canvas
	Ca.Initialize(Button)
	Ca.DrawColor(Normal)
	
	Dim No As NativeObject = Button
	No.RunMethod("setBackgroundImage:forState:", Array(Ca.CreateBitmap, 0))
	
	Ca.DrawColor(Press)
	No.RunMethod("setBackgroundImage:forState:", Array(Ca.CreateBitmap, 1))
	
	Ca.DrawColor(Disable)
	No.RunMethod("setBackgroundImage:forState:", Array(Ca.CreateBitmap, 2))
	#else
	here
	#End If
	
End Sub

Public Sub SetTextOrCSBuilderToLabel(Label_or_Button As B4XView, Text As Object)
   #if B4A or B4J
   Label_or_Button.Text = Text
   #else if B4i
	If Text Is CSBuilder Then
		If Label_or_Button Is Label Then
			Dim lbl As Label = Label_or_Button
			lbl.AttributedText = Text
		else if Label_or_Button Is Button Then
			Dim no As NativeObject = Label_or_Button
			Dim AText As AttributedString = Text
			'normal text
			no.RunMethod("setAttributedTitle:forState:", Array(AText, 0))
			'Highlighted Text
			no.RunMethod("setAttributedTitle:forState:", Array(AText, 1))
			' disabled text
			no.RunMethod("setAttributedTitle:forState:", Array(AText, 2))
		End If
	Else
		If GetType(Text) = "__NSCFNumber" Then Text = "" & Chr(Text)
		Label_or_Button.Text = Text
	End If
   #end if
End Sub

Sub ShakeView (View As B4XView, Duration As Int)
	Dim Left As Int = View.Left
	Dim Delta As Int = 20dip
	For i = 1 To 4
		View.SetLayoutAnimated(Duration / 5, Left + Delta, View.Top, View.Width, View.Height)
		Delta = -Delta
		Sleep(Duration / 5)
	Next
	View.SetLayoutAnimated(Duration/5, Left, View.Top, View.Width, View.Height)
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

Sub ScaleView(View As B4XView,Scale As Float)
	
	#if b4i
	Dim no As NativeObject = Me
	no.RunMethod("SetScaleTransformation:::", Array(View, Scale,Scale))
	#if ObjC
	- (void) SetScaleTransformation:(UIView*) view :(float)x :(float)y {
	   view.transform = CGAffineTransformMakeScale(x, y);
	}
	#End if
	#else
	Scale View
	#End If
	
End Sub

Sub RotateView(View As View,Angle As Int)
	#if b4i
	Dim no As NativeObject = Me
	no.RunMethod("rotateView:::", Array(View, 0, Angle * cPI / 180))
	
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

Public Sub GetRelativeLeft(View As View,Parent As View) As Int
	
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
			Dim VW As View = View
			Return VW.Left + GetRelativeLeft(View.RunMethod("getParent",Null))
		Catch
			Return GetRelativeLeft(View.RunMethod("getParent",Null))
		End Try
	End If
	#end if
	
End Sub

Public Sub GetRelativeTop(View As View,Parent As View) As Int
	#if b4i
	Dim NaObj As NativeObject = Me
	Dim r As Rect=NaObj.RunMethod("PositionInView::",Array(View,Parent))
	Return r.Top
	#else
	If GetType(View) = "android.view.ViewRoot" Or GetType(View) = "android.view.ViewRootImpl" Then
		Return 0
	Else
		'If V.Top is valid for this view returns a value then add it, else skip to the next parent
		Try
			Dim VW As View = View
			Return VW.Top + GetRelativeTop(View.RunMethod("getParent",Null))
		Catch
			Return GetRelativeTop(View.RunMethod("getParent",Null))
		End Try
	#end if
End Sub

Public Sub GetLineCount(Text As String) As Int
	
	Dim r() As String = Regex.Split(CRLF,Text.Replace("<br>",CRLF))
	Return r.Length
	
End Sub

Sub CreateHaloEffect (Parent As B4XView, x As Int, y As Int, clr As Int)
	Dim cvs As B4XCanvas
	Dim xui As XUI
	Dim p As B4XView = xui.CreatePanel("")
	Dim radius As Int = 150dip
	p.SetLayoutAnimated(0, 0, 0, radius * 2, radius * 2)
	cvs.Initialize(p)
	cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, cvs.TargetRect.Width / 2, clr, True, 0)
	Dim bmp As B4XBitmap = cvs.CreateBitmap
	For i = 1 To 5
		CreateHaloEffectHelper(Parent,bmp, x, y, clr, radius)
		Sleep(800)
	Next
End Sub

Public Sub SetShadow (View As B4XView, Offset As Double, Color As Int)
    #if B4J
    Dim DropShadow As JavaObject
	'You might prefer to ignore panels as the shadow is different.
	'If View Is Pane Then Return
    DropShadow.InitializeNewInstance(IIf(View Is Pane, "javafx.scene.effect.InnerShadow", "javafx.scene.effect.DropShadow"), Null)
    DropShadow.RunMethod("setOffsetX", Array(Offset))
    DropShadow.RunMethod("setOffsetY", Array(Offset))
    DropShadow.RunMethod("setRadius", Array(Offset))
    Dim fx As JFX
    DropShadow.RunMethod("setColor", Array(fx.Colors.From32Bit(Color)))
    View.As(JavaObject).RunMethod("setEffect", Array(DropShadow))
    #Else If B4A
    Offset = Offset * 2
    View.As(JavaObject).RunMethod("setElevation", Array(Offset.As(Float)))
    #Else If B4i
	View.As(View).SetShadow(Color, Offset, Offset, 0.5, False)
    #End If
End Sub

Private Sub CreateHaloEffectHelper (Parent As B4XView,bmp As B4XBitmap, x As Int, y As Int, clr As Int, radius As Int)
	Dim iv As ImageView
	iv.Initialize("")
	Dim p As B4XView = iv
	p.SetBitmap(bmp)
	Parent.AddView(p, x, y, 0, 0)
	Dim duration As Int = 3000
	p.SetLayoutAnimated(duration, x - radius, y - radius, 2 * radius, 2 * radius)
	p.SetVisibleAnimated(duration, False)
	Sleep(duration)
	p.RemoveViewFromParent
End Sub

#if b4i
#If OBJC



-(B4IRect*)GetCenter: (UIView*)view
{
CGPoint cntr=view.center;
B4IRect * r;
	r=[B4IRect new];
	[r Initialize :(float)(cntr.x) :(float)(cntr.y) :(float)(0.0) :(float)(0.0)];
return r;

}

-(void) SetCenter: (UIView*)view :(CGPoint)point
{
view.center=point;
}

-(B4IRect*)ToPoint: (CGPoint)point
{

B4IRect * r;
	r=[B4IRect new];
	[r Initialize :(float)(point.x) :(float)(point.y) :(float)(0.0) :(float)(0.0)];
return r;

}

-(B4IRect*)ToRect: (CGRect)rect
{

B4IRect * r;
	r=[B4IRect new];
	[r Initialize :(float)(rect.origin.x) :(float)(rect.origin.y) :(float)(rect.size.width+rect.origin.x) :(float)(rect.size.height+rect.origin.y)];
return r;

}

-(B4IRect*)PositionInView: (UIView*)view :(UIView*)parent
{

CGRect rect = [view convertRect:view.frame fromView:parent];

CGPoint point = [view.superview convertPoint:view.center toView:parent];
B4IRect * r;
	r=[B4IRect new];
	[r Initialize :(float)(point.x) :(float)(point.y) :(float)(0.0) :(float)(0.0)];

return r;
}

- (void) moveTo: (UIView*)view :(CGRect)destination :(float)secs  :(NSObject*)handler
{
    [UIView animateWithDuration:secs delay:0.0 options:UIViewAnimationOptionCurveLinear
        animations:^{
            view.frame = CGRectMake(destination.origin.x,destination.origin.y, destination.size.width, destination.size.height);
        }
        completion:^(BOOL finished) { 
		[self.__c CallSub:self.bi :handler :@"animation_finish"];
        //[self.bi raiseUIEvent:handler event:@"animation_finish" params:@[]];
    }];
}

-(UIRefreshControl*)AddRefresh: (UITableView*)tbl {
	UITableViewController *tableViewController = [[UITableViewController alloc] init];
	tableViewController.tableView = tbl;
	UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
	[refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
	tableViewController.refreshControl = refreshControl;
	return refreshControl;
}

- (void)refresh:(id)sender {
    NSLog(@"Refreshing");
 
    // End Refreshing
	UIRefreshControl *refreshControl=sender;
	[self.bi raiseEvent:nil event:@"refresh_end:" params:@[(refreshControl)]];
    //[(UIRefreshControl *)sender endRefreshing];
}
#End If
#End If