from typing import Any
from django import http
from django.shortcuts import render, redirect
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from common.models import Producto, Bateria, Filtro, Lampara, Llanta, Lubricentro, Neumatico
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.http.response import JsonResponse
from django.utils.decorators import method_decorator
import json
# Create your views here.
'''
def add_producto(request):
    if request.method == 'POST':
        form = ProductoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('success_url')
    else:
        form = ProductoForm()
    return render(request, 'add_producto.html', {'form': form})

def listado_Productos(request):
    productos = Producto.objects.all()
    return render(request, 'listadoProductos.html', {'productos': productos})
'''
class ProductoView(View):
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)
    
    def get(self,request):
        productos = list(Producto.objects.values())
        print(productos)
        if len(productos) > 0:
            datos = {'mensaje': 'exito', 'productos': productos}
        else:
            productos = list(Producto.objects.values())
            if len(productos) > 0:
                datos = {'mensaje': 'exito', 'productos': productos}
            else:
                datos = {'mensaje': 'no se encuentra productos'}
            return JsonResponse(datos)

    def post(self,request):
        jd = json.loads(request.body)
        Producto.objects.create(nombreproducto = jd['nombreProducto'], preciocompra = jd['precioCompra'], precioventa = jd['precioVenta'], marcaproducto = jd['marcaProducto'], descripcionproducto = jd['descripcionProducto'], stockproducto = jd['stockProducto'], rubroproducto = jd['rubroProducto'])
        datos = {'mensaje': 'success'}
        return JsonResponse(datos)
    
    def put(self,request):
        pass
    def delete(self,request):
        pass    
