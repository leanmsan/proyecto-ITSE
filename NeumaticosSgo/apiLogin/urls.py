from django.urls import path
from .views import register, login_view
from . import views

urlpatterns = [
    path('register/', register, name='api_register'),
    path('login/', login_view, name='api_login'),
    #path('obtain-token/', obtain_token, name='obtain_token'),
]