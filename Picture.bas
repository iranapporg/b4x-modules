B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
#Event: OnDownloadPicture(Res As Bitmap,Tag As Object)

Private Sub Class_Globals
	Private cache As Map
	Private cache_folder As String = ""
	Private w,h As Int
	Private force_resize As Boolean
	Private radius_,degree_ As Int
	Private center_crop As Boolean
	Private circle_crop As Boolean
	Private img As Object
	Private duration As Int
	Private holder As Bitmap
	Private xui As XUI
	Private timeout_ As Int
	Private dir As String
	Private Su As StringUtils
	Private is_success As Boolean
	Private no_cache As Boolean
	#if b4a
	dir = File.DirInternal
	#Else
	dir = File.DirLibrary
	#End If
	Private temp_bitmap As Bitmap
	Private module_ As Object
	Private event_ As String
	Private tag_ As Object
	Private url_ As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize As Picture
	cache_folder = "cache"
	File.MakeDir(dir,cache_folder)
	cache.Initialize
	timeout_ = 2500
	Return Me
End Sub

Public Sub SetCallback(Module As Object,Event As String,Tag As Object) As Picture
	module_ = Module
	event_ = Event
	tag_ = Tag
	Return Me
End Sub

Public Sub AnimationDuration(Val As Int) As Picture	
	duration = Val
	Return Me
End Sub

Public Sub Resize(Width As Int,Height As Int) As Picture
	w = Width
	h = Height
	force_resize = True
	Return Me
End Sub

Public Sub SetTimeout(Timeout As Int) As Picture
	timeout_ = Timeout
	Return Me
End Sub

Public Sub Success As Boolean
	Return is_success
End Sub

Public Sub NoCache As Picture
	no_cache = True
	Return Me
End Sub

'The radius filter is applied at the end 
Public Sub SetRadius(Radius As Int) As Picture
	radius_ = Radius
	Return Me
End Sub

Public Sub SetPlaceHolder(res As Bitmap) As Picture
	holder = res
	Return Me
End Sub

Public Sub Rotate(Degree As Int) As Picture
	degree_ = Degree
	Return Me
End Sub

Public Sub CenterCrop(iv As ImageView) As Picture
	center_crop = True
	img = iv
	Return Me
End Sub

Public Sub CircleCrop(iv As ImageView) As Picture
	circle_crop = True
	img = iv
	Return Me
End Sub

Public Sub ShowFade(IV As B4XView,bt As Bitmap)
	
	IV.Visible = False
	IV.SetBitmap(bt)
	IV.SetVisibleAnimated(duration,True)
		
End Sub

Public Sub Download(Url As String) As ResumableSub

	Dim filename As String = GetFilename(Url)

	If no_cache = False Then
		
		If File.Exists(dir & "/" & cache_folder,filename) Then
			Try
				Dim b As Bitmap = LoadBitmap(dir & "/" & cache_folder,filename)
				cache.Put(Su.EncodeBase64(Url.GetBytes("UTF8")),b)
				is_success = True
				If event_ <> "" And module_ <> Null Then
					CallSubDelayed3(module_,event_ & "_OnDownloadPicture",ApplyFilter(b),tag_)
				Else
					Return ApplyFilter(b)
				End If
				
			Catch
			End Try
		End If
		
		If cache.ContainsKey(Su.EncodeBase64(Url.GetBytes("UTF8"))) Then
			is_success = True
			If event_ <> "" And module_ <> Null Then
				CallSubDelayed3(module_,event_ & "_OnDownloadPicture",ApplyFilter(cache.Get(filename)),tag_)
			Else
			Return ApplyFilter(cache.Get(filename))
			End If
		End If
	
	End If
	
	If True Then
		
		Dim h1 As HttpJob
		h1.Initialize("",Me)
		h1.Download(Url)
		h1.GetRequest.Timeout = timeout_
		Wait For (h1) JobDone(Job As HttpJob)
			If Job.Success Then
				
				is_success = True
			
				Dim res As Bitmap
				res = Job.GetBitmap
				If res.IsInitialized = False Then
					is_success = False
					Return Null
				End If
				
				SaveBitmap(res,dir & "/" & cache_folder,filename)
			
				res = ApplyFilter(res)
				
				Try
					cache.Put(Su.EncodeBase64(Url.GetBytes("UTF8")),res)
				Catch
				End Try
				
				If event_ <> "" And module_ <> Null Then
					CallSubDelayed3(module_,event_ & "_OnDownloadPicture",res,tag_)
				Else
					Return res
				End If
				
			Else
				
				is_success = False
			
				If holder.IsInitialized Then
					
					If event_ <> "" And module_ <> Null Then
						CallSubDelayed3(module_,event_ & "_OnDownloadPicture",res,tag_)	
					Else
						Return ApplyFilter(holder)
					End If
				
				End If
	
				Return Null

		End If
			
	End If
	
End Sub

Public Sub LoadURL(Url As String) As Picture
	url_ = Url
	Return Me
End Sub

Public Sub LoadFile(Dirname As String,Filename As String) As Picture
	
	Try
		Dim b As Bitmap = LoadBitmap(Dirname,Filename)
		is_success = True
		temp_bitmap = ApplyFilter(b)
	Catch
		is_success = False
	End Try
	
	Return Me
	
End Sub

Public Sub Into(destImageview As ImageView)
	
	If url_ <> "" Then
		
		Wait For (Download(url_)) Complete(Res As Bitmap)
			If Success Then destImageview.Bitmap = Res
			
		Return
		
	End If
	
	Try
		destImageview.Bitmap = temp_bitmap
	Catch
	End Try
	
End Sub

#region private subrootine
Private Sub ApplyFilter(res As Bitmap) As Bitmap
	
	If force_resize Then
		force_resize = False
		res = res.Resize(w,h,True)
	End If
				
	If center_crop Then
		center_crop = False
		res = FillImage(res,img)
	End If
				
	If radius_ > 0 Then
		res = RoundBitmap(res,radius_)
		radius_ = 0
	End If
				
	If degree_ > 0 Then
		res = RotateBitmap(res,degree_)
		degree_ = 0
	End If
	
	Return res
	
End Sub

Private Sub GetFilename(fullpath As String) As String
	
	Try
		Dim Su As StringUtils
		fullpath		=	Su.DecodeUrl(fullpath,"UTF8")
		
		Dim index As Int
		index = fullpath.LastIndexOf("/")
		Dim rs As String
		rs = fullpath.SubString(index + 1)
		rs = Su.EncodeBase64(rs.GetBytes("UTF8"))
		rs = rs.Replace("/","").Replace("\","").Replace("=","")
		If rs.Length > 40 Then rs = rs.SubString2(0,39)
		Return rs
	Catch
		Return fullpath
	End Try
	
End Sub

Private Sub SaveBitmap(Bitmap As Bitmap,Dir_ As String,Filename As String)
	
	Dim format As String
	
	Try
		Dim ext As String = Filename.SubString(Filename.LastIndexOf("."))
		If ext.ToLowerCase = "jpg" Or ext.ToLowerCase = "jpeg" Then
			format = "JPEG"
		Else if ext.ToLowerCase = "png" Then
			format = "PNG"
		Else
			format = "JPEG"
		End If
	Catch
		format = "JPEG"
	End Try
	
	Dim b1 As Bitmap
	Dim out As OutputStream
	b1 = Bitmap
	out = File.OpenOutput(Dir_,Filename,False)
	b1.WriteToStream(out,100,format)
	out.Close
	
End Sub

Private Sub RoundBitmap(Input As Bitmap,Corner As Int) As Bitmap
	
	Dim xui As XUI
	Dim BorderColor As Int = xui.Color_Black
	Dim BorderWidth As Int = 0
	Dim c As B4XCanvas
	Dim xview As B4XView = xui.CreatePanel("")
	xview.SetLayoutAnimated(0, 0, 0, Input.Width, Input.Height)
	c.Initialize(xview)
	Dim path As B4XPath
	path.InitializeRoundedRect(c.TargetRect, Corner)
	c.ClipPath(path)
	c.DrawRect(c.TargetRect, BorderColor, True, BorderWidth) 'border
	c.RemoveClip
	Dim r As B4XRect
	r.Initialize(BorderWidth, BorderWidth, c.TargetRect.Width - BorderWidth, c.TargetRect.Height - BorderWidth)
	path.InitializeRoundedRect(r, Corner)
	c.ClipPath(path)
	c.DrawBitmap(Input, r)
	c.RemoveClip
	c.Invalidate
	Dim res As B4XBitmap = c.CreateBitmap
	c.Release
	Return res
	
End Sub

Private Sub FillImage(bmp As Bitmap, ImageView As B4XView) As Bitmap
	
	Dim bmpRatio As Float = bmp.Width / bmp.Height
	Dim viewRatio As Float = ImageView.Width / ImageView.Height
	If viewRatio > bmpRatio Then
		Dim NewHeight As Int = bmp.Width / viewRatio
		bmp = bmp.Crop(0, bmp.Height / 2 - NewHeight / 2, bmp.Width, NewHeight)
	Else if viewRatio < bmpRatio Then
		Dim NewWidth As Int = bmp.Height * viewRatio
		bmp = bmp.Crop(bmp.Width / 2 - NewWidth / 2, 0, NewWidth, bmp.Height)
	End If
	Dim scale As Float = 1
    #if B4i
	scale = GetDeviceLayoutValues.NonnormalizedScale
    #End If
	Return bmp.Resize(ImageView.Width * scale, ImageView.Height * scale, True)
End Sub

Private Sub RotateBitmap(original As Bitmap, degree As Float) As Bitmap
	Return original.Rotate(degree)
End Sub
#end region