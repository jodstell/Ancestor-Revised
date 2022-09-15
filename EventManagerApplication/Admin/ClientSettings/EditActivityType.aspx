<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditActivityType.aspx.vb" Inherits="EventManagerApplication.EditActivityType" %>

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
            margin-bottom: 10px;
        }

        /*label {
            width: 125px;
        }*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script>
             // close the div in 5 secs    
            window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version        
            $("#messageHolder").fadeOut("slow", null);
        }
            </script>
        </telerik:RadScriptBlock>



    <div class="container">
        <div class="row">
            <div id="messageHolder">
                <asp:Literal ID="msgLabel" runat="server" />
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">

                <div style="margin: 0 0 15px 0">
                    <h2>Activity Type: 
                        <asp:Label ID="ActivityNameLabel" runat="server" Font-Bold="true" /></h2>

                </div>

                </div>
            </div>

        <asp:Panel ID="MainPanel" runat="server">

<div class="row">
            <div class="col-md-12">

                <div style="margin: 12px 0 12px 0">
                   
                </div>

                <hr />

                 <div class="pull-right">
                        <asp:LinkButton ID="btnAddField" runat="server" Text="Add New Column" CssClass="btn btn-success btn-sm" ForeColor="White"> <i class="fa fa-plus"></i> Add New Column
                            </asp:LinkButton>
                    </div>

                <div class="form-horizontal">
                    <h3>Settings</h3>
                    
                    <div class="form-group">
                        <label for="activityNameTextBox" class="col-sm-2 control-label">Activity Name</label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="activityNameTextBox" runat="server" Text='' CssClass="form-control" />

                            <asp:RequiredFieldValidator ID="EventNameRequiredFieldValidator" runat="server"
ErrorMessage="Activity Name is required" 
CssClass="errorlabel" 
ControlToValidate="activityNameTextBox"
Display="Dynamic" 
ValidationGroup="details">
</asp:RequiredFieldValidator>


                        </div>
                    </div>

                    <div class="form-group">
                        <label for="ActiveList" class="col-sm-2 control-label">Active</label>
                        <div class="col-sm-8">
                           <asp:DropDownList ID="ActiveTextBox" runat="server" CssClass="form-control" Width="100px">
                                                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <span id="helpBlock1" class="help-block">Select Yes to enable this Event Type for the current client.</span>
                        </div>
                    </div>

                      <div class="form-group">
                        <label for="ActiveList" class="col-sm-2 control-label"></label>
                        <div class="col-sm-10">
                          <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" ValidationGroup="details" Text="Save & Continue" CssClass="btn btn-primary btn-sm" />


                             <asp:LinkButton ID="btnUpdate" runat="server" CausesValidation="True" ValidationGroup="details" CommandName="Update" Text="Update" CssClass="btn btn-primary btn-sm" />
                    &nbsp;<asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default btn-sm" />
                        </div>
                    </div>

                  
                    <br />

                    <h3>Columns</h3>

                   

                     <div class="form-group">
                        <label for="accountNameTextBox" class="col-sm-1 control-label"></label>
                        <div class="col-sm-11">

                    <asp:Repeater ID="ColumnList" runat="server" DataSourceID="getColumns">
                        <HeaderTemplate>
                            <table class="table" cellspacing="0" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Column Name</th>
                                            <th>Type</th>
                                            <th>Required</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                        </HeaderTemplate>

                        <ItemTemplate>
                            <tr>
                                <td>
                                    <div class="btn-group" role="group" aria-label="...">
                                    <asp:LinkButton ID="btnEditField" runat="server" CommandArgument='<%# Eval("fieldID")%>' CommandName="EditField" CssClass="btn btn-default btn-sm"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                                         <asp:LinkButton ID="DeleteButton1" runat="server" CausesValidation="False" CommandName="DeleteRow" CommandArgument='<%# Eval("fieldID")%>' CssClass="btn btn-sm btn-danger" ToolTip="Delete" OnClientClick="javascript:if(!confirm('This action will delete the selected question. Are you sure?')){return false;}"><i class="fa fa-trash"></i> Delete</asp:LinkButton>
                                        </div>
                                </td>
                                <td><%# Eval("fieldName")%></td>
                                <td><%# Eval("type")%></td>
                                <td>
                                    <asp:CheckBox ID="requiredCheckBox" runat="server" Checked='<%# Eval("required")%>' /></td>
                                <td>
                                    <div class="pull-right">
                            <div class="btn-group" role="group" aria-label="...">
                         <asp:LinkButton ID="MoveDown1" runat="server" OnClick="movedown" CommandArgument='<%# Eval("fieldID")%>' CssClass="btn btn-default btn-sm" ToolTip="Move Down" Enabled='<%# ShowLastButton(Eval("fieldID"))%>'><i class="fa fa-arrow-down"></i> Move Down</asp:LinkButton>

                                                                
                          <asp:LinkButton ID="MoveUp1" runat="server" OnClick="moveup" CommandArgument='<%# Eval("fieldID")%>' CssClass="btn btn-default btn-sm" ToolTip="Move Up" Enabled='<%# ShowFirstButton(Eval("fieldID"))%>'><i class="fa fa-arrow-up"></i> Move Up</asp:LinkButton>
                                </div>
</div>
                                </td>
                            </tr>

                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                            </table>

                             <asp:Label ID="lblEmptyData"
                                                Text='<%# Common.ShowAlertNoClose("warning", "There are no columns for this Activity Type.")%>'  runat="server" Visible="false">
                                         </asp:Label>

                        </FooterTemplate>

                    </asp:Repeater>

                            </div>
                    </div>

                    <asp:LinqDataSource ID="getColumns" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="sortOrder" TableName="tblActivityFields" Where="activityTypeID == @activityTypeID" EnableDelete="True">
                        <WhereParameters>
                            <asp:QueryStringParameter Name="activityTypeID" QueryStringField="ActivityTypeID" Type="Int32" DefaultValue="0" />
                        </WhereParameters>
                    </asp:LinqDataSource>

                </div>


            </div>

        </div>
            </asp:Panel>

        <asp:Panel ID="AddNewColumnPanel" runat="server" Visible="false">
              <div class="widget stacked">
                                <div class="widget-content">



                        <asp:Label ID="errLabel" runat="server" />

        <div class="form-horizontal">
            <div class="form-group">
                <label for="ColumnNameTextBox" class="col-sm-3 control-label">Column Name</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="ColumnNameTextBox" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="form-group">
                <label for="RequiredFieldTextBox" class="col-sm-3 control-label">Required Field</label>
                <div class="col-sm-6">
                    <asp:RadioButtonList ID="RequiredFieldTextBox" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                        <asp:ListItem Text="No" Value="False"></asp:ListItem>
                    </asp:RadioButtonList>
                    <span id="helpBlock2" class="help-block">Require that this column contains information.</span>



                </div>
            </div>

            <div class="form-group">
                <label for="columnTypeList" class="col-sm-3 control-label">Column Type</label>
                <div class="col-md-6">
                    <asp:RadioButtonList ID="columnTypeList" runat="server" AutoPostBack="true" Width="100%">
                        <asp:ListItem Text="Single line of text" Value="text"></asp:ListItem>
                        <asp:ListItem Text="Multiple lines of text" Value="multiline"></asp:ListItem>
                        <asp:ListItem Text="Yes/No (check box)" Value="yes/no"></asp:ListItem>
                        <asp:ListItem Text="Choice (menu to choose from)" Value="choice"></asp:ListItem>
                        <asp:ListItem Text="Number (1, 1.0, 100)" Value="number"></asp:ListItem>
                        <asp:ListItem Text="Date" Value="date"></asp:ListItem>
                        <asp:ListItem Text="Time" Value="time"></asp:ListItem>
                        <asp:ListItem Text="Currency ($)" Value="currency"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>



            <!-- Text Option -->
            <asp:Panel ID="DescriptionPanel" runat="server">
                <div class="form-group">
                    <label for="txtDescription" class="col-sm-3 control-label">Description Text</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control"></asp:TextBox>
                        <span id="helpBlock" class="help-block">Specify detailed options for the type of information you selected.</span>
                    </div>
                </div>

            </asp:Panel>

            <!-- Multiple Lines Option -->
            <asp:Panel ID="MultilinePanel" runat="server" Visible="false">
                <div class="form-group">
                    <label for="txtLines" class="col-sm-3 control-label">Number of lines for text</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtLines" runat="server" Text="6" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </asp:Panel>


            <!-- Choice Option -->
            <asp:Panel ID="ChoicePanel" runat="server" Visible="false">

                <div class="form-group">
                    <label for="txtChioces" class="col-sm-3 control-label">Choices</label>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txtChioces" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control"></asp:TextBox>
                        <span id="helpBlock3" class="help-block">Type each choice on a separate line.</span>


                    </div>
                </div>

                <div class="form-group">
                    <label for="DisplayOptions" class="col-sm-3 control-label">Display Options</label>
                    <div class="col-sm-6">
                        <asp:RadioButtonList ID="DisplayOptions" runat="server">
                            <asp:ListItem Selected="True" Text="Drop-Down Menu" Value="drop"></asp:ListItem>
                            <asp:ListItem Text="Radio Buttons" Value="radio"></asp:ListItem>
                            <asp:ListItem Text="Checkboxes (allow multiple selections)" Value="check"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>

            </asp:Panel>

             <!-- Choice Option -->
            <asp:Panel ID="YesNoPanel" runat="server" Visible="false">

                <div class="form-group">
                    <label for="ckbYesNo" class="col-sm-3 control-label">Default Value</label>
                    <div class="col-sm-4">
                        
                         <asp:RadioButtonList ID="ckbYesNo" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Yes" Value="True" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="No" Value="False"></asp:ListItem>
                        </asp:RadioButtonList>


                    </div>
                </div>
                </asp:Panel>


            <!-- Number Option -->
            <asp:Panel ID="NumberPanel" runat="server" Visible="false">

                <div class="form-group">
                    <label for="txtDecimalPlace" class="col-sm-3 control-label">Number of decimal places</label>
                    <div class="col-sm-1">
                        <asp:DropDownList ID="txtDecimalPlace" runat="server" CssClass="form-control">
                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtDefaultNumber" class="col-sm-3 control-label">Default value</label>
                    <div class="col-sm-1">
                        <asp:TextBox ID="txtDefaultNumber" runat="server" CssClass="form-control" Text="0" TextMode="Number"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="DisplayOptions" class="col-sm-3 control-label">Show as percentage</label>
                    <div class="col-sm-6">
                        <asp:RadioButtonList ID="ckbPercentage" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                            <asp:ListItem Text="No" Selected="True" Value="False"></asp:ListItem>
                        </asp:RadioButtonList>
                        (for example, 50%)
                    </div>
                </div>

            </asp:Panel>

            <!-- Date Option -->
            <asp:Panel ID="DatePanel" runat="server" Visible="false">
                <div class="form-group">
                    <label for="ckbDateFormat" class="col-sm-3 control-label">Date and Time Format</label>
                    <div class="col-sm-6">
                         <asp:RadioButtonList ID="ckbDateFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Date Only" Selected="True" Value="Date"></asp:ListItem>
                            <asp:ListItem Text="Date & Time" Value="DateTime"></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>

                    </div>

                <div class="form-group">
                    <label for="DisplayOptions" class="col-sm-3 control-label">Display Format</label>
                    <div class="col-sm-6">
                         <asp:RadioButtonList ID="ckbDateDisplayFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Standard" Value="Standard" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Friendly" Value="Friendly"></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>

                    </div>

                <div class="form-group">
                    <label for="ckbDateDefualtValue" class="col-sm-3 control-label">Default Value</label>
                    <div class="col-sm-6">
                         <asp:RadioButtonList ID="ckbDateDefualtValue" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="None" Selected="True" Value="None"></asp:ListItem>
                            <asp:ListItem Text="Current Date" Value="Current"></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>

                    </div>

            </asp:Panel>

            <!-- Date Option -->
            <asp:Panel ID="TimePanel" runat="server" Visible="false">
                <div class="form-group">
                    <label for="ckbTimeFormat" class="col-sm-3 control-label">Time Format</label>
                    <div class="col-sm-6">
                         <asp:RadioButtonList ID="ckbTimeFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="12 hours" Value="12 hours" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="24 hours" Value="24 hours"></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>

                    </div>
            </asp:Panel>

            <!-- Currency Option -->
            <asp:Panel ID="CurrencyPanel" runat="server" Visible="false">
            </asp:Panel>


            <div class="form-group">
                <label for="accountNameTextBox" class="col-sm-3 control-label"></label>
                <div class="col-sm-6">
                    <asp:Button ID="btnInsertQuestion" runat="server" Text="Save" CssClass="btn btn-primary" />
                    <asp:Button ID="btnCancelNewQuestion" runat="server" Text="Cancel" CssClass="btn btn-default" />
                </div>
            </div>
        </div>

                </div>

                 </div>


        </asp:Panel>

    </div>

</asp:Content>
