B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Private Sub Class_Globals
	Private su As StringUtils
End Sub

'this support aes 128
Public Sub Initialize
	
End Sub

#if b4a
Public Sub Descrypt(EncryptedText As String, Key As String) As String 'ignore
	
	Try
		'kilid ro to kg set mikonim
		Dim kg As KeyGenerator
		kg.Initialize("AES")
		kg.KeyFromBytes(Key.GetBytes("UTF8"))
	    
		'cipher ro set mikonim
		Dim Cipher As Cipher
		Dim Reflector As Reflector
		Dim o As Object = Reflector.RunStaticMethod("javax.crypto.Cipher", "getInstance", Array("AES/CBC/PKCS7Padding", "BC"),Array As String("java.lang.String", "java.lang.String"))
		Reflector.Target = Cipher
		Reflector.SetField2("cipher", o)

		Dim IV2() As Byte = GenerateRandomPassword(16).GetBytes("UTF8")
		Cipher.InitialisationVector = IV2
	    
	    
		'as base64 dar miarim o decrypt mikonim
		Dim su As StringUtils
		Dim b() As Byte = su.DecodeBase64(EncryptedText)
		Dim Decrypted() As Byte = Cipher.Decrypt(b,kg.Key,True)
	        
		'string ro return mikonim as iv b bad
		Return(BytesToString(Decrypted,16,Decrypted.Length-16,"UTF-8"))
		
	Catch
		Return ""
	End Try
	
End Sub

'key must be 32 bit or 16 bit
Public Sub Encrypt(Text As String, Key As String,IV As String) As String
	
	Try
		'kilid ro to kg set mikonim
		Dim kg As KeyGenerator
		kg.Initialize("AES")
		kg.KeyFromBytes(Key.GetBytes("UTF8"))
	    
		'cipher ro set mikonim
		Dim Cipher As Cipher
		Dim Reflector As Reflector
		Dim o As Object = Reflector.RunStaticMethod("javax.crypto.Cipher", "getInstance", Array("AES/CBC/PKCS7Padding", "BC"),Array As String("java.lang.String", "java.lang.String"))
		Reflector.Target = Cipher
		Reflector.SetField2("cipher", o)
	    
		Dim IV2() As Byte = IV.GetBytes("UTF8")
		Cipher.InitialisationVector = IV2

		Dim Encrypted() As Byte = Cipher.Encrypt(Text.GetBytes("UTF8"), kg.Key, True)

		Return su.EncodeBase64(CombineBytes(IV2,Encrypted))
		
	Catch
		Return ""
	End Try
	
End Sub

Public Sub GenerateRandomPassword(Lenght As Int) As String
	Dim jo As JavaObject = Me
	Return jo.RunMethod("GenerateRandomPassword",Array As Object(Lenght))

#IF JAVA
  import java.security.SecureRandom;
  import java.util.Random;
    public static String GenerateRandomPassword(final int PasswordLenght){
        try {
            final int RandomPasswordLenght = PasswordLenght;
            final Random RANDOM = new SecureRandom();
            
            // Pick from some letters that won't be easily mistaken for each
            // other. So, for example, omit o O and 0, 1 l and L.
            final String letters = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789+@";
            
            String pw = "";
            for (int i = 0; i < RandomPasswordLenght; i++)
            {
                int index = (int) (RANDOM.nextDouble() * letters.length());
                pw += letters.substring(index, index + 1);
            }
            return pw;
            
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
#End If
End Sub

Private Sub CombineBytes(arr1() As Byte, arr2() As Byte) As Byte()
	Dim res1(arr1.Length + arr2.Length) As Byte
	Dim bc As ByteConverter
	bc.ArrayCopy(arr1, 0, res1, 0, arr1.Length)
	bc.ArrayCopy(arr2, 0, res1, arr1.Length, arr2.Length)
	Return res1
End Sub
#end if

#if b4i
Public Sub Encrypt(Text As String,Key As String,IV As String) As String
	
	Dim c As Cipher
	Dim Bconv As ByteConverter
	Dim Data(0) As Byte
	Dim IV2(0) As Byte
	IV2 = IV.GetBytes("UTF8")
	Data = Bconv.StringToBytes(Text, "UTF8")
	Data = c.Encrypt2(Data, Key.GetBytes("UTF8"),"AES",IV2, c.OPTION_PKCS7Padding)
  
	Dim newarr(IV2.Length + Data.Length) As Byte
	Bconv.ArrayCopy(IV2,0,newarr,0,IV2.Length)
	Bconv.ArrayCopy(Data,0,newarr,IV2.Length,Data.Length)
  
	Dim result As String
	result	=	su.EncodeBase64(newarr)
	Return result
	
End Sub

'data should be without IV prefix
Public Sub Decrypt(input As String,Key As String) As String
	
	Try

		Dim Bconv As ByteConverter
		Dim fulldata(0) As Byte
		fulldata = su.DecodeBase64(input)
       
		Dim ln As Int
		ln=fulldata.Length-16
		Dim data(ln) As Byte
		Dim IV(16) As Byte
       
		Bconv.ArrayCopy(fulldata,0,IV,0,16)
		Bconv.ArrayCopy(fulldata,16,data,0,ln)
       
	   	Dim c As Cipher
       
		data = c.Decrypt2(data, Key.GetBytes("UTF8"),"AES",IV,c.OPTION_PKCS7Padding)
		Dim result As String= BytesToString(data,0,data.Length,"UTF-8")' Bconv.HexFromBytes(data)
       
		Return result
		
	Catch
		Return ""
	End Try
	
End Sub

Public Sub GenerateRandomPassword(Length As Int) As String
	
	Dim sb As StringBuilder
	sb.Initialize
	For i = 1 To Length
		Dim C As Int = Rnd(48, 122)
    
		Do While (C>= 58 And C<=64) Or (C>= 91 And C<=96)
			C = Rnd(48, 122)
		Loop
    
		sb.Append(Chr(C))
	Next
	Return sb.ToString
	
End Sub
#End If