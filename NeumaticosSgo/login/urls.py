from django.urls import path
from . import views
from django.contrib.auth.views import LoginView

urlpatterns = [
    path('accounts/login/', LoginView.as_view(), name='login'),
    path('', views.menu, name='menu'),
    path('logout/', views.logout_view, name='logout')
]