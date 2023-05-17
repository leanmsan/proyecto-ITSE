from django.urls import path
from . import views

urlpatterns = [
    path('altaproducto/', views.add_producto, name='altaproducto'),
    path('listadoproducto/', views.listadoProductos, name='listadoproductos')
]
