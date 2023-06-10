#from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.contrib.auth import authenticate, login
from django.contrib.auth.models import User
from django.db import IntegrityError
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.authtoken.views import obtain_auth_token


@api_view(['POST'])
def register(request):
    username = request.data.get('username')
    password = request.data.get('password')

    if not username or not password:
        return Response({'error': 'Debes proporcionar un nombre de usuario y una contraseña.'}, status=status.HTTP_400_BAD_REQUEST)

    try:
        User.objects.create_user(username=username, password=password)
        return Response({'message': 'Usuario creado exitosamente.'}, status=status.HTTP_201_CREATED)
    except IntegrityError:
        return Response({'error': 'El nombre de usuario ya está en uso.'}, status=status.HTTP_400_BAD_REQUEST)
    

    

@api_view(['POST'])
def login_view(request):
    username = request.data.get('username')
    password = request.data.get('password')

    if not username or not password:
        return Response({'error': 'Debes proporcionar un nombre de usuario y una contraseña.'}, status=status.HTTP_400_BAD_REQUEST)

    user = authenticate(request, username=username, password=password)
    login(request, user)

    if user is not None:
        login(request, user)
        refresh = RefreshToken.for_user(user)
        return Response({'token': str(refresh.access_token)}, status=status.HTTP_200_OK)
    else:
        return Response({'error': 'Credenciales inválidas.'}, status=status.HTTP_401_UNAUTHORIZED)









    
    '''
    
    username = request.data.get('username')
    password = request.data.get('password')

    user = authenticate(request, username=username, password=password)
    

    if user is not None:
        login(request, user)
        return Response({'message': 'Inicio de sesión exitoso.'}, status=status.HTTP_200_OK)

    else:
        return Response({'error': 'Credenciales inválidas.'}, status=status.HTTP_401_UNAUTHORIZED)
    '''
'''

@api_view(['POST'])
def obtain_token(request):
    username = request.data.get('username')
    password = request.data.get('password')

    if not username or not password:
        return Response({'error': 'Debes proporcionar un nombre de usuario y una contraseña.'}, status=status.HTTP_400_BAD_REQUEST)

    user = authenticate(request, username=username, password=password)

    if user is not None:
        refresh = RefreshToken.for_user(user)
        return Response({'token': str(refresh.access_token)}, status=status.HTTP_200_OK)
    else:
        return Response({'error': 'Credenciales inválidas.'}, status=status.HTTP_401_UNAUTHORIZED)
'''

# Create your views here.
