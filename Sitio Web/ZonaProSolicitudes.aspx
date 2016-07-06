<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="ZonaProSolicitudes.aspx.cs" Inherits="ZonaProSolicitudes" Title="Página sin título" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlace" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlace" Runat="Server">
    <div class="BodyPlace">
        <asp:Panel ID="panelSols" CssClass="panelClisOn" runat="server">
            <asp:Label ID="Label1" runat="server" Text="<b>Mis solicitudes</b>"></asp:Label> 
            <asp:DropDownList ID="ddVistaSols" runat="server" onchange="setVistaSolPro(this.value)">
                <asp:ListItem Selected="True" Text="Todas" Value="Todas"></asp:ListItem>
                <asp:ListItem Text="Sitios Web" Value="SitiosWeb"></asp:ListItem>
                <asp:ListItem Text="Aplicaciones Windows" Value="AppWindows"></asp:ListItem>                
            </asp:DropDownList>
            <span id="lblNumSols" class="labelNum"></span>
            <br /><br />
                <span id="tablespan" class="labelTabla"></span>            
            <br />
            <asp:Image ID="preloader" runat="server" ImageUrl="FOTOS/loading.gif" />                                                                                                                            
            <br />
            <img src="images/first.png" alt=" " title="página anterior" class="navs" onclick="return retrocederPaginaSolPro()" />            
            <img src="images/prior.png" alt=" " title="anterior" class="navs" onclick="return retrocederRegistroSolPro()"/>            
            <span id="spanPosition" class="labelPosicion"></span>                                                
            <img src="images/next.png" alt=" " title="siguiente" class="navsnext" onclick="return avanzarRegistroSolPro()" />            
            <img src="images/last.png" alt=" " title="página siguiente" class="navs" onclick="return avanzarPaginaSolPro()" />            
            <img src="images/thumb_up.png" alt=" " title="aceptar esta oferta" class="navs" onclick="return aceptarSolicitudSoft(idactual)"/>                        
            <img src="images/thumb_down.png" alt=" " title="rechazar esta oferta" class="navs" onclick="return rechazarSolicitudSoft(idactual)"/>                                    
        </asp:Panel>
        <img id="globo" src="images/vineta.png" alt="" class="Infopanel" />
        <span id="globodes" class="Infolabel"></span>
    </div>
</asp:Content>

