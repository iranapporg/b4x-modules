B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Private Sub Class_Globals
	
	Private su As StringUtils
	Private Bconv As ByteConverter
		
	Private MessageBytes(0),MessageBytesEncrypted(0),MessageBytesDecrypted(0) As Byte
	Private MessageStringEncrypted, MessageStringDecrypted As String
		
	Private ForeignKPG As KeyPairGenerator
	Private c As Cipher
	
	Public KEY_SIZE_1024 As Int : KEY_SIZE_1024 = 1024
	Public KEY_SIZE_2048 As Int : KEY_SIZE_2048	= 2048
	
	Private key_size As Int
	
	Private ForeignPubKeyBytes(0) As Byte
	Private ForeignPrivKeyBytes(0) As Byte
	
End Sub

Public Sub Initialize(Keysize As Int,PublicKey As String,PrivateKey As String)
	
	key_size			=	Keysize
	
	c.Initialize("RSA/ECB/PKCS1Padding")
	ForeignKPG.Initialize("RSA", key_size)
	
	If PublicKey <> "" Then
						   
		PublicKey	=	PublicKey.Replace("-----BEGIN PUBLIC KEY-----","")
		PublicKey	=	PublicKey.Replace("-----END PUBLIC KEY-----","")
		
		ForeignPubKeyBytes	=	su.DecodeBase64(PublicKey)
		ForeignKPG.publicKeyFromBytes(ForeignPubKeyBytes)
		
	End If
	
	If PrivateKey <> "" Then

		PrivateKey	=	PrivateKey.Replace("-----BEGIN PRIVATE KEY-----","")
		PrivateKey	=	PrivateKey.Replace("-----END PRIVATE KEY-----","")
	
		ForeignPrivKeyBytes	=	su.DecodeBase64(PrivateKey)
		ForeignKPG.PrivateKeyFromBytes(ForeignPrivKeyBytes)
		
	End If

End Sub

'return output as base64
Public Sub Encrypt(Data As String) As String
	
	MessageBytes = Bconv.StringToBytes(Data, "UTF8")
	MessageBytesEncrypted = c.encrypt(MessageBytes, ForeignKPG.PublicKey, False)
					   
	'Now let the server try to decrypt it...
	MessageStringEncrypted	=	Bconv.HexFromBytes(MessageBytesEncrypted)
	MessageStringEncrypted	=	su.EncodeBase64(MessageBytesEncrypted)
					   
	Return MessageStringEncrypted
	
End Sub

'data must be base64 format
Public Sub Decrypt(Data As String) As String
	
	MessageBytesDecrypted	= 	c.Decrypt(su.DecodeBase64(Data),ForeignKPG.PrivateKey, False)
	MessageStringDecrypted	=	Bconv.StringFromBytes(MessageBytesDecrypted,"UTF8")
	
	Return MessageStringDecrypted
	
End Sub