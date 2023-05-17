from django.shortcuts import render, redirect
from forms import ProductoForm
from common.models import Producto, Bateria, Filtro, Lampara, Llanta, Lubricentro, Neumatico

# Create your views here.

def add_producto(request):
    if request.method == 'POST':
        form = ProductoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('success_url')
    else:
        form = ProductoForm()
    return render(request, 'add_producto.html', {'form': form})

def listadoProductos(request):
    productos = Producto.objects.all()
    return render(request, 'listadoProductos.html', {'productos': productos})