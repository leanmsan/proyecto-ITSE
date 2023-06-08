from django.urls import path
from . import views
from .views import RubroView

urlpatterns = [
    
    path('apiRubros/', RubroView.as_view(), name="rubros_list"),
    path('apiRubros/<int:id_>/', RubroView.as_view(), name="rubros_process")
    
]