from typing import Any
from django import http
from django.shortcuts import render, redirect
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from common.models import Proveedor
from django.views import View
from django.http.response import JsonResponse
import json

# Create your views here.

class ProveedorView(View):
    
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)
    
    def get(self,request,id=0):
        if id > 0:
            proveedores = list(Proveedor.objects.filter(idproveedor=id).values())
            if len(proveedores) > 0:
                proveedor = proveedores[0]
                datos = {'mensaje': 'exito', 'proveedor': proveedor}    
            else:
                datos = {'mensaje': 'no se encuentra proveedores'}
            return JsonResponse(datos)
        else:
            proveedores = list(Proveedor.objects.values())
            if len(proveedores) > 0:
                datos = {'mensaje': 'exito', 'proveedores': proveedores}
            else:
                datos = {'mensaje': 'no se encuentran proveedores'}
            return JsonResponse(datos)

    def post(self,request):
        jd = json.loads(request.body)
        Proveedor.objects.create(cuitproveedor= jd['cuitproveedor'], nombre = jd['nombre'], razonsocial = jd['razonsocial'], direccion = jd['direccion'], localidad = jd['localidad'], provincia = jd['provincia'], contacto = jd['contacto'], estado = jd['estado'])
        datos = {'mensaje': 'success'}
        return JsonResponse(datos) 
    
    def put(self,request,id):
        jd = json.loads(request.body)
        proveedores = list(Proveedor.objects.filter(idproveedor=id).values())
        if len(proveedores) > 0:
            proveedor = Proveedor.objects.get(idproveedor=id)
            proveedor.cuitproveedor = jd['cuitproveedor']
            proveedor.nombre = jd['nombre']
            proveedor.razonsocial = jd['razonsocial']
            proveedor.direccion = jd['direccion']
            proveedor.localidad = jd['localidad']
            proveedor.provincia = jd['provincia']
            proveedor.contacto = jd['contacto']
            proveedor.estado = jd['estado']
            proveedor.save()
            datos = {'mensaje': 'Proveedor actualizado correctamente'}
        else:
            datos = {'mensaje': 'No se encontro el proveedor'}
        return JsonResponse(datos)


