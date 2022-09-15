
Imports System
Imports System.Collections.Generic
Imports System.Drawing.Imaging
Imports System.IO
Imports System.Linq
Imports System.Web
Imports System.Drawing


Namespace Data

    Public NotInheritable Class DataProvider

        Private Sub New()

        End Sub

        <ThreadStatic()> Private Shared _photos As List(Of Photo)


        Public Shared Function GetData() As IList(Of Photo)

            Dim db As New DataClassesDataContext

            If _photos IsNot Nothing Then
                Return _photos
            End If

            _photos = New List(Of Photo)()

            Dim q = From p In db.tblPhotos Select p
            For Each p In q

                Dim photo = New Photo()
                photo.Name = p.fileName

                'Dim image__1 As System.Data.Linq.Binary = p.LargeImage

                Dim buffer As Byte() = p.LargeImage.ToArray()

                Using memoryStream = New MemoryStream()
                    photo.Data = buffer
                End Using

                _photos.Add(photo)

            Next

            Return _photos

        End Function



        Public Shared Function GetPhotoByID(Id As Integer) As Photo

            Return GetData().Where(Function(d) d.Id = Id).First()

        End Function

    End Class



    Public Class Photo

        Private Shared ReadOnly _key As New Object()

        <ThreadStatic()> Private Shared _counter As Integer



        Public Sub New()

            Id = GetId()

        End Sub



        Public Property Name() As String

            Get

                Return m_Name

            End Get

            Set(ByVal value As String)

                m_Name = value

            End Set

        End Property

        Private m_Name As String

        Public Property Data() As Byte()

            Get

                Return m_Data

            End Get

            Set(ByVal value As Byte())

                m_Data = value

            End Set

        End Property

        Private m_Data As Byte()

        Public Property Id() As Integer

            Get

                Return m_Id

            End Get

            Private Set(ByVal value As Integer)

                m_Id = value

            End Set

        End Property

        Private m_Id As Integer



        Protected Shared Function GetId() As Integer

            SyncLock _key

                _counter += 1

            End SyncLock

            Return _counter

        End Function

    End Class

End Namespace
