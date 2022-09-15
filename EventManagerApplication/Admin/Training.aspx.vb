Imports Telerik.Web.UI

Public Class Training1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub hierarchyLoadMode_SelectedIndexChanged(sender As Object, e As EventArgs)

        SetHierarchyLoadMode(CourseGrid.MasterTableView)

        CourseGrid.Rebind()

    End Sub

    Private Sub SetHierarchyLoadMode(tableView As GridTableView)

        'Select Case HierarchyLoadMode.SelectedIndex

        '    Case 0

        '        tableView.HierarchyLoadMode = GridChildLoadMode.ServerBind

        '        Exit Select

        '    Case 1

        tableView.HierarchyLoadMode = GridChildLoadMode.ServerOnDemand

        '        Exit Select

        '    Case 2

        '        tableView.HierarchyLoadMode = GridChildLoadMode.Conditional

        '        Exit Select

        '    Case 3

        '        tableView.HierarchyLoadMode = GridChildLoadMode.Client

        '        Exit Select

        'End Select



        For Each detailView As GridTableView In tableView.DetailTables

            SetHierarchyLoadMode(detailView)

        Next

    End Sub

End Class