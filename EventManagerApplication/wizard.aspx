<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="wizard.aspx.vb" Inherits="EventManagerApplication.wizard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">

    <style>
    /*.RadWizard_Bootstrap .rwzNext{
    border-color: #2e6da4;
    color: #fff;
    background-color: #337ab7;
    width: 150px;
}

.RadWizard_Bootstrap .rwzFinish {
    border-color: #669933;
    color: #fff;
    background-color: #669933;
    width: 150px;
}


.RadWizard_Bootstrap .rwzFinish .rwzClicked {
    border-color: #ff0000;
    color: #fff;
    background-color: #ff0000;
    width: 150px;
}

.RadWizard_Bootstrap .rwzFinish .rwzHovered {
    border-color: #ff6a00;
    color: #fff;
    background-color: #ff6a00;
    width: 150px;
}*/

    .ladda-spinner {

     overflow: hidden;
        top: 42px;
                left: 50%;
                margin-left: 0;

                margin-top: -2em;
    }

        </style>

        <link href="Theme/css/custom.css" rel="stylesheet" />
        <link href="Theme/css/ekko-lightbox.css" rel="stylesheet" />

<%--    <link href="Theme/css/ladda-themeless.min.css" rel="stylesheet" />--%>

        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap" Modal="true" />
        <asp:Panel ID="Panel1" runat="server">

        <p class="col-sm-3"><a href="/SamplePage" data-title="My Sample Page" data-footer="A custom footer text" data-toggle="lightbox" data-parent="" data-gallery="remoteload" data-width="1280">Open up Bootstrap</a></p>




<%--        <link href="Theme/css/finish_spinner.css" rel="stylesheet" />--%>
   <button class="btn btn-default ladda-button" data-style="slide-down" data-spinner-color="#000"><span class="ladda-label">Button</span></button>

         <telerik:RadWizard ID="RadWizard1" runat="server" OnClientButtonClicked="OnClientButtonClicked">



            <WizardSteps>
                <telerik:RadWizardStep Title="Tab One" Active="true"></telerik:RadWizardStep>
                <telerik:RadWizardStep Title="Tab Two"></telerik:RadWizardStep>
                <telerik:RadWizardStep Title="Tab Three">

                </telerik:RadWizardStep>


            </WizardSteps>

        </telerik:RadWizard>

            </asp:Panel>
    </div>





    <script type="text/javascript">
    function OnClientButtonClicked(sender, args) {
        var command = args.get_command();

        // if finish button is clicked

        if (command == "2") {

            // Your custom confirmation logic here
            var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
            var currentUpdatedControl = "<%= Panel1.ClientID %>";
            loadingPanel.set_modal(true);
            loadingPanel.show(currentUpdatedControl);


           // alert("Good job!")

        }
    }
</script>


    <script>

			// Bind normal buttons
      //  Ladda.bind( 'div:not(.progress-demo) button', { timeout: 2000 } );

			// Bind progress buttons and simulate loading progress
        Ladda.bind('.rwzFinish', {
				callback: function( instance ) {
					var progress = 0;
					var interval = setInterval( function() {
						progress = Math.min( progress + Math.random() * 0.1, 1 );
						instance.setProgress( progress );

						if( progress === 1 ) {
							instance.stop();
							clearInterval( interval );
						}
					}, 200 );
				}
			} );

			// You can control loading explicitly using the JavaScript API
			// as outlined below:

			// var l = Ladda.create( document.querySelector( 'button' ) );
			// l.start();
			// l.stop();
			// l.toggle();
			// l.isLoading();
			// l.setProgress( 0-1 );

		</script>



    <script src="Theme/js/ekko-lightbox.min.js"></script>
    <script type="text/javascript">
			$(document).ready(function ($) {

				// delegate calls to data-toggle="lightbox"
				$(document).delegate('*[data-toggle="lightbox"]:not([data-gallery="navigateTo"])', 'click', function(event) {
					event.preventDefault();
					return $(this).ekkoLightbox({
						onShown: function() {
							if (window.console) {
								return console.log('onShown event fired');
							}
						},
						onContentLoaded: function() {
							if (window.console) {
								return console.log('onContentLoaded event fired');
							}
						},
						onNavigate: function(direction, itemIndex) {
							if (window.console) {
								return console.log('Navigating '+direction+'. Current item: '+itemIndex);
							}
						}
					});
				});

				//Programatically call
				$('#open-image').click(function (e) {
					e.preventDefault();
					$(this).ekkoLightbox();
				});
				$('#open-youtube').click(function (e) {
					e.preventDefault();
					$(this).ekkoLightbox();
				});

				$(document).delegate('*[data-gallery="navigateTo"]', 'click', function(event) {
					event.preventDefault();
					return $(this).ekkoLightbox({
						onShown: function() {
							var lb = this;
							$(lb.modal_content).on('click', '.modal-footer a#jumpit', function(e) {
								e.preventDefault();
								lb.navigateTo(2);
							});
							$(lb.modal_content).on('click', '.modal-footer a#closeit', function(e) {
								e.preventDefault();
								lb.close();
							});
						}
					});
				});

			});
		</script>


</asp:Content>
