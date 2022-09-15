<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="RadListDemo.aspx.vb" Inherits="EventManagerApplication.RadListDemo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">



    <div class="container">

     <telerik:RadListView runat="server" ID="lvTest" AllowPaging="true" PageSize="9">
                <LayoutTemplate>
                    <div id="items">
                    </div>
                </LayoutTemplate>
                <ClientSettings>
                    <DataBinding ItemPlaceHolderID="items">
                        <ItemTemplate>
                            <div class="item">
                                <span class="name">#= AccountName#</span>
                            </div>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <div>No items</div>
                        </EmptyDataTemplate>
                        <DataService Location="ClientService.asmx" DataPath="getAllLocations" SortParameterType="Linq" FilterParameterType="Linq" />
                    </DataBinding>



                </ClientSettings>
            </telerik:RadListView>


   </div>


</asp:Content>
