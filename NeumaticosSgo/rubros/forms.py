from django.forms import ModelForm
from common.models import Rubro

class RubroForm(ModelForm):
    class Meta:
        model = Rubro
        fields = ('__all___')