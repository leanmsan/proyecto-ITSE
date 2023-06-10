from django.urls import path
from . import views
from .views import ProductoView

urlpatterns = [
    #path('altaproducto/', views.add_producto, name='altaproducto'),
    #path('listadoproducto/', views.listado_Productos, name='listadoproductos')
    path('productos/', ProductoView.as_view(), name="productos_list"),
    path('productos/<int:id>/', ProductoView.as_view(), name="productos_process"),
    path('productos/<str:rubro>/', ProductoView.as_view(), name="productos_filtro")   

]
