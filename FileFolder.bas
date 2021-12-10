B4A=true
Group=Libraries
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
'Class module
#Event: FilesAndFoldersFinish(DirListing As List, FileListing as List)
#Event: ListFilesFinish(FileListing as List)
#Event: ListFoldersFinish(DirListing as List)
#Event: DirListingError(error As String)
Sub Class_Globals
	Private EventName As String
	Private CallBack As Object
	Private DirListing As List
	Private FileListing As List
	Private xui As XUI
End Sub

'Initializes the object "wildcardlisting".
'vCallback  = Reference to Activityobject in which the Events should be fired
'vEventname = prefix for Events to be used
Public Sub Initialize (vCallback As Object, vEventName As String)
	Log("wcl.Initialize("&vEventName&")")
	EventName = vEventName
	CallBack = vCallback
	DirListing.Initialize
	FileListing.Initialize
End Sub

' Lists all folders 
' Path      = Starting path. eg. File.DirRootExternal
' Recursive = use recursive search (true/false)
' Sorted    = The resulting Directory-Listing or File-Listing will be sorted 
'             or not (true/false)
' Ascending = The resulting Directory-Listing or File-Listing will be sorted 
'             Ascending (true/false)
' The Event DirListingFinish will be fired when it finishes.
' The list which will returned in this event will be cleared before this sub runs
' The Event DirListingError will be fired when the given path is not Valid
'
Sub ListFolders(Path As String, Recursive As Boolean, Sorted As Boolean, Ascending As Boolean)
	Log("ListFolders("&Path&")")
	If DirListing.IsInitialized Then
		DirListing.Clear
	Else
		DirListing.Initialize
	End If
	GetDirs(Path, Recursive, "", Sorted, Ascending, False, True)
	Log("Dirlisting.Size = "&DirListing.Size)
	If Sorted Then
		DirListing.SortCaseInsensitive(Ascending)
	End If
	If xui.SubExists(CallBack, EventName & "_ListFoldersFinish",1) Then
		CallSubDelayed2(CallBack, EventName & "_ListFoldersFinish", DirListing)
	Else
		Log("Event sub ListFoldersFinish should be fire but cannot be found")
	End If
End Sub

' Lists all mathing files 
' Path      = Starting path. eg. File.DirRootExternal
' Recursive = use recursive search (true/false)
' Wildcards = wildcards to use to find FILES. It is only effected on files. 
'             If using recursive search ALL directorys will be scanned but it 
'             will only find those files who matches one of the wildcards.
'             eg: "*.log, *.txt"
'             "*.jpg, *.png"
'             Wildcards is a comma separated list with one or more entries
' Sorted    = The resulting Directory-Listing or File-Listing will be sorted 
'             or not (true/false)
' Ascending = The resulting Directory-Listing or File-Listing will be sorted 
'             Ascending (true/false)
' The Event ListFilesFinish will be fired when it finishes.
' The list of files which will returned in this event will NOT be cleared before this sub runs
' The Event DirListingError will be fired when the given path is not Valid
'
Sub ListFiles(Path As String, Recursive As Boolean, WildCards As String, Sorted As Boolean, Ascending As Boolean)
	Log("ListFiles("&Path&","&WildCards&")")
	GetDirs(Path, Recursive, WildCards, Sorted, Ascending, True, False)
	Log("Filelisting.Size = "&FileListing.Size)
	If Sorted Then
		FileListing.SortCaseInsensitive(Ascending)
	End If
	If xui.SubExists(CallBack, EventName & "_ListFilesFinish",1) Then
		CallSubDelayed2(CallBack, EventName & "_ListFilesFinish", FileListing)
	Else
		Log("Event sub ListFilesFinish should be fire but cannot be found")
	End If
End Sub

' Lists all found folders and all mathing files 
' Path      = Starting path. eg. File.DirRootExternal
' Recursive = use recursive search (true/false)
' Wildcards = wildcards to use to find FILES. It is only effected on files. 
'             If using recursive search ALL directorys will be scanned but it 
'             will only find those files who matches one of the wildcards.
'             eg: "*.log, *.txt"
'             "*.jpg, *.png"
'             Wildcards is a comma separated list with one or more entries
' Sorted    = The resulting Directory-Listing or File-Listing will be sorted 
'             or not (true/false)
' Ascending = The resulting Directory-Listing or File-Listing will be sorted 
'             Ascending (true/false)
' The Event DirListingFinish will be fired when it finishes.
' The lists which will returned in this event will be cleared before this sub runs
' The Event DirListingError will be fired when the given path is not Valid
'
Sub ListFilesAndFolders(Path As String, Recursive As Boolean, WildCards As String, Sorted As Boolean, Ascending As Boolean)
	Log("ListFilesAndFolders("&Path&","&WildCards&")")
	ClearLists
	GetDirs(Path, Recursive, WildCards, Sorted, Ascending, True, True)
	Log("Filelisting.Size = "&FileListing.Size)
	Log("Dirlisting.Size = "&DirListing.Size)
	If Sorted Then
		DirListing.SortCaseInsensitive(Ascending)
	End If
	If Sorted Then
		FileListing.SortCaseInsensitive(Ascending)
	End If
	If xui.SubExists(CallBack, EventName & "_FilesAndFoldersFinish",2) Then
		CallSubDelayed3(CallBack, EventName & "_FilesAndFoldersFinish", DirListing, FileListing)
	Else
		Log("Event sub FilesAndFoldersFinish should be fire but cannot be found")
	End If
End Sub

'
' Clears the intern Dir- and File-lists which will be used when firing the event DirListingFinish
Sub ClearLists
	If DirListing.IsInitialized Then
		DirListing.Clear
	Else
		DirListing.Initialize
	End If
	If FileListing.IsInitialized Then
		FileListing.Clear
	Else
		FileListing.Initialize
	End If
End Sub

Private Sub GetDirs(Path As String, Recursive As Boolean, WildCards As String, _
  Sorted As Boolean, Ascending As Boolean, vListFiles As Boolean, vListDirs As Boolean)
	'Log("wcl.GetDirs("&Path&")")
	Dim GetCards() As String = Regex.Split(",", WildCards)
	Dim mask As String
	Dim pattern As String
	If File.IsDirectory("", Path) Then
		Dim FilesFound As List = File.ListFiles(Path)
		For i = 0 To FilesFound.Size -1
			If File.IsDirectory(Path,FilesFound.Get(i)) Then
				'Log(Path&"/"&FilesFound.Get(i))
				If vListDirs Then
					DirListing.Add(Path&"/"&FilesFound.Get(i))
				End If
				If Recursive Then
					GetDirs(Path&"/"&FilesFound.Get(i), Recursive, WildCards, Sorted, Ascending, vListFiles, vListDirs)
				End If
			Else
				'Log(Path&"/"&FilesFound.Get(i))
				If vListFiles Then
					For l = 0 To GetCards.Length -1
						Dim TestItem As String = FilesFound.Get(i)
						mask = GetCards(l).Trim
						pattern = "^"&mask.Replace(".","\.").Replace("*",".+").Replace("?",".")&"$"
						If Regex.IsMatch(pattern,TestItem) = True Then
							FileListing.Add(Path&"/"&FilesFound.Get(i))
						End If
					Next
				End If
			End If
		Next
	Else
		If xui.SubExists(CallBack, EventName & "_DirListingError",2) Then
			CallSub2(CallBack, EventName & "_DirListingError", "The given path ''"&Path&"'' must be a valid directory.")
		Else
			Log("Event sub DirListingError not found")
		End If
	End If
End Sub

#if raf
Sub IsZipFile(Path As String, FileName As String) As Boolean
	If Not(File.Exists(Path,FileName)) Or File.IsDirectory(Path,FileName) Then Return False
	If File.Size(Path,FileName) < 4 Then Return False
	Dim RAF As RandomAccessFile
	RAF.Initialize2(Path,FileName,True,True)
	Dim result As Boolean = RAF.ReadInt(0) = 0x04034b50
	RAF.Close
	Return result
End Sub

Sub IsClassFile(Path As String, FileName As String) As Boolean
	If Not(File.Exists(Path,FileName)) Or File.IsDirectory(Path,FileName) Then Return False
	If File.Size(Path,FileName) < 4 Then Return False
	Dim RAF As RandomAccessFile
	RAF.Initialize2(Path,FileName,True,False)
	Dim result As Boolean = RAF.ReadInt(0) = 0xCAFEBABE
	RAF.Close
	Return result
End Sub
#end if

'Description: get a parent path of a file from a complete file path
Sub GetFileParentPath(Path As String) As String
	Dim Path1 As String
	Dim L As Int
	If Path = "/" Then
		Return "/"
	End If
	L = Path.LastIndexOf("/")
	If L = Path.Length - 1 Then
		'Strip the last slash
		Path1 = Path.SubString2(0,L)
	Else
		Path1 = Path
	End If
	L = Path.LastIndexOf("/")
	If L = 0 Then
		L = 1
	End If
	Return Path1.SubString2(0,L)
End Sub

'Description: get a file extention from a complete file path
Sub GetFileExt(FullPath As String) As String
	Return FullPath.SubString(FullPath.LastIndexOf(".")+1)
End Sub

'Description: get a file name from a complete file path
Sub GetFileName(FullPath As String) As String
	Return FullPath.SubString(FullPath.LastIndexOf("/")+1)
End Sub

'rename folder
Sub RenameFolder(Parent As String, CurrentFolder As String, NewFolderName As String)
	
	#if b4a
	Dim p As Phone
	Dim args(2) As String
	args(0) = File.Combine(Parent, CurrentFolder)
	args(1) = File.Combine(Parent, NewFolderName)
	p.Shell("mv", args, Null, Null)
	#end if
	
	#if b4i
	Dim no As NativeObject = Me
	Return no.RunMethod("renameFile::", Array (File.Combine(Parent, CurrentFolder),NewFolderName)).AsBoolean
	#end if
	
End Sub

Sub RenameFile(OriginalFileName As String, NewFileName As String) As Boolean
	
	#if b4a
	Dim Result As Int
	Dim StdOut, StdErr As StringBuilder
	StdOut.Initialize
	StdErr.Initialize
	Dim Ph As Phone
	Result = Ph.Shell("mv " & OriginalFileName & " " & NewFileName, Null,  StdOut, StdErr)
	If Result = 0 Then
		Return True
	Else
		Return False
	End If
	#end if
	
	#if b4i
	Dim no As NativeObject = Me
	Return no.RunMethod("renameFile::", Array (OriginalFileName,NewFileName)).AsBoolean
	#if objc
		- (BOOL)renameFile: (NSString*)source :(NSString*)target {
		   return [[NSFileManager defaultManager] moveItemAtPath:source toPath:target error:nil];
		}
	#end if
	#end if
	
End Sub

Sub BitmapToFile(Bitmap As Bitmap,Dir As String,Filename As String) As Boolean
	
	Try
		Dim o As OutputStream
		o = File.OpenOutput(Dir,Filename,False)
		Bitmap.WriteToStream(o,100,"JPEG")
		o.Close
		Return True
	Catch
		Return False
	End Try
	
End Sub