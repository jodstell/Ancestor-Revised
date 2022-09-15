<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CoursesControl.ascx.vb" Inherits="EventManagerApplication.CoursesControl" %>


<asp:PlaceHolder ID="InsertPlaceHolder" runat="server"></asp:PlaceHolder>


<telerik:RadWindowManager ID="RadWindowManager1" Width="800px" Height="575px" runat="server" Modal="true" Behaviors="Close" >
                            <Windows>
                            <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" NavigateUrl="/Training/ViewCurriculum.aspx" Skin="Bootstrap"
                                Width="1200px" Height="1100px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                                Modal="true">
                            </telerik:RadWindow>

                        </Windows>

</telerik:RadWindowManager>

<script type="text/javascript">
    function OpenPositionedWindow(oButton, url, windowName)
    {
        var oWnd = window.radopen(url, windowName);
    }
    function openRadWindow(curriculumID)
    {
        var oWnd = radopen("/Training/ViewCurriculum.aspx?ID=" + curriculumID + "&p=1", "Details");
        oWnd.center();
    }

  

</script>





<asp:LinqDataSource runat="server" EntityTypeName="" ID="getBrandTrainingList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblBrandTrainings" Where="brandID == @brandID">
    <WhereParameters>
        <asp:ControlParameter ControlID="HiddenBrandID" PropertyName="Value" Name="brandID" Type="Int32"></asp:ControlParameter>
    </WhereParameters>
</asp:LinqDataSource>
<asp:HiddenField ID="HiddenBrandID" runat="server" />

