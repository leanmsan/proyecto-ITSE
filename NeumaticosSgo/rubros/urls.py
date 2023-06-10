from django.urls import path
from . import views
from .views import RubroView

urlpatterns = [
    
    path('rubros/', RubroView.as_view(), name="rubros_list"),
    path('rubros/<int:id>/', RubroView.as_view(), name="rubros_process")
    
]