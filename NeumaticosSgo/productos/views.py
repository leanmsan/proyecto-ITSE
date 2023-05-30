from typing import Any
from django import http
from django.shortcuts import render, redirect
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from common.models import Producto, Bateria, Filtro, Lampara, Llanta, Lubricentro, Neumatico
from django.views import View
from django.http.response import JsonResponse
import json
#from forms import ProductoForm
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
    
    def get(self,request,id=0):
        if id > 0:
            productos = list(Producto.objects.filter(idproducto=id).values())
            if len(productos) > 0:
                producto = productos[0]
                datos = {'mensaje': 'exito', 'producto': producto}    
            else:
                datos = {'mensaje': 'no se encuentra productos'}
            return JsonResponse(datos)
        else:
            productos = list(Producto.objects.values())
            if len(productos) > 0:
                datos = {'mensaje': 'exito', 'productos': productos}
            else:
                datos = {'mensaje': 'no se encuentra productos'}
            return JsonResponse(datos)

    def post(self,request):
        pass
    
    def put(self,request,id):
        jd = json.loads(request.body)
        productos = list(Producto.objects.filter(idproducto=id).values())
        if len(productos) > 0:
            producto = Producto.objects.get(idproducto=id)
            producto.nombreproducto = jd['nombreproducto']
            producto.preciocompra = jd['preciocompra']
            producto.precioventa = jd['precioventa']
            producto.marcaproducto = jd['marcaproducto']
            producto.descripcionproducto = jd['descripcionproducto']
            producto.stockproducto = jd['stockproducto']
            producto.rubroproducto = jd['rubroproducto']
            producto.save()
            datos = {'mensaje': 'Producto actualizado correctamente'}
        else:
            datos = {'mensaje': 'No se encontro el producto'}
        return JsonResponse(datos)
    
    def delete(self,request):
        pass    
