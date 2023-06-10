from django.forms import ModelForm
from common.models import Proveedor

class ProveedorForm(ModelForm):
    class Meta:
        model = Proveedor
        fields = ['__all___']
