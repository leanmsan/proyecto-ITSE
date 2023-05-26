from django.shortcuts import render, redirect
#from forms import ProductoForm
from common.models import Producto, Bateria, Filtro, Lampara, Llanta, Lubricentro, Neumatico
from django.views import View
from django.http.response import JsonResponse
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
    def get(self,request):
        productos = list(Producto.objects.values())
        print(productos)
        if len(productos) > 0:
            datos = {'mensaje': 'exito', 'productos': productos}
        else:
            datos = {'mensaje': 'no se encuentra productos'}
        return JsonResponse(datos)

    def post(self,request):
        pass
    def put(self,request):
        pass
    def delete(self,request):
        pass