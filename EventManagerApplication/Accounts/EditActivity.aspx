<%@ Page Title="Edit Activity" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditActivity.aspx.vb" Inherits="EventManagerApplication.EditActivity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .widget .widget-content {
            padding-top: 5px;
        }

        .nav-tabs, .nav-pills {
            margin-bottom: 1px;
        }

        .table th, .table td {
            border-top: none !important;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group-sm {
            margin-bottom: 10px;
        }

        .combobox {
            width: 300px;
        }


        .RadListView div.rlvI, .RadListView div.rlvA {
            border-bottom: 1px solid;
            padding-top: 5px;
            padding-bottom: 8px;
            padding-left: 5px;
        }


        .DropZone1 {

    width: 100%;
    height: 90px;
    background-color: #357A2B;
    border-color: #CCCCCC;
    float: left;
    text-align: center;
    font-size: 16px;
    color: white;
    margin-bottom: 25px;
}

 

.demo-container .RadAsyncUpload {
    margin-bottom: 28px;
}

 

.demo-container .RadUpload .ruUploadProgress {
    width: 230px;
    display: inline-block;
    overflow: hidden;
    text-overflow: ellipsis;
}

 

.demo-container .ruFakeInput {
    width: 200px;
}

.btnbox {
    padding-top: 25px;
    text-align: right;
}

.imageContainer {
        padding: 4px;
    }

        .imageContainer:hover {
            background-color: #a1da29 !important;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    
    <div class="container">

        <asp:Panel ID="ViewPanel" runat="server" Visible="false">
            <div class="row">
                <div class="col-xs-12">
                    <h2>View Activity:
                        <asp:Label ID="activityTypeLabel" runat="server" /></h2>

                    <ol class="breadcrumb">
                        <li><a href="/">Dashboard</a></li>
                        <li><a href="/Accounts/ViewAccounts?LoadState=Yes">Accounts</a></li>
                        <li><a href="/Accounts/ViewActivities?LoadState=Yes">Activities</a></li>
                        <li class="active">View Activity</li>
                    </ol>

                </div>
            </div>
            <!-- end row -->

            <div class="row">
                <div class="col-xs-12">
                    <div>
                        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                            <div class="pull-right">

                                <div class="btn-group" role="group">
                                    <a href='/Accounts/ViewActivities?LoadState=Yes' class="btn btn-default"><i class="fa fa-chevron-left" aria-hidden="true"></i> Back to Activities</a>
                                    <a href='/Accounts/editactivity?ActivityID=<%= Request.QueryString("ActivityID")%>&AccountID=<%= Request.QueryString("AccountID")%>&Mode=Edit' class="btn btn-default"><i class="fa fa-pencil" aria-hidden="true"></i> Edit Activity</a>

                                    <asp:LinkButton ID="btnDelete1" runat="server" CausesValidation="False"
                                        CssClass="btn btn-danger" OnClientClick="javascript:if(!confirm('This action will delete this activity. Are you sure?')){return false;}"><i class="fa fa-trash" aria-hidden="true"></i> Delete</asp:LinkButton>
                                </div>

                            </div>
                        </telerik:RadScriptBlock>
                    </div>

                </div>
                <!-- end row -->
            </div>

            <div class="row">
                <div class="col-md-12">

                <%--<label class="lbl" for="accountNameLabel">Account Name</label>--%>
                <div>
                    <h3><a href='/Accounts/AccountDetails?AccountID=<%= Request.QueryString("AccountID")%>'>
                        <asp:Label ID="accountNameLabel" runat="server" /></a></h3>
                </div>

                <p>
                    <asp:Label ID="accountlLocationLabel" runat="server" Font-Size="Large" />
                    <br />


                    <asp:Label ID="activityDateLabel" runat="server" Font-Size="Large" />
                </p>
                    </div>
            </div>

            <div class="row">

                <hr />

                <div class="col-xs-8">

                    <h3>Activity Results</h3>

                    <div class="widget stacked1">
                        <div class="widget-content1">

                            
                            <telerik:RadListView runat="server" ID="FlowListView" RenderMode="Lightweight" AllowPaging="False"
                                DataSourceID="getActivityResult">
                                
                                <LayoutTemplate>
                                    <div class="RadListView RadListView_Bootstrap">
                                        <div id="itemPlaceholder" runat="server"></div>
                                    </div>
                                </LayoutTemplate>

                                <AlternatingItemTemplate>
                                    <table class="table table-bordered" style="margin-bottom:0; border-bottom-color:white">
                                    <tr>

                                        <td style="width:50% !important;">
                                            <asp:Label ID="questionLabel" runat="server" Text='<%# Eval("question")%>' /></label>
                                        </td>

                                        <td style="width:50% !important;" class="active">
                                            <asp:Label ID="answerLabel" runat="server" Text='<%# Eval("answer")%>' ForeColor="#23527c" />
                                        </td>

                                    </tr>
                                    </table>
                                </AlternatingItemTemplate>

                                <ItemTemplate>
                                    <table class="table table-bordered" style="margin-bottom:0; border-bottom-color:white">
                                    <tr>

                                        <td style="width:50% !important;">
                                            <asp:Label ID="questionLabel" runat="server" Text='<%# Eval("question")%>' /></label>
                                        </td>

                                        <td style="width:50% !important;" class="active">
                                            <asp:Label ID="answerLabel" runat="server" Text='<%# Eval("answer")%>' ForeColor="#23527c" />
                                        </td>

                                    </tr>
                                    </table>
                                </ItemTemplate>

                            </telerik:RadListView>


                            <%--  <asp:Repeater ID="ActivityRepeater" runat="server" DataSourceID="getActivityResult">
                                <HeaderTemplate></HeaderTemplate>
                                <ItemTemplate>

                                    <div class="form-group" style="border-bottom: 1px solid #c0c0c0; padding-bottom: 15px;">
                                        <label>
                                            <asp:Label ID="questionLabel" runat="server" Text='<%# Eval("question")%>' /></label>
                                        <div>
                                            <asp:Label ID="answerLabel" runat="server" Text='<%# Eval("answer")%>' />
                                        </div>
                                    </div>

                                </ItemTemplate>
                                <FooterTemplate></FooterTemplate>
                            </asp:Repeater>--%>
                        </div>
                    </div>



                    <h3>POS Distribution</h3>
                    <div class="widget stacked">
                        <div class="widget-content">

                            <asp:Repeater ID="POSRepeater" runat="server"></asp:Repeater>
                        </div>
                    </div>
                </div>

                <div class="col-xs-4">

                    <%--<div class="RadListView RadListView_Bootstrap">
                        <div class="rlvA">
                            Activity Created By
                            </div>
                        <div class="rlvI">
                            Notes
                            </div>
                        </div>--%>

                    


                    <h3>Photos</h3>

                    <div class="widget stacked">
                        <div class="widget-content">
                            
                            <asp:Panel ID="Panel1" runat="server">

            <asp:Label ID="errorLabel" runat="server" />

            

            <div class="row" style="margin-left:-5px !important;">
            <telerik:RadListView runat="server" ID="PhotoListView" DataSourceID="getImageList" Skin="Bootstrap"
                        AllowPaging="true" DataKeyNames="photoID" OverrideDataSourceControlSorting="true">

                        <LayoutTemplate>

                                <asp:Panel ID="itemPlaceholder" runat="server">
                                </asp:Panel>
                                                                            
                        </LayoutTemplate>

                        <ItemTemplate>

                            <div class="col-md-4 imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                    <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                            DataValue='<%#Eval("Image") %>' Height="130px" Width="130px"
                                ResizeMode="Crop" AlternateText="Click to view larger image" ToolTip="Click to view larger image" onclick='<%#CreateWindowScript(Eval("activityID"), Eval("photoID")) %>' />

                            </div>
                        </ItemTemplate>


                <AlternatingItemTemplate>

                     <div class="col-md-4 imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                    <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                            DataValue='<%#Eval("Image") %>' Height="130px" Width="140px"
                                ResizeMode="Crop" AlternateText="Click to view larger image" ToolTip="Click to view larger image" onclick='<%#CreateWindowScript(Eval("activityID"), Eval("photoID")) %>' />

                            </div>

                </AlternatingItemTemplate>

                        
                    </telerik:RadListView>
                </div>
            

        <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [tblAccountActivityPhoto] WHERE ([activityID] = @activityID)">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="ActivityID" Name="activityID" Type="Int32"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>


        </asp:Panel>
                            
                        </div>
                    </div>

                </div>

            </div>


        </asp:Panel>


        <asp:Panel ID="EditPanel" runat="server" Visible="false">
            <div class="row">
                <div class="col-xs-12">
                    <h2>Edit Activity</h2>
                    <hr />
                </div>
            </div>
            <!-- end row -->

            <div class="row">
                <div class="col-xs-12">
                    <div>
                        <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">

                            <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-primary" />
                            &nbsp;<a href='<%= String.Format("/accounts/editactivity?ActivityID={0}&AccountID={1}&Mode=View#activities", Request.QueryString("ActivityID"), Request.QueryString("AccountID")) %>'
                                 class="btn btn-default">Cancel</a>


                        </telerik:RadScriptBlock>
                    </div>
                    <hr />
                </div>


            </div>
            <!-- end row -->



            <div class="row">

                <div class="col-xs-8">

                    <div class="form-group-sm">
                        <label class="lbl" for="accountNameLabel">Account Name:</label>
                        <asp:Label ID="AccountNameLabel1" runat="server" />
                    </div>

                    <div class="form-group-sm">
                        <label class="lbl" for="activityTypeLabel">Activity Type:</label>
                        <asp:Label ID="ActivityTypeLabel1" runat="server" />
                    </div>

                    <div class="form-group-sm">
                        <label class="lbl" for="activityDateLabel">Date:</label>
                        <asp:Label ID="ActivityDateLabel1" runat="server" />
                    </div>

                    <h3>Activity</h3>
                    <div class="widget stacked">
                        <div class="widget-content">

                            <asp:PlaceHolder ID="EditPlaceHolder" runat="server"></asp:PlaceHolder>

                        </div>
                    </div>

                    <h3>POS Distribution</h3>
                    <div class="widget stacked">
                        <div class="widget-content">

                            <asp:Repeater ID="Repeater2" runat="server"></asp:Repeater>
                        </div>
                    </div>
                </div>

                <div class="col-xs-4">
                    <h3>Photos</h3>

                    <div class="widget stacked">
                        <div class="widget-content">

                            <asp:Panel ID="divbuttons" runat="server">
                            <div class="row">

                                <div class="col-md-12">
                                    <div class="pull-right">
                        <asp:LinkButton ID="AddPhotoButton" runat="server" CssClass="btn btn-success btn-sm" Style="margin: 12px 0 12px 0"><i class="fa fa-plus"></i> Add New Photo</asp:LinkButton>
                                        </div>
                                    </div>

                            </div>
                            </asp:Panel>

                            <asp:Panel ID="ViewPhotoPanel" runat="server">

                            <telerik:RadListView runat="server" ID="PhotoListViewEdit" DataSourceID="getImageList" Skin="Bootstrap"
                                            AllowPaging="true" DataKeyNames="photoID" OverrideDataSourceControlSorting="true">

                                            <LayoutTemplate>

                                                    <asp:Panel ID="itemPlaceholder" runat="server">
                                                    </asp:Panel>
                                                
                                            </LayoutTemplate>

                                            <ItemTemplate>

                                                <div class="col-md-4 imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                     <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                DataValue='<%#Eval("Image") %>' Height="130px" Width="130px"
                                                 ResizeMode="Crop" AlternateText="Click to view larger image" ToolTip="Click to view larger image" onclick='<%#CreateWindowScript(Eval("activityID"), Eval("photoID")) %>' />

                                                    <div style="margin-top: -30px; position: absolute; width: <%#ImageHeight.Value/1.5 %>px;">
                                                        <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" Text="Delete" CssClass="txt" />

                                                    </div>
                                                </div>
                                            </ItemTemplate>

                                            <AlternatingItemTemplate>

                                                <div class="col-md-4 imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">
                                         <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                        DataValue='<%#Eval("Image") %>' Height="130px" Width="130px"
                                                        ResizeMode="Crop" AlternateText="Click to view larger image" ToolTip="Click to view larger image" onclick='<%#CreateWindowScript(Eval("activityID"), Eval("photoID")) %>' />
                                                    <div style="margin-top: -30px; position: absolute; width: <%#ImageHeight.Value/1.5 %>px;">

                                                        <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server" Text="Delete" CssClass="txt" />

                                                    </div>

                                                </div>

                                            </AlternatingItemTemplate>

                                        </telerik:RadListView>

                            </asp:Panel>


                            <asp:Panel ID="UploadPanel" runat="server" Visible="false">
                                <div class="demo-container size-wide">
                                    <h2>Photos</h2>
                                <p>
                                    Upload your photos here using the file uploader or the drop box below.
                                </p>

                                <telerik:RadAsyncUpload runat="server" ID="RadAsyncUpload1" MultipleFileSelection="Automatic" DropZones=".DropZone1,#DropZone2" />


                                <div class="DropZone1">

                                    <br />
                                    <br />

                                    <p>Drop Files Here</p>

                                </div>

                                    
                                    <asp:Button ID="btnUpload" runat="server" Text="Upload Photos" CssClass="btn btn-md btn-primary" /> <asp:Button ID="btnCancelUpload" runat="server" Text="Cancel" CssClass="btn btn-md btn-default" />
                                    

                            </div>
                        </asp:Panel>

                            </div>
                        </div>

                    </div>

                </div>




        </asp:Panel>


        <asp:LinqDataSource ID="getActivityTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="activityName" TableName="tblActivityTypes">
        </asp:LinqDataSource>

        <asp:LinqDataSource ID="getSelectedActivity" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblAccountActivities" Where="accountActivityID == @accountActivityID">
            <WhereParameters>
                <asp:QueryStringParameter Name="accountActivityID" QueryStringField="ActivityID" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>

        <asp:LinqDataSource ID="getActivityResult" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="order" TableName="tblAccountActivityResults" Where="accountActivityID == @accountActivityID">
            <WhereParameters>
                <asp:QueryStringParameter Name="accountActivityID" QueryStringField="ActivityID" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>

    </div>


    <telerik:RadWindowManager runat="server" ID="RadWindowManager1">

        <Windows>

            <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" Skin="Bootstrap"
                Width="675px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                Modal="true">
            </telerik:RadWindow>

        </Windows>

    </telerik:RadWindowManager>

    <%--    <script src="../js/plugins/datepicker/bootstrap-datepicker.js"></script>

    <script>

        $(function () {

            $('#dp-ex-1').datepicker()
            $('#dp-ex-2').datepicker()
            $('#dp-ex-3').datepicker()
            $('#dp-ex-4').datepicker()
            $('#dp-ex-5').datepicker()
        });
    </script>--%>


    <telerik:RadScriptBlock ID="RadScriptBlock3" runat="server">

        <script>

    (function () {

        var $;

        var demo = window.demo = window.demo || {};



        demo.initialize = function () {

            $ = $telerik.$;



            if (!Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {

                $(".qsf-demo-canvas").html("<strong>Your browser does not support Drag and Drop. Please take a look at the info box for additional information.</strong>");

            }

            else {

                $(document).bind({ "drop": function (e) { e.preventDefault(); } });



                var dropZone1 = $(document).find(".DropZone1");

                dropZone1.bind({ "dragenter": function (e) { dragEnterHandler(e, dropZone1); } })

                         .bind({ "dragleave": function (e) { dragLeaveHandler(e, dropZone1); } })

                         .bind({ "drop": function (e) { dropHandler(e, dropZone1); } });



                var dropZone2 = $(document).find("#DropZone2");

                dropZone2.bind({ "dragenter": function (e) { dragEnterHandler(e, dropZone2); } })

                         .bind({ "dragleave": function (e) { dragLeaveHandler(e, dropZone2); } })

                         .bind({ "drop": function (e) { dropHandler(e, dropZone2); } });

            }

        };



        function dropHandler(e, dropZone) {

            dropZone[0].style.backgroundColor = "#357A2B";

        }



        function dragEnterHandler(e, dropZone) {

            var dt = e.originalEvent.dataTransfer;

            var isFile = (dt.types != null && (dt.types.indexOf ? dt.types.indexOf('Files') != -1 : dt.types.contains('application/x-moz-file')));

            if (isFile || $telerik.isSafari5 || $telerik.isIE10Mode || $telerik.isOpera)

                dropZone[0].style.backgroundColor = "#000000";

        }



        function dragLeaveHandler(e, dropZone) {

            if (!$telerik.isMouseOverElement(dropZone[0], e.originalEvent))

                dropZone[0].style.backgroundColor = "#357A2B";

        }





    })();
</script>

<script>

        function containerMouseover(sender) {
            sender.getElementsByTagName("div")[0].style.display = "";
        }

        function containerMouseout(sender) {
            sender.getElementsByTagName("div")[0].style.display = "none";
        }
    </script>

    </telerik:RadScriptBlock>

</asp:Content>
