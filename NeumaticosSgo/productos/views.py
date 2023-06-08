
from typing import Any
from django import http
from django.shortcuts import render, redirect
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from common.models import Producto, Rubro
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.http.response import JsonResponse
from django.utils.decorators import method_decorator
import json

# Create your views here.

class ProductoView(View):
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)

    def post(self,request):
        jd = json.loads(request.body)
        
        rubro_nombre = jd['rubro']
        rubro, created = Rubro.objects.get_or_create(nombre=rubro_nombre)
    
        Producto.objects.create(nombre = jd['nombre'], descripcion = jd['descripcion'], preciocompra = jd['preciocompra'], precioventa = jd['precioventa'], marca = jd['marca'], stockdisponible = jd['stockdisponible'], rubro = rubro, caracteristicas = jd['caracteristicas'])
        datos = {'mensaje': 'success'}
        return JsonResponse(datos) 

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

    def put(self,request,id):
        jd = json.loads(request.body)
        productos = list(Producto.objects.filter(idproducto=id).values())
        if len(productos) > 0:
            producto = Producto.objects.get(idproducto=id)
            producto.nombre = jd['nombre']
            producto.preciocompra = jd['preciocompra']
            producto.precioventa = jd['precioventa']
            producto.marca = jd['marca']
            producto.descripcion = jd['descripcion']
            producto.stockdisponible = jd['stock']
            producto.rubro = jd['rubro']
            producto.caracteristicas = jd['caracteristicas']
            producto.save()
            datos = {'mensaje': 'Producto actualizado correctamente'}
        else:
            datos = {'mensaje': 'No se encontro el producto'}
        return JsonResponse(datos)