from typing import Any
from django import http
from django.shortcuts import render, redirect
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from common.models import Rubro
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.http.response import JsonResponse
from django.utils.decorators import method_decorator
import json
# Create your views here.

class RubroView(View):
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)
    
    def post(self,request):
        jd = json.loads(request.body)
        Rubro.objects.create(nombre = jd['nombre'], caracteristicas = jd['caracteristicas'])
        datos = {'mensaje': 'success'}
        return JsonResponse(datos) 

    def get(self,request,id=0):
        if id > 0:
            rubros = list(Rubro.objects.filter(idrubro=id).values())
            if len(rubros) > 0:
                rubros = rubros[0]
                datos = {'mensaje': 'exito', 'rubro': rubros}
            else:
                datos = {'mensaje': 'no se encuentra rubros'}
            return JsonResponse(datos)
        else:
            rubros = list(Rubro.objects.values())
            if len(rubros) > 0:
                datos = {'mensaje': 'exito', 'rubros': rubros}
            else:
                datos = {'mensaje': 'no se encuentra rubros'}
            return JsonResponse(datos)

    def put(self,request,id):
        jd = json.loads(request.body)
        rubros = list(Rubro.objects.filter(idrubro=id).values())
        if len(rubros) > 0:
            rubro = Rubro.objects.get(idrubro=id)
            rubro.nombre = jd['nombre']
            rubro.caracteristicas = jd['caracteristicas']
            rubro.save()
            datos = {'mensaje': 'Rubro actualizado correctamente'}
        else:
            datos = {'mensaje': 'No se encontro el rubro'}
        return JsonResponse(datos)
