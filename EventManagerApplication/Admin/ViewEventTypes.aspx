<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ViewEventTypes.aspx.vb" Inherits="EventManagerApplication.ViewEventTypes" %>

<%@ Register Src="~/UserControls/AdminLeftNavBarControl.ascx" TagPrefix="uc1" TagName="AdminLeftNavBarControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h2>Administration</h2>
                <br />

            </div>
        </div>

        <div class="row">
            <div class="col-sm-3 col-lg-2">

                <uc1:AdminLeftNavBarControl runat="server" id="AdminLeftNavBarControl" />

            </div>

             <div class="col-sm-9 col-lg-10">
                <h2>Event Types</h2>
                <hr />
                 <div style="margin-bottom:10px;">
                 <asp:LinkButton ID="btnAddNewEventType" runat="server" CssClass="btn btn-primary btn-md"><i class="fa fa-plus"></i> Add New Event Type</asp:LinkButton>
                </div>

                 <telerik:RadGrid ID="EventTypeList" runat="server" DataSourceID="getEventTypeList">
                     <MasterTableView AutoGenerateColumns="False" DataKeyNames="eventTypeID" DataSourceID="getEventTypeList">
                         <Columns>

                             <telerik:GridTemplateColumn>
                                 <ItemTemplate>
                                     <a href="#" class="btn btn-xs btn-primary" style="color:white">Edit</a>
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>

                             <telerik:GridBoundColumn DataField="eventTypeName" 
                                 FilterControlAltText="Filter eventTypeName column" 
                                 HeaderText="Name" 
                                 SortExpression="eventTypeName" 
                                 UniqueName="eventTypeName">
                                 <ColumnValidationSettings>
                                     <ModelErrorMessage Text="" />
                                 </ColumnValidationSettings>
                             </telerik:GridBoundColumn>

                             <telerik:GridTemplateColumn HeaderText="# of Events">
                                 <ItemTemplate>
                                     <asp:Label ID="EventCountLabel" runat="server" Text="Label" />
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>


                            <telerik:GridTemplateColumn>
                                 <ItemTemplate>
                                     <span class="label label-success">Active</span>
                                 </ItemTemplate>
                             </telerik:GridTemplateColumn>

                         </Columns>
                     </MasterTableView>
                 </telerik:RadGrid>

                 <asp:LinqDataSource ID="getEventTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblEventTypes" OrderBy="eventTypeName">
                 </asp:LinqDataSource>

            </div>
             </div>

            </div>


</asp:Content>
