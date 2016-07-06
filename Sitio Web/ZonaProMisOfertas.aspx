<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="ZonaProMisOfertas.aspx.cs" Inherits="ZonaProMisOfertas" Title="Comunicación y tecnología" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlace" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlace" Runat="Server">
    <div class="BodyPlace">
        <asp:Panel ID="panelOfers" CssClass="panelClisOn" runat="server">
            <asp:Label ID="Label1" runat="server" Text="<b>Mis ofertas</b>"></asp:Label> 
            <asp:DropDownList ID="ddVistaOfers" runat="server" onchange="setVistaOfers(this.value)">
                <asp:ListItem Selected="True" Text="Todas" Value="Todas"></asp:ListItem>
                <asp:ListItem Text="Sitios Web" Value="SitiosWeb"></asp:ListItem>
                <asp:ListItem Text="Aplicaciones Windows" Value="AppWindows"></asp:ListItem>                
            </asp:DropDownList>
            <span id="lblNumOfers" class="labelNum"></span>
            <br /><br />
                <span id="tablespan" class="labelTabla"></span>            
            <br />
            <asp:Image ID="preloader" runat="server" ImageUrl="FOTOS/loading.gif" />                                                                                                                                        
            <br />
            <img src="images/first.png" alt=" " title="página anterior" class="navs" onclick="return retrocederPaginaPro()" />            
            <img src="images/prior.png" alt=" " title="anterior" class="navs" onclick="return retrocederRegistroPro()"/>            
            <span id="spanPosition" class="labelPosicion"></span>                                                
            <img src="images/next.png" alt=" " title="siguiente" class="navsnext" onclick="return avanzarRegistroPro()" />            
            <img src="images/last.png" alt=" " title="página siguiente" class="navs" onclick="return avanzarPaginaPro()" />            
            <img src="images/edit.png" alt=" " title="editar esta solicitud" class="navs" onclick="editarFila(indice)"/>                                    
            <img src="images/add.png" alt=" " title="añadir oferta" class="navs" onclick="irAofertas()" />            
            <img src="images/erase.png" alt=" " title="borrar esta oferta" class="navs" onclick="return borrarSoftOfer(idactual)" />                        
        </asp:Panel>
        <img id="globo" src="images/vineta.png" alt="" class="Infopanel" />
        <span id="globodes" class="Infolabel"></span>
    </div>
</asp:Content>

