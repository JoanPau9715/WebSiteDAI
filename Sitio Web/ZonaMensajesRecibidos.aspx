<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="ZonaMensajesRecibidos.aspx.cs" Inherits="ZonaMensajesRecibidos" Title="Página sin título" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlace" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlace" Runat="Server">
    <div class="BodyPlace">
        <asp:Panel ID="panelSols" CssClass="panelMensajes" runat="server">
            <asp:Label ID="Label1" runat="server" Text="<b>Mensajes recibidos</b>"></asp:Label> 
            <span id="lblNumSols" class="labelNum"></span>
            <br /><br />
                <span id="tablespan" class="labelTabla"></span>            
            <br />
            <asp:Image ID="preloader" runat="server" ImageUrl="FOTOS/loading.gif" /> 
            <br />
            <img src="images/first.png" alt=" " title="página anterior" class="navs" onclick="retrocederPaginaMensajes()" />            
            <img src="images/prior.png" alt=" " title="anterior" class="navs" onclick="retrocederRegistroMensajes()" />            
            <span id="spanPosition" class="labelPosicion"></span>                                                
            <img src="images/next.png" alt=" " title="siguiente" class="navsnext" onclick="avanzarRegistroMensajes()" />            
            <img src="images/last.png" alt=" " title="página siguiente" class="navs" onclick="avanzarPaginaMensajes()" />                                
        </asp:Panel>
    </div>
</asp:Content>

