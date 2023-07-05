from django.shortcuts import render
from common.models import Entrada, Entradadetalle, Salida, Salidadetalle, Proveedor, Producto
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.http.response import JsonResponse
from django.utils.decorators import method_decorator
import json
# Create your views here.

# VISTA DE ENTRADA

@method_decorator(csrf_exempt, name='dispatch')
class EntradaView(View):

    def get(self, request, id=0, prov=None):
        if id > 0:
            entradas = list(Entrada.objects.filter(identrada=id).values())
            if len(entradas) > 0:
                entrada = entradas[0]
                datos = {'mensaje': 'exito', 'entrada': entrada}
            else:
                datos = {'mensaje': 'No se encontró el movimiento de entrada'}
        else:
            if prov:
                entradas = list(Entrada.objects.filter(idproveedor=prov).values())
            else:
                entradas = list(Entrada.objects.values())

            if len(entradas) > 0:
                datos = {'mensaje': 'exito', 'cantidad': len(entradas), 'entradas': entradas}
            else:
                datos = {'mensaje': 'No se encontraron movimientos de entrada'}
        
        return JsonResponse(datos)

    def post(self, request):
        jd = json.loads(request.body)
        idproveedor_id = jd['idproveedor_id']
        try:
            idproveedor = Proveedor.objects.get(idproveedor=idproveedor_id)
        except Proveedor.DoesNotExist:
            idproveedor = None

        if idproveedor:
            entrada = Entrada.objects.create(idproveedor=idproveedor, montototal=jd['montototal'])
            datos = {'mensaje': 'success'}
        else:
            datos = {'mensaje': 'El proveedor no existe'}
        
        return JsonResponse(datos)
    
    def put(self, request, id):
        pass
    
    
# VISTA DE ENTRADA DETALLE

@method_decorator(csrf_exempt, name='dispatch')
class EntradadetalleView(View):

    def get(self, request, id=0, prod = 0):
        if id > 0:
            entradasdet = list(Entradadetalle.objects.filter(identrada=id).values())
            if len(entradasdet):
                datos = {'mensaje': 'exito', 'entradas': entradasdet}
            else:
                datos = {'mensaje': 'No se encontró el id de entrada'}
            return JsonResponse(datos)
        else:
            if prod:
                entradasdet = list(Entradadetalle.objects.filter(idproducto=prod).values())
            else:
                entradasdet = list(Entradadetalle.objects.values())

            if len(entradasdet) > 0:
                datos = {'mensaje': 'exito', 'cantidad': len(entradasdet), 'entradas': entradasdet}
            else:
                datos = {'mensaje': 'No se encontraron detalles de entrada'}
            return JsonResponse(datos)
        
    def post(self, request):
        jd = json.loads(request.body)
        identrada_id = jd['identrada_id']
        idproducto_id = jd['idproducto_id']
        try:
            entrada = Entrada.objects.get(identrada = identrada_id)
        except Entrada.DoesNotExist:
            entrada = None
        if entrada:
            try:
                idproducto = Producto.objects.get(idproducto=idproducto_id)
            except Producto.DoesNotExist:
                idproducto = None
            if idproducto:
                entrada = Entradadetalle.objects.create(identrada = identrada_id, idproducto = idproducto_id, cantidad = jd['cantidad'], preciounitario=jd['preciounitario'])
                datos = {'mensaje': 'success'}
            else:
                datos = {'mensaje': 'El producto no existe'}
        else:
            datos = {'mensaje': 'La entrada no existe'}
        
        return JsonResponse(datos)
    
    def put(self, request, id):
        pass


# VISTA DE SALIDA

@method_decorator(csrf_exempt, name='dispatch')
class SalidaView(View):

    def get(self, request, id=0, prov=None):
        if id > 0:
            salidas = list(Salida.objects.filter(idsalida=id).values())
            if len(salidas) > 0:
                salida = salidas[0]
                datos = {'mensaje': 'exito', 'salida': salida}
            else:
                datos = {'mensaje': 'No se encontró el movimiento de salida'}
        else:
            if prov:
                salidas = list(Salida.objects.filter(idproveedor=prov).values())
            else:
                salidas = list(Salida.objects.values())

            if len(salidas) > 0:
                datos = {'mensaje': 'exito', 'cantidad': len(salidas), 'salidas': salidas}
            else:
                datos = {'mensaje': 'No se encontraron movimientos de salida'}

        return JsonResponse(datos)

    def post(self, request):
        jd = json.loads(request.body)
        idproveedor_id = jd['idproveedor_id']
        try:
            idproveedor = Proveedor.objects.get(idproveedor=idproveedor_id)
        except Proveedor.DoesNotExist:
            idproveedor = None

        if idproveedor:
            salida = Salida.objects.create(idproveedor=idproveedor, montototal=jd['montototal'])
            datos = {'mensaje': 'success'}
        else:
            datos = {'mensaje': 'El proveedor no existe'}

        return JsonResponse(datos)
    
    def put(self, request, id):
        pass


# VISTA DE SALIDA DETALLE

@method_decorator(csrf_exempt, name='dispatch')
class SalidadetalleView(View):

    def get(self, request, id=0, prod=0):
        if id > 0:
            salidasdet = list(Salidadetalle.objects.filter(idsalida=id).values())
            if len(salidasdet) > 0:
                datos = {'mensaje': 'exito', 'salidas': salidasdet}
            else:
                datos = {'mensaje': 'No se encontró el ID de salida'}
        else:
            if prod:
                salidasdet = list(Salidadetalle.objects.filter(idproducto=prod).values())
            else:
                salidasdet = list(Salidadetalle.objects.values())

            if len(salidasdet) > 0:
                datos = {'mensaje': 'exito', 'cantidad': len(salidasdet), 'salidas': salidasdet}
            else:
                datos = {'mensaje': 'No se encontraron detalles de salida'}
        
        return JsonResponse(datos)
        
    def post(self, request):
        jd = json.loads(request.body)
        idsalida_id = jd['idsalida_id']
        idproducto_id = jd['idproducto_id']
        try:
            salida = Salida.objects.get(idsalida=idsalida_id)
        except Salida.DoesNotExist:
            salida = None
        
        if salida:
            try:
                idproducto = Producto.objects.get(idproducto=idproducto_id)
            except Producto.DoesNotExist:
                idproducto = None
            
            if idproducto:
                salidadetalle = Salidadetalle.objects.create(idsalida=idsalida_id, idproducto=idproducto_id, cantidad=jd['cantidad'], preciounitario=jd['preciounitario'])
                datos = {'mensaje': 'success'}
            else:
                datos = {'mensaje': 'El producto no existe'}
        else:
            datos = {'mensaje': 'La salida no existe'}
        
        return JsonResponse(datos)
    
    def put(self, request, id):
        pass