<%@ Page Title="Brand Details" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditBrand.aspx.vb" Inherits="EventManagerApplication.EditBrand" MaintainScrollPositionOnPostback="true" %>

<%@ Register Src="~/Admin/UserControls/BrandStaffingPositionControl.ascx" TagPrefix="uc1" TagName="BrandStaffingPositionControl" %>
<%@ Register Src="~/Admin/UserControls/BrandExecutionControl.ascx" TagPrefix="uc1" TagName="BrandExecutionControl" %>
<%@ Register Src="~/Admin/UserControls/BrandCategoryControl.ascx" TagPrefix="uc1" TagName="BrandCategoryControl" %>
<%@ Register Src="~/Admin/UserControls/BrandRoleAssociationControl.ascx" TagPrefix="uc1" TagName="BrandRoleAssociationControl" %>
<%@ Register Src="~/Admin/UserControls/BrandEventTasksControl.ascx" TagPrefix="uc1" TagName="BrandEventTasksControl" %>
<%@ Register Src="~/Admin/UserControls/BrandDocumentControl.ascx" TagPrefix="uc1" TagName="BrandDocumentControl" %>
<%@ Register Src="~/Admin/UserControls/AssociatedSuppliersControl.ascx" TagPrefix="uc1" TagName="AssociatedSuppliersControl" %>
<%@ Register Src="~/Admin/UserControls/BrandPosInformationControl.ascx" TagPrefix="uc1" TagName="BrandPosInformationControl" %>
<%@ Register Src="~/Admin/UserControls/BrandPOSItemsControl.ascx" TagPrefix="uc1" TagName="BrandPOSItemsControl" %>
<%@ Register Src="~/Admin/UserControls/RecapQuestionsControl.ascx" TagPrefix="uc1" TagName="RecapQuestionsControl" %>
<%@ Register Src="~/Admin/UserControls/BrandProcuctsControl.ascx" TagPrefix="uc1" TagName="BrandProcuctsControl" %>





<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        // close the div in 5 secs    
        window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version        
            $("#messageHolder").fadeOut("slow", null);
        }

        function resetDotNetScrollPosition() {
            var scrollX = document.getElementById('__SCROLLPOSITIONX');
            var scrollY = document.getElementById('__SCROLLPOSITIONY');

            if (scrollX != null && scrollY != null) {
                scrollX.value = 0;
                scrollY.value = 0;
            }
        }


        function requestStart(sender, args) {
            if (args.get_eventTarget().indexOf("btnExport") >= 0) {
                args.set_enableAjax(false);
            }
        }


    </script>

    <style>
        .form-group {
            margin-bottom: 10px;
        }
    </style>



</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="requestStart">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RecapListPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RecapListPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="NewRecapQuestionPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="NewRecapQuestionPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="BrandEventTaskListPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="BrandEventTaskListPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="BrandPositionListPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="BrandPositionListPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="EventExecutionListPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="EventExecutionListPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="BrandPOSListPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="BrandPOSListPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="InformationPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="InformationPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="BrandCategoryControlPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="BrandCategoryControlPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" BackgroundPosition="Top" Transparency="100"></telerik:RadAjaxLoadingPanel>

    <div class="container">
        <div class="row">
            <div id="messageHolder">
                <asp:Literal ID="msgLabel" runat="server" />
            </div>
        </div>


        <div class="row">
            <div class="col-md-12">

                <div style="margin: 0 0 15px 0">
                    <h2>Client Details: 
                        <asp:Label ID="ClientNameLabel" runat="server" Font-Bold="true" /></h2>
                    <h3>Brand Details: 
                        <asp:Label ID="BrandNameLabel" Font-Bold="true" runat="server" /></h3>
                    <asp:Label ID="ModifiedByLabel" runat="server" />
                </div>

                <div class="tabbable">

                    <ul id="MainTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                        <li class="active"><a href="#defaulttab" data-toggle="tab">Information</a></li>
                        <li><a href="#executiontab" data-toggle="tab">Event Execution</a></li>
                        <li class=""><a href="#productstab" data-toggle="tab">Products</a></li>
                        <%--<li class=""><a href="#categorytab" data-toggle="tab">Categories</a></li>--%>
                        <%--<li class=""><a href="#rolestab" data-toggle="tab">Roles</a></li>--%>
                        <li class=""><a href="#staffingtab" data-toggle="tab">Staffing</a></li>
                        <li class=""><a href="#eventtaskstab" data-toggle="tab">Event Tasks</a></li>                        
                        <li class=""><a href="#recaptab" data-toggle="tab">Recap Questions</a></li>
                        <li class=""><a href="#postab" data-toggle="tab">POS</a></li>
                        <li class=""><a href="#documentstab" data-toggle="tab">Documents</a></li>

                        <li class="pull-right secondarytab">
                            <asp:HyperLink ID="ReturnLink" runat="server"><i class="fa fa-angle-double-left"></i>&nbsp;Client Overview</asp:HyperLink>
                        </li>
                    </ul>

                    <div class="tab-content tab-container">
                        <!-- Client Details Tab -->
                        <div class="tab-pane active" id="defaulttab">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <h2>Default Information</h2>

                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CssClass="btn btn-md btn-primary" />
                                            </div>
                                        </div>
                                    </div>

                                    <hr />

                                    <asp:Panel runat="server" ID="InformationPanel2">
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <label for="BrandNameTextBox" class="col-sm-2 control-label">Brand Name:</label>
                                                <div class="col-sm-6">
                                                    <asp:TextBox ID="BrandNameTextBox" runat="server" CssClass="form-control" />
                                                </div>
                                            </div>

                                            

                                            <asp:HiddenField ID="HiddenBrandGroupID" runat="server" />


                                            <%--<div class="form-group">
                                                <label for="AssociatedSuppliersListBox" class="col-sm-2 control-label">Associated Suppliers:</label>
                                                <div class="col-sm-10">
                                                    <uc1:AssociatedSuppliersControl runat="server" ID="AssociatedSuppliersControl" />
                                                </div>
                                            </div>--%>

                                            <div class="form-group">
                                                <label for="ActiveTextBox" class="col-sm-2 control-label">Active:</label>
                                                <div class="col-sm-2">
                                                    <asp:DropDownList ID="ActiveTextBox" runat="server" CssClass="form-control" Width="150px">
                                                        <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                        <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                    </asp:DropDownList>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="StartDateTextBox1" class="col-sm-2 control-label">Brand Start Date:</label>
                                                <div class="col-sm-10">
                                                    <div class="form-inline">

                                                        <telerik:RadDatePicker ID="StartDateDatePicker" runat="server" Skin="Bootstrap"></telerik:RadDatePicker>

                                                        <label for="EndDateTextBox1" class="control-label" style="padding-right: 15px; padding-left: 20px;">Brand End Date:</label>
                                                        <telerik:RadDatePicker ID="EndDateDatePicker" runat="server" Skin="Bootstrap"></telerik:RadDatePicker>

                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="DataViewEndDateTextBox1" class="col-sm-2 control-label">Data View End Date:</label>
                                                <div class="col-sm-2">
                                                    <telerik:RadDatePicker ID="DataViewEndDateDatePicker" runat="server" Skin="Bootstrap"></telerik:RadDatePicker>
                                                </div>
                                            </div>

                                          <%--  <div class="form-group">
                                                <label class="col-sm-2 control-label">UPC:</label>
                                                <div class="col-sm-6">

                                                    

                                                    <telerik:RadDropDownList runat="server" ID="CourseList" DataSourceID="getCourseList" DataTextField="CourseTitle" DataValueField="CourseID" Width="300px" AutoPostBack="true" AppendDataBoundItems="true">
                                                        <Items>
                                                            <telerik:DropDownListItem Text="-- Select School --" Value="" />
                                                        </Items>
                                                    </telerik:RadDropDownList>

                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getCourseList" ContextTypeName="EventManagerApplication.LMSDataClassesDataContext" OrderBy="CourseTitle" TableName="Courses" Where="SiteID == @SiteID">
                                                        <WhereParameters>
                                                            <asp:Parameter DefaultValue="GigEngyn" Name="SiteID" Type="String"></asp:Parameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>
                                                </div>
                                            </div>--%>

                                           <%-- <div class="form-group">
                                                <label class="col-sm-2 control-label">Brand Training:</label>
                                                <div class="col-sm-6">
                                                    <telerik:RadDropDownList ID="CurriculumList" runat="server" DataSourceID="getCurriculumList" DataTextField="Title" DataValueField="CurriculumGroupID"
                                                        AppendDataBoundItems="true" Width="300px">
                                                        <Items>
                                                            <telerik:DropDownListItem Text="-- Select Training Course --" Value="" />
                                                        </Items>
                                                    </telerik:RadDropDownList>


                                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getCurriculumList" ContextTypeName="EventManagerApplication.LMSDataClassesDataContext" OrderBy="Title" TableName="CurriculumGroups" Where="CourseID == @CourseID">
                                                        <WhereParameters>
                                                            <asp:ControlParameter ControlID="CourseList" PropertyName="SelectedValue" Name="CourseID" Type="String"></asp:ControlParameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>
                                                </div>

                                            </div>--%>


                                        </div>
                                    </asp:Panel>
                                </div>
                            </div>

                        </div>

                        <!-- event execution Tab -->
                        <div class="tab-pane" id="executiontab">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <h2>Event Execution Details</h2>
                                    <hr />

                                    <uc1:BrandExecutionControl runat="server" ID="BrandExecutionControl" />
                                </div>
                            </div>
                        </div>


                        <!-- brand category Tab -->
                        <%--<div class="tab-pane" id="categorytab">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <h2>Brand Category</h2>
                                    <hr />

                                    <uc1:BrandCategoryControl runat="server" ID="BrandCategoryControl" />
                                </div>
                            </div>

                        </div>--%>

                        <div class="tab-pane" id="productstab">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <h2>Products</h2>
                                    <hr />
                                    <uc1:BrandProcuctsControl runat="server" id="BrandProcuctsControl" />
                                </div>
                            </div>

                        </div>

                        <!-- role association Tab -->
                        <div class="tab-pane" id="rolestab">
                            <div class="widget stacked min-height">
                                <div class="widget-content">
                                    <h2>Role Association</h2>
                                    <hr />

                                    <uc1:BrandRoleAssociationControl runat="server" ID="BrandRoleAssociationControl" />
                                </div>
                            </div>
                        </div>

                        <!-- staffing Tab -->
                        <div class="tab-pane" id="staffingtab">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <h2>Staffing Details</h2>
                                    <hr />

                                    <uc1:BrandStaffingPositionControl runat="server" ID="BrandStaffingPositionControl" />

                                </div>
                            </div>
                        </div>

                        <!-- event tasks Tab -->
                        <div class="tab-pane" id="eventtaskstab">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <h2>Event Tasks</h2>
                                    <hr />

                                    <uc1:BrandEventTasksControl runat="server" ID="BrandEventTasksControl" />
                                </div>
                            </div>
                        </div>

                        <!-- documents Tab -->
                        <div class="tab-pane" id="documentstab">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <h2>Files/Documents</h2>
                                    <hr />

                                    <uc1:BrandDocumentControl runat="server" ID="BrandDocumentControl" />
                                </div>
                            </div>
                        </div>

                        <!-- recap questions Tab -->
                        <div class="tab-pane" id="recaptab">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <h2>Recap Questions</h2>
                                    <hr />

                                    <uc1:RecapQuestionsControl runat="server" ID="RecapQuestionsControl" />

                                </div>
                            </div>
                        </div>

                        <!-- pos Tab -->
                        <div class="tab-pane" id="postab">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <h2>POS Items</h2>
                                    <hr />

                                    <uc1:BrandPOSItemsControl runat="server" ID="BrandPOSItemsControl" />


                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>



        </div>


    </div>

    <script>
        $(document).ready(function () {

            handleTabLinks();
        });

        function handleTabLinks() {
            if (window.location.hash == '') {
                window.location.hash = window.location.hash + '#_';
            }
            var hash = window.location.hash.split('#')[1];
            var prefix = '_';
            var hpieces = hash.split('/');
            for (var i = 0; i < hpieces.length; i++) {
                var domelid = hpieces[i].replace(prefix, '');
                var domitem = $('a[href=#' + domelid + '][data-toggle=tab]');
                if (domitem.length > 0) {
                    domitem.tab('show');
                }
            }
            $('a[data-toggle=tab]').on('shown', function (e) {
                if ($(this).hasClass('nested')) {
                    var nested = window.location.hash.split('/');
                    window.location.hash = nested[0] + '/' + e.target.hash.split('#')[1];
                } else {
                    window.location.hash = e.target.hash.replace('#', '#' + prefix);
                }
            });
        }
    </script>



    <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Text="Your changes were updated successfully!" Title="Success" TitleIcon="info"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>


</asp:Content>
