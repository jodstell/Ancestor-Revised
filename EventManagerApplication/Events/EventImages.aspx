<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EventImages.aspx.vb" Inherits="EventManagerApplication.EventImages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>

        .col-md-2, .col-xs-2 {
    position: relative;
    min-height: 1px;
    padding-right: 0px;
    padding-left: 5px;
}
        .bin {
                        border: 2px solid;
                        padding: 2px;
                        color: white;
                        background-color: #428BCA;
                    }


                /*Photo Galery Styles*/
        .galery {
            background-color: grey;
        }

         .btnbox {
            padding-top: 25px;
            text-align: right;
        }

        .imageContainer {
            float: left;
            margin: 5px;
            padding: 2px;
            position: relative;
            background: #eeeeee;
        }

            .imageContainer:hover {
                background-color: #a1da29 !important;
            }

        .buttonsWrapper {
            display: inline-block;
            vertical-align: middle;
        }

        .image {
            cursor: pointer;
            display: block;
        }

        .txt {
            border: 0 !important;
            background: #eeeeee !important;
            color: Black !important;
            margin-left: 25%;
            margin-right: auto;
            width: 100%;
            filter: alpha(opacity=50); /* IE's opacity*/
            opacity: 0.50;
            text-align: center;
        }

        #list {
            max-width: 900px;
        }

                .clearFix {
            clear: both;
        }

        .demo-container {
            max-width: 856px;
        }

        .sliderWrapper {
            float: left;
            display: inline-block;
            margin-bottom: 15px;
        }
        /*End Photo Galery Styles*/

        /*showHidenDiv*/
        .showDiv {
            display: none;
        }
    </style>



      <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            </AjaxSettings>
          </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>
    <asp:Panel ID="Panel1" runat="server">
    <div class="container">

                                                    <telerik:RadListView runat="server" ID="PhotoListView" DataSourceID="getImageList" Skin="Bootstrap" DataKeyNames="photoID" OverrideDataSourceControlSorting="true">

                                                <LayoutTemplate>

                                                    <div id="list2">

                                                        <%--<asp:Panel runat="server" ID="Panel1" CssClass="buttonsWrapper" Visible="<%#Container.PageCount > 1 %>">

                                                            <asp:Button runat="server" ID="PrevButton" CommandName="Page" CommandArgument="Prev"
                                                                Text="Prev Page" Enabled="<%#Container.CurrentPageIndex > 0 %>" />

                                                            <asp:Button runat="server" ID="NextButton" CommandName="Page" CommandArgument="Next"
                                                                Text="Next Page" Enabled="<%#Container.CurrentPageIndex < Container.PageCount - 1 %>" />

                                                            <br />

                                                        </asp:Panel>--%>

                                                        <div class="clearFix">
                                                        </div>

                                                        <asp:Panel ID="itemPlaceholder" runat="server">
                                                        </asp:Panel>

                                                        <div class="clearFix">
                                                        </div>

                                                    </div>

                                                </LayoutTemplate>

                                                <ItemTemplate>

                                                    <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                                        <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                            DataValue='<%#Eval("Image") %>' Height='<%#ImageHeight %>' Width="<%#ImageWidth %>"
                                                            ResizeMode="Crop"
                                                            onclick='<%#CreateWindowScript3(Eval("eventID"), Eval("photoID")) %>'
                                                            AlternateText="Click to view larger image" ToolTip="Click to view larger image" />

                                                        <div style="margin-top: -30px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">
                                                            <asp:LoginView ID="LoginView_AddButton" runat="server">
                                                                <RoleGroups>
                                                                    <asp:RoleGroup Roles="Administrator, EventManager">
                                                                        <ContentTemplate>

                                        <asp:LinkButton ID="btnDeleteImage" runat="server" ToolTip="Delete Image" CommandArgument='<%# Eval("photoID") %>' CommandName="DeleteImage"><i class="fa fa-trash fa-2x delete bin"></i></asp:LinkButton>
<%--                                                                            <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" 
                                                                                Text="Delete" CssClass="txt" />--%>

                                                                            <asp:LinkButton ID="btnRotateImage1" runat="server" ToolTip="Rotate Image" CommandName="Rotate"  CommandArgument='<%# Eval("photoID") %>'>
                                            <i class="fa fa-repeat fa-2x bin"></i></asp:LinkButton>





                                                                        </ContentTemplate>
                                                                    </asp:RoleGroup>
                                                                </RoleGroups>
                                                            </asp:LoginView>




                                                        </div>

                                                    </div>

                                                </ItemTemplate>

                                                <AlternatingItemTemplate>

                                                    <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                                        <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                            DataValue='<%#Eval("Image") %>' Height='<%#ImageHeight %>' Width="<%#ImageWidth %>"
                                                            ResizeMode="Crop"
                                                            onclick='<%#CreateWindowScript3(Eval("eventID"), Eval("photoID")) %>'
                                                            AlternateText="Click to view larger image" ToolTip="Click to view larger image" />

                                                        <div style="margin-top: -30px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">

                                        <asp:LinkButton ID="btnDeleteImage" runat="server" ToolTip="Delete Image" CommandArgument='<%# Eval("photoID") %>' CommandName="DeleteImage"><i class="fa fa-trash fa-2x delete bin"></i></asp:LinkButton>
<%--                                                                            <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" 
                                                                                Text="Delete" CssClass="txt" />--%>

                                                                            <asp:LinkButton ID="btnRotateImage2" runat="server" ToolTip="Rotate Image" CommandName="Rotate"  CommandArgument='<%# Eval("photoID") %>' >
                                            <i class="fa fa-repeat fa-2x bin"></i></asp:LinkButton>

                                                        </div>

                                                    </div>

                                                </AlternatingItemTemplate>
                                            </telerik:RadListView>

                                            <asp:Label ID="errorLabel" runat="server" />

                                            <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [photoID], [photoTitle], [photoDescription], [Image], [accountID], [eventID], [brandID] FROM [tblPhoto] WHERE ([eventID] = @eventID)">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="String"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

    </div>

        </asp:Panel>


     <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

     

        <script>
             // close the div in 5 secs    
            window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version        
            $("#messageHolder").fadeOut("slow", null);
        }

        function containerMouseover(sender) {
            sender.getElementsByTagName("div")[0].style.display = "";
        }

        function containerMouseout(sender) {
            sender.getElementsByTagName("div")[0].style.display = "none";
        }

            </script>
         </telerik:RadScriptBlock>
</asp:Content>
