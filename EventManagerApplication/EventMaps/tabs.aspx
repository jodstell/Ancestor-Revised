<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="tabs.aspx.vb" Inherits="EventManagerApplication.tabs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


 <h1>Bootstrap tabs remote data plugin demo</h1>
<hr>

<h2>Tabs demo</h2>
<!-- Nav tabs -->
<ul class="nav nav-tabs">
    <li class="active"><a href="#home" data-toggle="tab">No remote data</a></li>
    <li><a href="#simple" data-toggle="tab" data-tab-url="remote/normal.html">Simple remote data</a></li>
    <li><a href="#simple2" data-toggle="tab" data-tab-url="remote/delay.html" data-tab-delay="3000">Simple remote data (with 3 second delay)</a></li>
    <li><a href="#callback" data-toggle="tab" data-tab-url="remote/callback.html" data-tab-callback="sampleCallback" >Remote data with callback</a></li>
    <li><a href="#jsondata" data-toggle="tab" data-tab-json='{"name":"John Doe"}'
           data-tab-url="remote/json.html" data-tab-callback="showJsonName" >Remote data with callback and json data</a></li>
</ul>

<!-- Tab panes -->
<div class="tab-content">
    <div class="tab-pane active" id="home">
        <p>No special data here!</p>
    </div>
    <div class="tab-pane" id="simple"></div>
    <div class="tab-pane" id="simple2"></div>
    <div class="tab-pane" id="callback"></div>
    <div class="tab-pane" id="jsondata"></div>
</div>

<h2>Accordion demo</h2>

<div class="panel-group" id="accordion">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" data-tab-url="remote/normal.html">Simple remote data</a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in">
      <div class="panel-body">&nbsp;</div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" data-tab-url="remote/delay.html" data-tab-delay="3000">
         Simple remote data (with 3 second delay)
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse">
      <div class="panel-body">&nbsp;
      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" data-toggle="tab" data-tab-url="remote/callback.html" data-tab-callback="sampleCallback">
	  Remote data with callback
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse">
      <div class="panel-body">&nbsp;
      </div>
    </div>
  </div>
</div>


<script src="/js/jquery.loadmask.js"></script>
<script src="/js/bootstrap-remote-tabs.js"></script>

<script type="text/javascript">

    /**
     * @param data
    */
    function sampleCallback() {
        alert('Hello, World!');
    }
    /**
     *
     * @param data
     * @param trigger
     * @param container
     * @param json
     */
    function showJsonName(data, trigger, container, json) {
        alert('Welcome, ' + json.name + '!');
    }
</script>
</asp:Content>
