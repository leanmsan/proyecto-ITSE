from django.urls import path
from .views import obtain_auth_token
from .views import CreateUserAPIView, ObtainAuthToken

urlpatterns = [
    path('api-token-auth/', obtain_auth_token, name='api_token_auth'),
    path('create-user/', CreateUserAPIView.as_view(), name='create_user'),
    #path('api-token-auth-register/', ObtainAuthToken.as_view(), name='api_token_auth'),
]