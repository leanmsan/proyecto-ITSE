from django.forms import ModelForm
from common.models import Producto, Bateria, Filtro, Lampara, Llanta, Lubricentro, Neumatico

class ProductoForm(ModelForm):
    class Meta:
        model = Producto
        fields = ['nombreProducto', 'precioCompra', 'precioVenta', 'marcaProducto', 'descripcionProducto', 'stockProducto', 'rubroProducto']

