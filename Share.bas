B4A=true
Group=Libraries
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Needed libraries: ContentResolver

Private Sub Process_Globals

End Sub

#if b4a
Sub ShareFile(sDir As String,sFileName As String,sSubject As String)
	Dim u As Uri 'ContentResolver library
	u.Parse("file://" & File.Combine(sDir, sFileName))
	Dim inten As Intent
	Dim tmpt As String = sSubject
	inten.Initialize(inten.ACTION_SEND,"")
	inten.SetType("image/*")
	inten.PutExtra("android.intent.extra.STREAM",u)
	inten.PutExtra("android.intent.extra.TEXT",tmpt)
	StartActivity(inten)
End Sub

'share file in twitter
Sub ShareTwitter(sDir As String,sFileName As String,sSubject As String)
	Dim u As Uri 'ContentResolver library
	u.Parse("file://" & File.Combine(sDir, sFileName))
	Dim inten As Intent
	Dim tmpt As String = sSubject
	inten.Initialize(inten.ACTION_SEND,"")
	inten.SetType("image/*")
	inten.PutExtra("android.intent.extra.STREAM",u)
	inten.PutExtra("android.intent.extra.TEXT",tmpt)
	inten.SetComponent("com.twitter.android/.composer.ComposerActivity")
	StartActivity(inten)
End Sub

'share string
Sub ShareString(sInfo As String,sBody As String,sSubject As String)
	Dim share As Intent
	share.Initialize(share.ACTION_SEND,"")
	share.SetType("text/plain")
	share.PutExtra("android.intent.extra.TEXT",sBody)
	share.PutExtra("android.intent.extra.SUBJECT", sSubject)
	share.WrapAsIntentChooser(sInfo)
	StartActivity(share)
End Sub

'share file in instagram
Sub ShareInstagram(sDir As String,sFileName As String,sSubject As String)
	Dim u As Uri 'ContentResolver library
	u.Parse("file://" & File.Combine(sDir, sFileName))
	Dim inten As Intent
	Dim tmpt As String = sSubject
	inten.Initialize(inten.ACTION_SEND,"")
	inten.SetType("image/*")
	inten.PutExtra("android.intent.extra.STREAM",u)
	inten.PutExtra("android.intent.extra.TEXT",tmpt)
	inten.SetComponent("com.instagram.android/.activity.MainTabActivity")
	StartActivity(inten)
End Sub
#end if

#if b4i
Public Sub ShareString(Page1 As Page,Info As String,Body As String,Subject As String)
	
	Dim avc As ActivityViewController
	
	Dim ls As List
	ls.Initialize
	
	If Info <> "" Then
		ls.Add(Info)
	End If
	
	If Body <> "" Then
		ls.Add(Body)
	End If
	
	If Subject <> "" Then
		ls.Add(Subject)
	End If
	
	avc.Initialize("avc",ls)
	avc.Show(Page1, Page1.RootPanel)
	
End Sub

Public Sub ShareFile(Page1 As Page, Text As String,Dir As String,Filename As String)

	Dim avc As ActivityViewController
	avc.Initialize("avc", Array(Text,CreateFileUrl(Dir,Filename)))
	avc.Show(Page1, Page1.RootPanel)

End Sub

'add only #PlistExtra: <key>UIFileSharingEnabled</key><true/>
Public Sub ShareFileiTunes
End Sub

Private Sub CreateFileUrl (Dir As String, FileName As String) As Object
	Dim no As NativeObject
	no = no.Initialize("NSURL").RunMethod("fileURLWithPath:", Array(File.Combine(Dir, FileName)))
	Return no
End Sub

#end if