from django.shortcuts import render
from django.contrib.auth import logout
from django.shortcuts import redirect
from django.contrib.auth.decorators import login_required

# Create your views here.
@login_required
def menu(request):
    return render(request, 'index.html', {})

def logout_view(request):
    logout(request)
    return redirect('login')