
Imports System

Imports System.Collections.Generic

Imports System.Linq

Imports System.Web

Imports Telerik.Web.UI

Imports Telerik.Web.UI.PersistenceFramework

Imports System.IO

Imports System.IO.Compression

Imports System.Text



Public Class CookieStorageProvider

    Implements IStateStorageProvider



    Private Shared ReadOnly AsciiEncoding As Encoding = System.Text.Encoding.ASCII

    Private Shared ReadOnly MaxCookieSize As Integer = 4000

    Private Shared ReadOnly LengthDataByteCount As Integer = Runtime.InteropServices.Marshal.SizeOf(New Int32)

    Private Property StorageKey() As String

        Get

            Return m_StorageKey

        End Get

        Set(value As String)

            m_StorageKey = value

        End Set

    End Property

    Private m_StorageKey As String



#Region "IStateStorageProvider"



    Public Sub New(key As String)

        StorageKey = key

    End Sub



    Public Sub SaveStateToStorage(key As String, serializedState As String) Implements PersistenceFramework.IStateStorageProvider.SaveStateToStorage

        Dim cookie As New HttpCookie(StorageKey)

        Dim settingsData As String = CompressString(serializedState)



        If settingsData.Length > MaxCookieSize Then

            Throw New ArgumentOutOfRangeException("Current settings exceed 4k in compressed form! Operation canceled!")

        End If



        cookie.Value = settingsData



        HttpContext.Current.Response.Cookies.Add(cookie)

    End Sub



    Public Function LoadStateFromStorage(key As String) As String Implements PersistenceFramework.IStateStorageProvider.LoadStateFromStorage

        Return DecompressString(HttpContext.Current.Request.Cookies(StorageKey).Value.ToString())

    End Function



#End Region



    Private Function CompressString(inputString As String) As String

        Dim outputBytes As Byte() = Nothing

        Dim inputBytes As Byte() = AsciiEncoding.GetBytes(inputString)



        Using ms As New MemoryStream()

            Using zipStream As New GZipStream(ms, CompressionMode.Compress)

                zipStream.Write(inputBytes, 0, inputBytes.Length)

            End Using

            outputBytes = ms.ToArray()

        End Using



        Return Convert.ToBase64String(AddDataCount(outputBytes, inputBytes.Length))

    End Function



    Private Function DecompressString(inputString As String) As String

        Dim outputString As String = [String].Empty

        Dim inputBytes As Byte() = Convert.FromBase64String(inputString)

        Dim lengthDataArray As Int32 = BitConverter.ToInt32(inputBytes, inputBytes.Length - LengthDataByteCount)

        Dim outputBytes As Byte() = New Byte(lengthDataArray - 1) {}



        Using ms As New MemoryStream(RemoveDataCount(inputBytes))

            Using zipStream As New GZipStream(ms, CompressionMode.Decompress)

                zipStream.Read(outputBytes, 0, outputBytes.Length)

            End Using

            outputString = AsciiEncoding.GetString(outputBytes)

        End Using



        Return outputString

    End Function



    Private Function AddDataCount(inputArray As Byte(), length As Int32) As Byte()

        Dim lengthDataArray As Byte() = BitConverter.GetBytes(length)

        Array.Resize(Of Byte)(inputArray, inputArray.Length + LengthDataByteCount)

        Array.Copy(lengthDataArray, 0, inputArray, inputArray.Length - LengthDataByteCount, LengthDataByteCount)

        Return inputArray

    End Function



    Private Function RemoveDataCount(inputArray As Byte()) As Byte()

        Array.Resize(Of Byte)(inputArray, inputArray.Length - LengthDataByteCount)

        Return inputArray

    End Function



End Class
