B4A=true
Group=Libraries\B4X
ModulesStructureVersion=1
Type=StaticCode
Version=10.9
@EndOfDesignText@
'Code module
#IgnoreWarnings: 12
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
	
	#if b4a
	For Each v As View In Panel.GetAllViewsRecursive
		
		If v.Tag <> Null Then
			
			Dim Fontname As String = v.Tag
			If Fontname = "" Then Continue
			
			If v Is Label Then
				Dim l As Label
				l = v
				l.Typeface = Typeface.LoadFromAssets(Fontname)
			End If
			
			If v Is Button Then
				Dim l2 As Button
				l2 = v
				l2.Typeface = Typeface.LoadFromAssets(Fontname)
			End If
			
			If v Is EditText Then
				Dim l3 As EditText
				l3 = v
				l3.Typeface = Typeface.LoadFromAssets(Fontname)
			End If
			
		End If
		
	Next
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