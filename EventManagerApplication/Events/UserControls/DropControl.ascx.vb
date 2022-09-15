Imports System.Data.SqlClient
Imports Telerik.Web.UI

Public Class DropControl
    Inherits System.Web.UI.UserControl


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            BindGenresRepeater()
        End If

    End Sub

    Protected ReadOnly Property TrackManager() As TrackManager

        Get
            If Session("_trackManager") Is Nothing OrElse Not Page.IsPostBack Then
                Dim manager As New TrackManager()
                manager.LoadTrackData()
                Session("_trackManager") = manager
            End If

            Return DirectCast(Session("_trackManager"), TrackManager)
        End Get

    End Property

    Private Sub RadListView1_NeedDataSource(sender As Object, e As RadListViewNeedDataSourceEventArgs) Handles RadListView1.NeedDataSource
        RadListView1.DataSource = TrackManager.GetTracksInCurrentGenre()
    End Sub

    Protected Sub BindGenresRepeater()
        GenresRepeater.DataSource = TrackManager.GetGenres()
        GenresRepeater.DataBind()
    End Sub

    Private Sub GenresRepeater_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles GenresRepeater.ItemCommand

        If e.CommandName = "ShowTracks" Then
            TrackManager.CurrentGenre = e.CommandArgument.ToString()
            RadListView1.Rebind()
        End If

    End Sub

    Private Sub GenresRepeater_PreRender(sender As Object, e As EventArgs) Handles GenresRepeater.PreRender
        For Each item As RepeaterItem In GenresRepeater.Items

            Dim genreLink As LinkButton = DirectCast(item.FindControl("GenreLink"), LinkButton)
            Dim genreCss As String = IIf(genreLink.CommandArgument <> String.Empty, genreLink.CommandArgument, "Unsorted")

            If genreLink.CommandArgument = TrackManager.CurrentGenre Then
                genreLink.CssClass = genreCss + " selected"
            Else
                genreLink.CssClass = genreCss
            End If

        Next
    End Sub

    Private Sub RadListView1_ItemDrop(sender As Object, e As RadListViewItemDragDropEventArgs) Handles RadListView1.ItemDrop
        If e.DestinationHtmlElement.IndexOf("GenreLink") < 0 Then
            Return
        End If


        For Each item As RepeaterItem In GenresRepeater.Items
            Dim genreLink As LinkButton = TryCast(item.FindControl("GenreLink"), LinkButton)

            If genreLink IsNot Nothing AndAlso genreLink.ClientID = e.DestinationHtmlElement Then
                Dim trackId As Integer = DirectCast(e.DraggedItem.GetDataKeyValue("TrackID"), Integer)
                Dim title As String = e.DraggedItem.GetDataKeyValue("Title").ToString()
                Dim genre As String = genreLink.CommandArgument

                TrackManager.SetTrackGenre(trackId, genre)

                ResultsPanel.Controls.Add(New LiteralControl([String].Format("<div class='msg'><b>{0}</b> was moved to <strong>{1}</strong></div>", title, genre)))

                RadListView1.Rebind()
                BindGenresRepeater()

                Exit For
            End If

        Next
    End Sub


End Class

Public Class Track

    Private _trackId As Integer, _year As Integer, _trackNumber As Integer
    Private _title As String, _artist As String, _album As String, _genre As String

    Public Sub New()

        _trackId = -1
        _year = _trackNumber = 0
        _title = 0
        _artist = 0
        _album = 0
        _genre = 0

    End Sub

    Public Property TrackID() As Integer

        Get
            Return _trackId
        End Get

        Set(ByVal value As Integer)
            _trackId = value
        End Set

    End Property

    Public Property Title() As String

        Get

            Return _title

        End Get

        Set(ByVal value As String)

            _title = value

        End Set

    End Property

    Public Property Artist() As String

        Get

            Return _artist

        End Get

        Set(ByVal value As String)

            _artist = value

        End Set

    End Property

    Public Property Album() As String

        Get

            Return _album

        End Get

        Set(ByVal value As String)

            _album = value

        End Set

    End Property

    Public Property Year() As Integer

        Get

            Return _year

        End Get

        Set(ByVal value As Integer)

            _year = value

        End Set

    End Property

    Public Property TrackNumber() As Integer

        Get

            Return _trackNumber

        End Get

        Set(ByVal value As Integer)

            _trackNumber = value

        End Set

    End Property

    Public Property Genre() As String

        Get

            Return _genre

        End Get

        Set(ByVal value As String)

            _genre = value

        End Set

    End Property

End Class



Public Class TrackManager

    Private _tracks As List(Of Track)
    Private _currentGenre As String

    Public Sub New()

        _tracks = New List(Of Track)()
        _currentGenre = ""

    End Sub

    Public Property CurrentGenre() As String

        Get
            Return _currentGenre
        End Get

        Set(ByVal value As String)
            _currentGenre = value

        End Set

    End Property



    Public Sub LoadTrackData()

        Dim sqlCon As New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ConnectionString)
        Dim adapter As New SqlDataAdapter("SELECT * FROM Tracks", sqlCon)


        Dim data As New DataTable()

        adapter.Fill(data)



        For Each row As DataRow In data.Rows

            Dim track As New Track()

            track.TrackID = DirectCast(row("TrackID"), Integer)

            track.Title = row("Title") + ""

            track.Artist = row("Artist") + ""

            track.Album = row("Album") + ""

            track.Genre = row("Genre") + ""



            Dim trackNumber As Integer = 0

            Int32.TryParse(row("Track").ToString(), trackNumber)

            track.TrackNumber = trackNumber



            Dim year As Integer = 0

            Int32.TryParse(row("Year").ToString(), year)

            track.Year = year



            _tracks.Add(track)

        Next

    End Sub



    Public Function GetTracksInCurrentGenre() As List(Of Track)

        Dim ret As New List(Of Track)()



        For Each track As Track In _tracks

            If track.Genre = CurrentGenre Then

                ret.Add(track)

            End If

        Next



        Return ret

    End Function



    Public Function GetGenres() As SortedList(Of String, Integer)

        Dim slist As New SortedList(Of String, Integer)()

        For Each track As Track In _tracks

            If slist.ContainsKey(track.Genre) Then

                System.Math.Max(System.Threading.Interlocked.Increment(slist(track.Genre)), slist(track.Genre) - 1)

            Else

                slist.Add(track.Genre, 1)

            End If

        Next



        Return slist

    End Function



    Private currentTrackId As Integer



    Public Sub SetTrackGenre(ByVal trackId As Integer, ByVal genre As String)

        currentTrackId = trackId

        Dim track As Track = _tracks.Find(AddressOf CompareTracks)

        If track IsNot Nothing Then

            track.Genre = genre

        End If

    End Sub



    Private Function CompareTracks(ByVal track As Track) As Boolean

        Return track.TrackID = currentTrackId

    End Function

End Class

