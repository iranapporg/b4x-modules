B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
#Event: Complete(Tag As Object,Status as Boolean)
#Event: Progress(Progress As Float,Total As Float)
#Event: Error(Message As String)
#if b4a
#Event: NotificationClick
#end if
#Event: Cancel
Private Sub Class_Globals
	#if b4a
	Private DownloadManager1 As DownloadManager
	Private DownloadManagerRequest1 As DownloadManagerRequest
	Private ReasonTextMap As Map
	#else
		Private outputDir,outputFilename As String
	#end if
	Private IsInitialized As Boolean=False
	Private url2 As String
	Private DownloadId As Long
	Private my_module As Object
	Private my_event As String
	Private tag_ As Object
	Private Headers As Map
	Private Keys,Values As List
End Sub

'add below code in manifest for android
'<code>AddPermission(android.permission.WRITE_EXTERNAL_STORAGE)</code>
Public Sub Initialize(Module As Object,Event As String,Url As String) As Downloader
	
	Headers.Initialize
	Keys.Initialize
	Values.Initialize
	
	#if b4a
	ReasonTextMap.Initialize
	ReasonTextMap.Put(DownloadManager1.ERROR_CANNOT_RESUME, "ERROR_CANNOT_RESUME")
	ReasonTextMap.Put(DownloadManager1.ERROR_DEVICE_NOT_FOUND, "ERROR_DEVICE_NOT_FOUND")
	ReasonTextMap.Put(DownloadManager1.ERROR_FILE_ALREADY_EXISTS, "ERROR_FILE_ALREADY_EXISTS")
	ReasonTextMap.Put(DownloadManager1.ERROR_FILE_ERROR, "ERROR_FILE_ERROR")
	ReasonTextMap.Put(DownloadManager1.ERROR_HTTP_DATA_ERROR, "ERROR_HTTP_DATA_ERROR")
	ReasonTextMap.Put(DownloadManager1.ERROR_INSUFFICIENT_SPACE, "ERROR_INSUFFICIENT_SPACE")
	ReasonTextMap.Put(DownloadManager1.ERROR_TOO_MANY_REDIRECTS, "ERROR_TOO_MANY_REDIRECTS")
	ReasonTextMap.Put(DownloadManager1.ERROR_UNHANDLED_HTTP_CODE, "ERROR_UNHANDLED_HTTP_CODE")
	ReasonTextMap.Put(DownloadManager1.ERROR_UNKNOWN, "ERROR_UNKNOWN")
	ReasonTextMap.Put(DownloadManager1.PAUSED_QUEUED_FOR_WIFI, "PAUSED_QUEUED_FOR_WIFI")
	ReasonTextMap.Put(DownloadManager1.PAUSED_UNKNOWN, "PAUSED_UNKNOWN")
	ReasonTextMap.Put(DownloadManager1.PAUSED_WAITING_FOR_NETWORK, "PAUSED_WAITING_FOR_NETWORK")
	ReasonTextMap.Put(DownloadManager1.PAUSED_WAITING_TO_RETRY, "PAUSED_WAITING_TO_RETRY")
	DownloadManager1.RegisterReceiver("DownloadManager1")
	DownloadManagerRequest1.Initialize(Url)
	#else
	
	#end if
	
	url2			=	Url
	my_module	=	Module
	my_event		=	Event

	Return Me
	
End Sub

Public Sub SetShowUI(Val As Boolean) As Downloader
	#if b4a
	DownloadManagerRequest1.VisibleInDownloadsUi	=	Val
	#end if
	Return Me
End Sub

Public Sub SetTag(Tag As Object)
	tag_	=	Tag
End Sub

Public Sub SetOutputFilename(Dir As String,Filename As String) As Downloader
	#if b4a
	DownloadManagerRequest1.DestinationUri	=	"file://"	&	File.Combine(Dir, Filename)
	#else
	outputDir = Dir
	outputFilename = Filename
	#end if
	Return Me
End Sub

Public Sub SetTitle(Val As String) As Downloader
	#if b4a
	DownloadManagerRequest1.Title	=	Val
	#end if
	Return Me
End Sub

Public Sub SetDescription(Val As String) As Downloader
	#if b4a
	DownloadManagerRequest1.Description	=	Val
	#end if
	Return Me
End Sub

Public Sub SetHeader(Key As String,Value As String) As Downloader
	#if b4a
	DownloadManagerRequest1.AddRequestHeader(Key,Value)
	#else
	Keys.Add(Key)
	Values.Add(Value)
	#end if
	Return Me
End Sub

Public Sub SetMimeType(sType As String) As Downloader
	#if b4a
	DownloadManagerRequest1.MimeType	=	sType
	#end if
	Return Me
End Sub

Public Sub Download
	
	#if b4a
	DownloadId	=	DownloadManager1.Enqueue(DownloadManagerRequest1)
	#else
	Dim NativeMe As NativeObject = Me
	NativeMe.RunMethod("Download::::::",Array(url2,Null,outputDir & "/" & outputFilename,"",Keys,Values))
	#end if
	
End Sub

Public Sub Cancel
	
	#if b4a
	DownloadManager1.Remove(DownloadId)
	#else
	Dim NativeMe As NativeObject = Me
	NativeMe.RunMethod("cancel:", Array (True))
	#End If
	
End Sub

#if b4a
Private Sub DownloadManager1_DownloadComplete(DownloadId1 As Long)
	
	If DownloadId	=	DownloadId1 Then

		Dim DownloadManagerQuery1 As DownloadManagerQuery
		DownloadManagerQuery1.Initialize
		DownloadManagerQuery1.SetFilterById(DownloadId)
			
		Dim StatusCursor As Cursor
		StatusCursor=DownloadManager1.Query(DownloadManagerQuery1)
		
		If StatusCursor.RowCount > 0 Then
			
			StatusCursor.Position=0
				
			Dim StatusInt As Int
			StatusInt = StatusCursor.getInt(DownloadManager1.COLUMN_STATUS)

			If StatusInt <> DownloadManager1.STATUS_SUCCESSFUL Then
				Dim ReasonInt As Int
				ReasonInt=StatusCursor.GetInt(DownloadManager1.COLUMN_REASON)
				CallSubDelayed2(my_module,my_event & "_error",ReasonTextMap.Get(ReasonInt))
			Else
				CallSubDelayed2(my_module,my_event.ToLowerCase & "_complete",tag_)
			End If

		Else
			
			Dim xui As XUI
			If xui.SubExists(my_module,my_event & "_cancel",0) Then
				CallSub(my_module,my_event & "_cancel")
			End If
		
		End If
			
		'	free system resources
		StatusCursor.Close
		DownloadManager1.UnregisterReceiver
	
	End If
	
End Sub
#end if

Private Sub Download_Complete
	CallSubDelayed3(my_module,my_event.ToLowerCase & "_complete",tag_,True)
End Sub

#if b4i
Private Sub Download_Progress(ProgressValue As String,Total As String)
	Dim val,Total2 As Float
	val 	= 	ProgressValue
	Total2	=	Total
	If SubExists(my_module,my_event & "_progress",2) Then CallSub3(my_module,my_event & "_progress",val,Total2)
End Sub

Private Sub Download_Error(ErrorMessage As String)
	If SubExists(my_module,my_event & "_error",1) Then CallSubDelayed2(my_module,my_event & "_error",ErrorMessage)
End Sub
#End If

#if b4a
Private Sub DownloadManager1_NotificationClicked(DownloadIds() As Long)
	If IsPaused(my_module) = False Then CallSubDelayed2(my_module,my_event.ToLowerCase & "_notificationclick",False)
End Sub
#end if

#if b4i
#If OBJC

NSURLResponse *DownloadedResponse;
NSMutableData *DownloadedData;
NSString *FilePath;
NSURLConnection * connection2;
NSURLRequest *request;

- (void) cancel: (bool) on {
	[connection2 cancel];
}

-(void)Download: (NSString *)FileUrl :(UILabel *)LabelToSet :(NSString *)Directory :(NSString *)FileName :(NSArray *)Headers :(NSArray *)Values
{

	FilePath = [Directory stringByAppendingString: FileName];

	DownloadedData = [[NSMutableData alloc] init];
	NSURL *url = [NSURL URLWithString:FileUrl];
	request = [NSURLRequest requestWithURL:url];
	NSMutableURLRequest *mutableRequest = [request mutableCopy];

	NSUInteger count = [Headers count];
	for (NSUInteger i = 0; i < count; i++) {
		NSString * key = [Headers objectAtIndex: i];
   		NSString * val = [Values objectAtIndex: i];
		[mutableRequest addValue:val forHTTPHeaderField:key];
	}
	 
	request = [mutableRequest copy];
	NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
	connection2	=	connection;
   
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   [DownloadedData appendData:data];
   float res = ((100.0/DownloadedResponse.expectedContentLength)*DownloadedData.length)/100;

   NSString * LabelText = [NSString stringWithFormat:@"%f", (res)];
   NSString * LabelText2 = [NSString stringWithFormat:@"%d", [DownloadedData length]];
   
   [self.bi raiseEvent:nil event:@"download_progress::" params:@[(LabelText),LabelText2]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   [DownloadedData writeToFile:FilePath atomically:YES];
   [self.bi raiseEvent:nil event:@"download_complete" params:@[]];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
   [self.bi raiseEvent:nil event:@"download_error:" params:@[error.localizedDescription]];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  DownloadedResponse = response;
}
#End If
#end if