<%@ Page Title="Edit Message" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EmailMessages.aspx.vb" Inherits="EventManagerApplication.EmailMessages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .active2b { /*hover state CSS*/
            color: #3276b1;
            background-color: #fff;
            text-decoration: none;
        }

        .form-group {
            margin-bottom: 10px;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="BccPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="BccPanel" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="ListPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ListPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="btnPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <div id="container" class="container min-height">
        <div class="row">
            <div class="col-md-12">

                <h2>Edit Message:
                    <asp:Label ID="lblEmail" runat="server" /></h2>
                <hr />

                <asp:Panel ID="Panel1" runat="server">

                    <div class="row" style="padding-top: 20px;">

                        <div class="col-md-3">
                            <div class="widget stacked">
                                <div class="widget-content-sidebar sidemenu">
                                    <asp:Panel ID="ListPanel" runat="server">
                                        <asp:Repeater ID="MessageList" runat="server" DataSourceID="getMessageList">
                                            <HeaderTemplate>
                                                <ul>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <li id='link<%# Eval("messageID") %>'>
                                                    <asp:LinkButton ID="btnChangeForm" runat="server" CommandName="Change" CommandArgument='<%# Eval("messageID") %>'><%# Eval("messageTitle") %></asp:LinkButton>
                                                </li>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </ul>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </asp:Panel>
                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getMessageList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblMessages"></asp:LinqDataSource>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-9">

                            <asp:Panel ID="btnPanel" runat="server">
                                <div class="row">
                                    <div class="col-md-12">
                                        <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-primary" ValidationGroup="confirm" />
                                        <asp:Button ID="btnBackEmail" runat="server" Text="Back To Site Administration" CssClass="btn btn-default" />

                                        <div class="btn-group pull-right" role="group" aria-label="...">
                                            <asp:Button ID="btnPreviewEmail" runat="server" Text="Preview Email" CssClass="btn btn-success" />
                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>

                            <br />


                            <div class="widget stacked">
                                <div class="widget-content">
                                    <div class="form-horizontal">
                                        <asp:Panel ID="MessagePanel" runat="server">

                                            <div class="form-group">
                                                <label id="lblDescriptionLabel" class="col-sm-2 control-label">Description: </label>
                                                <div class="col-sm-10" style="margin-top: 7px;">
                                                    <p>
                                                        <asp:Label ID="DescriptionLabel" runat="server" /> </p>
                                                </div>
                                            </div>




                                            <div class="form-group">
                                                <label id="lblFromEmail" class="col-sm-2 control-label">From Email: <span class="text-danger">*</span></label>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="FromEmailTextBox" runat="server" CssClass="form-control" />

                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server"
                                                        ErrorMessage="Your email is required" CssClass="errorlabel" ControlToValidate="FromEmailTextBox"
                                                        Display="Dynamic" ValidationGroup="confirm"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label id="lblFromName" class="col-sm-2 control-label">From Name: <span class="text-danger">*</span></label>
                                                <div class="col-sm-4">
                                                    <asp:TextBox ID="FromNameTextBox" runat="server" CssClass="form-control" />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                        ErrorMessage="Your name is required" CssClass="errorlabel" ControlToValidate="FromNameTextBox"
                                                        Display="Dynamic" ValidationGroup="confirm"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label id="lblSubject" class="col-sm-2 control-label">Subject: <span class="text-danger">*</span></label>
                                                <div class="col-sm-7">
                                                    <asp:TextBox ID="SubjectTextBox" runat="server" CssClass="form-control" />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                        ErrorMessage="Your subject is required" CssClass="errorlabel" ControlToValidate="SubjectTextBox"
                                                        Display="Dynamic" ValidationGroup="confirm"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>


                                            <div class="form-group">
                                                <label id="MessageTextBox" class="col-sm-2 control-label">Message: <span class="text-danger">*</span></label>
                                                <div class="col-sm-10">
                                                    <telerik:RadEditor ID="MessageEditor" runat="server" EditModes="Design, HTML" OnClientCommandExecuting="OnClientCommandExecuting" Width="100%">

                                                        <Tools>
                                                            <telerik:EditorToolGroup>
                                                                <telerik:EditorTool Name="AjaxSpellCheck" />
                                                                <telerik:EditorTool Name="Bold" />
                                                                <telerik:EditorTool Name="Italic" />
                                                                <telerik:EditorTool Name="Underline" />
                                                                <telerik:EditorTool Name="Cut" />
                                                                <telerik:EditorTool Name="Undo" />
                                                                <telerik:EditorTool Name="FormatStripper" />
                                                                <telerik:EditorTool Name="PasteStrip" />
                                                                <telerik:EditorTool Name="FormatBlock" />
                                                                <telerik:EditorTool Name="FontName" />
                                                                <telerik:EditorTool Name="RealFontSize" />
                                                                <telerik:EditorSeparator />

                                                                <telerik:EditorTool  name="InsertLink" />
                                                                <%--<telerik:EditorTool Name="InsertTable" />--%>
                                                            </telerik:EditorToolGroup>
                                                        </Tools>
                                                        <Languages>
                                                            <telerik:SpellCheckerLanguage Code="en-US" Title="English" />
                                                        </Languages>
                                                    </telerik:RadEditor>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                    </div>

                                    <br />
                                    <br />

                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" style="margin-top:-5px">BCC:</label>
                                            <div class="col-sm-10">

                                                <div class="row">
                                                    <div class="col-md-12">

                                                        <asp:Panel ID="BccPanel" runat="server">
                                                            <asp:Repeater ID="BccRepeater" runat="server" DataSourceID="getBccAddresses">
                                                                <HeaderTemplate>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>

                                                                    <div class="row">
                                                                        <div class="col-sm-4">
                                                                            <asp:Label ID="lblBccAddress" runat="server" Text='<%# Eval("bccAddress") %>' CssClass="control-label"></asp:Label>
                                                                        </div>
                                                                        <div class="col-sm-4">
                                                                            <asp:LinkButton ID="btnRemove" runat="server" CommandName="RmoveBcc"
                                                                                CommandArgument='<%# Eval("messagebccID") %>' CssClass="btn btn-xs btn-danger">Remove</asp:LinkButton>
                                                                        </div>
                                                                    </div>

                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                </FooterTemplate>
                                                            </asp:Repeater>


                                                            <div class="row" style="padding-top: 20px;">
                                                                <div class="col-sm-4">
                                                                    <asp:TextBox ID="AddBccTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                                        ErrorMessage="Email address is required" CssClass="errorlabel" ControlToValidate="AddBccTextBox"
                                                                        Display="Dynamic" ValidationGroup="bcc"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="emailAdressRegularExpressionValidator" runat="server" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
                                                                        ControlToValidate="AddBccTextBox" ErrorMessage="Invalid Email Format" CssClass="errorlabel" ValidationGroup="bcc"></asp:RegularExpressionValidator>
                                                                </div>
                                                                <div class="col-sm-4">
                                                                    <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-xs btn-success" ValidationGroup="bcc">Add BCC</asp:LinkButton>
                                                                </div>
                                                            </div>

                                                        </asp:Panel>

                                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getBccAddresses" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                            OrderBy="bccAddress" TableName="tblMessageBccs" Where="messageID == @messageID">
                                                            <WhereParameters>
                                                                <asp:QueryStringParameter QueryStringField="messageID" Name="messageID" Type="Int32"></asp:QueryStringParameter>
                                                            </WhereParameters>
                                                        </asp:LinqDataSource>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>

                </asp:Panel>


            </div>
        </div>
    </div>

    <telerik:RadNotification RenderMode="Lightweight" ID="ErrorRadNotification" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500" ContentIcon="warning"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" title="warning"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>

     <telerik:RadNotification RenderMode="Lightweight" ID="SuccessRadNotification" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500" ContentIcon="ok"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Title="Success"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>

     <telerik:RadNotification RenderMode="Lightweight" ID="InfoRadNotification" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500" ContentIcon="info"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Title="Alert"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>

    <telerik:RadNotification RenderMode="Lightweight" ID="DeleteRadNotification1" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500" ContentIcon="delete"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Title="Alert"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            //<![CDATA[

            function getUrlVars() {
                var vars = [], hash;
                var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < hashes.length; i++) {
                    hash = hashes[i].split('=');
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                }
                return vars;
            }

            var messageID = getUrlVars()["messageID"];


            $('#link' + messageID).addClass('active2b');


            function OnClientCommandExecuting(editor, args) {
                var name = args.get_name(); //The command name
                var val = args.get_value(); //The tool that initiated the command

                if (name == "DynamicDropdown" || name == "DynamicSplitButton") {
                    editor.pasteHtml("[" + val + "]");
                    //Cancel the further execution of the command
                    args.set_cancel(true);
                }
            }
            //]]>
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
