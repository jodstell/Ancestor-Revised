<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EventTypeRecapQuestionsControl.ascx.vb" Inherits="EventManagerApplication.EventTypeRecapQuestionsControl" %>

<style>
    .form-horizontal .control-label {
    padding-top: 0;
    margin-bottom: 0;
    text-align: right;
}
</style>



    <asp:Panel ID="RecapListPanel" runat="server">
    <div class="col-md-12">


        

        <telerik:RadListView ID="RecapList" runat="server"
            DataKeyNames="eventTypeRecapQuestionID" InsertItemPosition="LastItem" DataSourceID="getEventTypeRecapQuestionList">
            <LayoutTemplate>
                <div class="RadListView RadListView_Default">
                    <table class="table" cellspacing="0" style="width: 100%;">
                        <thead>
                            <tr>
                                <th></th>
                            <th>Recap Question</th>
                            <th>Question Type</th>
                            <th>Required</th>
                            <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </tbody>
                        <tfoot>

                            <asp:LinkButton ID="btnInsert1" runat="server" CommandName="AddQuestion" Visible="<%# Not Container.IsItemInserted %>"
                                CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Recap Question</asp:LinkButton>
                        </tfoot>
                    </table>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <tr class="rlvI">
                    <td>
                        <div class="btn-group" role="group" aria-label="...">

                            <asp:LinkButton ID="btnEditRecap1" runat="server" CssClass="btn btn-sm btn-default" ToolTip="Edit" CommandName="EditRecapQuestion" CommandArgument='<%# Eval("eventTypeRecapQuestionID")%>'> <i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                         
                        <asp:LinkButton ID="DeleteButton1" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-sm btn-danger" ToolTip="Delete" OnClientClick="javascript:if(!confirm('This action will delete the selected question. Are you sure?')){return false;}"><i class="fa fa-trash"></i> Delete</asp:LinkButton>
                            </div>

                    </td>
                    <td style="width:50%">
                        <asp:Label ID="questionLabel" runat="server" Text='<%# Eval("question")%>' />
                    </td>
                    <td>
                         <%# Eval("questionType")%>
                    </td>

                    <td>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("required")%>' />
                                                                   </td>
                                                              

                    <td>
                        <div class="pull-right">
                            <div class="btn-group" role="group" aria-label="...">
                         <asp:LinkButton ID="MoveDown1" runat="server" OnClick="movedown" CommandArgument='<%# Eval("eventTypeRecapQuestionID")%>' CssClass="btn btn-default btn-sm" ToolTip="Move Down" Enabled='<%# ShowLastButton(Eval("eventTypeRecapQuestionID"))%>'><i class="fa fa-arrow-down"></i> Move Down</asp:LinkButton>

                                                                
                                                                    <asp:LinkButton ID="MoveUp1" runat="server" OnClick="moveup" CommandArgument='<%# Eval("eventTypeRecapQuestionID")%>' CssClass="btn btn-default btn-sm" ToolTip="Move Up" Enabled='<%# ShowFirstButton(Eval("eventTypeRecapQuestionID"))%>'><i class="fa fa-arrow-up"></i> Move Up</asp:LinkButton>
                                </div>
</div>
                    </td>
                </tr>
            </ItemTemplate>

            
            
            <EmptyDataTemplate>
                <div class="RadListView RadListView_Default">
                    <table class="table" cellspacing="0" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>&nbsp;</th>
                                <th>Question</th>

                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="5"><div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Recap Question</strong> button above.</div>
                                </td>
                            </tr>
                        </tbody>
                        <tfoot>
                             <asp:LinkButton ID="btnInsert" runat="server" CommandName="AddQuestion" Visible="<%# Not Container.IsItemInserted %>"
                                CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-plus"></i>   Add New Recap Question</asp:LinkButton>
                        </tfoot>
                    </table>


                </div>
            </EmptyDataTemplate>

        </telerik:RadListView>

    </div>
        </asp:Panel>

    <asp:Panel ID="NewRecapQuestionPanel" runat="server" Visible="false" Style="margin-top: 15px;">

        <asp:Label ID="errLabel" runat="server" />


        <asp:Label ID="Hidden_recapQuestionID" runat="server" Text="Label" Visible="false"></asp:Label> <asp:Label ID="Hidden_SortOrder" runat="server" Text="true" Visible="false"></asp:Label>




        <div class="form-horizontal">
            <div class="form-group">
                <label for="ColumnNameTextBox" class="col-sm-2 control-label">Question/Text</label>
                <div class="col-sm-8">
                    <asp:TextBox ID="ColumnNameTextBox" runat="server" CssClass="form-control" />

                </div>
            </div>

            <div class="form-group">
                <label for="RequiredFieldTextBox" class="col-sm-2 control-label">Required Field</label>
                <div class="col-sm-8">
                    <asp:RadioButtonList ID="RequiredFieldTextBox" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                        <asp:ListItem Text="No" Value="False" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                    <span id="helpBlock2" class="help-block">Require that this column contains information.</span>



                </div>
            </div>

            <div class="form-group">
                <label for="columnTypeList" class="col-sm-2 control-label">Column Type</label>
                <div class="col-sm-10">
                    <asp:RadioButtonList ID="columnTypeList" runat="server" AutoPostBack="true">
                        <asp:ListItem Text="Single line of text" Value="text"></asp:ListItem>
                        <asp:ListItem Text="Multiple lines of text" Value="multiline"></asp:ListItem>
                        <asp:ListItem Text="Yes/No (radio button)" Value="yes/no"></asp:ListItem>
                        <asp:ListItem Text="Choice (menu to choose from)" Value="choice"></asp:ListItem>
                        <asp:ListItem Text="Number (1, 1.0, 100)" Value="number"></asp:ListItem>
                        <asp:ListItem Text="Date" Value="date"></asp:ListItem>
                        <asp:ListItem Text="Time" Value="time"></asp:ListItem>
                        <asp:ListItem Text="Currency ($)" Value="currency"></asp:ListItem>
                        <asp:ListItem Text="Label" Value="label"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>



            <!-- Text Option -->
            <asp:Panel ID="DescriptionPanel" runat="server">
                <div class="form-group">
                    <label for="txtDescription" class="col-sm-2 control-label">Description Text</label>
                    <div class="col-sm-8">
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control"></asp:TextBox>
                        <span id="helpBlock" class="help-block">Specify detailed options for the type of information you selected.</span>
                    </div>
                </div>

            </asp:Panel>

            <!-- Multiple Lines Option -->
            <asp:Panel ID="MultilinePanel" runat="server" Visible="false">
                <div class="form-group">
                    <label for="txtLines" class="col-sm-2 control-label">Number of lines for text</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtLines" runat="server" Text="4" CssClass="form-control" Width="50px"></asp:TextBox>
                    </div>
                </div>
            </asp:Panel>


            <!-- Choice Option -->
            <asp:Panel ID="ChoicePanel" runat="server" Visible="false">

                <div class="form-group">
                    <label for="txtChioces" class="col-sm-2 control-label">Choices</label>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txtChioces" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control"></asp:TextBox>
                        <span id="helpBlock3" class="help-block">Type each choice on a separate line.</span>


                    </div>
                </div>

                <div class="form-group">
                    <label for="DisplayOptions" class="col-sm-2 control-label">Display Options</label>
                    <div class="col-sm-10">
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
                    <label for="ckbYesNo" class="col-sm-2 control-label">Default Value</label>
                    <div class="col-sm-4">
                        
                         <asp:RadioButtonList ID="ckbYesNo" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Yes"></asp:ListItem>
                            <asp:ListItem Text="No" Selected="True"></asp:ListItem>
                        </asp:RadioButtonList>


                    </div>
                </div>
                </asp:Panel>


            <!-- Number Option -->
            <asp:Panel ID="NumberPanel" runat="server" Visible="false">

                <div class="form-group">
                    <label for="txtDecimalPlace" class="col-sm-2 control-label">Number of decimal places</label>
                    <div class="col-sm-1">
                        <asp:DropDownList ID="txtDecimalPlace" runat="server" CssClass="form-control">
                            <asp:ListItem Text="0" Value="0" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtDefaultNumber" class="col-sm-2 control-label">Default value</label>
                    <div class="col-sm-1">
                        <asp:TextBox ID="txtDefaultNumber" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="DisplayOptions" class="col-sm-2 control-label">Show as percentage</label>
                    <div class="col-sm-10">
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
                    <label for="ckbDateFormat" class="col-sm-2 control-label">Date and Time Format</label>
                    <div class="col-sm-10">
                         <asp:RadioButtonList ID="ckbDateFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Date Only" Selected="True" Value="Date"></asp:ListItem>
                            <asp:ListItem Text="Date & Time" Value="DateTime"></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>

                    </div>

                <div class="form-group">
                    <label for="DisplayOptions" class="col-sm-2 control-label">Display Format</label>
                    <div class="col-sm-10">
                         <asp:RadioButtonList ID="ckbDateDisplayFormat" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Standard" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Friendly"></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>

                    </div>

                <div class="form-group">
                    <label for="ckbDateDefualtValue" class="col-sm-2 control-label">Default Value</label>
                    <div class="col-sm-10">
                         <asp:RadioButtonList ID="ckbDateDefualtValue" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                            <asp:ListItem Text="None" Selected="True" Value="None"></asp:ListItem>
                            <asp:ListItem Text="Current Date" Value="Current"></asp:ListItem>
                        </asp:RadioButtonList>
                        </div>

                    </div>

            </asp:Panel>

            <!-- Time Option -->
            <asp:Panel ID="TimePanel" runat="server" Visible="false">
                <div class="form-group">
                    <label for="ckbTimeFormat" class="col-sm-2 control-label">Time Format</label>
                    <div class="col-sm-10">
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
                <label for="accountNameTextBox" class="col-sm-2 control-label"></label>
                <div class="col-sm-6">
                    <asp:Button ID="btnUpdateQuestion" runat="server" Text="Update" CssClass="btn btn-primary" Visible="false" />
                    <asp:Button ID="btnInsertQuestion" runat="server" Text="Save" CssClass="btn btn-primary" />
                    <asp:Button ID="btnCancelNewQuestion" runat="server" Text="Cancel" CssClass="btn btn-default" />
                </div>
            </div>
        </div>

    </asp:Panel>

     
    



<asp:LinqDataSource runat="server" EntityTypeName="" ID="getEventTypeRecapQuestionList" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" TableName="tblEventTypeRecapQuestions" Where="eventTypeID == @eventTypeID && clientID == @clientID" OrderBy="sortorder">
    <WhereParameters>
        <asp:QueryStringParameter QueryStringField="EventTypeID" Name="eventTypeID" Type="Int32"></asp:QueryStringParameter>
        <asp:QueryStringParameter QueryStringField="ClientID" Name="clientID" Type="Int32"></asp:QueryStringParameter>
    </WhereParameters>
</asp:LinqDataSource>


