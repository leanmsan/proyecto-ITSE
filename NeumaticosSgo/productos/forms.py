from django.forms import ModelForm
from common.models import Producto

class ProductoForm(ModelForm):
    class Meta:
        model = Producto
        fields = ['nombreProducto', 'precioCompra', 'precioVenta', 'marcaProducto', 'descripcionProducto', 'stockProducto', 'rubroProducto']

